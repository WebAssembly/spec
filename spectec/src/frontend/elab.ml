open Util
open Source
open El
open Ast
open Convert
open Print

module Il = struct include Il include Ast end

module Set = Free.Set
module Map = Map.Make (String)


(* Errors *)

let error at msg = Source.error at "type" msg

let error_atom at atom t msg =
  error at (msg ^ " `" ^ string_of_atom atom ^ "` in type `" ^ string_of_typ t ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")

module Debug = struct include El.Debug include Il.Debug end


(* Helpers *)

let wild_exp t' = Il.VarE ("_" $ t'.at) $$ t'.at % t'

let unparen_exp e =
  match e.it with
  | ParenE (e1, _) -> e1
  | _ -> e

let unseq_exp e =
  match e.it with
  | EpsE -> []
  | SeqE es -> es
  | _ -> [e]

let tup_typ ts at =
  match ts with
  | [t] -> t
  | _ -> TupT ts $ at

let tup_typ' ts' at =
  match ts' with
  | [t'] -> t'
  | _ -> Il.TupT (List.map (fun t' -> wild_exp t', t') ts') $ at

let tup_typ_bind' es' ts' at =
  Il.TupT (List.combine es' ts') $ at

let tup_exp' es' at =
  match es' with
  | [e'] -> e'
  | _ -> Il.TupE es' $$ (at, tup_typ' (List.map note es') at)

let tup_exp_bind' es' at =
  let ts' = List.map note es' in
  Il.TupE es' $$ (at, tup_typ_bind' (List.map wild_exp ts') ts' at)

let lift_exp' e' iter' =
  if iter' = Opt then
    Il.OptE (Some e')
  else
    Il.ListE [e']

let cat_exp' e1' e2' =
  match e1'.it, e2'.it with
  | _, Il.ListE [] -> e1'.it
  | Il.ListE [], _ -> e2'.it
  | Il.ListE es1, Il.ListE es2 -> Il.ListE (es1 @ es2)
  | _ -> Il.CatE (e1', e2')


(* Environment *)

type kind =
  | Transp  (* alias types, notation types *)
  | Opaque  (* structures or variants, type parameter *)
  | Defined of typ * Il.deftyp
  | Family of (arg list * typ * Il.inst) list (* family of types *)

type var_typ = typ
type typ_typ = param list * kind
type gram_typ = param list * typ * gram option
type rel_typ = typ * Il.rule list
type def_typ = param list * typ * (def * Il.clause) list

type 'a env' = (region * 'a) Map.t
type env =
  { mutable gvars : var_typ env'; (* variable type declarations *)
    mutable vars : var_typ env';  (* local bindings *)
    mutable typs : typ_typ env';
    mutable syms : gram_typ env';
    mutable rels : rel_typ env';
    mutable defs : def_typ env';
  }

let new_env () =
  { gvars = Map.empty
      |> Map.add "bool" (no_region, BoolT $ no_region)
      |> Map.add "nat" (no_region, NumT NatT $ no_region)
      |> Map.add "int" (no_region, NumT IntT $ no_region)
      |> Map.add "rat" (no_region, NumT RatT $ no_region)
      |> Map.add "real" (no_region, NumT RealT $ no_region)
      |> Map.add "text" (no_region, TextT $ no_region);
    vars = Map.empty;
    typs = Map.empty;
    syms = Map.empty;
    rels = Map.empty;
    defs = Map.empty;
  }

let local_env env = {env with gvars = env.gvars; vars = env.vars; typs = env.typs}

let bound env' id = Map.mem id.it env'

let spaceid space id = if space = "definition" then ("$" ^ id.it) $ id.at else id

let find space env' id =
  match Map.find_opt id.it env' with
  | None -> error_id (spaceid space id) ("undeclared " ^ space)
  | Some (_at, t) -> t

let bind space env' id t =
  if id.it = "_" then
    env'
  else if Map.mem id.it env' then
    error_id (spaceid space id) ("duplicate declaration for " ^ space)
  else
    Map.add id.it (id.at, t) env'

let rebind _space env' id t =
  assert (Map.mem id.it env');
  Map.add id.it (id.at, t) env'

let find_field fs atom at t =
  match List.find_opt (fun (atom', _, _) -> atom'.it = atom.it) fs with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unbound field"

let find_case cases atom at t =
  match List.find_opt (fun (atom', _, _) -> atom'.it = atom.it) cases with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unknown case"

let bound_env' env' = Map.fold (fun id _ s -> Free.Set.add id s) env' Free.Set.empty
let bound_env env =
  Free.{
    varid = bound_env' env.vars;
    typid = bound_env' env.typs;
    relid = bound_env' env.rels;
    defid = bound_env' env.defs;
    gramid = bound_env' env.syms;
  }

let to_eval_var (_at, t) = t

let to_eval_typ id (_at, (ps, k)) =
  match k with
  | Opaque | Transp ->
    let args' = List.map Convert.arg_of_param ps in
    [(args', VarT (id $ no_region, args') $ no_region)]
  | Defined (t, _dt') ->
    [(List.map Convert.arg_of_param ps, t)]
  | Family insts ->
    List.map (fun (args, t, _inst') -> (args, t)) insts

let to_eval_def (_at, (_ps, _t, clauses)) =
  List.map (fun (d, _) ->
    match d.it with
    | DefD (_id, args, e, prems) -> (args, e, Convert.filter_nl prems)
    | _ -> assert false
  ) clauses

let to_eval_env env =
  (* Need to include gvars, since matching can encounter uimplicit vars *)
  let gvars = Map.map to_eval_var env.gvars in
  let vars = Map.map to_eval_var env.vars in
  let typs = Map.mapi to_eval_typ env.typs in
  let defs = Map.map to_eval_def env.defs in
  let syms = Map.map ignore env.syms in
  Eval.{vars = Map.union (fun _ _ t -> Some t) gvars vars; typs; defs; syms}


(* More Errors *)

let typ_string env t =
  let t' = Eval.reduce_typ (to_eval_env env) t in
  if Eq.eq_typ t t' then
    "`" ^ string_of_typ t ^ "`"
  else
    "`" ^ string_of_typ t ^ "` = `" ^ string_of_typ t' ^ "`"

let error_typ env at phrase t =
  error at (phrase ^ " does not match expected type " ^ typ_string env t)

let error_typ2 env at phrase t1 t2 reason =
  error at (phrase ^ "'s type " ^ typ_string env t1 ^
    " does not match expected type " ^ typ_string env t2 ^ reason)

type direction = Infer | Check

let error_dir_typ env at phrase dir t expected =
  match dir with
  | Check -> error_typ env at phrase t
  | Infer ->
    error at (phrase ^ "'s type `" ^ string_of_typ t ^ "`" ^
      " does not match expected type " ^ expected)


(* Type Accessors *)

let rec arg_subst s ps args =
  match ps, args with
  | [], [] -> s
  | p::ps', a::as' ->
    let s' =
      match p.it, !((Subst.subst_arg s a).it) with
      | ExpP (id, _), ExpA e -> Subst.add_varid s id e
      | TypP id, TypA t -> Subst.add_typid s id t
      | GramP (id, _), GramA g -> Subst.add_gramid s id g
      | _, _ -> assert false
    in arg_subst s' ps' as'
  | _, _ -> assert false

(* TODO: eliminate, replace expansion with reduction *)
let aliased dt' =
  match dt'.it with
  | Il.AliasT _ -> `Alias
  | _ -> `NoAlias
let aliased_inst inst' =
  let Il.InstD (_, _, dt') = inst'.it in
  aliased dt'

(* TODO: replace with reduce_typ *)
let as_defined_typid' env id args at : typ' * [`Alias | `NoAlias] =
  match find "syntax type" env.typs (strip_var_suffix id) with
  | ps, Defined (t, dt') ->
    let t' = if ps = [] then t else  (* optimization *)
      Subst.subst_typ (arg_subst Subst.empty ps args) t in
    t'.it, aliased dt'
  | _ps, Opaque -> VarT (id, args), `NoAlias
  | _ps, Transp ->
    error_id (id.it $ at) "invalid forward use of syntax type"
  | _ps, Family insts ->
    let env' = to_eval_env env in
    let args = List.map (Eval.reduce_arg env') args in
    let rec lookup = function
      | [] -> error_id (id.it $ at) "undefined case of syntax type family"
      | (args', t, inst')::insts' ->
        Debug.(log "el.lookup"
          (fun _ -> fmt "%s(%s) =: %s(%s)" id.it (el_args args) id.it (el_args args'))
          (fun (r, _) -> fmt "%s" (el_typ (r $ no_region )))
        ) @@ fun _ ->
        if args' = [] && args = [] then t.it, aliased_inst inst' else   (* optimisation *)
        match Eval.(match_list match_arg env' Subst.empty args args') with
        | None -> lookup insts'
        | Some s -> (Subst.subst_typ s t).it, aliased_inst inst'
        | exception _ -> lookup insts'  (* assume coherent matches *)
          (* error at "cannot reduce type family application" *)
    in lookup insts

(* Only expand aliases *)
let rec expand' env = function
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args id.at with
    | t1', `Alias -> expand' env t1'
    | _, `NoAlias -> t'
    | exception Error _ -> t'
    )
  | ParenT t -> expand' env t.it
  | t' -> t'

let expand env t = expand' env t.it

(* Expand all but the last alias. TODO: remove *)
exception Last
let rec expand_nondef' env t =
  match t.it with
  | VarT (id, args) ->
    (match as_defined_typid' env id args id.at with
    | t1', `Alias -> (try expand_nondef' env (t1' $ t.at) with Last -> t)
    | _, `NoAlias -> t
    | exception Error _ -> t
    )
  | ParenT t1 -> expand_nondef' env t1
  | _ -> raise Last

let expand_nondef env t = try expand_nondef' env t with Last -> t

(* Expand definitions *)
let expand_def env t =
  match expand' env t.it with
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args id.at with
    | t1', _ -> t1'
    | exception Error _ -> t'
    )
  | t' -> t'

let rec expand_id env t =
  match (expand_nondef env t).it with
  | VarT (id, _) -> id
  | IterT (t1, _) -> expand_id env t1  (* TODO: this shouldn't be needed, but goes along with the as_*_typ functions unrolling iterations *)
  | _ -> "" $ no_region

let rec expand_iter_notation env t =
  match expand env t with
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args t.at with
    | IterT _ as t'', _ -> t''
    | ConT ((t1, _), _), _ -> expand_iter_notation env t1
    | _ -> t'
    )
  | ConT ((t1, _), _) -> expand_iter_notation env t1
  | t' -> t'

let expand_singular env t =
  match expand env t with
  | IterT (t1, (Opt | List | List1)) -> expand env t1
  | t' -> t'


let as_iter_typ_opt env t : (typ * iter) option =
  match expand env t with IterT (t1, iter) -> Some (t1, iter) | _ -> None

let as_list_typ_opt env t : typ option =
  match expand env t with IterT (t1, List) -> Some t1 | _ -> None

let as_iter_notation_typ_opt env t : (typ * iter) option =
  match expand_iter_notation env t with IterT (t1, iter) -> Some (t1, iter) | _ -> None

let as_opt_notation_typ_opt env t : typ option =
  match expand_iter_notation env t with IterT (t1, Opt) -> Some t1 | _ -> None

let as_tup_typ_opt env t : typ list option =
  match expand_singular env t with TupT ts -> Some ts | _ -> None


let as_x_typ as_t_opt phrase env dir t at shape =
  match as_t_opt env t with
  | Some x -> x
  | None -> error_dir_typ env at phrase dir t shape

let as_iter_typ phrase env dir t at =
  as_x_typ as_iter_typ_opt phrase env dir t at "(_)*"
let as_list_typ phrase env dir t at =
  as_x_typ as_list_typ_opt phrase env dir t at "(_)*"
let as_tup_typ phrase env dir t at =
  as_x_typ as_tup_typ_opt phrase env dir t at "(_, ..., _)"
let as_iter_notation_typ phrase env dir t at =
  as_x_typ as_iter_notation_typ_opt phrase env dir t at "(_)*"
let as_opt_notation_typ phrase env dir t at =
  as_x_typ as_opt_notation_typ_opt phrase env dir t at "(_)?"


let rec as_notation_typid' phrase env id args at : typ =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_notation_typid' phrase env id' args' at
  | ConT ((t, _), _), _ -> t
  | (AtomT _ | SeqT _ | InfixT _ | BrackT _ | IterT _) as t, _ -> t $ at
  | _ -> error_dir_typ env at phrase Infer (VarT (id, args) $ id.at) "_ ... _"

let as_notation_typ phrase env dir t at : typ =
  match expand_singular env t with
  | VarT (id, args) -> as_notation_typid' phrase env id args at
  | _ -> error_dir_typ env at phrase dir t "_ ... _"

let rec as_struct_typid' phrase env id args at : typfield list =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_struct_typid' phrase env id' args' at
  | StrT tfs, _ -> filter_nl tfs
  | _ -> error_dir_typ env at phrase Infer (VarT (id, args) $ id.at) "| ..."

let as_struct_typ phrase env dir t at : typfield list =
  match expand_singular env t with
  | VarT (id, args) -> as_struct_typid' phrase env id args at
  | _ -> error_dir_typ env at phrase dir t "{...}"

let rec as_variant_typid' phrase env id args at : typcase list * dots =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_variant_typid' phrase env id' args' at
  | CaseT (_dots1, ts, cases, dots2), _ ->
    let casess = map_filter_nl_list (fun t -> as_variant_typ "" env Infer t at) ts in
    List.concat (filter_nl cases :: List.map fst casess), dots2
  | _ -> error_dir_typ env id.at phrase Infer (VarT (id, args) $ id.at) "| ..."

and as_variant_typid phrase env id args : typcase list * dots =
  as_variant_typid' phrase env id args id.at

and as_variant_typ phrase env dir t at : typcase list * dots =
  match expand_singular env t with
  | VarT (id, args) -> as_variant_typid' phrase env id args at
  | _ -> error_dir_typ env at phrase dir t "| ..."

let case_has_args env t op at : bool =
  let cases, _ = as_variant_typ "" env Check t at in
  let t, _prems = find_case cases op at t in
  match t.it with
  | SeqT ({it = AtomT _; _}::_) -> true
  | _ -> false


let is_x_typ as_x_typ env t =
  try ignore (as_x_typ "" env Check t no_region); true
  with Error _ -> false

let is_iter_typ = is_x_typ as_iter_typ
let is_iter_notation_typ = is_x_typ as_iter_notation_typ
let is_opt_notation_typ = is_x_typ as_opt_notation_typ
let is_notation_typ = is_x_typ as_notation_typ
let is_variant_typ = is_x_typ as_variant_typ


(* Type Equivalence and Shallow Numeric Subtyping *)

let equiv_typ env t1 t2 =
  Eval.equiv_typ (to_eval_env env) t1 t2

let sub_typ env t1 t2 =
  Eval.sub_typ (to_eval_env env) t1 t2


(* Hints *)

let elab_hint tid {hintid; hintexp} : Il.hint =
  let module IterAtoms =
    Iter.Make(struct include Iter.Skip let visit_atom atom = atom.note := tid.it end)
  in
  IterAtoms.exp hintexp;
  let ss =
    match hintexp.it with
    | SeqE es -> List.map Print.string_of_exp es
    | _ -> [Print.string_of_exp hintexp]
  in
  {Il.hintid; Il.hintexp = ss}

let elab_hints tid = List.map (elab_hint tid)


(* Atoms and Operators *)

let elab_atom atom tid =
  atom.note := tid.it;
  (match atom.it with
  | Atom s -> Il.Atom s
  | Infinity -> Il.Infinity
  | Bot -> Il.Bot
  | Top -> Il.Top
  | Dot -> Il.Dot
  | Dot2 -> Il.Dot2
  | Dot3 -> Il.Dot3
  | Semicolon -> Il.Semicolon
  | Backslash -> Il.Backslash
  | In -> Il.In
  | Arrow -> Il.Arrow
  | Arrow2 -> Il.Arrow2
  | Colon -> Il.Colon
  | Sub -> Il.Sub
  | Sup -> Il.Sup
  | Assign -> Il.Assign
  | Equal -> Il.Equal
  | Equiv -> Il.Equiv
  | Approx -> Il.Approx
  | SqArrow -> Il.SqArrow
  | SqArrowStar -> Il.SqArrowStar
  | Prec -> Il.Prec
  | Succ -> Il.Succ
  | Turnstile -> Il.Turnstile
  | Tilesturn -> Il.Tilesturn
  | Quest -> Il.Quest
  | Plus -> Il.Plus
  | Star -> Il.Star
  | Comma -> Il.Comma
  | Comp -> Il.Comp
  | Bar -> Il.Bar
  | BigComp -> Il.BigComp
  | BigAnd -> Il.BigAnd
  | BigOr -> Il.BigOr
  | LParen -> Il.LParen
  | RParen -> Il.RParen
  | LBrack -> Il.LBrack
  | RBrack -> Il.RBrack
  | LBrace -> Il.LBrace
  | RBrace -> Il.RBrace
  ) $$ atom.at % !(atom.note)

let numtyps = [NatT; IntT; RatT; RealT]

let elab_numtyp t : Il.numtyp =
  match t with
  | NatT -> Il.NatT
  | IntT -> Il.IntT
  | RatT -> Il.RatT
  | RealT -> Il.RealT

let infer_numop fop' ts =
  List.map (fun t -> fop' (elab_numtyp t), NumT t) ts

let infer_unop' = function
  | NotOp -> [Il.NotOp, BoolT]
  | PlusOp -> infer_numop (fun t -> Il.PlusOp t) (List.tl numtyps)
  | MinusOp -> infer_numop (fun t -> Il.MinusOp t) (List.tl numtyps)
  | PlusMinusOp -> infer_numop (fun t -> Il.PlusMinusOp t) (List.tl numtyps)
  | MinusPlusOp -> infer_numop (fun t -> Il.MinusPlusOp t) (List.tl numtyps)

let infer_binop' = function
  | AndOp -> [Il.AndOp, BoolT]
  | OrOp -> [Il.OrOp, BoolT]
  | ImplOp -> [Il.ImplOp, BoolT]
  | EquivOp -> [Il.EquivOp, BoolT]
  | AddOp -> infer_numop (fun t -> Il.AddOp t) numtyps
  | SubOp -> infer_numop (fun t -> Il.SubOp t) numtyps
  | MulOp -> infer_numop (fun t -> Il.MulOp t) numtyps
  | DivOp -> infer_numop (fun t -> Il.DivOp t) numtyps
  | ExpOp -> infer_numop (fun t -> Il.ExpOp t) numtyps

let infer_cmpop' = function
  | EqOp -> `Poly Il.EqOp
  | NeOp -> `Poly Il.NeOp
  | LtOp -> `Over (infer_numop (fun t -> Il.LtOp t) numtyps)
  | GtOp -> `Over (infer_numop (fun t -> Il.GtOp t) numtyps)
  | LeOp -> `Over (infer_numop (fun t -> Il.LeOp t) numtyps)
  | GeOp -> `Over (infer_numop (fun t -> Il.GeOp t) numtyps)

let infer_unop env op t1 at : Il.unop * typ =
  let ops = infer_unop' op in
  match List.find_opt (fun (_, t) -> sub_typ env t1 (t $ at)) ops with
  | Some (op', t) -> op', t $ at
  | None ->
    error at ("unary operator `" ^ string_of_unop op ^
      "` is not defined for operand type `" ^ string_of_typ t1 ^ "`")

let infer_binop env op t1 t2 at : Il.binop * typ =
  let ops = infer_binop' op in
  match
    List.find_opt (fun (_, t) ->
      sub_typ env t1 (t $ at) && sub_typ env t2 (t $ at)) ops
  with
  | Some (op', t) -> op', t $ at
  | None ->
    error at ("binary operator `" ^ string_of_binop op ^
      "` is not defined for operand types `" ^
      string_of_typ t1 ^ "` and `" ^ string_of_typ t2 ^ "`")

let infer_cmpop env op
  : [`Poly of Il.cmpop | `Over of typ -> typ -> region -> Il.cmpop * typ] =
  match infer_cmpop' op with
  | `Poly op' -> `Poly op'
  | `Over ops -> `Over (fun t1 t2 at ->
    match
      List.find_opt (fun (_, t) ->
        sub_typ env t1 (t $ at) && sub_typ env t2 (t $ at)) ops
    with
    | Some (op', t) -> op', t $ at
    | None ->
      error at ("comparison operator `" ^ string_of_cmpop op ^
        "` is not defined for operand types `" ^
        string_of_typ t1 ^ "` and `" ^ string_of_typ t2 ^ "`")
    )

let merge_mixop mixop1 mixop2 =
  match mixop1, mixop2 with
  | _, [] -> mixop1
  | [], _ -> mixop2
  | mixop1, atoms2::mixop2' ->
    let mixop1', atoms1 = Lib.List.split_last mixop1 in
    mixop1' @ [atoms1 @ atoms2] @ mixop2'


let check_atoms phrase item list at =
  let _, dups =
    List.fold_right (fun (atom, _, _) (set, dups) ->
      let s = Print.string_of_atom atom in
      if Set.mem s set then (set, s::dups) else (Set.add s set, dups)
    ) list (Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let rec elab_iter env iter : Il.iter =
  match iter with
  | Opt -> Il.Opt
  | List -> Il.List
  | List1 -> Il.List1
  | ListN (e, id_opt) ->
    Option.iter (fun id ->
      let e' = elab_exp env (VarE (id, []) $ id.at) (NumT NatT $ id.at) in
      (* TODO: extend IL to allow arbitrary pattern exps *)
      match e'.it with
      | Il.VarE _ -> ()
      | _ -> error_typ env id.at "iteration variable" (NumT NatT $ id.at)
    ) id_opt;
    Il.ListN (elab_exp env e (NumT NatT $ e.at), id_opt)


(* Types *)

and elab_typ env t : Il.typ =
  match t.it with
  | VarT (id, as_) ->
    let id' = strip_var_suffix id in
    let ps, _ = find "syntax type" env.typs id' in
    let as', _s = elab_args `Rhs env as_ ps t.at in
    Il.VarT (id', as') $ t.at
  | BoolT -> Il.BoolT $ t.at
  | NumT t' -> Il.NumT (elab_numtyp t') $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> tup_typ' (List.map (elab_typ env) ts) t.at
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in syntax type"
    | _ -> Il.IterT (elab_typ env t1, elab_iter env iter) $ t.at
    )
  | StrT _ | CaseT _ | ConT _ | RangeT _ | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    error t.at "this type is only allowed in type definitions"

and elab_typ_definition env tid t : Il.deftyp =
  assert (tid.it <> "");
  (match t.it with
  | StrT tfs ->
    let tfs' = filter_nl tfs in
    check_atoms "record" "field" tfs' t.at;
    Il.StructT (map_filter_nl_list (elab_typfield env tid t.at) tfs)
  | CaseT (dots1, ts, cases, _dots2) ->
    let cases0 =
      if dots1 = Dots then fst (as_variant_typid "own type" env tid []) else [] in
    let casess = map_filter_nl_list (fun t -> as_variant_typ "parent type" env Infer t t.at) ts in
    let cases' =
      List.flatten (cases0 :: List.map fst casess @ [filter_nl cases]) in
    let tcs' = List.map (elab_typcase env tid t.at) cases' in
    check_atoms "variant" "case" cases' t.at;
    Il.VariantT tcs'
  | ConT tc ->
    let tc' = elab_typcon env tid t.at tc in
    Il.VariantT [tc']
  | RangeT tes ->
    let ts_fes' = map_filter_nl_list (elab_typenum env tid) tes in
    let t1, fe' =
      List.fold_left (fun (t, fe') (tI, feI') ->
        (if sub_typ env tI t then t else tI),
        fun eid' nt ->
        let e' = fe' eid' nt and eI' = feI' eid' nt in
        let at = Source.over_region [e'.at; eI'.at] in
        Il.(BinE (OrOp, e', eI') $$ at % (BoolT $ at))
      ) (List.hd ts_fes') (List.tl ts_fes')
    in
    let t' = elab_typ env t1 in
    let nt = match t1.it with NumT nt -> nt | _ -> assert false in
    let id' = "i" $ t.at in
    let eid' = Il.VarE id' $$ t.at % t' in
    let bs' = [Il.ExpB (id', t', []) $ t.at] in
    let prems' = [Il.IfPr (fe' eid' nt) $ t.at] in
    let tc' = ([[]; []], (bs', Il.TupT [(eid', t')] $ t.at, prems'), []) in
    Il.VariantT [tc']
  | _ ->
    let t' = elab_typ env t in
    Il.AliasT t'
  ) $ t.at

and typ_rep env t : typ =
  Debug.(log_at "el.typ_rep" t.at
    (fun _ -> fmt "%s" (el_typ t))
    (fun r -> fmt "%s" (el_typ r))
  ) @@ fun _ ->
  match expand_def env t with
  | ConT ((t1, _), _) -> t1
  | RangeT tes ->
    let ts_fes' = map_filter_nl_list (elab_typenum env (expand_id env t)) tes in
    List.fold_left (fun t (tI, _) ->
      if sub_typ env tI t then t else tI
    ) (fst (List.hd ts_fes')) (List.tl ts_fes')
  | _ -> t

and elab_typfield env tid at ((atom, (t, prems), hints) as tf) : Il.typfield =
  assert (tid.it <> "");
  let env' = local_env env in
  let _mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = List.map (Dim.annot_exp dims') (List.map2 (elab_exp env') es ts) in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(union (free_list det_exp es) (det_prems prems)) in
  let free = Free.(diff (free_typfield tf) (union det (bound_env env))) in
  if free <> Free.empty then
    error at ("type case contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.exp es;
  Acc.prems prems;
  ( elab_atom atom tid,
    (!acc_bs', (if prems = [] then tup_typ' else tup_typ_bind' es') ts' t.at, prems'),
    elab_hints tid hints
  )

and elab_typcase env tid at ((_atom, (t, prems), hints) as tc) : Il.typcase =
  assert (tid.it <> "");
  let env' = local_env env in
  let mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = List.map (Dim.annot_exp dims') (List.map2 (elab_exp env') es ts) in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(union (free_list det_exp es) (det_prems prems)) in
  let free = Free.(diff (free_typcase tc) (union det (bound_env env))) in
  if free <> Free.empty then
    error at ("type case contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.exp es;
  Acc.prems prems;
  ( mixop,
    (!acc_bs', tup_typ_bind' es' ts' at, prems'),
    elab_hints tid hints
  )

and elab_typcon env tid at (((t, prems), hints) as tc) : Il.typcase =
  assert (tid.it <> "");
  let env' = local_env env in
  let mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = List.map (Dim.annot_exp dims') (List.map2 (elab_exp env') es ts) in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(union (free_list det_exp es) (det_prems prems)) in
  let free = Free.(diff (free_typcon tc) (union det (bound_env env))) in
  if free <> Free.empty then
    error at ("type constraint contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.exp es;
  Acc.prems prems;
  ( mixop,
    (!acc_bs', tup_typ_bind' es' ts' at, prems'),
    elab_hints tid hints
  )

and elab_typenum env tid (e1, e2o) : typ * (Il.exp -> numtyp -> Il.exp) =
  assert (tid.it <> "");
  let _e1' = elab_exp env e1 (NumT IntT $ e1.at) in  (* ensure it's <= int *)
  let _, t1 = infer_exp env e1 in                    (* get precise type *)
  match e2o with
  | None ->
    t1,
    fun eid' nt ->
    let e1' = elab_exp env e1 (NumT nt $ e1.at) in  (* redo with overall type *)
    Il.(CmpE (EqOp, eid', e1') $$ e1'.at % (BoolT $ e1.at))
  | Some e2 ->
    let at = Source.over_region [e1.at; e2.at] in
    let _e2' = elab_exp env e2 (NumT IntT $ e2.at) in
    let _, t2 = infer_exp env e2 in
    (if sub_typ env t2 t1 then t1 else t2).it $ at,
    fun eid' nt ->
    let e1' = elab_exp env e1 (NumT nt $ e1.at) in
    let e2' = elab_exp env e2 (NumT nt $ e2.at) in
    let nt' = elab_numtyp nt in
    Il.(BinE (AndOp,
      CmpE (GeOp nt', eid', e1') $$ e1'.at % (BoolT $ e1.at),
      CmpE (LeOp nt', eid', e2') $$ e2'.at % (BoolT $ e2.at)
    ) $$ at % (BoolT $ at))

and elab_typ_notation env tid t : Il.mixop * Il.typ list * typ list =
  Debug.(log_at "el.elab_typ_notation" t.at
    (fun _ -> fmt "%s = %s" tid.it (el_typ t))
    (fun (mixop, ts', _) -> fmt "%s(%s)" (il_mixop mixop) (list il_typ ts'))
  ) @@ fun _ ->
  assert (tid.it <> "");
  match t.it with
  | VarT (id, as_) ->
    let id' = strip_var_suffix id in
    (match find "syntax type" env.typs id' with
    | _, Transp -> error_id id "invalid forward reference to syntax type"
    | ps, _ ->
      let as', _s = elab_args `Rhs env as_ ps t.at in
      [[]; []], [Il.VarT (id', as') $ t.at], [t]
    )
  | AtomT atom ->
    [[elab_atom atom tid]], [], []
  | SeqT [] ->
    [[]], [], []
  | SeqT (t1::ts2) ->
    let mixop1, ts1', ts1 = elab_typ_notation env tid t1 in
    let mixop2, ts2', ts2 = elab_typ_notation env tid (SeqT ts2 $ t.at) in
    merge_mixop mixop1 mixop2, ts1' @ ts2', ts1 @ ts2
  | InfixT (t1, atom, t2) ->
    let mixop1, ts1', ts1 = elab_typ_notation env tid t1 in
    let mixop2, ts2', ts2 = elab_typ_notation env tid t2 in
    merge_mixop (merge_mixop mixop1 [[elab_atom atom tid]]) mixop2,
      ts1' @ ts2', ts1 @ ts2
  | BrackT (l, t1, r) ->
    let mixop1, ts1', ts1 = elab_typ_notation env tid t1 in
    merge_mixop (merge_mixop [[elab_atom l tid]] mixop1) [[elab_atom r tid]],
      ts1', ts1
  | ParenT t1 ->
    let mixop1, ts1', ts1 = elab_typ_notation env tid t1 in
    let l = Il.LParen $$ t.at % tid.it in
    let r = Il.RParen $$ t.at % tid.it in
    merge_mixop (merge_mixop [[l]] mixop1) [[r]], ts1', ts1
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in notation type"
    | _ ->
      let mixop1, ts1', ts1 = elab_typ_notation env tid t1 in
      let iter' = elab_iter env iter in
      let tit = IterT (tup_typ ts1 t1.at, iter) $ t.at in
      let t' = Il.IterT (tup_typ' ts1' t1.at, iter') $ t.at in
      let op = (match iter with Opt -> Il.Quest | _ -> Il.Star) $$ t.at % tid.it in
      (if mixop1 = [[]; []] then mixop1 else [List.flatten mixop1] @ [[op]]),
      [t'], [tit]
    )
  | _ ->
    [[]; []], [elab_typ env t], [t]


and (!!!) env tid t =
  let _, ts', _ = elab_typ_notation env tid t in tup_typ' ts' t.at


(* Expressions *)

and must_elab_exp env e =
  match e.it with
  | VarE (id, _) -> not (bound env.vars id || bound env.gvars (strip_var_suffix id))
  | AtomE _ | BrackE _ | InfixE _ | EpsE | SeqE _ | StrE _ -> true
  | ParenE (e1, _) | IterE (e1, _) -> must_elab_exp env e1
  | TupE es -> List.exists (must_elab_exp env) es
  | _ -> false

and infer_exp env e : Il.exp * typ =
  Debug.(log_at "el.infer_exp" e.at
    (fun _ -> fmt "%s" (el_exp e))
    (fun (e', t) -> fmt "%s : %s" (il_exp e') (el_typ t))
  ) @@ fun _ ->
  let e', t = infer_exp' env e in
  e' $$ e.at % elab_typ env t, t

and infer_exp' env e : Il.exp' * typ =
  match e.it with
  | VarE (id, args) ->
    if args <> [] then
      (* Args may only occur due to syntactic overloading with types *)
      error e.at "malformed expression";
    if id.it = "_" then
      error e.at "cannot infer type of wildcard";
    let t =
      if bound env.vars id then
        find "variable" env.vars id
      else
        (* If the variable itself is not yet declared, use type hint if available. *)
        let t =
          try find "variable" env.gvars (strip_var_suffix id) with Error _ ->
            find "variable" env.vars id  (* just to get the proper error message *)
        in
        env.vars <- bind "variable" env.vars id t;
        t
    in
    Il.VarE id, t
  | AtomE _ ->
    error e.at "cannot infer type of atom"
  | BoolE b ->
    Il.BoolE b, BoolT $ e.at
  | NatE (_op, n) ->
    Il.NatE n, NumT NatT $ e.at
  | TextE s ->
    Il.TextE s, TextT $ e.at
  | UnE (op, e1) ->
    let e1', t1 = infer_exp env e1 in
    let op', t = infer_unop env op (typ_rep env t1) e.at in
    Il.UnE (op', cast_exp "operand" env e1' t1 t), t
  | BinE (e1, op, e2) ->
    let e1', t1 = infer_exp env e1 in
    let e2', t2 = infer_exp env e2 in
    let op', t = infer_binop env op (typ_rep env t1) (typ_rep env t2) e.at in
    Il.BinE (op',
      cast_exp "operand" env e1' t1 t,
      cast_exp "operand" env e2' t2 t
    ), t
  | CmpE (e1, op, ({it = CmpE (e21, _, _); _} as e2)) ->
    let e1', _t1 = infer_exp env (CmpE (e1, op, e21) $ e.at) in
    let e2', _t2 = infer_exp env e2 in
    Il.BinE (Il.AndOp, e1', e2'), BoolT $ e.at
  | CmpE (e1, op, e2) ->
    (match infer_cmpop env op with
    | `Poly op' ->
      let e1', e2' =
        if must_elab_exp env e1 then
          let e2', t2 = infer_exp env e2 in
          let e1' = elab_exp env e1 t2 in
          e1', e2'
        else
          let e1', t1 = infer_exp env e1 in
          let e2' = elab_exp env e2 t1 in
          e1', e2'
      in
      Il.CmpE (op', e1', e2'), BoolT $ e.at
    | `Over elab_cmpop'  ->
      let e1', t1 = infer_exp env e1 in
      let e2', t2 = infer_exp env e2 in
      let op', t = elab_cmpop' (typ_rep env t1) (typ_rep env t2) e.at in
      Il.CmpE (op',
        cast_exp "operand" env e1' t1 t,
        cast_exp "operand" env e2' t2 t
      ), BoolT $ e.at
    )
  | IdxE (e1, e2) ->
    let e1', t1 = infer_exp env e1 in
    let t = as_list_typ "expression" env Infer t1 e1.at in
    let e2' = elab_exp env e2 (NumT NatT $ e2.at) in
    Il.IdxE (e1', e2'), t
  | SliceE (e1, e2, e3) ->
    let e1', t1 = infer_exp env e1 in
    let _t' = as_list_typ "expression" env Infer t1 e1.at in
    let e2' = elab_exp env e2 (NumT NatT $ e2.at) in
    let e3' = elab_exp env e3 (NumT NatT $ e3.at) in
    Il.SliceE (e1', e2', e3'), t1
  | UpdE (e1, p, e2) ->
    let e1', t1 = infer_exp env e1 in
    let p', t2 = elab_path env p t1 in
    let e2' = elab_exp env e2 t2 in
    Il.UpdE (e1', p', e2'), t1
  | ExtE (e1, p, e2) ->
    let e1', t1 = infer_exp env e1 in
    let p', t2 = elab_path env p t1 in
    let _t21 = as_list_typ "path" env Infer t2 p.at in
    let e2' = elab_exp env e2 t2 in
    Il.ExtE (e1', p', e2'), t1
  | StrE _ ->
    error e.at "cannot infer type of record"
  | DotE (e1, atom) ->
    let e1', t1 = infer_exp env e1 in
    let tfs = as_struct_typ "expression" env Infer t1 e1.at in
    let t, prems = find_field tfs atom e1.at t1 in
    let e' = Il.DotE (e1', elab_atom atom (expand_id env t1)) in
    let e'' = if prems = [] then e' else Il.ProjE (e' $$ e.at % elab_typ env t, 0) in
    e'', t
  | CommaE (e1, e2) ->
    let e1', t1 = infer_exp env e1 in
    let tfs = as_struct_typ "expression" env Infer t1 e1.at in
    (* TODO: this is a bit of a hack *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let _t2 = find_field tfs atom at t1 in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t1 in
      Il.CompE (e1', e2'), t1
    | _ -> failwith "unimplemented: infer CommaE"
    )
  | CompE (e1, e2) ->
    let e1', t1 = infer_exp env e1 in
    let _ = as_struct_typ "record" env Infer t1 e.at in
    let e2' = elab_exp env e2 t1 in
    Il.CompE (e1', e2'), t1
  | LenE e1 ->
    let e1', t1 = infer_exp env e1 in
    let _t11 = as_list_typ "expression" env Infer t1 e1.at in
    Il.LenE e1', NumT NatT $ e.at
  | SizeE id ->
    let _ = find "grammar" env.syms id in
    NatE Z.zero, NumT NatT $ e.at
  | ParenE (e1, _) ->
    infer_exp' env e1
  | TupE es ->
    let es', ts = List.split (List.map (infer_exp env) es) in
    Il.TupE es', TupT ts $ e.at
  | CallE (id, as_) ->
    let ps, t, _ = find "definition" env.defs id in
    let as', s = elab_args `Rhs env as_ ps e.at in
    Il.CallE (id, as'), Subst.subst_typ s t
  | EpsE -> error e.at "cannot infer type of empty sequence"
  | SeqE _ -> error e.at "cannot infer type of expression sequence"
  | InfixE _ -> error e.at "cannot infer type of infix expression"
  | BrackE _ -> error e.at "cannot infer type of bracket expression"
  | IterE (e1, iter) ->
    let e1', t1 = infer_exp env e1 in
    let iter' = elab_iterexp env iter in
    Il.IterE (e1', iter'), IterT (t1, match iter with ListN _ -> List | _ -> iter) $ e.at
  | TypE (e1, t) ->
    let _t' = elab_typ env t in
    (elab_exp env e1 t).it, t
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token concatenation"


and elab_exp env e t : Il.exp =
  try
    let e' = elab_exp' env e t in
    e' $$ e.at % elab_typ env t
  with Error _ when is_notation_typ env t ->
    Debug.(log_in_at "el.elab_exp" e.at
      (fun _ -> fmt "%s : %s # backtrack" (el_exp e) (el_typ t))
    );
    elab_exp_notation env (expand_id env t) e (as_notation_typ "" env Check t e.at) t

and elab_exp' env e t : Il.exp' =
  Debug.(log_at "el.elab_exp" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (el_typ t))
    (fun e' -> fmt "%s" (il_exp (e' $$ no_region % elab_typ env t)))
  ) @@ fun _ ->
  match e.it with
  | VarE (id, []) when id.it = "_" ->
    Il.VarE id
  | VarE (id, []) when not (Map.mem id.it env.vars) ->
    if bound env.gvars (strip_var_suffix id) then
      (* Variable type must be consistent with possible type hint. *)
      let t' = find "" env.gvars (strip_var_suffix id) in
      env.vars <- bind "variable" env.vars id t';
      let e' = elab_exp env e t' in
      cast_exp' "variable" env e' t' t
    else (
      env.vars <- bind "variable" env.vars id t;
      Il.VarE id
    )
  | VarE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "variable" env e' t' t
  | BoolE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "boolean" env e' t' t
  | NatE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "number" env e' t' t
  | TextE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "text" env e' t' t
  | UnE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "unary operator" env e' t' t
  | BinE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "binary operator" env e' t' t
  | CmpE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "comparison operator" env e' t' t
  | IdxE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "list element" env e' t' t
  | SliceE (e1, e2, e3) ->
    let _t' = as_list_typ "expression" env Check t e1.at in
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp env e2 (NumT NatT $ e2.at) in
    let e3' = elab_exp env e3 (NumT NatT $ e3.at) in
    Il.SliceE (e1', e2', e3')
  | UpdE (e1, p, e2) ->
    let e1' = elab_exp env e1 t in
    let p', t2 = elab_path env p t in
    let e2' = elab_exp env e2 t2 in
    Il.UpdE (e1', p', e2')
  | ExtE (e1, p, e2) ->
    let e1' = elab_exp env e1 t in
    let p', t2 = elab_path env p t in
    let _t21 = as_list_typ "path" env Check t2 p.at in
    let e2' = elab_exp env e2 t2 in
    Il.ExtE (e1', p', e2')
  | StrE efs ->
    let tfs = as_struct_typ "record" env Check t e.at in
    let efs' = elab_expfields env (expand_id env t) (filter_nl efs) tfs t e.at in
    Il.StrE efs'
  | DotE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "projection" env e' t' t
  | CommaE (e1, e2) ->
    let e1' = elab_exp env e1 t in
    let tfs = as_struct_typ "expression" env Check t e1.at in
    (* TODO: this is a bit of a hack *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let _t2 = find_field tfs atom at t in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t in
      Il.CompE (e1', e2')
    | _ -> failwith "unimplemented: check CommaE"
    )
  | CompE (e1, e2) ->
    let _ = as_struct_typ "record" env Check t e.at in
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp env e2 t in
    Il.CompE (e1', e2')
  | LenE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "list length" env e' t' t
  | SizeE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "expansion length" env e' t' t
  | ParenE (e1, true) when is_iter_typ env t ->
    (* Significant parentheses indicate a singleton *)
    let t1, _iter = as_iter_typ "expression" env Check t e.at in
    let e1' = elab_exp env e1 t1 in
    cast_exp' "expression" env e1' t1 t
  | ParenE (e1, _) ->
    elab_exp' env e1 t
  | TupE es ->
    let ts = as_tup_typ "tuple" env Check t e.at in
    if List.length es <> List.length ts then
      error e.at "arity mismatch for expression list";
    let es' = List.map2 (elab_exp env) es ts in
    Il.TupE es'
  | CallE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "function application" env e' t' t
  | EpsE | SeqE _ when is_iter_typ env t ->
    let es = unseq_exp e in
    elab_exp_iter' env es (as_iter_typ "" env Check t e.at) t e.at
  | EpsE
  | AtomE _
  | InfixE _
  | BrackE _
  | SeqE _ ->
    (* All these expression forms can only be used when checking against
     * either a defined notation/variant type or (for SeqE) an iteration type;
     * the latter case is already captured above *)
    if is_notation_typ env t then
      let nt = as_notation_typ "" env Check t e.at in
      (elab_exp_notation env (expand_id env t) e nt t).it
    else if is_variant_typ env t then
      let tcs, _ = as_variant_typ "" env Check t e.at in
      (elab_exp_variant env (expand_id env t) e tcs t e.at).it
    else
      error_typ env e.at "expression" t
  | IterE (e1, iter2) ->
    (* An iteration expression must match the expected type directly,
     * significant parentheses have to be used otherwise *)
    let t1, iter = as_iter_typ "iteration" env Check t e.at in
    if (iter = Opt) <> (iter2 = Opt) then
      error_typ env e.at "iteration expression" t;
    let e1' = elab_exp env e1 t1 in
    let iter2' = elab_iterexp env iter2 in
    Il.IterE (e1', iter2')
  | TypE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "type annotation" env e' t' t
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token fuse"

and elab_expfields env tid efs tfs t0 at : Il.expfield list =
  Debug.(log_in_at "el.elab_expfields" at
    (fun _ -> fmt "{%s} : {%s} = %s" (list el_expfield efs) (list el_typfield tfs) (el_typ t0))
  );
  assert (tid.it <> "");
  match efs, tfs with
  | [], [] -> []
  | (atom1, e)::efs2, (atom2, (t, prems), _)::tfs2 when atom1.it = atom2.it ->
    let es', _s = elab_exp_notation' env tid e t in
    let efs2' = elab_expfields env tid efs2 tfs2 t0 at in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') es' e.at in
    (elab_atom atom1 tid, e') :: efs2'
  | _, (atom, (t, prems), _)::tfs2 ->
    let atom' = string_of_atom atom in
    let es' =
      [cast_empty ("omitted record field `" ^ atom' ^ "`") env t at (elab_typ env t)] in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') es' at in
    let efs2' = elab_expfields env tid efs tfs2 t0 at in
    (elab_atom atom tid, e') :: efs2'
  | (atom, e)::_, [] ->
    error_atom e.at atom t0 "undefined or misplaced record field"

and elab_exp_iter env es (t1, iter) t at : Il.exp =
  let e' = elab_exp_iter' env es (t1, iter) t at in
  e' $$ at % elab_typ env t

and elab_exp_iter' env es (t1, iter) t at : Il.exp' =
  Debug.(log_at "el.elab_exp_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (el_typ t) (el_typ t1) (el_iter iter))
    (fun e' -> fmt "%s" (il_exp (e' $$ at % elab_typ env t)))
  ) @@ fun _ ->
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, _
    when is_variant_typ env t1 && case_has_args env t1 atom at1 ->
    let cases, _dots = as_variant_typ "" env Check t1 at in
    lift_exp' (elab_exp_variant env (expand_id env t1) (SeqE es $ at) cases t1 at) iter

  (* An empty sequence represents the None case for options *)
  | [], Opt ->
    Il.OptE None
  (* An empty sequence represents the Nil case for lists *)
  | [], List ->
    Il.ListE []
  (* All other elements are either splices or (by cast injection) elements *)
  | e1::es2, List ->
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp_iter env es2 (t1, iter) t at in
    cat_exp' e1' e2'

  | _, _ ->
    error_typ env at "expression" t

and elab_exp_notation env tid e nt t : Il.exp =
  (* Convert notation into applications of mixin operators *)
  assert (tid.it <> "");
  let es', _s = elab_exp_notation' env tid e nt in
  let mixop, _, _ = elab_typ_notation env tid nt in
  Il.CaseE (mixop, tup_exp_bind' es' e.at) $$ e.at % elab_typ env t

and elab_exp_notation' env tid e t : Il.exp list * Subst.t =
  Debug.(log_at "el.elab_exp_notation" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (el_typ t))
    (fun (es', _) -> fmt "%s" (seq il_exp es'))
  ) @@ fun _ ->
  assert (tid.it <> "");
  match e.it, t.it with
  | AtomE atom, AtomT atom' ->
    if atom.it <> atom'.it then error_typ env e.at "atom" t;
    ignore (elab_atom atom tid);
    [], Subst.empty
  | InfixE (e1, atom, e2), InfixT (t1, atom', t2) ->
    if atom.it <> atom'.it then error_typ env e.at "infix expression" t;
    let es1', s1 = elab_exp_notation' env tid e1 t1 in
    let es2', s2 = elab_exp_notation' env tid e2 (Subst.subst_typ s1 t2) in
    ignore (elab_atom atom tid);
    es1' @ es2', Subst.union s1 s2
  | BrackE (l, e1, r), BrackT (l', t1, r') ->
    if (l.it, r.it) <> (l'.it, r'.it) then error_typ env e.at "bracket expression" t;
    ignore (elab_atom l tid);
    ignore (elab_atom r tid);
    elab_exp_notation' env tid e1 t1

  | SeqE [], SeqT [] ->
    [], Subst.empty
  (* Iterations at the end of a sequence may be inlined *)
  | _, SeqT [t1] when is_iter_typ env t1 ->
    elab_exp_notation' env tid e t1
  (* Optional iterations may always be inlined, use backtracking *)
  | SeqE (e1::es2), SeqT (t1::ts2) when is_opt_notation_typ env t1 ->
    (try
      let es1' = [cast_empty "omitted sequence tail" env t1 e.at (!!!env tid t1)] in
      let es2', s2 = elab_exp_notation' env tid e (SeqT ts2 $ t.at) in
      es1' @ es2', s2
    with Error _ ->
      Debug.(log_in_at "el.elab_exp_notation" e.at
        (fun _ -> fmt "%s : %s # backtrack" (el_exp e) (el_typ t))
      );
      let es1', s1 = elab_exp_notation' env tid e1 t1 in
      let es2', s2 =
        elab_exp_notation' env tid (SeqE es2 $ e.at) (Subst.subst_typ s1 (SeqT ts2 $ t.at)) in
      es1' @ es2', Subst.union s2 s2
    )
  | SeqE (e1::es2), SeqT (t1::ts2) ->
    let es1', s1 = elab_exp_notation' env tid (unparen_exp e1) t1 in
    let es2', s2 =
      elab_exp_notation' env tid (SeqE es2 $ e.at) (Subst.subst_typ s1 (SeqT ts2 $ t.at)) in
    es1' @ es2', Subst.union s1 s2
  (* Trailing elements can be omitted if they can be eps *)
  | SeqE [], SeqT (t1::ts2) ->
    let es1' = [cast_empty "omitted sequence tail" env t1 e.at (!!!env tid t1)] in
    let es2', s2 =
      elab_exp_notation' env tid (SeqE [] $ e.at) (SeqT ts2 $ t.at) in
    es1' @ es2', s2
  | SeqE (e1::_), SeqT [] ->
    error e1.at
      "superfluous expression does not match expected empty notation type"
  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, SeqT _ ->
    elab_exp_notation' env tid (SeqE [e] $ e.at) t

  | SeqE [e1], IterT _ ->
    [elab_exp env e1 t], Subst.empty
  | (EpsE | SeqE _), IterT (t1, iter) ->
    [elab_exp_notation_iter env tid (unseq_exp e) (t1, iter) t e.at], Subst.empty
  | IterE (e1, iter1), IterT (t1, iter) ->
    if iter = Opt && iter1 <> Opt then
      error_typ env e.at "iteration expression" t;
    let es1', _s1 = elab_exp_notation' env tid e1 t1 in
    let iter1' = elab_iterexp env iter1 in
    [Il.IterE (tup_exp' es1' e1.at, iter1') $$ e.at % !!!env tid t], Subst.empty
  (* Significant parentheses indicate a singleton *)
  | ParenE (e1, true), IterT (t1, iter) ->
    let es', _s = elab_exp_notation' env tid e1 t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % elab_typ env t], Subst.empty
  (* Elimination forms are considered splices *)
  | (IdxE _ | SliceE _ | UpdE _ | ExtE _ | DotE _ | CallE _), IterT _ ->
    [elab_exp env e t], Subst.empty
  (* All other expressions are considered splices *)
  (* TODO: can't they be splices, too? *)
  | _, IterT (t1, iter) ->
    let es', _s = elab_exp_notation' env tid e t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % !!!env tid t], Subst.empty

  | ParenE (e1, _), _ ->
    elab_exp_notation' env tid e1 t
  | _, ParenT t1 ->
    elab_exp_notation' env tid e t1

  | _, _ ->
    [elab_exp env e t], Subst.add_varid Subst.empty (Convert.varid_of_typ t) e


and elab_exp_notation_iter env tid es (t1, iter) t at : Il.exp =
  assert (tid.it <> "");
  let e' = elab_exp_notation_iter' env tid es (t1, iter) t at in
  let _, ts', _ = elab_typ_notation env tid t in
  e' $$ at % tup_typ' ts' t.at

and elab_exp_notation_iter' env tid es (t1, iter) t at : Il.exp' =
  Debug.(log_at "el.elab_exp_notation_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (el_typ t) (el_typ t1) (el_iter iter))
    (fun e' -> fmt "%s" (il_exp (e' $$ at % elab_typ env t)))
  ) @@ fun _ ->
  assert (tid.it <> "");
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, _
    when is_variant_typ env t1 && case_has_args env t1 atom at1 ->
    let cases, _ = as_variant_typ "expression" env Check t1 at in
    lift_exp' (elab_exp_variant env (expand_id env t1) (SeqE es $ at) cases t1 at) iter

  (* An empty sequence represents the None case for options *)
  | [], Opt ->
    Il.OptE None
  (* An empty sequence represents the Nil case for lists *)
  | [], List ->
    Il.ListE []
  (* All other elements are either splices or (by cast injection) elements;
   * nested expressions must be lifted into a tuple *)
  | e1::es2, List ->
    let es1', _s1 = elab_exp_notation' env tid e1 t in
    let e2' = elab_exp_notation_iter env tid es2 (t1, iter) t at in
    cat_exp' (tup_exp' es1' e1.at) e2'

  | _, _ ->
    error_typ env at "expression" t

and elab_exp_variant env tid e cases t at : Il.exp =
  Debug.(log_at "el.elab_exp_variant" e.at
    (fun _ -> fmt "%s : %s = %s" (el_exp e) tid.it (el_typ t))
    (fun e' -> fmt "%s" (il_exp e'))
  ) @@ fun _ ->
  assert (tid.it <> "");
  let atom =
    match e.it with
    | AtomE atom
    | SeqE ({it = AtomE atom; _}::_)
    | InfixE (_, atom, _)
    | BrackE (atom, _, _) -> atom
    | _ -> error_typ env at "expression" t
  in
  let t1, _prems = find_case cases atom at t in
  let es', _s = elab_exp_notation' env tid e t1 in
  let t2 = expand_singular env t $ at in
  let t2' = elab_typ env t2 in
  let mixop, _, _ = elab_typ_notation env tid t1 in
  cast_exp "variant case" env
    (Il.CaseE (mixop, tup_exp_bind' es' at) $$ at % t2') t2 t


and elab_path env p t : Il.path * typ =
  let p', t' = elab_path' env p t in
  p' $$ p.at % elab_typ env t', t'

and elab_path' env p t : Il.path' * typ =
  match p.it with
  | RootP ->
    Il.RootP, t
  | IdxP (p1, e1) ->
    let p1', t1 = elab_path env p1 t in
    let e1' = elab_exp env e1 (NumT NatT $ e1.at) in
    let t' = as_list_typ "path" env Check t1 p1.at in
    Il.IdxP (p1', e1'), t'
  | SliceP (p1, e1, e2) ->
    let p1', t1 = elab_path env p1 t in
    let e1' = elab_exp env e1 (NumT NatT $ e1.at) in
    let e2' = elab_exp env e2 (NumT NatT $ e2.at) in
    let _ = as_list_typ "path" env Check t1 p1.at in
    Il.SliceP (p1', e1', e2'), t1
  | DotP (p1, atom) ->
    let p1', t1 = elab_path env p1 t in
    let tfs = as_struct_typ "path" env Check t1 p1.at in
    let t', _prems = find_field tfs atom p1.at t1 in
    Il.DotP (p1', elab_atom atom (expand_id env t1)), t'


and cast_empty phrase env t at t' : Il.exp =
  Debug.(log_at "el.cast_empty" at
    (fun _ -> fmt "%s  >>  (%s)" (el_typ t) (el_typ (expand env t $ t.at)))
    (fun r -> fmt "%s" (il_exp r))
  ) @@ fun _ ->
  match expand env t with
  | IterT (_, Opt) -> Il.OptE None $$ at % t'
  | IterT (_, List) -> Il.ListE [] $$ at % t'
  | VarT _ when is_iter_notation_typ env t ->
    assert (is_notation_typ env t);
    (match expand_iter_notation env t with
    | IterT (_, iter) as t1 ->
      let mixop, ts', _ts = elab_typ_notation env (expand_id env t) (t1 $ t.at) in
      assert (List.length ts' = 1);
      let e1' = if iter = Opt then Il.OptE None else Il.ListE [] in
      Il.CaseE (mixop, tup_exp_bind' [e1' $$ at % List.hd ts'] at) $$ at % t'
    | _ -> error_typ env at phrase t
    )
  | _ -> error_typ env at phrase t

and cast_exp phrase env e' t1 t2 : Il.exp =
  let e'' = cast_exp' phrase env e' t1 t2 in
  e'' $$ e'.at % elab_typ env (expand_nondef env t2)

and cast_exp' phrase env e' t1 t2 : Il.exp' =
  Debug.(log_at "el.cast_exp" e'.at
    (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s)" (el_typ t1) (el_typ t2)
      (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
      (el_typ (expand_nondef env t2))
    )
    (fun r -> fmt "%s" (il_exp (r $$ e'.at % elab_typ env t2)))
  ) @@ fun _ ->
  if equiv_typ env t1 t2 then e'.it else
  match expand_def env t1, expand_def env t2 with
  | _, _ when sub_typ env t1 t2 ->
    let t1' = elab_typ env (expand_nondef env t1) in
    let t2' = elab_typ env (expand_nondef env t2) in
    Il.SubE (e', t1', t2')
  | ConT ((t11, _), _), ConT ((t21, _), _) ->
    let mixop1, ts1', ts1 = elab_typ_notation env (expand_id env t1) t11 in
    let mixop2, _ts2', ts2 = elab_typ_notation env (expand_id env t2) t21 in
    if mixop1 <> mixop2 then
      error_typ2 env e'.at phrase t1 t2 "";
    let e'' = Il.UncaseE (e', mixop1) $$ e'.at % tup_typ' ts1' e'.at in
    let es' = List.mapi (fun i t1I' -> Il.ProjE (e'', i) $$ e''.at % t1I') ts1' in
    let es'' = List.map2 (fun eI' (t1I, t2I) ->
      cast_exp phrase env eI' t1I t2I) es' (List.combine ts1 ts2) in
    Il.CaseE (mixop2, tup_exp_bind' es'' e'.at)
  | ConT ((t11, _), _), t2' ->
    (try
      match t2' with
      | IterT (t21, Opt) ->
        Il.OptE (Some (cast_exp phrase env e' t1 t21))
      | IterT (t21, (List | List1)) ->
        Il.ListE [cast_exp phrase env e' t1 t21]
      | _ -> raise (Error (e'.at, ""))
    with Error _ ->  (* backtrack *)
      Debug.(log_in_at "el.cast_exp" e'.at
        (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 1" (el_typ t1) (el_typ t2)
          (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
          (el_typ (expand_nondef env t2))
        )
      );
      let mixop, ts', ts = elab_typ_notation env (expand_id env t1) t11 in
      let t111, t111' = match ts, ts' with [t111], [t111'] -> t111, t111' | _ ->
        error_typ2 env e'.at phrase t1 t2 "" in
      let e'' = Il.UncaseE (e', mixop) $$ e'.at % tup_typ' ts' e'.at in
      cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2
    )
  | _, ConT ((t21, _), _) ->
    let mixop, _ts', ts = elab_typ_notation env (expand_id env t2) t21 in
    let t211 = match ts with [t211] -> t211 | _ ->
      error_typ2 env e'.at phrase t1 t2 "" in
    Il.CaseE (mixop, tup_exp_bind' [cast_exp phrase env e' t1 t211] e'.at)
  | RangeT _, t2' ->
    (try
      match t2' with
      | IterT (t21, Opt) ->
        Il.OptE (Some (cast_exp phrase env e' t1 t21))
      | IterT (t21, (List | List1)) ->
        Il.ListE [cast_exp phrase env e' t1 t21]
      | _ -> raise (Error (e'.at, ""))
    with Error _ ->  (* backtrack *)
      Debug.(log_in_at "el.cast_exp" e'.at
        (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 2" (el_typ t1) (el_typ t2)
          (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
          (el_typ (expand_nondef env t2))
        )
      );
      let t11 = typ_rep env t1 in
      let t11' = elab_typ env t11 in
      let e'' = Il.UncaseE (e', [[]; []]) $$ e'.at % tup_typ' [t11'] e'.at in
      let e''' = Il.ProjE (e'', 0) $$ e'.at % t11' in
      cast_exp' phrase env e''' t11 t2
    )
  | _, RangeT _ ->
    let t21 = typ_rep env t2 in
    let e'' = cast_exp phrase env e' t1 t21 in
    Il.CaseE ([[]; []], tup_exp_bind' [e''] e'.at)
  | _, IterT (t21, Opt) ->
    Il.OptE (Some (cast_exp phrase env e' t1 t21))
  | _, IterT (t21, (List | List1)) ->
    Il.ListE [cast_exp phrase env e' t1 t21]
  | _, _ when is_variant_typ env t1 && is_variant_typ env t2 && not (is_iter_typ env t1) ->
    let cases1, dots1 = as_variant_typ "" env Check t1 e'.at in
    let cases2, _dots2 = as_variant_typ "" env Check t2 e'.at in
    if dots1 = Dots then
      error e'.at "used variant type is only partially defined at this point";
    (try
      List.iter (fun (atom, (t1', _prems1), _) ->
        let t2', _prems2 = find_case cases2 atom t1.at t2 in
        (* Shallow subtyping on variants *)
        let env' = to_eval_env env in
        if not (Eq.eq_typ (Eval.reduce_typ env' t1') (Eval.reduce_typ env' t2')) then
          failwith "bla" (*error_atom e'.at atom t1 "type mismatch for case"*)
      ) cases1
    with Error (_, msg) -> error_typ2 env e'.at phrase t1 t2 (", " ^ msg)
    );
    let t11 = expand_singular env t1 $ t1.at in
    let t21 = expand_singular env t2 $ t2.at in
    let t11' = elab_typ env (expand_nondef env t1) in
    let t21' = elab_typ env (expand_nondef env t2) in
    let e'' = Il.SubE (cast_exp phrase env e' t1 t11, t11', t21') in
    cast_exp' phrase env (e'' $$ e'.at % t21') t21 t2
  | _, _ ->
    error_typ2 env e'.at phrase t1 t2 ""


and elab_iterexp env iter : Il.iterexp =
  (elab_iter env iter, [])


(* Premises *)

and elab_prem env prem : Il.prem list =
  match prem.it with
  | VarPr (id, t) ->
    env.vars <- bind "variable" env.vars id t;
    []
  | RulePr (id, e) ->
    let t, _ = find "relation" env.rels id in
    let mixop, _, _ = elab_typ_notation env id t in
    let es', _s = elab_exp_notation' env id e t in
    [Il.RulePr (id, mixop, tup_exp' es' e.at) $ prem.at]
  | IfPr e ->
    let e' = elab_exp env e (BoolT $ e.at) in
    [Il.IfPr e' $ prem.at]
  | ElsePr ->
    [Il.ElsePr $ prem.at]
  | IterPr ({it = VarPr _; at; _}, _iter) ->
    error at "misplaced variable premise"
  | IterPr (prem1, iter) ->
    let prem1' = List.hd (elab_prem env prem1) in
    let iter' = elab_iterexp env iter in
    [Il.IterPr (prem1', iter') $ prem.at]


(* Grammars *)

and elab_sym env g : typ * env =
  match g.it with
  | VarG (id, as_) ->
    let ps, t, _gram_opt = find "grammar" env.syms id in
    let _as', s = elab_args `Rhs env as_ ps g.at in
    Subst.subst_typ s t, env
  | NatG _ -> NumT NatT $ g.at, env
  | TextG _ -> TextT $ g.at, env
  | EpsG -> TupT [] $ g.at, env
  | SeqG gs ->
    let _ts, env' = elab_sym_list env (filter_nl gs) in
    TupT [] $ g.at, env'
  | AltG gs ->
    let _ = elab_sym_list env (filter_nl gs) in
    TupT [] $ g.at, env
  | RangeG (g1, g2) ->
    let t1, env1 = elab_sym env g1 in
    let t2, env2 = elab_sym env g2 in
    if env1 != env then
      error g1.at "invalid symbol in range";
    if env2 != env then
      error g2.at "invalid symbol in range";
    if not (equiv_typ env t1 t2) then
      error_typ2 env g2.at "range item" t2 t1 " of other range item";
    TupT [] $ g.at, env
  | ParenG g1 -> elab_sym env g1
  | TupG gs ->
    let ts, env' = elab_sym_list env gs in
    TupT ts $ g.at, env'
  | IterG (g1, iter) ->
    let t1, env1 = elab_sym env g1 in
    let _iter' = elab_iterexp env iter in
    IterT (t1, match iter with Opt -> Opt | _ -> List) $ g.at, env1
  | ArithG e ->
    let _e', t = infer_exp env e in
    t, env
  | AttrG (e, g1) ->
    let t1, env1 = elab_sym env g1 in
    let _e' = elab_exp env1 e t1 in
    TupT [] $ g.at, env
  | FuseG _ -> error g.at "misplaced token concatenation"

and elab_sym_list env = function
  | [] -> [], env
  | g::gs ->
    let t, env' = elab_sym env g in
    let ts, env'' = elab_sym_list env' gs in
    t::ts, env''

and elab_prod env prod t =
  let (g, e, prems) = prod.it in
  let _e' = elab_exp env e t in
  let _prems' = concat_map_filter_nl_list (elab_prem env) prems in
  ignore (elab_sym env g);
  let free = Free.(diff (free_prod prod) (union (det_prod prod) (bound_env env))) in
  if free <> Free.empty then
    error prod.at ("grammar rule contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`")

and elab_gram env gram t =
  let (_dots1, prods, _dots2) = gram.it in
  iter_nl_list (fun prod -> elab_prod env prod t) prods


(* Definitions *)

and make_binds_iter_arg env free dims : Il.bind list ref * (module Iter.Arg) =
  let module Arg =
    struct
      include Iter.Skip

      let left = ref free
      let acc = ref []

      let visit_typid id =
        if Free.Set.mem id.it !left.typid then (
          acc := !acc @ [Il.TypB id $ id.at];
          left := Free.{!left with typid = Set.remove id.it !left.typid};
        )

      let visit_varid id =
        if Free.(Set.mem id.it !left.varid) then (
          let t =
            try find "variable" env.vars id with Error _ ->
              find "variable" env.gvars (strip_var_suffix id)
          in
          let fwd = Free.(inter (free_typ t) !left) in
          if fwd <> Free.empty then
            error id.at ("the type of `" ^ id.it ^ "` depends on " ^
              ( Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid) |>
                List.map (fun id -> "`" ^ id ^ "`") |>
                String.concat ", " ) ^
              ", which only occur(s) to its right; try to reorder parameters or premises");
          let t' = elab_typ env t in
          let ctx = List.map (elab_iter env) (Dim.Env.find id.it dims) in
          acc := !acc @ [Il.ExpB (id, t', ctx) $ id.at];
          left := Free.{!left with varid = Set.remove id.it !left.varid};
        )

      let visit_gramid id =
        if Free.(Set.mem id.it !left.gramid) then (
          let ps, t, _gram_opt = find "grammar" env.syms id in
          let free' = Free.(union (free_params ps) (diff (free_typ t) (bound_params ps))) in
          let fwd = Free.(inter free' !left) in
          if fwd <> Free.empty then
            error id.at ("the type of `" ^ id.it ^ "` depends on " ^
              ( Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid) |>
                List.map (fun id -> "`" ^ id ^ "`") |>
                String.concat ", " ) ^
              ", which only occur(s) to its right; try to reorder parameters or premises");
          left := Free.{!left with varid = Set.remove id.it !left.gramid};
        )
    end
  in Arg.acc, (module Arg)

and elab_arg in_lhs env a p s : Il.arg option * Subst.subst =
  (match !(a.it), p.it with  (* HACK: handle shorthands *)
  | ExpA e, TypP _ -> a.it := TypA (typ_of_exp e)
  | ExpA e, GramP _ ->
   a.it := GramA (sym_of_exp e)
  | _, _ -> ()
  );
  match !(a.it), (Subst.subst_param s p).it with
  | ExpA e, ExpP (id, t) ->
    let e' = elab_exp env e t in
    Some (Il.ExpA e' $ a.at), Subst.add_varid s id e
  | TypA ({it = VarT (id', []); _} as t), TypP id when in_lhs = `Lhs ->
    let id'' = strip_var_suffix id' in
    env.typs <- bind "syntax type" env.typs id'' ([], Opaque);
    env.gvars <- bind "variable" env.gvars id'' (VarT (id'', []) $ id''.at);
    Some (Il.TypA (Il.VarT (id'', []) $ t.at) $ a.at), Subst.add_typid s id t
  | TypA t, TypP _ when in_lhs = `Lhs ->
    error t.at "misplaced syntax type"
  | TypA t, TypP id ->
    let t' = elab_typ env t in
    Some (Il.TypA t' $ a.at), Subst.add_typid s id t
  | GramA g, GramP _ when in_lhs = `Lhs ->
    error g.at "misplaced grammar symbol"
  | GramA g, GramP (id, t) ->
    let t', _ = elab_sym env g in
    let s' = subst_implicit env s t t' in
    if not (sub_typ env t' (Subst.subst_typ s' t)) then
      error_typ2 env a.at "argument" t' t "";
    (* Grammar args are erased *)
    None, Subst.add_gramid s' id g
  | _, _ ->
    error a.at "sort mismatch for argument"

and elab_args in_lhs env as_ ps at : Il.arg list * Subst.subst =
  Debug.(log_in_at "el.elab_args" at
    (fun _ -> fmt "%s : %s" (list el_arg as_) (list el_param ps))
  );
  elab_args' in_lhs env as_ ps [] Subst.empty at

and elab_args' in_lhs env as_ ps aos' s at : Il.arg list * Subst.subst =
  match as_, ps with
  | [], [] -> List.rev (List.filter_map Fun.id aos'), s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as1, p::ps1 ->
    let ao', s' = elab_arg in_lhs env a p s in
    elab_args' in_lhs env as1 ps1 (ao'::aos') s' at

and subst_implicit env s t t' : Subst.subst =
  let free = Free.(Set.filter (fun id -> not (Map.mem id env.typs)) (free_typ t).typid) in
  let rec inst s t t' =
    match t.it, t'.it with
    | VarT (id, []), _
      when Free.Set.mem id.it free && not (Subst.mem_typid s id) ->
      Subst.add_typid s id t'
    | ParenT t1, _ -> inst s t1 t'
    | _, ParenT t1' -> inst s t t1'
    | TupT (t1::ts), TupT (t1'::ts') ->
      inst (inst s t1 t1') (TupT ts $ t.at) (TupT ts' $ t'.at)
    | IterT (t1, _), IterT (t1', _) -> inst s t1 t1'
    | _ -> s
  in inst s t t'

let elab_params env ps : Il.param list =
  List.fold_left (fun ps' p ->
    match p.it with
    | ExpP (id, t) ->
      let t' = elab_typ env t in
      (* If a variable isn't globally declared, this is a local declaration. *)
      if bound env.gvars (strip_var_suffix id) then (
        let t2 = find "" env.gvars (strip_var_suffix id) in
        if not (sub_typ env t t2) then
          error_typ2 env id.at "local variable" t t2 ", shadowing with different type"
      );
      (* Shadowing is allowed, but only with consistent type. *)
      if bound env.vars (strip_var_suffix id) then (
        let t2 = find "" env.vars (strip_var_suffix id) in
        if not (equiv_typ env t t2) then
          error_typ2 env id.at "local variable" t t2 ", shadowing with different type"
      )
      else
        env.vars <- bind "variable" env.vars id t;
      ps' @ [Il.ExpP (id, t') $ p.at]
    | TypP id ->
      env.typs <- bind "syntax type" env.typs id ([], Opaque);
      env.gvars <- bind "variable" env.gvars id (VarT (id, []) $ id.at);
      ps' @ [Il.TypP id $ p.at]
    | GramP (id, t) ->
      (* Treat unbound type identifiers in t as implicitly bound. *)
      let free = Free.free_typ t in
      env.syms <- bind "grammar" env.syms id ([], t, None);
      Free.Set.iter (fun id' ->
        if not (Map.mem id' env.typs) then (
          let id = id' $ t.at in
          if id.it <> (strip_var_suffix id).it then
            error_id id "invalid identifer suffix in binding position";
          env.typs <- bind "syntax type" env.typs id ([], Opaque);
          env.gvars <- bind "variable" env.gvars id (VarT (id, []) $ id.at);
        )
      ) free.typid;
      let _t' = elab_typ env t in
      ps'  (* Grammar parameters are erased *)
  ) [] ps


let infer_typ_definition _env t : kind =
  match t.it with
  | StrT _ | CaseT _ -> Opaque
  | ConT _ | RangeT _ -> Transp
  | _ -> Transp

let infer_typdef env d =
  match d.it with
  | FamD (id, ps, _hints) ->
    let _ps' = elab_params (local_env env) ps in
    env.typs <- bind "syntax type" env.typs id (ps, Family []);
    if ps = [] then  (* only types without parameters double as variables *)
      env.gvars <- bind "variable" env.gvars id (VarT (id, []) $ id.at);
  | TypD (id1, _id2, as_, t, _hints) ->
    if bound env.typs id1 then (
      let _ps, k = find "syntax type" env.typs id1 in
      let extension =
        match t.it with CaseT (Dots, _, _, _) -> true | _ -> false in
      if k <> Family [] && not extension then (* force error *)
        ignore (env.typs <- bind "syntax type" env.typs id1 ([], Family []))
    )
    else (
      let ps = List.map Convert.param_of_arg as_ in
      let env' = local_env env in
      let _ps' = elab_params env' ps in
      let k = infer_typ_definition env' t in
      env.typs <- bind "syntax type" env.typs id1 (ps, k);
      if ps = [] then  (* only types without parameters double as variables *)
        env.gvars <- bind "variable" env.gvars id1 (VarT (id1, []) $ id1.at);
    )
  | VarD (id, t, _hints) ->
    (* This is to ensure that we get rebind errors in syntactic order. *)
    env.gvars <- bind "variable" env.gvars id t;
  | _ -> ()

let infer_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, t, _gram, _hints) ->
    (*
    Printf.eprintf "[el.infer_gramdef %s]\n%!" (string_of_region d.at);
    *)
    if not (bound env.syms id1) then (
      let env' = local_env env in
      let _ps' = elab_params env' ps in
      let _t' = elab_typ env' t in
      env.syms <- bind "grammar" env.syms id1 (ps, t, None);
    )
  | _ -> ()

let elab_hintdef _env hd : Il.def list =
  match hd.it with
  | TypH (id1, _id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.TypH (id1, elab_hints id1 hints) $ hd.at) $ hd.at]
  | RelH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RelH (id, elab_hints id hints) $ hd.at) $ hd.at]
  | DecH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.DecH (id, elab_hints id hints) $ hd.at) $ hd.at]
  | GramH _ | AtomH _ | VarH _ ->
    []


let infer_binds env env' dims d : Il.bind list =
  let det = Free.det_def d in
  let free = Free.(diff (free_def d) (union det (bound_env env))) in
  if free <> Free.empty then
    error d.at ("definition contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  Acc.def d;
  !acc_bs'

let infer_no_binds env d =
  let bs' = infer_binds env env (Dim.check_def d) d in
  assert (bs' = [])


let elab_def env d : Il.def list =
  Debug.(log_in "el.elab_def" line);
  Debug.(log_in_at "el.elab_def" d.at (fun _ -> el_def d));
  match d.it with
  | FamD (id, ps, hints) ->
    let ps' = elab_params (local_env env) ps in
    infer_no_binds env d;
    env.typs <- rebind "syntax type" env.typs id (ps, Family []);
    [Il.TypD (id, ps', []) $ d.at]
      @ elab_hintdef env (TypH (id, "" $ id.at, hints) $ d.at)
  | TypD (id1, id2, as_, t, hints) ->
    let env' = local_env env in
    let ps1, k1 = find "syntax type" env.typs id1 in
    let as', _s = elab_args `Lhs env' as_ ps1 d.at in
    let dt' = elab_typ_definition env' id1 t in
    let dims = Dim.check_def d in
    let bs' = infer_binds env env' dims d in
    let inst' = Il.InstD (bs', as', dt') $ d.at in
    let k1', closed =
      match k1, t.it with
      | Opaque, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of not yet defined syntax type"
      | Opaque, CaseT (NoDots, _, _, dots2) ->
        Defined (t, dt'), dots2 = NoDots
      | (Opaque | Transp), _ ->
        Defined (t, dt'), true
      | Defined ({it = CaseT (dots1, ts1, tcs1, Dots); at; _}, _),
          CaseT (Dots, ts2, tcs2, dots2) ->
        let ps = List.map Convert.param_of_arg as_ in
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "syntax parameters differ from previous fragment";
        let t1 = CaseT (dots1, ts1 @ ts2, tcs1 @ tcs2, dots2) $ over_region [at; t.at] in
        Defined (t1, dt'), dots2 = NoDots
      | Defined _, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of non-extensible syntax type"
      | Defined _, _ ->
        error_id id1 "duplicate declaration for syntax type";
      | Family _, CaseT (dots1, _, _, dots2) when dots1 = Dots || dots2 = Dots ->
        error_id id1 "syntax type family cases are not extensible"
      | Family insts, _ ->
        Family (insts @ [(as_, t, inst')]), false
    in
    (*
    Printf.eprintf "[syntax %s] %s ~> %s\n%!" id1.it
      (string_of_typ t) (Il.Print.string_of_deftyp dt');
    *)
    env.typs <- rebind "syntax type" env.typs id1 (ps1, k1');
    (if not closed then [] else
      let ps = List.map Convert.param_of_arg as_ in
      let ps' = elab_params (local_env env) ps in
      [Il.TypD (id1, ps', [inst']) $ d.at]
    ) @ elab_hintdef env (TypH (id1, id2, hints) $ d.at)
  | GramD _ -> []
  | RelD (id, t, hints) ->
    let mixop, ts', _ts = elab_typ_notation env id t in
    infer_no_binds env d;
    env.rels <- bind "relation" env.rels id (t, []);
    [Il.RelD (id, mixop, tup_typ' ts' t.at, []) $ d.at]
      @ elab_hintdef env (RelH (id, hints) $ d.at)
  | RuleD (id1, id2, e, prems) ->
    let env' = local_env env in
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let t, rules' = find "relation" env.rels id1 in
    let mixop, _, _ = elab_typ_notation env id1 t in
    let es' = List.map (Dim.annot_exp dims') (fst (elab_exp_notation' env' id1 e t)) in
    let prems' = List.map (Dim.annot_prem dims')
      (concat_map_filter_nl_list (elab_prem env') prems) in
    let bs' = infer_binds env env' dims d in
    let rule' = Il.RuleD (id2, bs', mixop, tup_exp' es' e.at, prems') $ d.at in
    env.rels <- rebind "relation" env.rels id1 (t, rules' @ [rule']);
    []
  | VarD (id, t, _hints) ->
    let _t' = elab_typ env t in
    infer_no_binds env d;
    env.gvars <- rebind "variable" env.gvars id t;
    []
  | DecD (id, ps, t, hints) ->
    let env' = local_env env in
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    infer_no_binds env d;
    env.defs <- bind "definition" env.defs id (ps, t, []);
    [Il.DecD (id, ps', t', []) $ d.at]
      @ elab_hintdef env (DecH (id, hints) $ d.at)
  | DefD (id, as_, e, prems) ->
    let env' = local_env env in
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let ps, t, clauses' = find "definition" env.defs id in
    let as', s = elab_args `Lhs env' as_ ps d.at in
    let as' = List.map (Dim.annot_arg dims') as' in
    let e' = Dim.annot_exp dims' (elab_exp env' e (Subst.subst_typ s t)) in
    let prems' = List.map (Dim.annot_prem dims')
      (concat_map_filter_nl_list (elab_prem env') prems) in
    let bs' = infer_binds env env' dims d in
    let clause' = Il.DefD (bs', as', e', prems') $ d.at in
    env.defs <- rebind "definition" env.defs id (ps, t, clauses' @ [(d, clause')]);
    []
  | SepD ->
    []
  | HintD hd ->
    elab_hintdef env hd

let elab_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, t, gram, _hints) ->
    Debug.(log_in "el.elab_gramdef" line);
    Debug.(log_in_at "el.elab_gramdef" d.at (fun _ -> el_def d));
    let env' = local_env env in
    let _ps' = elab_params env' ps in
    let _t' = elab_typ env' t in
    elab_gram env' gram t;
    infer_no_binds env' d;
    let ps1, t1, gram1_opt = find "grammar" env.syms id1 in
    let gram' =
      match gram1_opt, gram.it with
      | None, (Dots, _, _) ->
        error_id id1 "extension of not yet defined grammar"
      | None, _ ->
        gram
      | Some {it = (dots1, prods1, Dots); at; _}, (Dots, prods2, dots2) ->
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "grammar parameters differ from previous fragment";
        if not (equiv_typ env' t t1) then
          error_typ2 env d.at "grammar" t1 t " of previous fragment";
        (dots1, prods1 @ prods2, dots2) $ over_region [at; t.at]
      | Some _, (Dots, _, _) ->
        error_id id1 "extension of non-extensible grammar"
      | Some _, _ ->
        error_id id1 "duplicate declaration for grammar";
    in
    env.syms <- rebind "grammar" env.syms id1 (ps, t, Some gram')
  | _ -> ()


let check_dots env =
  Map.iter (fun id (at, (_ps, k)) ->
    match k with
    | Transp | Opaque -> assert false
    | Defined ({it = CaseT (_, _, _, Dots); _}, _) ->
      error_id (id $ at) "missing final extension to syntax type"
    | Family [] ->
      error_id (id $ at) "no defined cases for syntax type family"
    | Defined _ | Family _ -> ()
  ) env.typs;
  Map.iter (fun id (at, (_ps, _t, gram_opt)) ->
    match gram_opt with
    | None -> assert false
    | Some {it = (_, _, Dots); _} ->
      error_id (id $ at) "missing final extension to grammar"
    | _ -> ()
  ) env.syms


let populate_def env d' : Il.def =
  Debug.(log_in "el.populate_def" dline);
  Debug.(log_in_at "el.populate_def" d'.at (Fun.const ""));
  match d'.it with
  | Il.TypD (id, ps', _dt') ->
    (match find "syntax type" env.typs id with
    | _ps, Family insts ->
      let insts' = List.map (fun (_, _, inst') -> inst') insts in
      Il.TypD (id, ps', insts') $ d'.at
    | _ps, _k ->
      d'
    )
  | Il.RelD (id, mixop, t', []) ->
    let _, rules' = find "relation" env.rels id in
    Il.RelD (id, mixop, t', rules') $ d'.at
  | Il.DecD (id, ps', t', []) ->
    let _, _, clauses' = find "definition" env.defs id in
    Il.DecD (id, ps', t', List.map snd clauses') $ d'.at
  | Il.HintD _ -> d'
  | _ ->
    assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id ->
    try Map.find id map with Not_found -> failwith ("recursifiy dep " ^ id)
  ) (Array.of_seq (Il.Free.Set.to_seq set))


let check_recursion ds' =
  List.iter (fun d' ->
    match d'.it, (List.hd ds').it with
    | Il.HintD _, _ | _, Il.HintD _
    | Il.TypD _, Il.TypD _
    | Il.RelD _, Il.RelD _
    | Il.DecD _, Il.DecD _ -> ()
    | _, _ ->
      error (List.hd ds').at (" " ^ string_of_region d'.at ^
        ": invalid recursion between definitions of different sort")
  ) ds'
  (* TODO: check that notations are non-recursive and defs are inductive? *)

let recursify_defs ds' : Il.def list =
  let open Il.Free in
  let da = Array.of_list ds' in
  let map_typid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let frees = Array.map Il.Free.free_def da in
  let bounds = Array.map Il.Free.bound_def da in
  Array.iteri (fun i bound ->
    origins i map_typid bound.typid;
    origins i map_relid bound.relid;
    origins i map_defid bound.defid;
  ) bounds;
  let graph =
    Array.map (fun free ->
      Array.concat
        [ deps !map_typid free.typid;
          deps !map_relid free.relid;
          deps !map_defid free.defid;
        ];
    ) frees
  in
  let sccs = Scc.sccs graph in
  List.map (fun set ->
    let ds'' = List.map (fun i -> da.(i)) (Scc.Set.elements set) in
    check_recursion ds'';
    let i = Scc.Set.choose set in
    match ds'' with
    | [d'] when Il.Free.disjoint bounds.(i) frees.(i) -> d'
    | ds'' -> Il.RecD ds'' $ Source.over_region (List.map at ds'')
  ) sccs


let elab ds : Il.script * env =
  let env = new_env () in
  List.iter (infer_typdef env) ds;
  let ds' = List.concat_map (elab_def env) ds in
  List.iter (infer_gramdef env) ds;
  List.iter (elab_gramdef env) ds;
  check_dots env;
  let ds' = List.map (populate_def env) ds' in
  recursify_defs ds', env

let elab_exp env e t : Il.exp =
  let _ = elab_typ env t in
  elab_exp env e t

let elab_rel env e id : Il.exp =
  match elab_prem env (RulePr (id, e) $ e.at) with
  | [{it = Il.RulePr (_, _, e'); _}] -> e'
  | _ -> assert false
