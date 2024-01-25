open Util
open Source
open El
open Ast
open Convert
open Print

module Il = struct include Il include Ast end

module Set = Free.Set
module Map = Map.Make(String)


(* Errors *)

let error at msg = Source.error at "type" msg

let error_atom at atom t msg =
  error at (msg ^ " `" ^ string_of_atom atom ^ "` in type `" ^ string_of_typ t ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")

let error_typ at phrase t =
  error at (phrase ^ " does not match expected type `" ^ string_of_typ t ^ "`")

let error_typ2 at phrase t1 t2 reason =
  error at (phrase ^ "'s type `" ^ string_of_typ t1 ^ "`" ^
    " does not match expected type `" ^ string_of_typ t2 ^ "`" ^ reason)

type direction = Infer | Check

let error_dir_typ at phrase dir t expected =
  match dir with
  | Check -> error_typ at phrase t
  | Infer ->
    error at (phrase ^ "'s type `" ^ string_of_typ t ^ "`" ^
      " does not match expected type " ^ expected)


(* Helpers *)

let unparen_exp e =
  match e.it with
  | ParenE (e1, _) -> e1
  | _ -> e

let unseq_exp e =
  match e.it with
  | EpsE -> []
  | SeqE es -> es
  | _ -> [e]

let tup_typ' ts' at =
  match ts' with
  | [t'] -> t'
  | _ -> Il.TupT ts' $ at

let tup_exp' es' at =
  match es' with
  | [e'] -> e'
  | _ -> Il.TupE es' $$ (at, Il.TupT (List.map note es') $ at)

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
  | Transp  (* alias types, notation types, type parameters *)
  | Opaque  (* structures or variants *)
  | Defined of typ * Il.deftyp
  | Family of (arg list * typ * Il.deftyp) list (* family of types *)

type var_typ = typ
type syn_typ = param list * kind
type gram_typ = param list * typ * gram option
type rel_typ = typ * Il.rule list
type def_typ = param list * typ * (def * Il.clause) list

type env =
  { mutable vars : var_typ Map.t;
    mutable typs : syn_typ Map.t;
    mutable syms : gram_typ Map.t;
    mutable rels : rel_typ Map.t;
    mutable defs : def_typ Map.t;
  }

let new_env () =
  { vars = Map.empty
      |> Map.add "bool" (BoolT $ no_region)
      |> Map.add "nat" (NumT NatT $ no_region)
      |> Map.add "int" (NumT IntT $ no_region)
      |> Map.add "rat" (NumT RatT $ no_region)
      |> Map.add "real" (NumT RealT $ no_region)
      |> Map.add "text" (TextT $ no_region);
    typs = Map.empty;
    syms = Map.empty;
    rels = Map.empty;
    defs = Map.empty;
  }

let local_env env = {env with vars = env.vars}

let bound env' id = Map.mem id.it env'

let find space env' id =
  match Map.find_opt id.it env' with
  | None -> failwith (string_of_region id.at^": "^space^" "^id.it) (*error_id id ("undeclared " ^ space)*)
  | Some t -> t

let bind space env' id t =
  if Map.mem id.it env' then
    error_id id ("duplicate declaration for " ^ space)
  else
    Map.add id.it t env'

let rebind _space env' id t =
  assert (Map.mem id.it env');
  Map.add id.it t env'

let find_field fs atom at t =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fs with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unbound field"

let find_case cases atom at t =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unknown case"


let to_eval_typ id (ps, k) =
  match k with
  | Opaque | Transp ->
    let args' = List.map Convert.arg_of_param ps in
    [(args', VarT (id $ no_region, args') $ no_region)]
  | Defined (t, _dt') ->
    [(List.map Convert.arg_of_param ps, t)]
  | Family defs ->
    List.map (fun (args, t, _dt') -> (args,t)) defs

let to_eval_def (_ps, _t, clauses) =
  List.map (fun (d, _) ->
    match d.it with
    | DefD (_id, args, e, prems) -> (args, e, Convert.filter_nl prems)
    | _ -> assert false
  ) clauses

let to_eval_env env =
  let typs = Map.mapi to_eval_typ env.typs in
  let defs = Map.map to_eval_def env.defs in
  let syms = Map.map ignore env.syms in
  Eval.{typs; defs; syms}


(* Type Accessors *)

let rec arg_subst s ps args =
  match ps, args with
  | p::ps', a::as' ->
    let s' =
      match p.it, !((Subst.subst_arg s a).it) with
      | ExpP (id, _), ExpA e -> Subst.add_varid s id e
      | SynP id, SynA t -> Subst.add_synid s id t
      | GramP (id, _), GramA g -> Subst.add_gramid s id g
      | _, _ -> assert false
    in arg_subst s' ps' as'
  | _, _ -> assert (ps = [] && args = []); s

let aliased dt' =
  match dt'.it with
  | Il.AliasT _ -> `Alias
  | _ -> `NoAlias

let as_defined_typid' env id args at : typ' * [`Alias | `NoAlias] =
  match find "syntax type" env.typs (strip_var_suffix id) with
  | ps, Defined (t, dt') ->
    let t' = if ps = [] then t else  (* optimization *)
      Subst.subst_typ (arg_subst Subst.empty ps args) t in
    t'.it, aliased dt'
  | _ps, Opaque -> VarT (id, args), `NoAlias
  | _ps, Transp ->
    error_id (id.it $ at) "invalid forward use of syntax type"
  | _ps, Family defs ->
    let rec lookup = function
      | [] -> error_id (id.it $ at) "undefined case of syntax type family"
      | (args', t, dt')::defs' ->
        if args' = [] then t.it, aliased dt' else   (* optimisation *)
        let env' = to_eval_env env in
        match Eval.(match_list match_arg env' Subst.empty args args') with
        | None -> lookup defs'
        | Some s -> (Subst.subst_typ s t).it, aliased dt'
    in lookup defs

let rec expand' env = function
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args id.at with
    | t1, `Alias -> expand' env t1
    | _ -> t'
    | exception Error _ -> t'
    )
  | ParenT t -> expand' env t.it
  | t' -> t'

let expand env t = expand' env t.it

let expand_iter_notation env t =
  match expand env t with
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args t.at with
    | IterT _ as t'', _ -> t''
    | _ -> t'
    )
  | t' -> t'

let expand_singular env t =
  match expand env t with
  | IterT (t1, (Opt | List | List1)) -> expand env t1
  | t' -> t'


let as_iter_typ phrase env dir t at : typ * iter =
  match expand env t with
  | IterT (t1, iter) -> t1, iter
  | _ -> error_dir_typ at phrase dir t "(_)*"

let as_list_typ phrase env dir t at : typ =
  match expand env t with
  | IterT (t1, List) -> t1
  | _ -> error_dir_typ at phrase dir t "(_)*"

let as_iter_notation_typ phrase env dir t at : typ * iter =
  match expand_iter_notation env t with
  | IterT (t1, iter) -> t1, iter
  | _ -> error_dir_typ at phrase dir t "(_)*"

let as_opt_notation_typ phrase env dir t at : typ =
  match expand_iter_notation env t with
  | IterT (t1, Opt) -> t1
  | _ -> error_dir_typ at phrase dir t "(_)?"

let as_tup_typ phrase env dir t at : typ list =
  match expand_singular env t with
  | TupT ts -> ts
  | _ -> error_dir_typ at phrase dir t "(_,...,_)"


let rec as_notation_typid' phrase env id args at : typ =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_notation_typid' phrase env id' args' at
  | (AtomT _ | SeqT _ | InfixT _ | BrackT _ | IterT _) as t, _ -> t $ at
  | _ -> error_dir_typ at phrase Infer (VarT (id, args) $ id.at) "_ ... _"

let as_notation_typ phrase env dir t at : typ =
  match expand_singular env t with
  | VarT (id, args) -> as_notation_typid' phrase env id args at
  | _ -> error_dir_typ at phrase dir t "_ ... _"

let rec as_struct_typid' phrase env id args at : typfield list =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_struct_typid' phrase env id' args' at
  | StrT tfs, _ -> filter_nl tfs
  | _ -> error_dir_typ at phrase Infer (VarT (id, args) $ id.at) "| ..."

let as_struct_typ phrase env dir t at : typfield list =
  match expand_singular env t with
  | VarT (id, args) -> as_struct_typid' phrase env id args at
  | _ -> error_dir_typ at phrase dir t "{...}"

let rec as_variant_typid' phrase env id args at : typcase list * dots =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_variant_typid' phrase env id' args' at
  | CaseT (_dots1, ts, cases, dots2), _ ->
    let casess = map_filter_nl_list (fun t -> as_variant_typ "" env Infer t at) ts in
    List.concat (filter_nl cases :: List.map fst casess), dots2
  | _ -> error_dir_typ id.at phrase Infer (VarT (id, args) $ id.at) "| ..."

and as_variant_typid phrase env id args : typcase list * dots =
  as_variant_typid' phrase env id args id.at

and as_variant_typ phrase env dir t at : typcase list * dots =
  match expand_singular env t with
  | VarT (id, args) -> as_variant_typid' phrase env id args at
  | _ -> error_dir_typ at phrase dir t "| ..."

let case_has_args env t atom at : bool =
  let cases, _ = as_variant_typ "" env Check t at in
  let t, _prems = find_case cases atom at t in
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
  match expand env t1, expand env t2 with
  | NumT t1', NumT t2' -> t1' <= t2'
  | RangeT (Elem (e1, _)::_), NumT t2' ->
    (* TODO: this should use infer_exp *)
    (match (Eval.reduce_exp (to_eval_env env) e1).it with
    | NatE _ -> true
    | UnE (MinusOp, _) -> t2' <= IntT
    | _ -> assert false
    )
  | _ -> equiv_typ env t1 t2


(* Hints *)

let elab_hint {hintid; hintexp} : Il.hint =
  let ss =
    match hintexp.it with
    | SeqE es -> List.map Print.string_of_exp es
    | _ -> [Print.string_of_exp hintexp]
  in
  {Il.hintid; Il.hintexp = ss}

let elab_hints = List.map elab_hint


(* Atoms and Operators *)

let elab_atom = function
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
  | Bar -> Il.Bar
  | LParen -> Il.LParen
  | RParen -> Il.RParen
  | LBrack -> Il.LBrack
  | RBrack -> Il.RBrack
  | LBrace -> Il.LBrace
  | RBrace -> Il.RBrace

let numtyps = [NatT; IntT; RatT; RealT]

let elab_numtyp t : Il.numtyp =
  match t with
  | NatT -> Il.NatT
  | IntT -> Il.IntT
  | RatT -> Il.RatT
  | RealT -> Il.RealT

let infer_numop fop' ts =
  List.map (fun t -> fop' (elab_numtyp t), NumT t) ts

let infer_unop = function
  | NotOp -> [Il.NotOp, BoolT]
  | PlusOp -> infer_numop (fun t -> Il.PlusOp t) (List.tl numtyps)
  | MinusOp -> infer_numop (fun t -> Il.MinusOp t) (List.tl numtyps)

let infer_binop = function
  | AndOp -> [Il.AndOp, BoolT]
  | OrOp -> [Il.OrOp, BoolT]
  | ImplOp -> [Il.ImplOp, BoolT]
  | EquivOp -> [Il.EquivOp, BoolT]
  | AddOp -> infer_numop (fun t -> Il.AddOp t) numtyps
  | SubOp -> infer_numop (fun t -> Il.SubOp t) numtyps
  | MulOp -> infer_numop (fun t -> Il.MulOp t) numtyps
  | DivOp -> infer_numop (fun t -> Il.DivOp t) numtyps
  | ExpOp -> infer_numop (fun t -> Il.ExpOp t) numtyps

let infer_cmpop = function
  | EqOp -> `Poly Il.EqOp
  | NeOp -> `Poly Il.NeOp
  | LtOp -> `Over (infer_numop (fun t -> Il.LtOp t) numtyps)
  | GtOp -> `Over (infer_numop (fun t -> Il.GtOp t) numtyps)
  | LeOp -> `Over (infer_numop (fun t -> Il.LeOp t) numtyps)
  | GeOp -> `Over (infer_numop (fun t -> Il.GeOp t) numtyps)

let elab_unop env op t1 at : Il.unop * typ =
  let ops = infer_unop op in
  match List.find_opt (fun (_, t) -> sub_typ env t1 (t $ at)) ops with
  | Some (op', t) -> op', t $ at
  | None ->
    error at ("operator is not defined for type `" ^ string_of_typ t1 ^ "`")

let elab_binop env op t1 t2 at : Il.binop * typ =
  let ops = infer_binop op in
  match
    List.find_opt (fun (_, t) ->
      sub_typ env t1 (t $ at) && sub_typ env t2 (t $ at)) ops
  with
  | Some (op', t) -> op', t $ at
  | None ->
    error at ("operator " ^ string_of_binop op ^ " is not defined for types `" ^
      string_of_typ t1 ^ "` and `" ^ string_of_typ t2 ^ "`")

let elab_cmpop env op
  : [`Poly of Il.cmpop | `Over of typ -> typ -> region -> Il.cmpop * typ] =
  match infer_cmpop op with
  | `Poly op' -> `Poly op'
  | `Over ops -> `Over (fun t1 t2 at ->
    match
      List.find_opt (fun (_, t) ->
        sub_typ env t1 (t $ at) && sub_typ env t2 (t $ at)) ops
    with
    | Some (op', t) -> op', t $ at
    | None ->
      error at ("operator " ^ string_of_cmpop op ^ " is not defined for types `" ^
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
      let t = find "variable" env.vars (strip_var_suffix id) in
      if not (equiv_typ env t (NumT NatT $ id.at)) then
        error_typ e.at "iteration index" (NumT NatT $ id.at)
    ) id_opt;
    Il.ListN (elab_exp env e (NumT NatT $ e.at), id_opt)


(* Types *)

and elab_typ env t : Il.typ =
  match t.it with
  | VarT (id, args) ->
    assert (
      let t' = VarT (id, []) $ t.at in
      Eq.eq_typ t' El.Convert.(typ_of_varid (varid_of_typ t'))
    );
    let id' = strip_var_suffix id in
    let ps, _ = find "syntax type" env.typs id' in
    let _es', _s = elab_args env ps args t.at in
    (* TODO: for now, erase type arguments *)
    Il.VarT id' $ t.at
  | BoolT -> Il.BoolT $ t.at
  | NumT t' -> Il.NumT (elab_numtyp t') $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> Il.TupT (List.map (elab_typ env) ts) $ t.at
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in syntax type"
    | _ -> Il.IterT (elab_typ env t1, elab_iter env iter) $ t.at
    )
  | StrT _ | CaseT _ | RangeT _ | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    error t.at "this type is only allowed in type definitions"

and elab_typ_definition env id t : Il.deftyp =
  (match t.it with
  | StrT tfs ->
    let tfs' = filter_nl tfs in
    check_atoms "record" "field" tfs' t.at;
    Il.StructT (map_filter_nl_list (elab_typfield env) tfs)
  | CaseT (dots1, ts, cases, _dots2) ->
    let cases0 =
      if dots1 = Dots then fst (as_variant_typid "own type" env id []) else [] in
    let casess = map_filter_nl_list (fun t -> as_variant_typ "parent type" env Infer t t.at) ts in
    let cases' =
      List.flatten (cases0 :: List.map fst casess @ [filter_nl cases]) in
    let tcs' = List.map (elab_typcase env t.at) cases' in
    check_atoms "variant" "case" cases' t.at;
    Il.VariantT tcs'
  | RangeT tes ->
    (* TODO: for now, erase ranges to nat or int *)
    let ts' = map_filter_nl_list (elab_typenum env) tes in
    (* HACK: assume that left-most enumerator is the smallest *)
    Il.AliasT (List.hd ts')
  | _ ->
    match elab_typ_notation env t with
    | false, _mixop, ts' -> Il.AliasT (tup_typ' ts' t.at)
    | true, mixop, ts' -> Il.NotationT (mixop, tup_typ' ts' t.at)
  ) $ t.at


and elab_typfield env (atom, (t, prems), hints) : Il.typfield =
  let env' = local_env env in
  let _, _, ts' = elab_typ_notation env' t in
  let dims = Multiplicity.check_typdef t prems in
  let dims' = Multiplicity.Env.map (List.map (elab_iter env')) dims in
  let prems' = List.map (Multiplicity.annot_prem dims')
    (map_filter_nl_list (elab_prem env') prems) in
  let free = Free.(free_nl_list free_prem prems).varid in
  let binds' = make_binds env' free dims t.at in
  ( elab_atom atom,
    (binds', tup_typ' ts' t.at, prems'),
    elab_hints hints
  )

and elab_typcase env at (atom, (t, prems), hints) : Il.typcase =
  let env' = local_env env in
  let _, _, ts' = elab_typ_notation env' t in
  let dims = Multiplicity.check_typdef t prems in
  let dims' = Multiplicity.Env.map (List.map (elab_iter env')) dims in
  let prems' = List.map (Multiplicity.annot_prem dims')
    (map_filter_nl_list (elab_prem env') prems) in
  let free = Free.(free_nl_list free_prem prems).varid in
  let binds' = make_binds env' free dims at in
  ( elab_atom atom,
    (binds', tup_typ' ts' at, prems'),
    elab_hints hints
  )

and elab_typenum env (e1, e2o) : Il.typ =
  let _e1' = elab_exp env e1 (NumT IntT $ e1.at) in
  let _e2o' = Option.map (fun e2 -> elab_exp env e2 (NumT IntT $ e2.at)) e2o in
  elab_typ env (snd (infer_exp env e1))

and elab_typ_notation env t : bool * Il.mixop * Il.typ list =
  (*
  Printf.eprintf "[typ_not %s] %s\n%!"
    (string_of_region t.at) (string_of_typ t);
  *)
  match t.it with
  | VarT (id, args) ->
    let id' = strip_var_suffix id in
    (match find "syntax type" env.typs id' with
    | _, Transp -> error_id id "invalid forward reference to syntax type"
    | ps, _ ->
      let _es', _s = elab_args env ps args t.at in
      (* TODO: for now, erase type arguments *)
      false, [[]; []], [Il.VarT id' $ t.at]
    )
  | AtomT atom ->
    true, [[elab_atom atom]], []
  | SeqT [] ->
    true, [[]], []
  | SeqT (t1::ts2) ->
    let _b1, mixop1, ts1' = elab_typ_notation env t1 in
    let _b2, mixop2, ts2' = elab_typ_notation env (SeqT ts2 $ t.at) in
    true, merge_mixop mixop1 mixop2, ts1' @ ts2'
  | InfixT (t1, atom, t2) ->
    let _b1, mixop1, ts1' = elab_typ_notation env t1 in
    let _b2, mixop2, ts2' = elab_typ_notation env t2 in
    true, merge_mixop (merge_mixop mixop1 [[elab_atom atom]]) mixop2, ts1' @ ts2'
  | BrackT (l, t1, r) ->
    let _b1, mixop1, ts' = elab_typ_notation env t1 in
    true, merge_mixop (merge_mixop [[elab_atom l]] mixop1) [[elab_atom r]], ts'
  | ParenT t1 ->
    let b1, mixop1, ts1' = elab_typ_notation env t1 in
    b1, merge_mixop (merge_mixop [[Il.LParen]] mixop1) [[Il.RParen]], ts1'
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in notation type"
    | _ ->
      let b1, mixop1, ts' = elab_typ_notation env t1 in
      let iter' = elab_iter env iter in
      let t' = Il.IterT (tup_typ' ts' t1.at, iter') $ t.at in
      let op = match iter with Opt -> Il.Quest | _ -> Il.Star in
      b1, [List.flatten mixop1] @ [[op]], [t']
    )
  | _ ->
    false, [[]; []], [elab_typ env t]


and (!!!) env t = let _, _, ts' = elab_typ_notation env t in tup_typ' ts' t.at


(* Expressions *)

and infer_exp env e : Il.exp * typ =
  let e', t = infer_exp' env e in
  e' $$ e.at % elab_typ env t, t

and infer_exp' env e : Il.exp' * typ =
  (*
  Printf.eprintf "[infer %s] %s\n%!"
    (string_of_region e.at) (string_of_exp e);
  *)
  match e.it with
  | VarE (id, args) ->
    if args <> [] then
      Source.error e.at "syntax" "malformed expression";
    let t = find "variable" env.vars (strip_var_suffix id) in
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
    let op', t = elab_unop env op t1 e.at in
    Il.UnE (op', cast_exp "operand" env e1' t1 t), t
  | BinE (e1, op, e2) ->
    let e1', t1 = infer_exp env e1 in
    let e2', t2 = infer_exp env e2 in
    let op', t = elab_binop env op t1 t2 e.at in
    Il.BinE (op',
      cast_exp "operand" env e1' t1 t,
      cast_exp "operand" env e2' t2 t
    ), t
  | CmpE (e1, op, ({it = CmpE (e21, _, _); _} as e2)) ->
    let e1', _t1 = infer_exp env (CmpE (e1, op, e21) $ e.at) in
    let e2', _t2 = infer_exp env e2 in
    Il.BinE (Il.AndOp, e1', e2'), BoolT $ e.at
  | CmpE (e1, op, e2) ->
    (match elab_cmpop env op with
    | `Poly op' ->
      let e1', t1 = infer_exp env e1 in
      let e2' = elab_exp env e2 t1 in
      Il.CmpE (op', e1', e2'), BoolT $ e.at
    | `Over elab_cmpop'  ->
      let e1', t1 = infer_exp env e1 in
      let e2', t2 = infer_exp env e2 in
      let op', t = elab_cmpop' t1 t2 e.at in
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
    let t, _prems = find_field tfs atom e1.at t1 in
    Il.DotE (e1', elab_atom atom), t
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
    NatE 0, NumT NatT $ e.at
  | ParenE (e1, _) ->
    infer_exp' env e1
  | TupE es ->
    let es', ts = List.split (List.map (infer_exp env) es) in
    Il.TupE es', TupT ts $ e.at
  | CallE (id, args) ->
    let ps, t, _ = find "function" env.defs id in
    let es', s = elab_args env ps args e.at in
    Il.CallE (id, tup_exp' es' e.at), Subst.subst_typ s t
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
  with Source.Error _ when is_notation_typ env t ->
    elab_exp_notation env e (as_notation_typ "" env Check t e.at) t

and elab_exp' env e t : Il.exp' =
  (*
  Printf.eprintf "[elab %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  match e.it with
  | VarE (id, []) when not (Map.mem (strip_var_suffix id).it env.vars) ->
    (* Infer type of variable *)
    env.vars <- bind "variable" env.vars (strip_var_suffix id) t;
    Il.VarE id
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
    let efs' = elab_expfields env (filter_nl efs) tfs t e.at in
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
      (elab_exp_notation env e (as_notation_typ "" env Check t e.at) t).it
    else if is_variant_typ env t then
      (elab_exp_variant env e
        (fst (as_variant_typ "" env Check t e.at)) t e.at).it
    else
      error_typ e.at "expression" t
  | IterE (e1, iter2) ->
    (* An iteration expression must match the expected type directly,
     * significant parentheses have to be used otherwise *)
    let t1, iter = as_iter_typ "iteration" env Check t e.at in
    if (iter = Opt) <> (iter2 = Opt) then
      error_typ e.at "iteration expression" t;
    let e1' = elab_exp env e1 t1 in
    let iter2' = elab_iterexp env iter2 in
    Il.IterE (e1', iter2')
  | TypE _ ->
    let e', t' = infer_exp env e in
    cast_exp' "type annotation" env e' t' t
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token fuse"

and elab_expfields env efs tfs t at : Il.expfield list =
  match efs, tfs with
  | [], [] -> []
  | (atom1, e)::efs2, (atom2, (t, _prems), _)::tfs2 when atom1 = atom2 ->
    let es', _s = elab_exp_notation' env e t in
    let efs2' = elab_expfields env efs2 tfs2 t at in
    (elab_atom atom1, tup_exp' es' e.at) :: efs2'
  | _, (atom, (t, _prems), _)::tfs2 ->
    let atom' = string_of_atom atom in
    let e' =
      cast_empty ("omitted record field `" ^ atom' ^ "`") env t at (elab_typ env t) in
    let efs2' = elab_expfields env efs tfs2 t at in
    (elab_atom atom, e') :: efs2'
  | (atom, e)::_, [] ->
    error_atom e.at atom t "unexpected record field"

and elab_exp_iter env es (t1, iter) t at : Il.exp =
  let e' = elab_exp_iter' env es (t1, iter) t at in
  e' $$ at % elab_typ env t

and elab_exp_iter' env es (t1, iter) t at : Il.exp' =
  (*
  Printf.eprintf "[iteration %s] %s  :  %s = (%s)%s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp es))
    (string_of_typ t) (string_of_typ t1) (string_of_iter iter);
  *)
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, _
    when is_variant_typ env t1 && case_has_args env t1 atom at1 ->
    let cases, _dots = as_variant_typ "" env Check t1 at in
    lift_exp' (elab_exp_variant env (SeqE es $ at) cases t1 at) iter

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
    error_typ at "expression" t

and elab_exp_notation env e nt t : Il.exp =
  (* Convert notation into applications of mixin operators *)
  let es', _s = elab_exp_notation' env e nt in
  let e' = tup_exp' es' e.at in
  match elab_typ_notation env nt with
  | false, _, _ -> e'
  | true, mixop, _ -> Il.MixE (mixop, e') $$ e.at % elab_typ env t

and elab_exp_notation' env e t : Il.exp list * Subst.t =
  (*
  Printf.eprintf "[notation %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  match e.it, t.it with
  | AtomE atom, AtomT atom' ->
    if atom <> atom' then error_typ e.at "atom" t;
    [], Subst.empty
  | InfixE (e1, atom, e2), InfixT (t1, atom', t2) ->
    if atom <> atom' then error_typ e.at "infix expression" t;
    let es1', s1 = elab_exp_notation' env e1 t1 in
    let es2', s2 = elab_exp_notation' env e2 (Subst.subst_typ s1 t2) in
    es1' @ es2', Subst.union s1 s2
  | BrackE (l, e1, r), BrackT (l', t1, r') ->
    if (l, r) <> (l', r') then error_typ e.at "bracket expression" t;
    elab_exp_notation' env e1 t1

  | SeqE [], SeqT [] ->
    [], Subst.empty
  (* Iterations at the end of a sequence may be inlined *)
  | _, SeqT [t1] when is_iter_typ env t1 ->
    elab_exp_notation' env e t1
  (* Optional iterations may always be inlined, use backtracking *)
  | SeqE (e1::es2), SeqT (t1::ts2) when is_opt_notation_typ env t1 ->
    (try
      (*
      Printf.eprintf "[try %s] %s  :  %s\n%!"
        (string_of_region e.at) (string_of_exp e) (string_of_typ t);
      *)
      let es1' = [cast_empty "omitted sequence tail" env t1 e.at (!!!env t1)] in
      let es2', s2 = elab_exp_notation' env e (SeqT ts2 $ t.at) in
      es1' @ es2', s2
    with Source.Error _ ->
      (*
      Printf.eprintf "[backtrack %s] %s  :  %s\n%!"
        (string_of_region e.at) (string_of_exp e) (string_of_typ t);
      *)
      let es1', s1 = elab_exp_notation' env e1 t1 in
      let es2', s2 = elab_exp_notation' env (SeqE es2 $ e.at) (Subst.subst_typ s1 (SeqT ts2 $ t.at)) in
      es1' @ es2', Subst.union s2 s2
    )
  | SeqE (e1::es2), SeqT (t1::ts2) ->
    let es1', s1 = elab_exp_notation' env (unparen_exp e1) t1 in
    let es2', s2 = elab_exp_notation' env (SeqE es2 $ e.at) (Subst.subst_typ s1 (SeqT ts2 $ t.at)) in
    es1' @ es2', Subst.union s1 s2
  (* Trailing elements can be omitted if they can be eps *)
  | SeqE [], SeqT (t1::ts2) ->
    let es1' = [cast_empty "omitted sequence tail" env t1 e.at (!!!env t1)] in
    let es2', s2 =
      elab_exp_notation' env (SeqE [] $ e.at) (SeqT ts2 $ t.at) in
    es1' @ es2', s2
  | SeqE (e1::_), SeqT [] ->
    error e1.at
      "superfluous expression does not match expected empty notation type"
  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, SeqT _ ->
    elab_exp_notation' env (SeqE [e] $ e.at) t

  | SeqE [e1], IterT _ ->
    [elab_exp env e1 t], Subst.empty
  | (EpsE | SeqE _), IterT (t1, iter) ->
    [elab_exp_notation_iter env (unseq_exp e) (t1, iter) t e.at], Subst.empty
  | IterE (e1, iter1), IterT (t1, iter) ->
    if iter = Opt && iter1 <> Opt then
      error_typ e.at "iteration expression" t;
    let es1', _s1 = elab_exp_notation' env e1 t1 in
    let iter1' = elab_iterexp env iter1 in
    [Il.IterE (tup_exp' es1' e1.at, iter1') $$ e.at % !!!env t], Subst.empty
  (* Significant parentheses indicate a singleton *)
  | ParenE (e1, true), IterT (t1, iter) ->
    let es', _s = elab_exp_notation' env e1 t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % elab_typ env t], Subst.empty
  (* Elimination forms are considered splices *)
  | (IdxE _ | SliceE _ | UpdE _ | ExtE _ | DotE _ | CallE _), IterT _ ->
    [elab_exp env e t], Subst.empty
  (* All other expressions are considered splices *)
  (* TODO: can't they be splices, too? *)
  | _, IterT (t1, iter) ->
    let es', _s = elab_exp_notation' env e t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % !!!env t], Subst.empty

  | ParenE (e1, _), _ ->
    elab_exp_notation' env e1 t
  | _, ParenT t1 ->
    elab_exp_notation' env e t1

  | _, VarT (id, _) ->
    [elab_exp env e t], Subst.add_varid Subst.empty id e

  | _, _ ->
    [elab_exp env e t], Subst.empty


and elab_exp_notation_iter env es (t1, iter) t at : Il.exp =
  let e' = elab_exp_notation_iter' env es (t1, iter) t at in
  let _, _, ts' = elab_typ_notation env t in
  e' $$ at % tup_typ' ts' t.at

and elab_exp_notation_iter' env es (t1, iter) t at : Il.exp' =
  (*
  Printf.eprintf "[niteration %s] %s  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp es))
    (string_of_typ t);
  *)
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, _
    when is_variant_typ env t1 && case_has_args env t1 atom at1 ->
    let cases, _ = as_variant_typ "expression" env Check t1 at in
    lift_exp' (elab_exp_variant env (SeqE es $ at) cases t1 at) iter

  (* An empty sequence represents the None case for options *)
  | [], Opt ->
    Il.OptE None
  (* An empty sequence represents the Nil case for lists *)
  | [], List ->
    Il.ListE []
  (* All other elements are either splices or (by cast injection) elements;
   * nested expressions must be lifted into a tuple *)
  | e1::es2, List ->
    let es1', _s1 = elab_exp_notation' env e1 t in
    let e2' = elab_exp_notation_iter env es2 (t1, iter) t at in
    cat_exp' (tup_exp' es1' e1.at) e2'

  | _, _ ->
    error_typ at "expression" t

and elab_exp_variant env e cases t at : Il.exp =
  (*
  Printf.eprintf "[variant %s] {%s}  :  %s\n%!"
    (string_of_region at)
    (string_of_exp e)
    (string_of_typ t);
  (*
    (String.concat " | "
      (List.map (fun (atom, ts, _) ->
          string_of_typ (SeqT ((AtomT atom $ at) :: ts) $ at)
        ) cases
      )
    );
  *)
  *)
  let atom =
    match e.it with
    | AtomE atom
    | SeqE ({it = AtomE atom; _}::_)
    | InfixE (_, atom, _)
    | BrackE (atom, _, _) -> atom
    | _ -> error_typ at "expression" t
  in
  let t1, _prems = find_case cases atom at t in
  let es', _s = elab_exp_notation' env e t1 in
  let t2 = expand_singular env t $ at in
  let t2' = elab_typ env t2 in
  cast_exp "variant case" env
    (Il.CaseE (elab_atom atom, tup_exp' es' at) $$ at % t2') t2 t


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
    Il.DotP (p1', elab_atom atom), t'


and cast_empty phrase env t at t' : Il.exp =
  match expand env t with
  | IterT (_, Opt) -> Il.OptE None $$ at % t'
  | IterT (_, List) -> Il.ListE [] $$ at % t'
  | VarT _ when is_iter_notation_typ env t ->
    assert (is_notation_typ env t);
    (match expand_iter_notation env t with
    | IterT (_, iter) as t1 ->
      let _, mixop, ts' = elab_typ_notation env (t1 $ t.at) in
      assert (List.length ts' = 1);
      let e1' = if iter = Opt then Il.OptE None else Il.ListE [] in
      Il.MixE (mixop, e1' $$ at % tup_typ' ts' at) $$ at % t'
    | _ -> error_typ at phrase t
    )
  | _ -> error_typ at phrase t

and cast_exp phrase env e' t1 t2 : Il.exp =
  let e'' = cast_exp' phrase env e' t1 t2 in
  e'' $$ e'.at % elab_typ env t2

and cast_exp' phrase env e' t1 t2 : Il.exp' =
  (*
  Printf.eprintf "[cast %s] (%s) <: (%s)  >>  (%s) <: (%s)\n%!"
    (string_of_region e'.at)
    (string_of_typ t1) (string_of_typ t2)
    (string_of_typ (expand env t1 $ t1.at))
    (string_of_typ (expand env t2 $ t2.at));
  *)
  if equiv_typ env t1 t2 then
    e'.it
  else if sub_typ env t1 t2 then
    Il.SubE (e', elab_typ env t1, elab_typ env t2)
  else
    match expand env t2 with
    | RangeT _ ->
      if sub_typ env t1 (NumT IntT $ t1.at) then
        (* TODO: can't generally prove it's in range *)
        e'.it
      else
        error e'.at ("literal not in range of type `" ^ string_of_typ t2 ^ "`")
    | IterT (t21, Opt) ->
      Il.OptE (Some (cast_exp phrase env e' t1 t21))
    | IterT (t21, (List | List1)) ->
      Il.ListE [cast_exp phrase env e' t1 t21]
    | _ ->
      (cast_exp_variant phrase env e' t1 t2).it

and cast_exp_variant phrase env e' t1 t2 : Il.exp =
  if equiv_typ env t1 t2 then e' else
  if is_variant_typ env t1 && is_variant_typ env t2 then
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
    with Error (_, msg) -> error_typ2 e'.at phrase t1 t2 (", " ^ msg)
    );
    Il.SubE (e', elab_typ env t1, elab_typ env t2) $$ e'.at % elab_typ env t2
  else
    error_typ2 e'.at phrase t1 t2 ""


and elab_iterexp env iter : Il.iterexp =
  (elab_iter env iter, [])


(* Premises *)

and elab_prem env prem : Il.premise =
  match prem.it with
  | RulePr (id, e) ->
    let t, _ = find "relation" env.rels id in
    let _, mixop, _ = elab_typ_notation env t in
    let es', _s = elab_exp_notation' env e t in
    Il.RulePr (id, mixop, tup_exp' es' e.at) $ prem.at
  | IfPr e ->
    let e' = elab_exp env e (BoolT $ e.at) in
    Il.IfPr e' $ prem.at
  | ElsePr ->
    Il.ElsePr $ prem.at
  | IterPr (prem1, iter) ->
    let prem1' = elab_prem env prem1 in
    let iter' = elab_iterexp env iter in
    Il.IterPr (prem1', iter') $ prem.at


(* Grammars *)

and elab_sym env g : typ * env =
  match g.it with
  | VarG (id, args) ->
    let ps, t, _gram = find "grammar" env.syms id in
    let _es', s = elab_args env ps args g.at in
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
      error_typ2 g2.at "range item" t2 t1 " of other range item";
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
  let _prems' = map_filter_nl_list (elab_prem env) prems in
  elab_sym env g

and elab_gram env gram t =
  let (_dots1, prods, _dots2) = gram.it in
  iter_nl_list (fun prod -> ignore (elab_prod env prod t)) prods


(* Definitions *)

and make_binds env free dims at : Il.binds =
  List.map (fun id' ->
    let id = id' $ at in
    let t = find "variable" env.vars (strip_var_suffix id) in
    let t' = elab_typ env t in
    let ctx = List.map (elab_iter env) (Multiplicity.Env.find id.it dims) in
    (id, t', ctx)
  ) (Set.elements free)


and elab_args env ps args at : Il.exp list * Subst.subst =
  let rec loop ps args es s =
    (*
    if ps <> [] || args <> [] then
    Printf.eprintf "[args] {%s}  :  {%s}[%s]\n%!"
      (String.concat " " (List.map string_of_arg args))
      (String.concat " " (List.map string_of_param ps))
      (String.concat ", " (List.map (fun (x, e) -> x^"="^string_of_exp e) Subst.(Map.bindings s.varid)));
    *)
    match ps, args with
    | [], [] -> List.rev es, s
    | [], a::_ -> error a.at "too many arguments"
    | _::_, [] -> error at "too few arguments"
    | p::ps', a::as' ->
      (match p.it, !(a.it) with  (* HACK: handle shorthands *)
      | SynP _, ExpA e -> a.it := SynA (typ_of_exp e)
      | GramP _, ExpA e ->  a.it := GramA (sym_of_exp e)
      | _, _ -> ()
      );
      let es', s' =
        match (Subst.subst_param s p).it, !(a.it) with
        | ExpP (id, t), ExpA e ->
          let e' = elab_exp env e t in
          e'::es, Subst.add_varid s id e
        | SynP id, SynA t ->
          let _ = elab_typ env t in
          (* TODO: for now we erase non-exp args *)
          es, Subst.add_synid s id t
        | GramP (id, t), GramA g ->
          let t', _ = elab_sym env g in
          let s' = subst_implicit env s t t' in
          if not (sub_typ env t' (Subst.subst_typ s' t)) then
            error_typ2 a.at "argument" t' t "";
          (* TODO: for now we erase non-exp args *)
          es, Subst.add_gramid s' id g
        | _, _ ->
          error a.at "sort mismatch for argument"
      in loop ps' as' es' s'
    in loop ps args [] Subst.empty

and subst_implicit env s t t' : Subst.subst =
  let free = Free.(Set.filter (fun id -> not (Map.mem id env.typs)) (free_typ t).synid) in
  let rec inst s t t' =
    match t.it, t'.it with
    | VarT (id, []), _
      when Free.Set.mem id.it free && not (Subst.mem_synid s id) ->
      Subst.add_synid s id t'
    | ParenT t1, _ -> inst s t1 t'
    | _, ParenT t1' -> inst s t t1'
    | TupT (t1::ts), TupT (t1'::ts') ->
      inst (inst s t1 t1') (TupT ts $ t.at) (TupT ts' $ t'.at)
    | IterT (t1, _), IterT (t1', _) -> inst s t1 t1'
    | _ -> s
  in inst s t t'
  
let bind_implicit env t : env =
  let free = Free.free_typ t in
  Free.Set.fold (fun id' env ->
    if Map.mem id' env.typs then env else
    let id = id' $ t.at in
    { env with
      typs = bind "syntax type" env.typs id ([], Transp);
      vars = bind "variable" env.vars id (VarT (id, []) $ id.at);
    }
  ) free.synid env

let elab_params env ps : Il.typ list * env =
  List.fold_left (fun (ts', env) p ->
    match p.it with
    | ExpP (id, t) ->
      let t' = elab_typ env t in
      ts' @ [t'],
      if id.it = "" || id.it = "_" then env else
      if not (bound env.vars (strip_var_suffix id)) then
        {env with vars = bind "variable" env.vars id t}
      else
        let t2 = find "" env.vars (strip_var_suffix id) in
        if equiv_typ env t t2 then env else
          error_typ2 id.at "local variable" t t2 ", shadowing with different type"
    | SynP id ->
      ts',  (* TODO: for now we erase non-exp params *)
      { env with
        typs = bind "syntax type" env.typs id ([], Transp);
        vars = bind "variable" env.vars id (VarT (id, []) $ id.at);
      }
    | GramP (id, t) ->
      (* Treat unbound type identifiers in t as implicitly bound. *)
      let env' = bind_implicit env t in
      let _t' = elab_typ env' t in
      ts',  (* TODO: for now we erase non-exp params *)
      if id.it = "" || id.it = "_" then env' else
      { env' with syms = bind "grammar" env'.syms id ([], t, None) }
  ) ([], env) ps


let infer_typ_definition _env t : kind =
  match t.it with
  | StrT _ | CaseT _ -> Opaque
  | _ -> Transp

let infer_syndef env d =
  match d.it with
  | FamD (id, ps, _hints) ->
    (*
    Printf.eprintf "[isyndef %s]\n%!" (string_of_region d.at);
    *)
    if not (bound env.typs id) then (
      let _, _env' = elab_params (local_env env) ps in
      env.typs <- bind "syntax type" env.typs id (ps, Family []);
      if ps = [] then  (* only types without parameters double as variables *)
        env.vars <- bind "variable" env.vars id (VarT (id, []) $ id.at);
    )
  | SynD (id1, _id2, args, t, _hints) ->
    (*
    Printf.eprintf "[isyndef %s]\n%!" (string_of_region d.at);
    *)
    if not (bound env.typs id1) then (
      let ps = List.map Convert.param_of_arg args in
      let env' = local_env env in
      let _, env' = elab_params env' ps in
      let k = infer_typ_definition env' t in
      env.typs <- bind "syntax type" env.typs id1 (ps, k);
      if ps = [] then  (* only types without parameters double as variables *)
        env.vars <- bind "variable" env.vars id1 (VarT (id1, []) $ id1.at);
    )
  | VarD (id, t, _hints) ->
    (* This is to ensure that we get rebind errors in syntactic order. *)
    env.vars <- bind "variable" env.vars id t;
  | _ -> ()

let infer_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, t, _gram, _hints) ->
    (*
    Printf.eprintf "[igramdef %s]\n%!" (string_of_region d.at);
    *)
    if not (bound env.syms id1) then (
      let _ts', env' = elab_params env ps in
      let _t' = elab_typ env' t in
      env.syms <- bind "grammar" env.syms id1 (ps, t, None);
    )
  | _ -> ()

let elab_hintdef _env hd : Il.def list =
  match hd.it with
  | SynH (id1, _id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.SynH (id1, elab_hints hints) $ hd.at) $ hd.at]
  | RelH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RelH (id, elab_hints hints) $ hd.at) $ hd.at]
  | DecH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.DecH (id, elab_hints hints) $ hd.at) $ hd.at]
  | GramH _ | AtomH _ | VarH _ ->
    []

let elab_def env d : Il.def list =
  (*
  Printf.eprintf "[DEF %s]\n%!" (string_of_region d.at);
  let ds' =
  *)
  match d.it with
  | FamD (id, ps, hints) ->
    let _ts', _env' = elab_params (local_env env) ps in
    env.typs <- rebind "syntax type" env.typs id (ps, Family []);
    [Il.SynD (id, Il.VariantT [] $ d.at) $ d.at]  (* dummy type, filled in by populate_defs *)
      @ elab_hintdef env (SynH (id, "" $ id.at, hints) $ d.at)
  | SynD (id1, id2, args, t, hints) ->
    let env' = local_env env in
    let ps = List.map Convert.param_of_arg args in
    let _ts', env' = elab_params env' ps in
    let dt' = elab_typ_definition env' id1 t in
    let ps1, k1 = find "syntax type" env.typs id1 in
    let k1', closed =
      match k1, t.it with
      | Opaque, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of not yet defined syntax type"
      | Opaque, CaseT (NoDots, _, _, dots2) ->
        Defined (t, dt'), dots2 = NoDots
      | (Opaque | Transp), _ ->
        Defined (t, dt'), true
      | Defined ({it = CaseT (dots1, ids1, tcs1, Dots); at; _}, _),
          CaseT (Dots, ids2, tcs2, dots2) ->
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "syntax parameters differ from previous fragment";
        let t1 = CaseT (dots1, ids1 @ ids2, tcs1 @ tcs2, dots2) $ over_region [at; t.at] in
        Defined (t1, dt'), dots2 = NoDots
      | Defined _, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of non-extensible syntax type"
      | Defined _, _ ->
        error_id id1 "duplicate declaration for syntax type";
      | Family _, CaseT (dots1, _, _, dots2) when dots1 = Dots || dots2 = Dots ->
        error_id id1 "syntax type family cases are not extensible"
      | Family defs, _ ->
        (* TODO: for now, type families are erased to a single type *)
        let _ts', _s = elab_args (local_env env) ps1 args d.at in
        Family (defs @ [(args, t, dt')]), false
    in
    (*
    Printf.eprintf "[syntax %s] %s ~> %s\n%!" id1.it
      (string_of_typ t) (Il.Print.string_of_deftyp dt');
    *)
    (* TODO: for now, we erase type parameters; this checks that it's okay. *)
    let free = Il.Free.free_deftyp dt' in
    List.iter (fun p ->
      if
        match p.it with
        | ExpP _ -> false
        | SynP id -> Il.Free.Set.mem id.it free.synid
        | GramP _ -> false  (* grammars are erased as well *)
      then
        error p.at "parameter still occurs on right-hand side after erasure"
    ) ps;
    env.typs <- rebind "syntax type" env.typs id1 (ps1, k1');
    (if not closed then [] else [Il.SynD (id1, dt') $ d.at])
      @ elab_hintdef env (SynH (id1, id2, hints) $ d.at)
  | GramD _ -> []
  | RelD (id, t, hints) ->
    let _, mixop, ts' = elab_typ_notation env t in
    env.rels <- bind "relation" env.rels id (t, []);
    [Il.RelD (id, mixop, tup_typ' ts' t.at, []) $ d.at]
      @ elab_hintdef env (RelH (id, hints) $ d.at)
  | RuleD (id1, id2, e, prems) ->
    let env' = local_env env in
    let dims = Multiplicity.check_def d in
    let dims' = Multiplicity.Env.map (List.map (elab_iter env')) dims in
    let t, rules' = find "relation" env.rels id1 in
    let _, mixop, _ = elab_typ_notation env t in
    let es' = List.map (Multiplicity.annot_exp dims') (fst (elab_exp_notation' env' e t)) in
    let prems' = List.map (Multiplicity.annot_prem dims')
      (map_filter_nl_list (elab_prem env') prems) in
    let free_rh =
      Free.(Set.diff
        (free_nl_list free_prem prems).varid
        (Set.union
          (pat_exp e).varid
          (free_nl_list bound_prem prems).varid
        )
      )
    in
    if free_rh <> Free.Set.empty then
      error d.at ("rule contains unbound variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free_rh) ^ "`");
    let free = (Free.free_def d).Free.varid in
    let binds' = make_binds env' free dims d.at in
    let rule' = Il.RuleD (id2, binds', mixop, tup_exp' es' e.at, prems') $ d.at in
    env.rels <- rebind "relation" env.rels id1 (t, rules' @ [rule']);
    []
  | VarD (id, t, _hints) ->
    let _t' = elab_typ env t in
    env.vars <- rebind "variable" env.vars id t;
    []
  | DecD (id, ps, t, hints) ->
    let ts', env' = elab_params (local_env env) ps in
    let t' = elab_typ env' t in
    env.defs <- bind "function" env.defs id (ps, t, []);
    [Il.DecD (id, tup_typ' ts' id.at, t', []) $ d.at]
      @ elab_hintdef env (DecH (id, hints) $ d.at)
  | DefD (id, args, e, prems) ->
    let env' = local_env env in
    let dims = Multiplicity.check_def d in
    let dims' = Multiplicity.Env.map (List.map (elab_iter env')) dims in
    let ps, t, clauses' = find "function" env.defs id in
    let es', s = elab_args env' ps args d.at in
    let e1' = Multiplicity.annot_exp dims' (tup_exp' es' d.at) in
    let e2' = Multiplicity.annot_exp dims' (elab_exp env' e (Subst.subst_typ s t)) in
    let prems' = List.map (Multiplicity.annot_prem dims')
      (map_filter_nl_list (elab_prem env') prems) in
    let free_rh =
      Free.(Set.diff
        (Set.union
          (free_exp e).varid
          (free_nl_list free_prem prems).varid
        )
        (Set.union
          (Set.union
            (free_list pat_arg args).varid
            (bound_exp e).varid
          )
          (free_nl_list bound_prem prems).varid
        )
      )
    in
    if free_rh <> Free.Set.empty then
      error d.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free_rh) ^ "`");
    let free =
      Free.(Set.union
        (Set.union (free_list free_arg args).varid (free_exp e).varid)
        (free_nl_list free_prem prems).varid
      )
    in
    let binds' = make_binds env' free dims d.at in
    let clause' = Il.DefD (binds', e1', e2', prems') $ d.at in
    env.defs <- rebind "definition" env.defs id (ps, t, clauses' @ [(d, clause')]);
    []
  | SepD ->
    []
  | HintD hd ->
    elab_hintdef env hd
  (*
  in
  Printf.eprintf "[DEF %s] done\n%!" (string_of_region d.at);
  ds'
  *)

let elab_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, t, gram, _hints) ->
    (*
    Printf.eprintf "[GRAMDEF %s]\n%!" (string_of_region d.at);
    *)
    let _ts', env' = elab_params (local_env env) ps in
    let _t' = elab_typ env' t in
    elab_gram env' gram t;
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
          error_typ2 d.at "grammar" t1 t " of previous fragment";
        (dots1, prods1 @ prods2, dots2) $ over_region [at; t.at]
      | Some _, (Dots, _, _) ->
        error_id id1 "extension of non-extensible grammar"
      | Some _, _ ->
        error_id id1 "duplicate declaration for grammar";
    in
    env.syms <- rebind "grammar" env.syms id1 (ps, t, Some gram')
  | _ -> ()


let populate_def env d' : Il.def =
  (*
  Printf.eprintf "[populate %s]\n%!" (string_of_region d'.at);
  *)
  match d'.it with
  | Il.SynD (id, _dt') ->
    (match find "syntax type" env.typs id with
    | _ps, Family [] ->
      error_id id "syntax type family has no defined cases";
    | _ps, Family (def1::defs) ->
      let _, t1, dt1' = def1 in
      let _t, dt' =
        List.fold_left (fun (t1, dt1') (_, _t2, dt2') ->
          match dt1'.it, dt2'.it with
          | Il.VariantT tcs1', Il.VariantT tcs2' ->
            (* TODO: for now, merge cases into one variant type *)
            (* may not yield well-typed IL in all cases *)
            let rec merge tcs1' tcs2' =
              match tcs1', tcs2' with
              | [], _ -> tcs2'
              | _, [] -> tcs1'
              | (atom1, tt1, hints1)::tcs1'', (atom2, tt2, hints2)::tcs2'' ->
                match compare atom1 atom2 with
                | -1 -> (atom1, tt1, hints1) :: merge tcs1'' ((atom2, tt2, hints2)::tcs2'')
                | +1 -> (atom2, tt2, hints2) :: merge ((atom1, tt1, hints1)::tcs1'') tcs2''
                | _ ->
                  (* TODO: this is a hack *)
(*
                  let (binds1, t1', prems1) = tt1 in
                  let (binds2, t2', prems2) = tt2 in
                  if
                    binds1 <> [] || binds2 <> [] || prems1 <> [] || prems2 <> [] ||
                    not (Il.Eq.eq_typ t1' t2')
                  then
                    error_id id ("syntax type family case is incompatible (`" ^
                      Il.Print.(string_of_deftyp dt1' ^ "` vs `" ^ string_of_deftyp dt2' ^ "`) for"));
*)
                  (atom1, tt1, hints1 @ hints2) :: merge tcs1'' tcs2''
            in
            t1, Il.VariantT (merge (List.sort compare tcs1') (List.sort compare tcs2')) $ dt1'.at
          | _, _ ->
            let dt1' = elab_typ_definition env id (expand env t1 $ t1.at) in
(*
            let dt2' = elab_typ_definition env id (expand env t2 $ t2.at) in
            if not (Il.Eq.eq_deftyp dt1' dt2') then
              error_id id ("syntax type family case erases to different IL type (" ^
                Il.Print.(string_of_deftyp dt1' ^ " vs " ^ string_of_deftyp dt2' ^ ") for "));
*)
            t1, dt1'
        ) (t1, dt1') defs
      in
      Il.SynD (id, dt') $ d'.at
    | _ps, _k ->
      d'
    )
  | Il.RelD (id, mixop, t', []) ->
    let _, rules' = find "relation" env.rels id in
    Il.RelD (id, mixop, t', rules') $ d'.at
  | Il.DecD (id, t1', t2', []) ->
    let _, _, clauses' = find "function" env.defs id in
    Il.DecD (id, t1', t2', List.map snd clauses') $ d'.at
  | Il.HintD _ -> d'
  | _ ->
    assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id -> Map.find id map) (Array.of_seq (Il.Free.Set.to_seq set))


let check_recursion ds' =
  List.iter (fun d' ->
    match d'.it, (List.hd ds').it with
    | Il.HintD _, _ | _, Il.HintD _
    | Il.SynD _, Il.SynD _
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
  let map_synid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let frees = Array.map Il.Free.free_def da in
  let bounds = Array.map Il.Free.bound_def da in
  Array.iteri (fun i bound ->
    origins i map_synid bound.synid;
    origins i map_relid bound.relid;
    origins i map_defid bound.defid;
  ) bounds;
  let graph =
    Array.map (fun free ->
      Array.concat
        [ deps !map_synid free.synid;
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

let elab ds : Il.script =
  let env = new_env () in
Printf.eprintf "[INFER DEF]\n%!";
  List.iter (infer_syndef env) ds;
Printf.eprintf "[ELAB DEF]\n%!";
  let ds' = List.concat_map (elab_def env) ds in
Printf.eprintf "[POPULATE DEF]\n%!";
  let ds' = List.map (populate_def env) ds' in
Printf.eprintf "[INFER GRAMDEF]\n%!";
  List.iter (infer_gramdef env) ds;
Printf.eprintf "[ELAB GRAMDEF]\n%!";
  List.iter (elab_gramdef env) ds;
Printf.eprintf "[RECURSIFY]\n%!";
  recursify_defs ds'
