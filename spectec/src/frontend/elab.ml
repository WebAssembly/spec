open Util
open Source
open El
open Xl
open Ast
open Convert
open Print

module Il = struct include Il include Ast end

module Set = Free.Set
module Map = Map.Make (String)

module Debug = struct include El.Debug include Il.Debug end


(* Errors *)

let lax_num = true

exception Error = Error.Error

let error at msg = Error.error at "type" msg

let error_atom at atom t msg =
  error at (msg ^ " `" ^ string_of_atom atom ^ "` in type `" ^ string_of_typ ~short:true t ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")


(* Helpers *)

let wild_exp t' = Il.VarE ("_" $ t'.at) $$ t'.at % t'

let unparen_exp e =
  match e.it with
  | ParenE e1 -> e1
  | _ -> e

let unseq_exp e =
  match e.it with
  | EpsE -> []
  | SeqE es -> es
  | _ -> [e]

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
  | Defined of typ * id list * Il.deftyp
  | Family of (arg list * typ * Il.inst) list (* family of types *)

type var_typ = typ
type typ_typ = param list * kind
type gram_typ = param list * typ * gram option * (id * Il.prod) list
type rel_typ = typ * (id * Il.rule) list
type def_typ = param list * typ * (def * Il.clause) list

type 'a env' = (region * 'a) Map.t
type env =
  { mutable gvars : var_typ env'; (* variable type declarations *)
    mutable vars : var_typ env';  (* local bindings *)
    mutable typs : typ_typ env';
    mutable rels : rel_typ env';
    mutable defs : def_typ env';
    mutable grams : gram_typ env';
    mutable atoms : atom env';    (* implicit single-atom type defs *)
    mutable pm : bool;            (* +- or -+ encountered *)
  }

let new_env () =
  { gvars = Map.empty
      |> Map.add "bool" (no_region, BoolT $ no_region)
      |> Map.add "nat" (no_region, NumT `NatT $ no_region)
      |> Map.add "int" (no_region, NumT `IntT $ no_region)
      |> Map.add "rat" (no_region, NumT `RatT $ no_region)
      |> Map.add "real" (no_region, NumT `RealT $ no_region)
      |> Map.add "text" (no_region, TextT $ no_region);
    vars = Map.empty;
    typs = Map.empty;
(*
      |> Map.add "bool" (no_region, ([], Defined (BoolT $ no_region, Il.BoolT $ no_region)))
      |> Map.add "nat" (no_region, ([], Defined (NumT `NatT $ no_region, Il.(NumT `NatT) $ no_region)))
      |> Map.add "int" (no_region, ([], Defined (NumT `IntT $ no_region, Il.(NumT `IntT) $ no_region)))
      |> Map.add "rat" (no_region, ([], Defined (NumT `RatT $ no_region, Il.(NumT `RatT) $ no_region)))
      |> Map.add "real" (no_region, ([], Defined (NumT `RealT $ no_region, Il.(NumT `RealT) $ no_region)))
      |> Map.add "text" (no_region, ([], Defined (TextT $ no_region, Il.TextT $ no_region)));
*)
    rels = Map.empty;
    defs = Map.empty;
    grams = Map.empty;
    atoms = Map.empty;
    pm = false;
  }

let local_env env =
  {env with gvars = env.gvars; vars = env.vars; typs = env.typs; defs = env.defs}
let promote_env env' env =
  env.gvars <- env'.gvars; env.vars <- env'.vars; env.typs <- env'.typs; env.defs <- env'.defs;
  env.pm <- env'.pm

let bound env' id = Map.mem id.it env'

let spaceid space id = if space = "definition" then ("$" ^ id.it) $ id.at else id

let find space env' id =
  match Map.find_opt id.it env' with
  | None -> error_id (spaceid space id) ("undeclared " ^ space)
  | Some (_at, t) -> t

let bind space env' id t =
  if id.it = "_" then
    env'
  else if bound env' id then
    error_id (spaceid space id) ("duplicate declaration for " ^ space)
  else
    Map.add id.it (id.at, t) env'

let rebind _space env' id t =
  assert (bound env' id);
  Map.add id.it (id.at, t) env'

let find_field fs atom at t =
  match List.find_opt (fun (atom', _, _) -> Atom.eq atom' atom) fs with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unbound field"

let find_case cases atom at t =
  match List.find_opt (fun (atom', _, _) -> Atom.eq atom' atom) cases with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unknown case"

let find_case_sub cases atom at t =
  match List.find_opt (fun (atom', _, _) -> Atom.eq atom' atom || Atom.sub atom' atom) cases with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unknown case"

let bound_env' env' = Map.fold (fun id _ s -> Free.Set.add id s) env' Free.Set.empty
let bound_env env =
  Free.{
    varid = bound_env' env.vars;
    typid = bound_env' env.typs;
    relid = bound_env' env.rels;
    defid = bound_env' env.defs;
    gramid = bound_env' env.grams;
  }

let vars env = Map.fold (fun id (at, _) ids -> (id $ at)::ids) env.vars []

let to_eval_var (_at, t) = t

let to_eval_typ id (_at, (ps, k)) =
  match k with
  | Opaque | Transp ->
    let args' = List.map Convert.arg_of_param ps in
    [(args', VarT (id $ no_region, args') $ no_region)]
  | Defined (t, _ids, _dt') ->
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
  (* Need to include gvars, since matching can encounter implicit vars *)
  let gvars = Map.map to_eval_var env.gvars in
  let vars = Map.map to_eval_var env.vars in
  let typs = Map.mapi to_eval_typ env.typs in
  let defs = Map.map to_eval_def env.defs in
  let grams = Map.map ignore env.grams in
  Eval.{vars = Map.union (fun _ _ t -> Some t) gvars vars; typs; defs; grams}

let valid_tid id = id.it <> ""


(* Backtracking *)

type trace = Trace of region * string * trace list
type 'a attempt = Ok of 'a | Fail of trace list

let ( let* ) r f =
  match r with
  | Ok x -> f x
  | Fail traces -> Fail traces

let rec choice env = function
  | [] -> Fail []
  | f::fs ->
    let env' = local_env env in
    match f env' with
    | Ok x -> promote_env env' env; Ok x
    | Fail traces1 ->
      match choice env fs with
      | Ok x -> Ok x
      | Fail traces2 -> Fail (traces1 @ traces2)

let nest at t r =
  match r with
  | Ok _ -> r
  | Fail traces ->
    Fail [Trace (at, "cannot parse expression as `" ^ string_of_typ ~short:true t ^ "`", traces)]

let rec map_attempt f = function
  | [] -> Ok []
  | x::xs ->
    let* y = f x in
    let* ys = map_attempt f xs in
    Ok (y::ys)

let iter_attempt f xs =
  let* _ = map_attempt f xs in Ok ()

let map2_attempt f xs ys =
  map_attempt (fun (x, y) -> f x y) (List.combine xs ys)

let fail at msg = Fail [Trace (at, msg, [])]
let fail_silent = Fail []

let fail_atom at atom t msg =
  fail at (msg ^ " `" ^ string_of_atom atom ^ "` in type `" ^ string_of_typ ~short:true t ^ "`")

let fail_infer at construct =
  fail at ("cannot infer type of " ^ construct)

let indent n = String.make (2*n) ' '

let rec msg_trace n = function
  | Trace (at, msg, traces) ->
    indent n ^ "- " ^ string_of_range at.left at.right ^ ": " ^ msg_traces n msg traces

and msg_traces n msg = function
  | [] -> msg
  | traces -> msg ^ ", because\n" ^ String.concat "\n" (List.map (msg_trace (n + 1)) traces)

let rec error_trace = function
  | Trace (_, _, [trace]) -> error_trace trace
  | Trace (at, msg, traces) -> error at (msg_traces 0 msg (Lib.List.nub (=) traces))

let checkpoint = function
  | Ok x -> x
  | Fail [trace] -> error_trace trace
  | Fail _ -> assert false  (* we only checkpoint around nest *)

let attempt f x =
  try Ok (f x) with Error.Error (at, msg) -> fail at msg


(* More Errors *)

let typ_string env t =
  let t' = Eval.reduce_typ (to_eval_env env) t in
  let s = string_of_typ ~short:true t in
  let s' = string_of_typ ~short:true t' in
  if s = s' then
    "`" ^ s ^ "`"
  else
    "`" ^ s ^ " = " ^ s' ^ "`"

let msg_typ env phrase t =
  phrase ^ " does not match type " ^ typ_string env t

let msg_typ2 env phrase t1 t2 reason =
  phrase ^ "'s type " ^ typ_string env t1 ^
    " does not match type " ^ typ_string env t2 ^ reason

let error_typ env at phrase t =
  error at (msg_typ env phrase t)

let error_typ2 env at phrase t1 t2 reason =
  error at (msg_typ2 env phrase t1 t2 reason)

let fail_typ env at phrase t =
  fail at (msg_typ env phrase t)

let fail_typ2 env at phrase t1 t2 reason =
  fail at (msg_typ2 env phrase t1 t2 reason)

type direction = Infer | Check

let fail_dir_typ env at phrase dir t expected =
  match dir with
  | Check -> fail_typ env at phrase t
  | Infer ->
    fail at (phrase ^ "'s type `" ^ string_of_typ ~short:true t ^ "`" ^
      " does not match type " ^ expected)


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
      | DefP (id, _, _), DefA id' -> Subst.add_defid s id id'
      | _, _ -> assert false
    in arg_subst s' ps' as'
  | _, _ -> assert false

(* TODO(4, rossberg): eliminate, replace expansion with reduction *)
let aliased dt' =
  match dt'.it with
  | Il.AliasT _ -> `Alias
  | _ -> `NoAlias
let aliased_inst inst' =
  let Il.InstD (_, _, dt') = inst'.it in
  aliased dt'

(* TODO(4, rossberg): replace with reduce_typ *)
let as_defined_typid' env id args at : typ' * [`Alias | `NoAlias] =
  match find "syntax type" env.typs (strip_var_suffix id) with
  | ps, Defined (t, _ids, dt') ->
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
      | [] -> error_id (id.it $ at) "undefined or undetermined case of syntax type family"
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

(* Expand all but the last alias. TODO(4, rossberg): remove *)
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

let expand_id env t =
  match (expand_nondef env t).it with
  | VarT (id, _) -> strip_var_suffix id
  | _ -> "" $ no_region

let rec expand_notation env t =
  match expand env t with
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args t.at with
    | ConT ((t1, _), _), _ -> expand_notation env t1
    | RangeT _ as t', _ -> t'
    | _ -> t'
    | exception Error _ -> t'
    )
  | ConT ((t1, _), _) -> expand_notation env t1
  | t' -> t'

let rec expand_iter_notation env t =
  match expand env t with
  | VarT (id, args) as t' ->
    (match as_defined_typid' env id args t.at with
    | IterT _ as t'', _ -> t''
    | ConT ((t1, _), _), _ -> expand_iter_notation env t1
    | _ -> t'
    | exception Error _ -> t'
    )
  | ConT ((t1, _), _) -> expand_iter_notation env t1
  | t' -> t'


let as_nat_typ_opt env t : unit option =
  match expand_notation env t with
  | NumT `NatT -> Some ()
  | RangeT _ -> Some ()
  | _ -> None

let as_num_typ_opt env t : numtyp option =
  match expand_notation env t with
  | NumT nt -> Some nt
  | RangeT _ -> Some `IntT
  | _ -> None

let as_iter_typ_opt env t : (typ * iter) option =
  match expand env t with IterT (t1, iter) -> Some (t1, iter) | _ -> None

let as_list_typ_opt env t : typ option =
  match expand env t with IterT (t1, List) -> Some t1 | _ -> None

let as_iter_notation_typ_opt env t : (typ * iter) option =
  match expand_iter_notation env t with IterT (t1, iter) -> Some (t1, iter) | _ -> None

let as_tup_typ_opt env t : typ list option =
  match expand env t with TupT ts -> Some ts | _ -> None

let as_empty_typ_opt env t : unit option =
  match expand_notation env t with SeqT [] -> Some () | _ -> None


let as_x_typ as_t_opt phrase env dir t at shape =
  match as_t_opt env t with
  | Some x -> Ok x
  | None -> fail_dir_typ env at phrase dir t shape

let as_nat_typ phrase env dir t at =
  as_x_typ as_nat_typ_opt phrase env dir t at "nat"
let as_num_typ phrase env dir t at =
  as_x_typ as_num_typ_opt phrase env dir t at "(nat|int|rat|real)"
let as_iter_typ phrase env dir t at =
  as_x_typ as_iter_typ_opt phrase env dir t at "(_)*"
let as_list_typ phrase env dir t at =
  as_x_typ as_list_typ_opt phrase env dir t at "(_)*"
let as_tup_typ phrase env dir t at =
  as_x_typ as_tup_typ_opt phrase env dir t at "(_, ..., _)"
let as_iter_notation_typ phrase env dir t at =
  as_x_typ as_iter_notation_typ_opt phrase env dir t at "(_)*"
let as_empty_typ phrase env dir t at =
  as_x_typ as_empty_typ_opt phrase env dir t at "()"


let rec as_notation_typid' phrase env id args at : typ attempt =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_notation_typid' phrase env id' args' at
  | ConT ((t, _), _), _ -> Ok t
  | (AtomT _ | SeqT _ | InfixT _ | BrackT _ | IterT _) as t, _ -> Ok (t $ at)
  | _ -> fail_dir_typ env at phrase Infer (VarT (id, args) $ id.at) "_ ... _"
  | exception Error (at', msg) -> fail at' msg

let as_notation_typ phrase env dir t at : typ attempt =
  match expand env t with
  | VarT (id, args) -> as_notation_typid' phrase env id args at
  | _ -> fail_dir_typ env at phrase dir t "_ ... _"

let rec as_struct_typid' phrase env id args at : typfield list attempt =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_struct_typid' phrase env id' args' at
  | StrT tfs, _ -> Ok (filter_nl tfs)
  | _ -> fail_dir_typ env at phrase Infer (VarT (id, args) $ id.at) "| ..."
  | exception Error (at', msg) -> fail at' msg

let as_struct_typ phrase env dir t at : typfield list attempt =
  match expand env t with
  | VarT (id, args) -> as_struct_typid' phrase env id args at
  | _ -> fail_dir_typ env at phrase dir t "{...}"

let rec as_cat_typid' phrase env dir id args at =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_cat_typid' phrase env dir id' args' at
  | IterT _, _ -> Ok ()
  | StrT tfs, _ ->
    iter_attempt (fun (_, (t, _), _) -> as_cat_typ phrase env dir t at) (filter_nl tfs)
  | _ ->
    fail at (phrase ^ "'s type `" ^ string_of_typ ~short:true (VarT (id, args) $ id.at) ^
      "` is not concatenable")
  | exception Error (at', msg) -> fail at' msg

and as_cat_typ phrase env dir t at =
  match expand env t with
  | VarT (id, args) -> as_cat_typid' phrase env dir id args at
  | IterT _ -> Ok ()
  | _ ->
    fail at (phrase ^ "'s type `" ^ string_of_typ ~short:true t ^ "` is not concatenable")

let rec as_variant_typid' phrase env id args at : (typcase list * dots) attempt =
  match as_defined_typid' env id args at with
  | VarT (id', args'), `Alias -> as_variant_typid' phrase env id' args' at
  | CaseT (_dots1, ts, cases, dots2), _ ->
    let* casess = map_attempt (fun t -> as_variant_typ "" env Infer t at) (filter_nl ts) in
    Ok (List.concat (filter_nl cases :: List.map fst casess), dots2)
  | _ -> fail_dir_typ env id.at phrase Infer (VarT (id, args) $ id.at) "| ..."
  | exception Error (at', msg) -> fail at' msg

and as_variant_typid phrase env id args : (typcase list * dots) attempt =
  as_variant_typid' phrase env id args id.at

and as_variant_typ phrase env dir t at : (typcase list * dots) attempt =
  match expand env t with
  | VarT (id, args) -> as_variant_typid' phrase env id args at
  | _ -> fail_dir_typ env at phrase dir t "| ..."


let is_x_typ as_x_typ env t =
  match as_x_typ "" env Check t no_region with
  | Ok _ -> true
  | Fail _ -> false

let is_nat_typ = is_x_typ as_nat_typ
let is_empty_typ = is_x_typ as_empty_typ
let is_iter_typ = is_x_typ as_iter_typ
let is_iter_notation_typ = is_x_typ as_iter_notation_typ
let is_notation_typ = is_x_typ as_notation_typ
let is_variant_typ = is_x_typ as_variant_typ


(* Type Equivalence and Shallow Numeric Subtyping *)

let equiv_typ env t1 t2 =
  Eval.equiv_typ (to_eval_env env) t1 t2

let sub_typ env t1 t2 =
  Eval.sub_typ (to_eval_env env) t1 t2

let narrow_typ env t1 t2 =
  Eval.narrow_typ (to_eval_env env) t1 t2


(* Hints *)

let elab_hint tid mixop {hintid; hintexp} : Il.hint =
  let module IterAtoms =
    Iter.Make(
      struct
        include Iter.Skip
        let visit_atom atom =
          assert (valid_tid tid);
          assert (atom.note.Atom.def = "");
          atom.note.Atom.def <- tid.it;
          atom.note.Atom.case <- Mixop.name mixop
      end
    )
  in
  IterAtoms.exp hintexp;
  {Il.hintid; Il.hintexp}

let elab_hints tid mixop = List.map (elab_hint tid mixop)


(* Atoms and Operators *)

let elab_atom atom tid =
  assert (valid_tid tid);
(*
if atom.note.Atom.def <> "" && atom.note.Atom.def <> tid.it then
Printf.eprintf "[elab_atom %s @ %s] def=%s/%s\n%!"
(Atom.string_of_atom atom) (Source.string_of_region atom.at) tid.it atom.note.Atom.def;
  assert (atom.note.Atom.def = "" || atom.note.Atom.def = tid.it);
*)
  atom.note.Atom.def <- tid.it;
  atom

let infer_unop'' op ts =
  List.map (fun t -> op, (t :> Il.optyp), NumT t, NumT t) ts

let infer_binop'' op ts =
  List.map (fun t -> op, (t :> Il.optyp), NumT t, NumT t, NumT t) ts

let infer_cmpop'' op ts =
  List.map (fun t -> op, (t :> Il.optyp), NumT t) ts

let infer_unop' = function
  | #Bool.unop as op -> [op, `BoolT, BoolT, BoolT]
  | #Num.unop as op -> infer_unop'' op [`IntT; `RatT; `RealT]
  | `PlusMinusOp -> infer_unop'' `PlusOp [`IntT; `RatT; `RealT]
  | `MinusPlusOp -> infer_unop'' `MinusOp [`IntT; `RatT; `RealT]

let infer_binop' = function
  | #Bool.binop as op -> [op, `BoolT, BoolT, BoolT, BoolT]
  | `AddOp as op -> infer_binop'' op [`NatT; `IntT; `RatT; `RealT]
  | `SubOp as op -> infer_binop'' op [`IntT; `RatT; `RealT]
  | `MulOp as op -> infer_binop'' op [`NatT; `IntT; `RatT; `RealT]
  | `DivOp as op -> infer_binop'' op [`RatT; `RealT]
  | `ModOp as op -> infer_binop'' op [`NatT; `IntT]
  | `PowOp as op ->
    infer_binop'' op [`NatT; `RatT; `RealT] |>
      List.map (fun (op, nt, t1, t2, t3) ->
        (op, nt, t1, (if t2 = NumT `NatT then t2 else NumT `IntT), t3))

let infer_cmpop' = function
  | #Bool.cmpop as op -> `Poly op
  | #Num.cmpop as op -> `Over (infer_cmpop'' op [`NatT; `IntT; `RatT; `RealT])

let infer_unop env op t1 at : (Il.unop * Il.optyp * typ * typ) attempt =
  let ops = infer_unop' op in
  match List.find_opt (fun (_, _, t1', _) -> narrow_typ env t1 (t1' $ at)) ops with
  | Some (op', nt, t1', t2') -> Ok (op', nt, t1' $ at, t2' $ at)
  | None ->
    fail at ("unary operator `" ^ string_of_unop op ^
      "` is not defined for operand type `" ^ string_of_typ ~short:true t1 ^ "`")

let infer_binop env op t1 t2 at : (Il.binop * Il.optyp * typ * typ * typ) attempt =
  let ops = infer_binop' op in
  match
    List.find_opt (fun (_, _, t1', t2', _) ->
      narrow_typ env t1 (t1' $ at) && (lax_num || narrow_typ env t2 (t2' $ at))) ops
  with
  | Some (op', nt, t1', t2', t3') -> Ok (op', nt, t1' $ at, t2' $ at, t3' $ at)
  | None ->
    fail at ("binary operator `" ^ string_of_binop op ^
      "` is not defined for operand types `" ^
      string_of_typ ~short:true t1 ^ "` and `" ^ string_of_typ ~short:true t2 ^ "`")

let infer_cmpop env op
  : [`Poly of Il.cmpop | `Over of (typ -> typ -> region -> (Il.cmpop * Il.optyp * typ) attempt)] =
  match infer_cmpop' op with
  | `Poly op' -> `Poly op'
  | `Over ops -> `Over (fun t1 t2 at ->
    match
      List.find_opt (fun (_, _, t) ->
        narrow_typ env t1 (t $ at) && narrow_typ env t2 (t $ at)) ops
    with
    | Some (op', nt, t) -> Ok (op', nt, t $ at)
    | None ->
      fail at ("comparison operator `" ^ string_of_cmpop op ^
        "` is not defined for operand types `" ^
        string_of_typ ~short:true t1 ^ "` and `" ^ string_of_typ ~short:true t2 ^ "`")
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
      let e' = checkpoint (elab_exp env (VarE (id, []) $ id.at) (NumT `NatT $ id.at)) in
      (* TODO(4, rossberg): extend IL to allow arbitrary pattern exps *)
      match e'.it with
      | Il.VarE _ -> ()
      | _ -> error_typ env id.at "iteration variable" (NumT `NatT $ id.at)
    ) id_opt;
    let e' = checkpoint (elab_exp env e (NumT `NatT $ e.at)) in
    Il.ListN (e', id_opt)


(* Types *)

and elab_typ env t : Il.typ =
  match t.it with
  | VarT (id, as_) ->
    let id' = strip_var_suffix id in
    if id'.it <> id.it && as_ = [] then elab_typ env (Convert.typ_of_varid id') else
    let ps, _ = find "syntax type" env.typs id' in
    let as', _s = elab_args `Rhs env as_ ps t.at in
    Il.VarT (id', as') $ t.at
  | BoolT -> Il.BoolT $ t.at
  | NumT t' -> Il.NumT t' $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT {it = SeqT []; _} -> Il.TupT [] $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> tup_typ' (List.map (elab_typ env) ts) t.at
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in syntax type"
    | _ ->
      let iter' = elab_iter env iter in
      let t1' = elab_typ env t1 in
      Il.IterT (t1', iter') $ t.at
    )
  | StrT _ | CaseT _ | ConT _ | RangeT _ | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    error t.at "this type is only allowed in type definitions"

and elab_typ_definition env tid t : Il.deftyp =
  Debug.(log_at "el.elab_typ_definition" t.at
    (fun _ -> fmt "%s = %s" tid.it (el_typ t)) il_deftyp
  ) @@ fun _ ->
  assert (valid_tid tid);
  (match t.it with
  | StrT tfs ->
    let tfs' = filter_nl tfs in
    check_atoms "record" "field" tfs' t.at;
    Il.StructT (map_filter_nl_list (elab_typfield env tid t.at) tfs)
  | CaseT (dots1, ts, cases, _dots2) ->
    let cases0 =
      if dots1 = Dots then
        fst (checkpoint (as_variant_typid "own type" env tid []))
      else []
    in
    let casess =
      map_filter_nl_list (fun t ->
        let cases, dots = checkpoint (as_variant_typ "parent type" env Infer t t.at) in
        if dots = Dots then
          error t.at "cannot include incomplete syntax type";
        List.map Iter.clone_typcase cases  (* ensure atom annotations are fresh *)
      ) ts
    in
    let cases' = List.flatten (List.map Iter.clone_typcase cases0 :: casess @ [filter_nl cases]) in
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
        (if narrow_typ env tI t then t else tI),
        fun eid' nt ->
        let e' = fe' eid' nt and eI' = feI' eid' nt in
        let at = Source.over_region [e'.at; eI'.at] in
        Il.(BinE (`OrOp, `BoolT, e', eI') $$ at % (BoolT $ at))
      ) (List.hd ts_fes') (List.tl ts_fes')
    in
    let t' = elab_typ env t1 in
    let nt = match t1.it with NumT nt -> nt | _ -> assert false in
    let id' = "i" $ t.at in
    let eid' = Il.VarE id' $$ t.at % t' in
    let bs' = [Il.ExpB (id', t') $ t.at] in
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
  assert (valid_tid tid);
  let env' = local_env env in
  let _mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef (vars env) t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = checkpoint (map2_attempt (elab_exp env') es ts) in
  let es' = List.map (Dim.annot_exp dims') es' in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(diff (union (free_list det_exp es) (det_prems prems)) (bound_env env)) in
  let free = Free.(diff (free_typfield tf) (union det (bound_env env))) in
  if free <> Free.empty then
    error at ("type field contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.exp es;
  Acc.prems prems;
  ( elab_atom atom tid,
    (!acc_bs', (if prems = [] then tup_typ' else tup_typ_bind' es') ts' t.at, prems'),
    elab_hints tid [] hints
  )

and elab_typcase env tid at ((_atom, (t, prems), hints) as tc) : Il.typcase =
  assert (valid_tid tid);
  let env' = local_env env in
  let mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef (vars env) t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = checkpoint (map_attempt Fun.id (List.map2 (elab_exp env') es ts)) in
  let es' = List.map (Dim.annot_exp dims') es' in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(diff (union (free_list det_exp es) (det_prems prems)) (bound_env env)) in
  let free = Free.(diff (free_typcase tc) (union det (bound_env env))) in
  if free <> Free.empty then
(Printf.printf "[typcase] t = %s\n%!" (Print.string_of_typ t);
  List.iteri (fun i e -> Printf.printf "[typcase] t%d = %s\n%!" i (Print.string_of_typ e)) ts;
  List.iteri (fun i e -> Printf.printf "[typcase] t%d' = %s\n%!" i (Il.Print.string_of_typ e)) ts';
  List.iteri (fun i e -> Printf.printf "[typcase] e%d = %s\n%!" i (Print.string_of_exp e)) es;
    error at ("type case contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
);
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.exp es;
  Acc.prems prems;
  ( mixop,
    (!acc_bs', tup_typ_bind' es' ts' at, prems'),
    elab_hints tid [] hints
  )

and elab_typcon env tid at (((t, prems), hints) as tc) : Il.typcase =
  assert (valid_tid tid);
  let env' = local_env env in
  let mixop, ts', ts = elab_typ_notation env' tid t in
  let es = Convert.pats_of_typs ts in
  let dims = Dim.check_typdef (vars env) t prems in
  let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
  let es' = checkpoint (map_attempt Fun.id (List.map2 (elab_exp env') es ts)) in
  let es' = List.map (Dim.annot_exp dims') es' in
  let prems' = List.map (Dim.annot_prem dims')
    (concat_map_filter_nl_list (elab_prem env') prems) in
  let det = Free.(diff (union (free_list det_exp es) (det_prems prems)) (bound_env env)) in
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
    elab_hints tid [Atom.Atom tid.it $$ tid.at % Atom.info ""] hints
  )

and elab_typenum env tid (e1, e2o) : typ * (Il.exp -> numtyp -> Il.exp) =
  assert (valid_tid tid);
  let _e1' = elab_exp env e1 (NumT `IntT $ e1.at) in (* ensure it's <= int *)
  let _, t1 = checkpoint (infer_exp env e1) in       (* get precise type *)
  match e2o with
  | None ->
    t1,
    fun eid' nt ->
    let e1' = checkpoint (elab_exp env e1 (NumT nt $ e1.at)) in  (* redo with overall type *)
    Il.(CmpE (`EqOp, `BoolT, eid', e1') $$ e1'.at % (BoolT $ e1.at))
  | Some e2 ->
    let at = Source.over_region [e1.at; e2.at] in
    let _e2' = elab_exp env e2 (NumT `IntT $ e2.at) in
    let _, t2 = checkpoint (infer_exp env e2) in
    (if narrow_typ env t2 t1 then t1 else t2).it $ at,
    fun eid' nt ->
    let e1' = checkpoint (elab_exp env e1 (NumT nt $ e1.at)) in
    let e2' = checkpoint (elab_exp env e2 (NumT nt $ e2.at)) in
    Il.(BinE (`AndOp, `BoolT,
      CmpE (`GeOp, (nt :> Il.optyp), eid', e1') $$ e1'.at % (BoolT $ e1.at),
      CmpE (`LeOp, (nt :> Il.optyp), eid', e2') $$ e2'.at % (BoolT $ e2.at)
    ) $$ at % (BoolT $ at))

and elab_typ_notation env tid t : Il.mixop * Il.typ list * typ list =
  Debug.(log_at "el.elab_typ_notation" t.at
    (fun _ -> fmt "(%s) %s" tid.it (el_typ t))
    (fun (mixop, ts', _) -> fmt "%s(%s)" (il_mixop mixop) (list il_typ ts'))
  ) @@ fun _ ->
  assert (valid_tid tid);
  match t.it with
  | VarT (id, as_) ->
    let id' = strip_var_suffix id in
    (match (Convert.typ_of_varid id').it with
    | VarT _ ->
      (match find "syntax type" env.typs id' with
      | _, Transp -> error_id id "invalid forward reference to syntax type"
      | ps, _ ->
        let as', _s = elab_args `Rhs env as_ ps t.at in
        [[]; []], [Il.VarT (id', as') $ t.at], [t]
      )
    | t' ->
      [[]; []], [elab_typ env (t' $ id.at)], [t]
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
  | _ ->
    [[]; []], [elab_typ env t], [t]


and (!!!) env tid t =
  let _, ts', _ = elab_typ_notation env tid t in tup_typ' ts' t.at


(* Expressions *)

(* Returns
 * - Ok (il_exp, typ) if the type can be inferred
 * - Fail (at, s) when it cannot, where s is the name of the failing construct
 * - raises Error.Error on fatal, unrecoverable errors
 *)
and infer_exp env e : (Il.exp * typ) attempt =
  Debug.(log_at "el.infer_exp" e.at
    (fun _ -> fmt "%s" (el_exp e))
    (function Ok (e', t) -> fmt "%s : %s" (il_exp e') (el_typ t) | _ -> "fail")
  ) @@ fun _ ->
  let* e', t' = infer_exp' env e in
  let t = t' $ e.at in
  Ok (e' $$ e.at % elab_typ env t, t)

and infer_exp' env e : (Il.exp' * typ') attempt =
  match e.it with
  | VarE (id, args) ->
    (* Args may only occur due to syntactic overloading with types *)
    if args <> [] then error e.at "malformed expression";
    if id.it = "_" then fail_infer e.at "wildcard" else
    let* t =
      if bound env.vars id then
        Ok (find "variable" env.vars id)
      else if bound env.gvars (strip_var_suffix id) then
        (* If the variable itself is not yet declared, use type hint. *)
        let t = find "variable" env.gvars (strip_var_suffix id) in
        env.vars <- bind "variable" env.vars id t;
        Ok t
      else fail_infer e.at "variable"
    in Ok (Il.VarE id, t.it)
  | AtomE _ ->
    fail_infer e.at "atom"
  | BoolE b ->
    Ok (Il.BoolE b, BoolT)
  | NumE (_op, n) ->
    Ok (Il.NumE n, NumT (Num.to_typ n))
  | TextE s ->
    Ok (Il.TextE s, TextT)
  | CvtE (e1, nt) ->
    let* e1', t1 = infer_exp env e1 in
    let* nt1 = as_num_typ "conversion" env Infer t1 e1.at in
    let* e1'' = cast_exp "operand" env e1' t1 (NumT nt1 $ e1.at) in
    Ok (Il.CvtE (e1'', nt1, nt), NumT nt)
  | UnE (op, e1) ->
    let* e1', t1 = infer_exp env e1 in
    let* op', ot, t1', t = infer_unop env op (typ_rep env t1) e.at in
    let* e1'' = cast_exp "operand" env e1' t1 t1' in
    if op = `PlusMinusOp || op = `MinusPlusOp then env.pm <- true;
    Ok (Il.UnE (op', ot, e1''), t.it)
  | BinE (e1, op, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* e2', t2 = infer_exp env e2 in
    let* op', ot, t1', t2', t = infer_binop env op (typ_rep env t1) (typ_rep env t2) e.at in
    let* e1'' = cast_exp "operand" env e1' t1 t1' in
    let* e2'' = cast_exp "operand" env e2' t2 t2' in
    Ok (Il.BinE (op', ot, e1'', e2''), t.it)
  | CmpE (e1, op, ({it = CmpE (e21, _, _); _} as e2)) ->
    let* e1', _t1 = infer_exp env (CmpE (e1, op, e21) $ e.at) in
    let* e2', _t2 = infer_exp env e2 in
    Ok (Il.BinE (`AndOp, `BoolT, e1', e2'), BoolT)
  | CmpE (e1, op, e2) ->
    (match infer_cmpop env op with
    | `Poly op' ->
      let* e1', e2' =
        choice env [
          (fun env ->
            let* e2', t2 = infer_exp env e2 in
            let* e1' = elab_exp env e1 t2 in
            Ok (e1', e2')
          );
          (fun env ->
            let* e1', t1 = infer_exp env e1 in
            let* e2' = elab_exp env e2 t1 in
            Ok (e1', e2')
          );
        ]
      in
      Ok (Il.CmpE (op', `BoolT, e1', e2'), BoolT)
    | `Over elab_cmpop'  ->
      let* e1', t1 = infer_exp env e1 in
      let* e2', t2 = infer_exp env e2 in
      let* op', ot, t = elab_cmpop' (typ_rep env t1) (typ_rep env t2) e.at in
      let* e1'' = cast_exp "operand" env e1' t1 t in
      let* e2'' = cast_exp "operand" env e2' t2 t in
      Ok (Il.CmpE (op', ot, e1'', e2''), BoolT)
    )
  | IdxE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* t = as_list_typ "expression" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 (NumT `NatT $ e2.at) in
    Ok (Il.IdxE (e1', e2'), t.it)
  | SliceE (e1, e2, e3) ->
    let* e1', t1 = infer_exp env e1 in
    let* _t' = as_list_typ "expression" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 (NumT `NatT $ e2.at) in
    let* e3' = elab_exp env e3 (NumT `NatT $ e3.at) in
    Ok (Il.SliceE (e1', e2', e3'), t1.it)
  | UpdE (e1, p, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* p', t2 = elab_path env p t1 in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.UpdE (e1', p', e2'), t1.it)
  | ExtE (e1, p, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* p', t2 = elab_path env p t1 in
    let* _t21 = as_list_typ "path" env Infer t2 p.at in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.ExtE (e1', p', e2'), t1.it)
  | StrE _ ->
    fail_infer e.at "record"
  | DotE (e1, atom) ->
    let* e1', t1 = infer_exp env e1 in
    let* tfs = as_struct_typ "expression" env Infer t1 e1.at in
    let* t, prems = attempt (find_field tfs atom e1.at) t1 in
    let e' = Il.DotE (e1', elab_atom atom (expand_id env t1)) in
    let e'' = if prems = [] then e' else Il.ProjE (e' $$ e.at % elab_typ env t, 0) in
    Ok (e'', t.it)
  | CommaE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* tfs = as_struct_typ "expression" env Infer t1 e1.at in
    let* _ = as_cat_typ "expression" env Infer t1 e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _t2 = attempt (find_field tfs atom at) t1 in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t1 in
      Ok (Il.CompE (e2', e1'), t1.it)
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* _ = as_cat_typ "operand" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 t1 in
    Ok ((if is_iter_typ env t1 then Il.CatE (e1', e2') else Il.CompE (e1', e2')), t1.it)
  | MemE (e1, e2) ->
    choice env [
      (fun env ->
        let* e1', t1 = infer_exp env e1 in
        let* e2' = elab_exp env e2 (IterT (t1, List) $ e2.at) in
        Ok (Il.MemE (e1', e2'), BoolT)
      );
      (fun env ->
        let* e2', t2 = infer_exp env e2 in
        let* t1 = as_list_typ "operand" env Infer t2 e2.at in
        let* e1' = elab_exp env e1 t1 in
        Ok (Il.MemE (e1', e2'), BoolT)
      );
    ]
  | LenE e1 ->
    let* e1', t1 = infer_exp env e1 in
    let* _t11 = as_list_typ "expression" env Infer t1 e1.at in
    Ok (Il.LenE e1', NumT `NatT)
  | SizeE id ->
    let _ = find "grammar" env.grams id in
    Ok (Il.NumE (`Nat Z.zero), NumT `NatT)
  | ParenE e1 | ArithE e1 ->
    infer_exp' env e1
  | TupE es ->
    let* es', ts = infer_exp_list env es in
    Ok (Il.TupE es', TupT ts)
  | CallE (id, as_) ->
    let ps, t, _ = find "definition" env.defs id in
    let as', s = elab_args `Rhs env as_ ps e.at in
    Ok (Il.CallE (id, as'), (Subst.subst_typ s t).it)
  | EpsE ->
    fail_infer e.at "empty sequence"
  | SeqE [] ->  (* treat as empty tuple, not principal *)
    Ok (Il.TupE [], TupT [])
  | SeqE es | ListE es ->  (* treat as homogeneous sequence, not principal *)
    let* es', ts = infer_exp_list env es in
    let t = List.hd ts in
    if List.for_all (equiv_typ env t) (List.tl ts) then
      Ok (Il.ListE es', IterT (t, List))
    else
      fail_infer e.at "expression sequence"
  | InfixE _ -> fail_infer e.at "infix expression"
  | BrackE _ -> fail_infer e.at "bracket expression"
  | IterE (e1, iter) ->
    let iter' = elab_iterexp env iter in
    let* e1', t1 = infer_exp env e1 in
    Ok (Il.IterE (e1', iter'), IterT (t1, match iter with ListN _ -> List | _ -> iter))
  | TypE (e1, t) ->
    let _t' = elab_typ env t in
    let* e1' = elab_exp env e1 t in
    Ok (e1'.it, t.it)
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token concatenation"
  | UnparenE _ -> error e.at "misplaced unparenthesize"
  | LatexE _ -> error e.at "misplaced latex literal"

and infer_exp_list env = function
  | [] -> Ok ([], [])
  | e::es ->
    let* e', t = infer_exp env e in
    let* es', ts = infer_exp_list env es in
    Ok (e'::es', t::ts)


and elab_exp env e t : Il.exp attempt =
  Debug.(log_at "el.elab_exp" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (el_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  nest e.at t (
    if is_iter_typ env t then
      let* t1, iter = as_iter_typ "" env Check t e.at in
      choice env [
        (* Try to parse as expressions of iter type as singleton element first,
        (* such that ambiguous patterns like `(x*) : t**` work as expected and
         * yield `[x* : t*]`. Except when the expression is a wildcard or empty,
         * in which case we never want to treat it as an element, because
         * otherwise patterns like `_ : t*` or `eps : t**` would become
         * `[_ : t] : t*` resp `[[]]`, which isn't useful. *)
        (fun env ->
          match e.it with
          | VarE ({it = "_"; _}, []) | EpsE | SeqE [] -> fail_silent
          | _ ->
            let* e' = elab_exp env e t1 in
            let t' = elab_typ env t in
            Ok (lift_exp' e' iter $$ e.at % t')
        );
        (fun env -> elab_exp_plain env e t);
      ]
    else if is_notation_typ env t then
      let* t1 = as_notation_typ "" env Check t e.at in
      choice env [
        (fun env -> elab_exp_plain env e t);
        (fun env -> elab_exp_notation env (expand_id env t) e t1 t);
      ]
    else
      elab_exp_plain env e t
  )

and elab_exp_plain env e t : Il.exp attempt =
  Debug.(log_at "el.elab_exp_plain" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (el_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  let* e' = elab_exp_plain' env e t in
  let t' = elab_typ env t in
  Ok (e' $$ e.at % t')

and elab_exp_plain' env e t : Il.exp' attempt =
  match e.it with
  | BoolE _ | NumE _ | CvtE _ | UnE _ | BinE _ | CmpE _
  | IdxE _ | DotE _ | MemE _ | LenE _ | SizeE _ | CallE _ | TypE _
  | HoleE _ | FuseE _ | UnparenE _ | LatexE _ ->
    let* e', t' = infer_exp env e in
    cast_exp' "expression" env e' t' t
  | TextE s ->
    let cs = try Utf8.decode s with Utf8.Utf8 -> [] in
    (* Allow treatment as character constant *)
    if List.length cs = 1 && is_nat_typ env t then
      let e' = Il.NumE (`Nat (Z.of_int (List.hd cs))) $$ e.at %
        (Il.NumT `NatT $ e.at) in
      cast_exp' "character" env e' (NumT `NatT $ e.at) t
    else
      let* e', t' = infer_exp env e in
      cast_exp' "expression" env e' t' t
  | VarE (id, _) when id.it = "_" ->
    Ok (Il.VarE id)
  | VarE (id, _) ->
    choice env [
      (fun env ->
        let* e', t' = infer_exp env e in
        cast_exp' "expression" env e' t' t
      );
      (fun env ->
        if is_iter_typ env t && id.it <> "_" then
          (* Never infer an iteration type for a variable *)
          let* t1, iter = as_iter_typ "" env Check t e.at in
          let* e' = elab_exp env e t1 in
          Ok (lift_exp' e' iter)
        else if not (bound env.vars id || bound env.gvars (strip_var_suffix id)) then
          let _ = () in
          env.vars <- bind "variable" env.vars id t;
          Ok (Il.VarE id)
        else
          fail_silent  (* suitable error was produced by infer_exp already *)
      );
    ]
  | SliceE (e1, e2, e3) ->
    let* _t' = as_list_typ "expression" env Check t e1.at in
    let* e1' = elab_exp env e1 t in
    let* e2' = elab_exp env e2 (NumT `NatT $ e2.at) in
    let* e3' = elab_exp env e3 (NumT `NatT $ e3.at) in
    Ok (Il.SliceE (e1', e2', e3'))
  | UpdE (e1, p, e2) ->
    let* e1' = elab_exp env e1 t in
    let* p', t2 = elab_path env p t in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.UpdE (e1', p', e2'))
  | ExtE (e1, p, e2) ->
    let* e1' = elab_exp env e1 t in
    let* p', t2 = elab_path env p t in
    let* _t21 = as_list_typ "path" env Check t2 p.at in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.ExtE (e1', p', e2'))
  | StrE efs ->
    let* tfs = as_struct_typ "record" env Check t e.at in
    let* efs' = elab_expfields env (expand_id env t) (filter_nl efs) tfs t e.at in
    Ok (Il.StrE efs')
  | CommaE (e1, e2) ->
    let* e1' = elab_exp env e1 t in
    let* tfs = as_struct_typ "expression" env Check t e1.at in
    let* _ = as_cat_typ "expression" env Check t e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _t2 = attempt (find_field tfs atom at) t in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t in
      Ok (Il.CompE (e2', e1'))
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* _ = as_cat_typ "expression" env Check t e.at in
    let* e1' = elab_exp env e1 t in
    let* e2' = elab_exp env e2 t in
    Ok (if is_iter_typ env t then Il.CatE (e1', e2') else Il.CompE (e1', e2'))
  | ParenE e1 | ArithE e1 ->
    elab_exp_plain' env e1 t
  | TupE es ->
    let* ts = as_tup_typ "tuple" env Check t e.at in
    let* es' = elab_exp_list env es ts e.at in
    Ok (Il.TupE es')
  | ListE es ->
    let* t1, iter = as_iter_typ "list" env Check t e.at in
    if iter <> List then fail_typ env e.at "list" t else
    let ts = List.init (List.length es) (fun _ -> t1) in
    let* es' = elab_exp_list env es ts e.at in
    Ok (Il.ListE es')
  | SeqE [] when is_empty_typ env t ->
    let* e', t' = infer_exp env e in
    cast_exp' "empty expression" env e' t' t
  | EpsE | SeqE _ when is_iter_typ env t ->
    let* t1, iter = as_iter_typ "" env Check t e.at in
    elab_exp_iter' env (unseq_exp e) (t1, iter) t e.at
  | EpsE
  | AtomE _
  | InfixE _
  | BrackE _
  | SeqE _ ->
    (* All these expression forms can only be used when checking against
     * either a defined notation/variant type or (for SeqE) an iteration type;
     * the latter case is already captured above *)
    if is_notation_typ env t then
      let* nt = as_notation_typ "" env Check t e.at in
      let* e' = elab_exp_notation env (expand_id env t) e nt t in
      Ok e'.it
    else if is_variant_typ env t then
      let* tcs, _ = as_variant_typ "" env Check t e.at in
      let* e' = elab_exp_variant env (expand_id env t) e tcs t e.at in
      Ok e'.it
    else
      let name =
        match e.it with
        | EpsE -> "empty sequence"
        | AtomE _ -> "atom"
        | InfixE _ -> "infix notation"
        | BrackE _ -> "bracket notation"
        | SeqE _ -> "expression sequence"
        | _ -> assert false
      in fail_typ env e.at name t
  | IterE (e1, iter2) ->
    let* t1, iter = as_iter_typ "iteration" env Check t e.at in
    let iter2' = elab_iterexp env iter2 in
    let* e1' = elab_exp env e1 t1 in
    let e' = Il.IterE (e1', iter2') in
    match iter2, iter with
    | Opt, Opt -> Ok e'
    | Opt, List ->
      Ok (Il.LiftE (e' $$ e.at % (Il.IterT (elab_typ env t1, Opt) $ e1.at)))
    | _, Opt -> fail_typ env e.at "iteration" t
    | _, _ -> Ok e'

and elab_exp_list env es ts at : Il.exp list attempt =
  match es, ts with
  | [], [] -> Ok []
  | e::es, t::ts ->
    let* e' = elab_exp env e t in
    let* es' = elab_exp_list env es ts at in
    Ok (e'::es')
  | _, _ ->
    fail at "arity mismatch for expression list"

and elab_expfields env tid efs tfs t0 at : Il.expfield list attempt =
  Debug.(log_in_at "el.elab_expfields" at
    (fun _ -> fmt "{%s} : {%s} = %s" (list el_expfield efs) (list el_typfield tfs) (el_typ t0))
  );
  assert (valid_tid tid);
  match efs, tfs with
  | [], [] -> Ok []
  | (atom1, e)::efs2, (atom2, (t, prems), _)::tfs2 when atom1.it = atom2.it ->
    let* es', _s = elab_exp_notation' env tid e t in
    let* efs2' = elab_expfields env tid efs2 tfs2 t0 at in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') es' e.at in
    Ok ((elab_atom atom1 tid, e') :: efs2')
  | _, (atom, (t, prems), _)::tfs2 ->
    let atom' = string_of_atom atom in
    let* e1' =
      cast_empty ("omitted record field `" ^ atom' ^ "`") env t at (elab_typ env t) in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') [e1'] at in
    let* efs2' = elab_expfields env tid efs tfs2 t0 at in
    Ok ((elab_atom atom tid, e') :: efs2')
  | (atom, e)::_, [] ->
    fail_atom e.at atom t0 "undefined or misplaced record field"

and elab_exp_iter env es (t1, iter) t at : Il.exp attempt =
  let* e' = elab_exp_iter' env es (t1, iter) t at in
  Ok (e' $$ at % elab_typ env t)

and elab_exp_iter' env es (t1, iter) t at : Il.exp' attempt =
  Debug.(log_at "el.elab_exp_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (el_typ t) (el_typ t1) (el_iter iter))
    (function Ok e' -> fmt "%s" (il_exp (e' $$ at % elab_typ env t)) | _ -> "fail")
  ) @@ fun _ ->
  match es, iter with
  | [], Opt ->
    Ok (Il.OptE None)
  | [e1], Opt ->
    let* e1' = elab_exp env e1 t1 in
    Ok (Il.OptE (Some e1'))
  | _::_::_, Opt ->
    fail_typ env at "expression" t

  | [], List ->
    Ok (Il.ListE [])
  | e1::es2, List ->
    let* e1' = elab_exp env e1 t in
    let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
    let* e2' = elab_exp_iter env es2 (t1, iter) t at' in
    Ok (cat_exp' e1' e2')

  | _, (List1 | ListN _) ->
    assert false

and elab_exp_notation env tid e nt t : Il.exp attempt =
  (* Convert notation into applications of mixin operators *)
  assert (valid_tid tid);
  let* es', _s = elab_exp_notation' env tid e nt in
  let mixop, ts', _ = elab_typ_notation env tid nt in
  assert (List.length es' = List.length ts');
  Ok (Il.CaseE (mixop, tup_exp_bind' es' e.at) $$ e.at % elab_typ env t)

and elab_exp_notation' env tid e t : (Il.exp list * Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (el_typ t))
    (function Ok (es', _) -> fmt "%s" (seq il_exp es') | _ -> "fail")
  ) @@ fun _ ->
  assert (valid_tid tid);
  match e.it, t.it with
  | AtomE atom, AtomT atom' ->
    if atom.it <> atom'.it then fail_typ env e.at "atom" t else
    let _ = elab_atom atom tid in
    Ok ([], Subst.empty)
  | InfixE (e1, atom, e2), InfixT (_, atom', _) when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ e2.at) $ e2.at in
    elab_exp_notation' env tid
      (InfixE (e1, atom', SeqE [e21; e2] $ e2.at) $ e.at) t
  | InfixE (e1, atom, e2), InfixT (t1, atom', t2) ->
    if atom.it <> atom'.it then fail_typ env e.at "infix expression" t else
    let* es1', s1 = elab_exp_notation' env tid e1 t1 in
    let* es2', s2 = elab_exp_notation' env tid e2 (Subst.subst_typ s1 t2) in
    let _ = elab_atom atom tid in
    Ok (es1' @ es2', Subst.union s1 s2)
  | BrackE (l, e1, r), BrackT (l', t1, r') ->
    if (l.it, r.it) <> (l'.it, r'.it) then fail_typ env e.at "bracket expression" t else
    let _ = elab_atom l tid in
    let _ = elab_atom r tid in
    elab_exp_notation' env tid e1 t1

  | SeqE [], SeqT [] ->
    Ok ([], Subst.empty)
  | _, SeqT (t1::ts2) when is_iter_typ env t1 ->
    let* t11, iter = as_iter_typ "iteration" env Check t1 e.at in
    elab_exp_notation_iter env tid (unseq_exp e) (t11, iter) t1 ts2 e.at
  | SeqE ({it = AtomE atom; at; _}::es2), SeqT ({it = AtomT atom'; _}::_)
    when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ at) $ at in
    elab_exp_notation' env tid (SeqE ((AtomE atom' $ at) :: e21 :: es2) $ e.at) t
  (* Trailing notation can be flattened *)
  | SeqE (e1::es2), SeqT [t1] ->
    choice env [
      (fun env ->
        let* es1', s1 = elab_exp_notation' env tid (unparen_exp e1) t1 in
        let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let t2 = SeqT [] $ Source.after_region t1.at in
        let* es2', s2 = elab_exp_notation' env tid e2 (Subst.subst_typ s1 t2) in
        Ok (es1' @ es2', Subst.union s1 s2)
      );
      (fun env ->
        let* e' = elab_exp env e t1 in
        Ok ([e'], Subst.empty)
      )
    ]
  | SeqE (e1::es2), SeqT (t1::ts2) ->
    let* es1', s1 = elab_exp_notation' env tid (unparen_exp e1) t1 in
    let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
    let t2 = SeqT ts2 $ Source.over_region (after_region t1.at :: List.map Source.at ts2) in
    let* es2', s2 = elab_exp_notation' env tid e2 (Subst.subst_typ s1 t2) in
    Ok (es1' @ es2', Subst.union s1 s2)
  (* Trailing elements can be omitted if they can be eps *)
  | SeqE [], SeqT (t1::ts2) ->
    let* e1' = cast_empty "omitted sequence tail" env t1 e.at (!!!env tid t1) in
    let t2 = SeqT ts2 $ Source.over_region (after_region t1.at :: List.map Source.at ts2) in
    let* es2', s2 = elab_exp_notation' env tid e t2 in
    Ok (e1' :: es2', s2)
  | SeqE (e1::_), SeqT [] ->
    fail e1.at "expression is not empty"
  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, SeqT _ ->
    elab_exp_notation' env tid (SeqE [e] $ e.at) t

  | ParenE e1, _
  | ArithE e1, _ ->
    elab_exp_notation' env tid e1 t
  | _, ParenT t1 ->
    elab_exp_notation' env tid e t1

  | _, (AtomT _ | InfixT _ | BrackT _) ->
    fail_typ env e.at "expression" t

  | _, _ ->
    let* e' = elab_exp env e t in
    Ok ([e'], Subst.add_varid Subst.empty (Convert.varid_of_typ t) e)

and elab_exp_notation_iter env tid es (t1, iter) t ts at : (Il.exp list * Subst.t) attempt =
  assert (valid_tid tid);
  let t' = elab_typ env t in
  let* e', es', s = elab_exp_notation_iter' env tid es (t1, iter) t ts t' at in
  Ok (e'::es', s)

and elab_exp_notation_iter' env tid es (t1, iter) t ts t' at : (Il.exp * Il.exp list * Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (el_typ t) (el_typ t1) (el_iter iter))
    (function Ok (e', es', _) -> fmt "%s" (seq il_exp (e'::es')) | _ -> "fail")
  ) @@ fun _ ->
  let tat' = Source.over_region (after_region t.at :: List.map Source.at ts) in
  match es, iter with
  | [], Opt ->
    let* es', s = elab_exp_notation' env tid (SeqE [] $ at) (SeqT ts $ tat') in
    Ok (Il.OptE None $$ at % t', es', s)
  | e1::es2, Opt ->
    choice env [
      (fun env ->
        let* es', s = elab_exp_notation' env tid (SeqE (e1::es2) $ at) (SeqT ts $ tat') in
        Ok (Il.OptE None $$ Source.before_region e1.at % t', es', s)
      );
      (fun env ->
        let* e1' = elab_exp env e1 t in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* es2', s = elab_exp_notation' env tid (SeqE es2 $ at') (SeqT ts $ tat') in
        Ok (e1', es2', s)
      );
    ]

  | [], List ->
    let* es', s = elab_exp_notation' env tid (SeqE [] $ at) (SeqT ts $ tat') in
    Ok (Il.ListE [] $$ at % t', es', s)
  | e1::es2, List ->
    choice env [
      (fun env ->
        let* es', s = elab_exp_notation' env tid (SeqE (e1::es2) $ at) (SeqT ts $ tat') in
        Ok (Il.ListE [] $$ at % t', es', s)
      );
      (fun env ->
        let* e1' = elab_exp env e1 t in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* e2', es2', s = elab_exp_notation_iter' env tid es2 (t1, iter) t ts t' at' in
        Ok (cat_exp' e1' e2' $$ Source.over_region [e1'.at; e2'.at] % t', es2', s)
      );
    ]

  | _, (List1 | ListN _) ->
    assert false

and elab_exp_variant env tid e cases t at : Il.exp attempt =
  Debug.(log_at "el.elab_exp_variant" e.at
    (fun _ -> fmt "%s : %s = %s" (el_exp e) tid.it (el_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  assert (valid_tid tid);
  let* atom =
    match e.it with
    | AtomE atom
    | SeqE ({it = AtomE atom; _}::_)
    | InfixE (_, atom, _)
    | BrackE (atom, _, _) -> Ok atom
    | _ -> fail_typ env at "expression" t
  in
  let* t1, _prems = attempt (find_case_sub cases atom atom.at) t in
  let* es', _s = elab_exp_notation' env tid e t1 in
  let t2 = expand env t $ at in
  let t2' = elab_typ env t2 in
  let mixop, ts', _ = elab_typ_notation env tid t1 in
  assert (List.length es' = List.length ts');
  cast_exp "variant case" env
    (Il.CaseE (mixop, tup_exp_bind' es' at) $$ at % t2') t2 t


and elab_path env p t : (Il.path * typ) attempt =
  let* p', t' = elab_path' env p t in
  Ok (p' $$ p.at % elab_typ env t', t')

and elab_path' env p t : (Il.path' * typ) attempt =
  match p.it with
  | RootP ->
    Ok (Il.RootP, t)
  | IdxP (p1, e1) ->
    let* p1', t1 = elab_path env p1 t in
    let e1' = checkpoint (elab_exp env e1 (NumT `NatT $ e1.at)) in
    let* t' = as_list_typ "path" env Check t1 p1.at in
    Ok (Il.IdxP (p1', e1'), t')
  | SliceP (p1, e1, e2) ->
    let* p1', t1 = elab_path env p1 t in
    let e1' = checkpoint (elab_exp env e1 (NumT `NatT $ e1.at)) in
    let e2' = checkpoint (elab_exp env e2 (NumT `NatT $ e2.at)) in
    let* _ = as_list_typ "path" env Check t1 p1.at in
    Ok (Il.SliceP (p1', e1', e2'), t1)
  | DotP (p1, atom) ->
    let* p1', t1 = elab_path env p1 t in
    let* tfs = as_struct_typ "path" env Check t1 p1.at in
    let* t', _prems = attempt (find_field tfs atom p1.at) t1 in
    Ok (Il.DotP (p1', elab_atom atom (expand_id env t1)), t')


and cast_empty phrase env t at t' : Il.exp attempt =
  Debug.(log_at "el.elab_exp_cast_empty" at
    (fun _ -> fmt "%s  >>  (%s)" (el_typ t) (el_typ (expand_notation env t $ t.at)))
    (function Ok r -> fmt "%s" (il_exp r) | _ -> "fail")
  ) @@ fun _ ->
  nest at t (
    match expand_notation env t with
    | SeqT [] -> Ok (Il.ListE [] $$ at % t')
    | IterT (_, Opt) -> Ok (Il.OptE None $$ at % t')
    | IterT (_, List) -> Ok (Il.ListE [] $$ at % t')
    | VarT _ when is_iter_notation_typ env t ->
      (match expand_iter_notation env t with
      | IterT (_, iter) as t1 ->
        let mixop, ts', _ts = elab_typ_notation env (expand_id env t) (t1 $ t.at) in
        assert (List.length ts' = 1);
        let e1' = if iter = Opt then Il.OptE None else Il.ListE [] in
        Ok (Il.CaseE (mixop, tup_exp_bind' [e1' $$ at % List.hd ts'] at) $$ at % t')
      | _ -> fail_typ env at phrase t
      )
    | _ -> fail_typ env at phrase t
  )

and cast_exp phrase env e' t1 t2 : Il.exp attempt =
  let* e'' = nest e'.at t2 (cast_exp' phrase env e' t1 t2) in
  Ok (e'' $$ e'.at % elab_typ env (expand_nondef env t2))

and cast_exp' phrase env e' t1 t2 : Il.exp' attempt =
  Debug.(log_at "el.elab_exp_cast" e'.at
    (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s)" (el_typ t1) (el_typ t2)
      (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
      (el_typ (expand_nondef env t2))
    )
    (function Ok r -> fmt "%s" (il_exp (r $$ e'.at % elab_typ env t2)) | _ -> "fail")
  ) @@ fun _ ->
  if equiv_typ env t1 t2 then Ok e'.it else
  match expand_def env t1, expand_def env t2 with
  | _, _ when sub_typ env t1 t2 ->
    let t1' = elab_typ env (expand_nondef env t1) in
    let t2' = elab_typ env (expand_nondef env t2) in
    Ok (Il.SubE (e', t1', t2'))
  | NumT nt1, NumT nt2 when nt1 < nt2 || lax_num && nt1 <> `RealT ->
    Ok (Il.CvtE (e', nt1, nt2))
  | TupT [], SeqT [] ->
    Ok e'.it
  | ConT ((t11, _), _), ConT ((t21, _), _) ->
    choice env [
      (fun env ->
        let mixop1, ts1', ts1 = elab_typ_notation env (expand_id env t1) t11 in
        let mixop2, _ts2', ts2 = elab_typ_notation env (expand_id env t2) t21 in
        if mixop1 <> mixop2 then
          fail_typ2 env e'.at phrase t1 t2 "" else
        let e'' = Il.UncaseE (e', mixop1) $$ e'.at % tup_typ' ts1' e'.at in
        let es' = List.mapi (fun i t1I' -> Il.ProjE (e'', i) $$ e''.at % t1I') ts1' in
        let* es'' = map2_attempt (fun eI' (t1I, t2I) ->
          cast_exp phrase env eI' t1I t2I) es' (List.combine ts1 ts2) in
        Ok (Il.CaseE (mixop2, tup_exp_bind' es'' e'.at))
      );
      (fun env ->
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 1" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let mixop, ts', ts = elab_typ_notation env (expand_id env t1) t11 in
        let* t111, t111' = match ts, ts' with [t111], [t111'] -> Ok (t111, t111') | _ ->
          fail_typ2 env e'.at phrase t1 t2 "" in
        let e'' = Il.UncaseE (e', mixop) $$ e'.at % tup_typ' ts' e'.at in
        cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2
      );
    ]
  | ConT ((t11, _), _), t2' ->
    choice env [
      (fun env ->
        let* e'' =
          match t2' with
          | IterT (t21, iter) ->
            let* e1' = cast_exp phrase env e' t1 t21 in
            (match iter with
            | Opt -> Ok (Il.OptE (Some e1'))
            | List -> Ok (Il.ListE [e1'])
            | _ -> assert false
            )
          | _ -> fail_silent
        in
        Ok e''
      );
      (fun env ->
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 2" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let mixop, ts', ts = elab_typ_notation env (expand_id env t1) t11 in
        let* t111, t111' = match ts, ts' with [t111], [t111'] -> Ok (t111, t111') | _ ->
          fail_typ2 env e'.at phrase t1 t2 "" in
        let e'' = Il.UncaseE (e', mixop) $$ e'.at % tup_typ' ts' e'.at in
        cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2
      );
    ]
  | _, ConT ((t21, _), _) ->
    let mixop, _ts', ts = elab_typ_notation env (expand_id env t2) t21 in
    let* t211 = match ts with [t211] -> Ok t211 | _ ->
      fail_typ2 env e'.at phrase t1 t2 "" in
    let* e1' = cast_exp phrase env e' t1 t211 in
    Ok (Il.CaseE (mixop, tup_exp_bind' [e1'] e'.at))
  | RangeT _, t2' ->
    choice env [
      (fun env ->
        let* e'' =
          match t2' with
          | IterT (t21, iter) ->
            let* e1' = cast_exp phrase env e' t1 t21 in
            (match iter with
            | Opt -> Ok (Il.OptE (Some e1'))
            | List -> Ok (Il.ListE [e1'])
            | _ -> assert false
            )
          | _ -> fail_silent
        in
        Ok e''
      );
      (fun env ->
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 3" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let t11 = typ_rep env t1 in
        let t11' = elab_typ env t11 in
        let e'' = Il.UncaseE (e', [[]; []]) $$ e'.at % tup_typ' [t11'] e'.at in
        let e''' = Il.ProjE (e'', 0) $$ e'.at % t11' in
        cast_exp' phrase env e''' t11 t2
      );
    ]
  | _, RangeT _ ->
    let t21 = typ_rep env t2 in
    let* e'' = cast_exp phrase env e' t1 t21 in
    Ok (Il.CaseE ([[]; []], tup_exp_bind' [e''] e'.at))
  | _, IterT (t21, Opt) ->
    let* e'' = cast_exp phrase env e' t1 t21 in
    Ok (Il.OptE (Some e''))
(* TODO(3, rossberg): enable; violates invariant that all iterexps are initially empty
  | IterT (t11, List), IterT (t21, List) ->
    choice env [
      (fun env ->
        let id = x $ e'.at in
        let t11' = elab_typ env t11 in
        let* e'' = cast_exp phrase env (Il.VarE id $$ e'.at % t11') t11 t21 in
        Ok (Il.IterE (e'', (List, [x, e'])))
      );
      (fun env ->
        let* e'' = cast_exp phrase env e' t1 t21 in
        Ok (Il.ListE [e''])
      );
    ]
*)
  | IterT (t11, Opt), IterT (t21, List) ->
    choice env [
      (fun env ->
        let t11' = elab_typ env t11 in
        let e'' = Il.LiftE e' $$ e'.at % (Il.IterT (t11', Il.List) $ e'.at) in
        cast_exp' phrase env e'' (IterT (t11, List) $ e'.at) t2
      );
      (fun env ->
        let* e'' = cast_exp phrase env e' t1 t21 in
        Ok (Il.ListE [e''])
      );
    ]
  | _, IterT (t21, (List | List1)) ->
    let* e'' = cast_exp phrase env e' t1 t21 in
    Ok (Il.ListE [e''])
  | _, _ when is_variant_typ env t1 && is_variant_typ env t2 && not (is_iter_typ env t1) ->
    let cases1, dots1 = checkpoint (as_variant_typ "" env Check t1 e'.at) in
    let cases2, _dots2 = checkpoint (as_variant_typ "" env Check t2 e'.at) in
    if dots1 = Dots then
      error e'.at "used variant type is only partially defined at this point";
    let* _ =
      match
        iter_attempt (fun (atom, (t1', _prems1), _) ->
          let* t2', _prems2 = attempt (find_case cases2 atom t1.at) t2 in
          (* Shallow subtyping on variants *)
          let env' = to_eval_env env in
          if Eq.eq_typ (Eval.reduce_typ env' t1') (Eval.reduce_typ env' t2') then Ok () else
            fail_atom e'.at atom t1 "type mismatch for case"
        ) cases1
      with
      | Ok () -> Ok ()
      | Fail (Trace (_, msg, _) :: _) -> fail_typ2 env e'.at phrase t1 t2 (", " ^ msg)
      | Fail [] -> assert false
    in
    let t11 = expand env t1 $ t1.at in
    let t21 = expand env t2 $ t2.at in
    let t11' = elab_typ env (expand_nondef env t1) in
    let t21' = elab_typ env (expand_nondef env t2) in
    let* e'' = cast_exp phrase env e' t1 t11 in
    let e''' = Il.SubE (e'', t11', t21') in
    cast_exp' phrase env (e''' $$ e'.at % t21') t21 t2
  | _, _ ->
    fail_typ2 env e'.at phrase t1 t2 ""


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
    let es', _s = checkpoint (elab_exp_notation' env id e t) in
    [Il.RulePr (id, mixop, tup_exp' es' e.at) $ prem.at]
  | IfPr e ->
    let e' = checkpoint (elab_exp env e (BoolT $ e.at)) in
    [Il.IfPr e' $ prem.at]
  | ElsePr ->
    [Il.ElsePr $ prem.at]
  | IterPr ({it = VarPr _; at; _}, _iter) ->
    error at "misplaced variable premise"
  | IterPr (prem1, iter) ->
    let iter' = elab_iterexp env iter in
    let prem1' = List.hd (elab_prem env prem1) in
    [Il.IterPr (prem1', iter') $ prem.at]


(* Grammars *)

and infer_sym env g : (Il.sym * typ) attempt =
  Debug.(log_at "el.infer_sym" g.at
    (fun _ -> fmt "%s" (el_sym g))
    (function Ok (g', t) -> fmt "%s : %s" (il_sym g') (el_typ t) | _ -> "fail")
  ) @@ fun _ ->
  nest g.at (TupT [] $ g.at) (
    match g.it with
    | VarG (id, as_) ->
      let ps, t, _gram, _prods' = find "grammar" env.grams id in
      let as', s = elab_args `Rhs env as_ ps g.at in
      Ok (Il.VarG (id, as') $ g.at, Subst.subst_typ s t)
    | NumG (`CharOp, n) ->
(*
      let s = try Utf8.encode [Z.to_int n] with Z.Overflow | Utf8.Utf8 ->
        error g.at "character value out of range" in
      Il.TextG s $ g.at, TextT $ g.at, env
*)
      if n < Z.of_int 0x00 || n > Z.of_int 0x10ffff then
        fail g.at "unicode value out of range"
      else
        Ok (Il.NumG (Z.to_int n) $ g.at, NumT `NatT $ g.at)
    | NumG (_, n) ->
      if n < Z.of_int 0x00 || n > Z.of_int 0xff then
        fail g.at "byte value out of range"
      else
        Ok (Il.NumG (Z.to_int n) $ g.at, NumT `NatT $ g.at)
    | TextG s ->
      Ok (Il.TextG s $ g.at, TextT $ g.at)
    | EpsG ->
      Ok (Il.EpsG $ g.at, TupT [] $ g.at)
    | SeqG gs ->
      let* gs' = elab_sym_list env (filter_nl gs) (TupT [] $ g.at) in
      Ok (Il.SeqG gs' $ g.at, TupT [] $ g.at)
    | AltG gs ->
      choice env [
        (fun env ->
          let* gs', ts = infer_sym_list env (filter_nl gs) in
          if ts <> [] && List.for_all (equiv_typ env (List.hd ts)) ts then
            Ok (Il.AltG gs' $ g.at, List.hd ts)
          else fail g.at "inconsistent types"
        );
        (fun env ->
          (* HACK to treat singleton strings in short grammar as characters *)
          let* g' = elab_sym env g (NumT `NatT $ g.at) in
          Ok (g', NumT `NatT $ g.at)
        );
        (fun env ->
          let* g' = elab_sym env g (TupT [] $ g.at) in
          Ok (g', TupT [] $ g.at)
        )
      ]
    | RangeG (g1, g2) ->
      let env1 = local_env env in
      let env2 = local_env env in
      let* g1' = elab_sym env1 g1 (NumT `NatT $ g1.at) in
      let* g2' = elab_sym env2 g2 (NumT `NatT $ g2.at) in
      if env1.vars != env.vars then
        error g1.at "invalid symbol in range";
      if env2.vars != env.vars then
        error g2.at "invalid symbol in range";
      Ok (Il.RangeG (g1', g2') $ g.at, NumT `NatT $ g.at)
    | ParenG g1 ->
      infer_sym env g1
    | TupG _ -> error g.at "malformed grammar"
    | ArithG e ->
      infer_sym env (sym_of_exp e)
    | IterG (g1, iter) ->
      let iterexp' = elab_iterexp env iter in
      let* g1', t1 = infer_sym env g1 in
      Ok (
        Il.IterG (g1', iterexp') $ g.at,
        IterT (t1, match iter with Opt -> Opt | _ -> List) $ g.at
      )
    | AttrG (e, g1) ->
      choice env [
        (fun env ->
          (* HACK to treat singleton strings in short grammar as characters *)
          let t1 = NumT `NatT $ g1.at in
          let* g1' = elab_sym env g1 t1 in
          let* e' = elab_exp env e t1 in
          Ok (Il.AttrG (e', g1') $ g.at, t1)
        );
        (fun env ->
          let* g1', t1 = infer_sym env g1 in
          let* e' = elab_exp env e t1 in
          Ok (Il.AttrG (e', g1') $ g.at, t1)
        );
      ]
  (*
      let g1', t1 = infer_sym env g1 in
      let e' = checkpoint (elab_exp env e t1) in
      Il.AttrG (e', g1') $ g.at, t1
  *)
    | FuseG _ -> error g.at "misplaced token concatenation"
    | UnparenG _ -> error g.at "misplaced token unparenthesize"
  )

and infer_sym_list env es : (Il.sym list * typ list) attempt =
  match es with
  | [] -> Ok ([], [])
  | g::gs ->
    let* g', t = infer_sym env g in
    let* gs', ts = infer_sym_list env gs in
    Ok (g'::gs', t::ts)

and elab_sym env g t : Il.sym attempt =
  Debug.(log_at "el.elab_sym" g.at
    (fun _ -> fmt "%s : %s" (el_sym g) (el_typ t))
    (function Ok g' -> fmt "%s" (il_sym g') | _ -> "fail")
  ) @@ fun _ ->
  nest g.at t (
    match g.it with
    | TextG s when is_nat_typ env t ->
      let cs = try Utf8.decode s with Utf8.Utf8 -> [] in
      (* Allow treatment as character constant *)
      if List.length cs = 1 then
        Ok (Il.NumG (List.hd cs) $ g.at)
      else
        let* g', t' = infer_sym env g in
        cast_sym env g' t' t
    | AltG gs ->
      let* gs' = elab_sym_list env (filter_nl gs) t in
      Ok (Il.AltG gs' $ g.at)
    | ParenG g1 ->
      elab_sym env g1 t
    | _ ->
      let* g', t' = infer_sym env g in
      cast_sym env g' t' t
  )

and elab_sym_list env es t : Il.sym list attempt =
  match es with
  | [] -> Ok []
  | g::gs ->
    let* g' = elab_sym env g t in
    let* gs' = elab_sym_list env gs t in
    Ok (g'::gs')

and cast_sym env g' t1 t2 : Il.sym attempt =
  Debug.(log_at "el.elab_cast_sym" g'.at
    (fun _ -> fmt "%s : %s :> %s" (il_sym g') (el_typ t1) (el_typ t2))
    (function Ok g'' -> fmt "%s" (il_sym g'') | _ -> "fail")
  ) @@ fun _ ->
  nest g'.at t2 (
    if equiv_typ env t1 t2 then
      Ok g'
    else if equiv_typ env t2 (TupT [] $ t2.at) then
      Ok (Il.SeqG [g'] $ g'.at)
    else
      fail_typ2 env g'.at "symbol" t1 t2 ""
  )

and elab_prod env prod t : Il.prod list =
  Debug.(log_in_at "el.elab_prod" prod.at
    (fun _ -> fmt "%s : %s" (el_prod prod) (el_typ t))
  );
  match prod.it with
  | SynthP (g, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_prod (vars env) prod in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let g', _t = checkpoint (infer_sym env' g) in
    let g' = Dim.annot_sym dims' g' in
    let e' =
      checkpoint (
        if equiv_typ env' t (TupT [] $ e.at) then
          (* Special case: ignore unit attributes *)
          (* TODO(4, rossberg): introduce proper top type? *)
          let* e', _t = infer_exp env' e in
          let t'_unit = Il.TupT [] $ e.at in
          let joker () = Il.VarE ("_" $ e.at) $$ e.at % t'_unit in
          Ok (Il.ProjE (
            Il.TupE [
              e'; Il.TupE [] $$ e.at % t'_unit
            ] $$ e.at % (Il.TupT [joker (), e'.note; joker (), t'_unit] $ e.at), 1
          ) $$ e.at % t'_unit)
        else
          elab_exp env' e t
      )
    in
    let e' = Dim.annot_exp dims' e' in
    let prems' = List.map (Dim.annot_prem dims')
      (concat_map_filter_nl_list (elab_prem env') prems) in
    let det = Free.(diff (union (det_sym g) (det_prems prems)) (bound_env env)) in
    let free = Free.(diff (free_prod prod) (union (det_prod prod) (bound_env env'))) in
    if free <> Free.empty then
      error prod.at ("grammar rule contains indeterminate variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
    let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
    let module Acc = Iter.Make(Arg) in
    Acc.sym g;
    Acc.exp e;
    Acc.prems prems;
    let prod' = Il.ProdD (!acc_bs', g', e', prems') $ prod.at in
    if not env'.pm then
      [prod']
    else
      prod' :: elab_prod env Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t
  | RangeP (g1, e1, g2, e2) ->
    let t = NumT `NatT $ prod.at in
    let g1' = checkpoint (elab_sym env g1 t) in
    let e1' = checkpoint (elab_exp env e1 t) in
    let g2' = checkpoint (elab_sym env g2 t) in
    let e2' = checkpoint (elab_exp env e2 t) in
    let c1 =
      match g1'.it with
      | Il.NumG c1 -> c1
      | _ -> error g1.at "invalid rule range grammar"
    in
    let c2 =
      match g2'.it with
      | Il.NumG c2 -> c2
      | _ -> error g2.at "invalid rule range grammar"
    in
    let n1 =
      match e1'.it with
      | Il.NumE (`Nat n1) -> n1
      | _ -> error e1.at "invalid rule range expression"
    in
    let n2 =
      match e2'.it with
      | Il.NumE (`Nat n2) -> n2
      | _ -> error e2.at "invalid rule range expression"
    in
    if c2 < c1 then
      error prod.at "empty rule range";
    if Z.of_int (c2 - c1) <> Z.(n2 - n1) then
      error prod.at "inconistent grammar vs expression distance in rule range";
    List.init (c2 - c1 + 1) (fun i ->
      let n = `Nat Z.(n1 + Z.of_int i) in
      let g' = {(if i = 0 then g1' else g2') with it = Il.NumG (c1 + i)} in
      let e' = {(if i = 0 then e1' else e2') with it = Il.NumE n} in
      Il.ProdD ([], g', e', []) $ prod.at
    )
  | EquivP (g1, g2, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_prod (vars env) prod in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let g1', _t1 = checkpoint (infer_sym env' g1) in
    let g1' = Dim.annot_sym dims' g1' in
    let g2', _t2 = checkpoint (infer_sym env' g2) in
    let g2' = Dim.annot_sym dims' g2' in
    let prems' = List.map (Dim.annot_prem dims')
      (concat_map_filter_nl_list (elab_prem env') prems) in
    let det = Free.(diff (union (det_sym g1) (det_prems prems)) (bound_env env)) in
    let free = Free.(diff (free_prod prod) (union (det_prod prod) (bound_env env'))) in
    if free <> Free.empty then
      error prod.at ("grammar rule contains indeterminate variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
    let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
    let module Acc = Iter.Make(Arg) in
    Acc.sym g1;
    Acc.sym g2;
    Acc.prems prems;
ignore (acc_bs', g1', g2', prems');
[]
(*
    let prod' = Il.ProdD (!acc_bs', g1', e', prems') $ prod.at in
    if not env'.pm then
      [prod']
    else
      prod' :: elab_prod env Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t
*)

and elab_gram env gram t : Il.prod list =
  let (_dots1, prods, _dots2) = gram.it in
  concat_map_filter_nl_list (fun prod -> elab_prod env prod t) prods


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
        if Free.(Set.mem id.it !left.varid) && Dim.Env.mem id.it dims then (
          let t =
            try find "variable" env.vars id with Error _ ->
              find "variable" env.gvars (strip_var_suffix id)
          in
          let fwd = Free.(inter (free_typ t) !left) in
          if fwd <> Free.empty then
            error id.at ("the type of `" ^ id.it ^ "` depends on " ^
              ( Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid @ elements fwd.defid) |>
                List.map (fun id -> "`" ^ id ^ "`") |>
                String.concat ", " ) ^
              ", which only occur(s) to its right; try to reorder parameters or premises");
          let ctx' =
            List.map (function Opt -> Il.Opt | _ -> Il.List)
              (Dim.Env.find id.it dims)
          in
          let t' =
            List.fold_left (fun t iter ->
              Il.IterT (t, iter) $ t.at
            ) (elab_typ env t) ctx'
          in
          acc := !acc @ [Il.ExpB (Dim.annot_varid id ctx', t') $ id.at];
          left := Free.{!left with varid = Set.remove id.it !left.varid};
        )

      let visit_gramid id =
        if Free.(Set.mem id.it !left.gramid) then (
          let ps, t, _gram, _prods' = find "grammar" env.grams id in
          let free' = Free.(union (free_params ps) (diff (free_typ t) (bound_params ps))) in
          let fwd = Free.(inter free' !left) in
          if fwd <> Free.empty then
            error id.at ("the type of `" ^ id.it ^ "` depends on " ^
              ( Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid @ elements fwd.defid) |>
                List.map (fun id -> "`" ^ id ^ "`") |>
                String.concat ", " ) ^
              ", which only occur(s) to its right; try to reorder parameters or premises");
          left := Free.{!left with varid = Set.remove id.it !left.gramid};
        )

      let visit_defid id =
        if Free.Set.mem id.it !left.defid then (
          let ps, t, _ = find "definition" env.defs id in
          let env' = local_env env in
          let ps' = elab_params env' ps in
          let t' = elab_typ env' t in
          let free' = Free.(union (free_params ps) (diff (free_typ t) (bound_params ps))) in
          let fwd = Free.(inter free' !left) in
          if fwd <> Free.empty then
            error id.at ("the type of `" ^ (spaceid "definition" id).it ^ "` depends on " ^
              ( Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid @ elements fwd.defid) |>
                List.map (fun id -> "`" ^ id ^ "`") |>
                String.concat ", " ) ^
              ", which only occur(s) to its right; try to reorder parameters or premises");
          acc := !acc @ [Il.DefB (id, ps', t') $ id.at];
          left := Free.{!left with defid = Set.remove id.it !left.defid};
        )
    end
  in Arg.acc, (module Arg)

and elab_arg in_lhs env a p s : Il.arg list * Subst.subst =
  (match !(a.it), p.it with  (* HACK: handle shorthands *)
  | ExpA e, TypP _ -> a.it := TypA (typ_of_exp e)
  | ExpA e, GramP _ -> a.it := GramA (sym_of_exp e)
  | ExpA {it = CallE (id, []); _}, DefP _ -> a.it := DefA id
  | _, _ -> ()
  );
  match !(a.it), (Subst.subst_param s p).it with
  | ExpA e, ExpP (id, t) ->
    let e' = checkpoint (elab_exp env e t) in
    [Il.ExpA e' $ a.at], Subst.add_varid s id e
  | TypA ({it = VarT (id', []); _} as t), TypP id when in_lhs = `Lhs ->
    let id'' = strip_var_suffix id' in
    let is_prim =
      match (Convert.typ_of_varid id'').it with
      | VarT _ -> false
      | _ -> true
    in
    env.typs <- bind "syntax type" env.typs id'' ([], Opaque);
    if not is_prim then
      env.gvars <- bind "variable" env.gvars (strip_var_sub id'') (VarT (id'', []) $ id''.at);
    [Il.TypA (Il.VarT (id'', []) $ t.at) $ a.at], Subst.add_typid s id t
  | TypA t, TypP _ when in_lhs = `Lhs ->
    error t.at "misplaced syntax type"
  | TypA t, TypP id ->
    let t' = elab_typ env t in
    [Il.TypA t' $ a.at], Subst.add_typid s id t
  | GramA g, GramP _ when in_lhs = `Lhs ->
    error g.at "misplaced grammar symbol"
  | GramA g, GramP (id', t) ->
    let g', t' = checkpoint (infer_sym env g) in
    let s' = subst_implicit env s t t' in
    if not (equiv_typ env t' (Subst.subst_typ s' t)) then
      error_typ2 env a.at "argument" t' t "";
    let as' = List.map (fun (_id, t) -> Il.TypA (elab_typ env t) $ t.at) Subst.(Map.bindings s'.typid) in
    as' @ [Il.GramA g' $ a.at], Subst.add_gramid s' id' g
  | DefA id, DefP (id', ps', t') when in_lhs = `Lhs ->
    env.defs <- bind "definition" env.defs id (ps', t', []);
    [Il.DefA id $ a.at], Subst.add_defid s id' id
  | DefA id, DefP (id', ps', t') ->
    let ps, t, _ = find "definition" env.defs id in
    if not (Eval.equiv_functyp (to_eval_env env) (ps, t) (ps', t')) then
      error a.at ("type mismatch in function argument, expected `" ^
        (spaceid "definition" id').it ^ Print.(string_of_params ps' ^ " : " ^ string_of_typ ~short:true t') ^
        "` but got `" ^
        (spaceid "definition" id).it ^ Print.(string_of_params ps ^ " : " ^ string_of_typ ~short:true t ^ "`")
      );
    [Il.DefA id $ a.at], Subst.add_defid s id id'
  | _, _ ->
    error a.at "sort mismatch for argument"

and elab_args in_lhs env as_ ps at : Il.arg list * Subst.subst =
  Debug.(log_at "el.elab_args" at
    (fun _ -> fmt "(%s) : (%s)" (list el_arg as_) (list el_param ps))
    (fun (r, _) -> fmt "(%s)" (list il_arg r))
  ) @@ fun _ ->
  elab_args' in_lhs env as_ ps [] Subst.empty at

and elab_args' in_lhs env as_ ps as' s at : Il.arg list * Subst.subst =
  match as_, ps with
  | [], [] -> List.concat (List.rev as'), s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as1, p::ps1 ->
    let a', s' = elab_arg in_lhs env a p s in
    elab_args' in_lhs env as1 ps1 (a'::as') s' at

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

and elab_param env p : Il.param list =
  match p.it with
  | ExpP (id, t) ->
    let t' = elab_typ env t in
    (* If a variable isn't globally declared, this is a local declaration. *)
    let id' = strip_var_suffix id in
    if bound env.gvars id' then (
      let t2 = find "" env.gvars id' in
      if not (sub_typ env t t2) then
        error_typ2 env id.at "local variable" t t2 ", shadowing with different type"
    );
    (* Shadowing is allowed, but only with consistent type. *)
    if bound env.vars id' then (
      let t2 = find "" env.vars id' in
      if not (equiv_typ env t t2) then
        error_typ2 env id.at "local variable" t t2 ", shadowing with different type"
    )
    else
      env.vars <- bind "variable" env.vars id t;
    [Il.ExpP (id, t') $ p.at]
  | TypP id ->
    env.typs <- bind "syntax type" env.typs id ([], Opaque);
    env.gvars <- bind "variable" env.gvars (strip_var_sub id) (VarT (id, []) $ id.at);
    [Il.TypP id $ p.at]
  | GramP (id, t) ->
    (* Treat unbound type identifiers in t as implicitly bound. *)
    let free = Free.free_typ t in
    env.grams <- bind "grammar" env.grams id ([], t, None, []);
    let ps' =
      Free.Set.fold (fun id' ps' ->
        if Map.mem id' env.typs then ps' else (
          let id = id' $ t.at in
          if id.it <> (strip_var_suffix id).it then
            error_id id "invalid identifer suffix in binding position";
          env.typs <- bind "syntax type" env.typs id ([], Opaque);
          env.gvars <- bind "variable" env.gvars (strip_var_sub id) (VarT (id, []) $ id.at);
          (Il.TypP id $ id.at) :: ps'
        )
      ) free.typid []
    in
    let t' = elab_typ env t in
    ps' @ [Il.GramP (id, t') $ p.at] 
  | DefP (id, ps, t) ->
    let env' = local_env env in
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    env.defs <- bind "definition" env.defs id (ps, t, []);
    [Il.DefP (id, ps', t') $ p.at]

and elab_params env ps : Il.param list =
  List.concat_map (elab_param env) ps


(* To allow optional atoms such as `MUT?`, preprocess type
 * definitions to insert implicit type definition
 * `syntax MUT hint(show MUT) = MUT` and replace atom with type id. *)
and infer_typ_notation env is_con t : typ =
  (match t.it with
  | VarT _ | BoolT | NumT _ | TextT | ParenT _ | TupT _ | RangeT _ -> t.it
  | AtomT _ -> is_con := true; t.it
  | SeqT ts -> is_con := true;
    SeqT (List.map (infer_typ_notation env is_con) ts)
  | InfixT (t1, op, t2) -> is_con := true;
    InfixT (infer_typ_notation env is_con t1, op, infer_typ_notation env is_con t2)
  | BrackT (l, t1, r) -> is_con := true;
    BrackT (l, infer_typ_notation env is_con t1, r)
  | StrT tfs ->
    StrT (Convert.map_nl_list (fun (a, (t, p), h) ->
      a, (infer_typ_notation env is_con t, p), h) tfs)
  | CaseT (d1, ts, tcs, d2) ->
    CaseT (d1, ts, Convert.map_nl_list (fun (a, (t, p), h) ->
      a, (infer_typ_notation env is_con t, p), h) tcs, d2)
  | ConT ((t, p), h) ->
    assert (not !is_con);  (* ConT cannot nest *)
    let t' = infer_typ_notation env is_con t in
    if !is_con || p <> [] || h <> [] then
      ConT ((t', p), h)
    else
      t'.it
  | IterT ({it = AtomT atom; _}, iter) ->
    let id = Atom.name atom $ atom.at in
    if not (bound env.atoms id) then
    (
      env.typs <- bind "syntax type" env.typs id ([], Transp);
      env.atoms <- bind "atom" env.atoms id atom;
    );
    IterT (VarT (id, []) $ atom.at, iter)
  | IterT (t1, iter) -> IterT (infer_typ_notation env is_con t1, iter)
  ) $ t.at

let infer_typ_definition _env t : kind =
  match t.it with
  | StrT _ | CaseT _ -> Opaque
  | ConT _ | RangeT _ -> Transp
  | _ -> Transp

let infer_typdef env d : def =
  match d.it with
  | FamD (id, ps, _hints) ->
    let _ps' = elab_params (local_env env) ps in
    env.typs <- bind "syntax type" env.typs id (ps, Family []);
    if ps = [] then  (* only types without parameters double as variables *)
      env.gvars <- bind "variable" env.gvars (strip_var_sub id) (VarT (id, []) $ id.at);
    d
  | TypD (id1, id2, as_, t, hints) ->
    let is_con = ref false in
    let t = infer_typ_notation env is_con t in
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
        env.gvars <- bind "variable" env.gvars (strip_var_sub id1) (VarT (id1, []) $ id1.at);
    );
    TypD (id1, id2, as_, t, hints) $ d.at
  | VarD (id, t, _hints) ->
    (* This is to ensure that we get rebind errors in syntactic order. *)
    env.gvars <- bind "variable" env.gvars id t;
    d
  | _ -> d

let infer_gramdef env d =
  match d.it with
  | GramD (id1, _id2, ps, t, _gram, _hints) ->
    (*
    Printf.eprintf "[el.infer_gramdef %s]\n%!" (string_of_region d.at);
    *)
    if not (bound env.grams id1) then (
      let env' = local_env env in
      let _ps' = elab_params env' ps in
      let _t' = elab_typ env' t in
      env.grams <- bind "grammar" env.grams id1 (ps, t, None, []);
    )
  | _ -> ()

let elab_hintdef _env hd : Il.def list =
  match hd.it with
  | TypH (id1, _id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.TypH (id1, elab_hints id1 [] hints) $ hd.at) $ hd.at]
  | RelH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RelH (id, elab_hints id [] hints) $ hd.at) $ hd.at]
  | DecH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.DecH (id, elab_hints id [] hints) $ hd.at) $ hd.at]
  | AtomH (id, atom, _hints) ->
    let _ = elab_atom atom id in []
  | GramH _ | VarH _ ->
    []


let infer_binds env env' dims d : Il.bind list =
  Debug.(log_in_at "el.infer_binds" d.at
    (fun _ ->
      Map.fold (fun id _ ids ->
        if Map.mem id env.vars then ids else id::ids
      ) env'.vars [] |> List.rev |> String.concat " "
    )
  );
  let det = Free.det_def d in
  let free = Free.(diff (free_def d) (union det (bound_env env))) in
  if free <> Free.empty then
    error d.at ("definition contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
  let acc_bs', (module Arg : Iter.Arg) = make_binds_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  Acc.def d;
  !acc_bs'

let infer_no_binds env dims d =
  let bs' = infer_binds env env dims d in
  assert (bs' = [])


let rec elab_def env d : Il.def list =
  Debug.(log_in "el.elab_def" line);
  Debug.(log_in_at "el.elab_def" d.at (fun _ -> el_def d));
  match d.it with
  | FamD (id, ps, hints) ->
    env.pm <- false;
    let ps' = elab_params (local_env env) ps in
    if env.pm then error d.at "misplaced +- or -+ operator in syntax type declaration";
    let dims = Dim.check_def d in
    infer_no_binds env dims d;
    env.typs <- rebind "syntax type" env.typs id (ps, Family []);
    [Il.TypD (id, ps', []) $ d.at]
      @ elab_hintdef env (TypH (id, "" $ id.at, hints) $ d.at)
  | TypD (id1, id2, as_, t, hints) ->
    let env' = local_env env in
    env'.pm <- false;
    let ps1, k1 = find "syntax type" env.typs id1 in
    let as', _s = elab_args `Lhs env' as_ ps1 d.at in
    let dt' = elab_typ_definition env' id1 t in
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let bs' = infer_binds env env' dims d in
    let inst' = Il.InstD (bs', List.map (Dim.annot_arg dims') as', dt') $ d.at in
    let k1', closed =
      match k1, t.it with
      | Opaque, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of not yet defined syntax type"
      | Opaque, CaseT (NoDots, _, _, dots2) ->
        Defined (t, [id2], dt'), dots2 = NoDots
      | (Opaque | Transp), _ ->
        Defined (t, [id2], dt'), true
      | Defined ({it = CaseT (dots1, ts1, tcs1, Dots); at; _}, ids, _),
          CaseT (Dots, ts2, tcs2, dots2) ->
        let ps = List.map Convert.param_of_arg as_ in
        if List.exists (fun id -> id.it = id2.it) ids then
          error d.at ("duplicate syntax fragment name `" ^ id1.it ^
            (if id2.it = "" then "" else "/" ^ id2.it) ^ "`");
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "syntax parameters differ from previous fragment";
        let t1 = CaseT (dots1, ts1 @ ts2, tcs1 @ tcs2, dots2) $ over_region [at; t.at] in
        Defined (t1, id2::ids, dt'), dots2 = NoDots
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
    ) @ elab_hintdef env (TypH (id1, id2, hints) $ d.at) @
    (if not env'.pm then [] else elab_def env Subst.(subst_def pm_snd (Iter.clone_def d)))
  | GramD (id1, id2, ps, t, gram, hints) ->
    let env' = local_env env in
    env'.pm <- false;
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    if env'.pm then error d.at "misplaced +- or -+ operator in grammar";
    let prods' = List.map (fun pr -> id2, pr) (elab_gram env' gram t) in
    let dims = Dim.check_def d in
    infer_no_binds env' dims d;
    let ps1, t1, gram1_opt, prods1' = find "grammar" env.grams id1 in
    let gram', last =
      match gram1_opt, gram.it with
      | None, (Dots, _, _) ->
        error_id id1 "extension of not yet defined grammar"
      | None, (_, _, dots2) ->
        gram, dots2 = NoDots
      | Some {it = (dots1, prods1, Dots); at; _}, (Dots, prods2, dots2) ->
        if List.exists (fun (id, _) -> id.it = id2.it) prods1' then
          error d.at ("duplicate grammar fragment name `" ^ id1.it ^
            (if id2.it = "" then "" else "/" ^ id2.it) ^ "`");
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "grammar parameters differ from previous fragment";
        if not (equiv_typ env' t t1) then
          error_typ2 env d.at "grammar" t1 t " of previous fragment";
        (dots1, prods1 @ prods2, dots2) $ over_region [at; t.at], dots2 = NoDots
      | Some _, (Dots, _, _) ->
        error_id id1 "extension of non-extensible grammar"
      | Some _, _ ->
        error_id id1 "duplicate declaration for grammar";
    in
    env.grams <- rebind "grammar" env.grams id1 (ps, t, Some gram', prods1' @ prods');
    (* Only add last fragment to IL defs, so that populate finds it only once *)
    (if last then [Il.GramD (id1, ps', t', []) $ d.at] else [])
      @ elab_hintdef env (GramH (id1, id2, hints) $ d.at)
  | RelD (id, t, hints) ->
    env.pm <- false;
    let mixop, ts', _ts = elab_typ_notation env id t in
    if env.pm then error d.at "misplaced +- or -+ operator in relation";
    let dims = Dim.check_def d in
    infer_no_binds env dims d;
    env.rels <- bind "relation" env.rels id (t, []);
    [Il.RelD (id, mixop, tup_typ' ts' t.at, []) $ d.at]
      @ elab_hintdef env (RelH (id, hints) $ d.at)
  | RuleD (id1, id2, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let t, rules' = find "relation" env.rels id1 in
    if List.exists (fun (id, _) -> id.it = id2.it) rules' then
      error d.at ("duplicate rule name `" ^ id1.it ^
        (if id2.it = "" then "" else "/" ^ id2.it) ^ "`");
    let mixop, _, _ = elab_typ_notation env id1 t in
    let es', _ = checkpoint (elab_exp_notation' env' id1 e t) in
    let es' = List.map (Dim.annot_exp dims') es' in
    let prems' = List.map (Dim.annot_prem dims')
      (concat_map_filter_nl_list (elab_prem env') prems) in
    let bs' = infer_binds env env' dims d in
    let rule' = Il.RuleD (id2, bs', mixop, tup_exp' es' e.at, prems') $ d.at in
    env.rels <- rebind "relation" env.rels id1 (t, rules' @ [id2, rule']);
    if not env'.pm then [] else elab_def env Subst.(subst_def pm_snd (Iter.clone_def d))
  | VarD (id, t, _hints) ->
    env.pm <- false;
    let _t' = elab_typ env t in
    if env.pm then error d.at "misplaced +- or -+ operator in variable declaration";
    let dims = Dim.check_def d in
    infer_no_binds env dims d;
    env.gvars <- rebind "variable" env.gvars id t;
    []
  | DecD (id, ps, t, hints) ->
    let env' = local_env env in
    env'.pm <- false;
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    if env'.pm then error d.at "misplaced +- or -+ operator in declaration";
    let dims = Dim.check_def d in
    infer_no_binds env dims d;
    env.defs <- bind "definition" env.defs id (ps, t, []);
    [Il.DecD (id, ps', t', []) $ d.at]
      @ elab_hintdef env (DecH (id, hints) $ d.at)
  | DefD (id, as_, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_iter env')) dims in
    let ps, t, clauses' = find "definition" env.defs id in
    let as', s = elab_args `Lhs env' as_ ps d.at in
    let as' = List.map (Dim.annot_arg dims') as' in
    let prems' = concat_map_filter_nl_list (elab_prem env') prems in
    let e' = checkpoint (elab_exp env' e (Subst.subst_typ s t)) in
    let e' = Dim.annot_exp dims' e' in
    let prems' = List.map (Dim.annot_prem dims') prems' in
    let bs' = infer_binds env env' dims d in
    let clause' = Il.DefD (bs', as', e', prems') $ d.at in
    env.defs <- rebind "definition" env.defs id (ps, t, clauses' @ [(d, clause')]);
    if not env'.pm then [] else elab_def env Subst.(subst_def pm_snd (Iter.clone_def d))
  | SepD ->
    []
  | HintD hd ->
    elab_hintdef env hd


let check_dots env =
  Map.iter (fun id (at, (_ps, k)) ->
    match k with
    | Transp | Opaque -> assert false
    | Defined ({it = CaseT (_, _, _, Dots); _}, _, _) ->
      error_id (id $ at) "missing final extension to syntax type"
    | Family [] ->
      error_id (id $ at) "no defined cases for syntax type family"
    | Defined _ | Family _ -> ()
  ) env.typs;
  Map.iter (fun id (at, (_ps, _t, gram_opt, _prods')) ->
    match gram_opt with
    | None -> assert false
    | Some {it = (_, _, Dots); _} ->
      error_id (id $ at) "missing final extension to grammar"
    | _ -> ()
  ) env.grams


let populate_hint env hd' =
  match hd'.it with
  | Il.TypH (id, _) -> ignore (find "syntax type" env.typs id)
  | Il.RelH (id, _) -> ignore (find "relation" env.rels id)
  | Il.DecH (id, _) -> ignore (find "definition" env.defs id)
  | Il.GramH (id, _) -> ignore (find "grammar" env.grams id)

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
    Il.RelD (id, mixop, t', List.map snd rules') $ d'.at
  | Il.DecD (id, ps', t', []) ->
    let _, _, clauses' = find "definition" env.defs id in
    Il.DecD (id, ps', t', List.map snd clauses') $ d'.at
  | Il.GramD (id, ps', t', []) ->
    let _, _, _, prods' = find "grammar" env.grams id in
    Il.GramD (id, ps', t', List.map snd prods') $ d'.at
  | Il.HintD hd' -> populate_hint env hd'; d'
  | _ -> assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id ->
    try Map.find id map with Not_found -> failwith ("recursify dep " ^ id)
  ) (Array.of_seq (Il.Free.Set.to_seq set))


let check_recursion ds' =
  List.iter (fun d' ->
    match d'.it, (List.hd ds').it with
    | Il.HintD _, _ | _, Il.HintD _
    | Il.TypD _, Il.TypD _
    | Il.RelD _, Il.RelD _
    | Il.DecD _, Il.DecD _
    | Il.GramD _, Il.GramD _ -> ()
    | _, _ ->
      error (List.hd ds').at (" " ^ string_of_region d'.at ^
        ": invalid recursion between definitions of different sort")
  ) ds'
  (* TODO(4, rossberg): check that notations are non-recursive and defs are inductive? *)

let recursify_defs ds' : Il.def list =
  let open Il.Free in
  let da = Array.of_list ds' in
  let map_typid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let map_gramid = ref Map.empty in
  let frees = Array.map Il.Free.free_def da in
  let bounds = Array.map Il.Free.bound_def da in
  Array.iteri (fun i bound ->
    origins i map_typid bound.typid;
    origins i map_relid bound.relid;
    origins i map_defid bound.defid;
    origins i map_gramid bound.gramid;
  ) bounds;
  let graph =
    Array.map (fun free ->
      Array.concat
        [ deps !map_typid free.typid;
          deps !map_relid free.relid;
          deps !map_defid free.defid;
          deps !map_gramid free.gramid;
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


let implicit_typdef id (at, atom) ds =
  let hint = {hintid = "show" $ at; hintexp = AtomE atom $ at} in
  let t = ConT ((AtomT (El.Iter.clone_atom atom) $ at, []), []) $ at in
  let d = TypD (id $ at, "" $ at, [], t, [hint]) $ at in
  d :: ds

let elab ds : Il.script * env =
  let env = new_env () in
  let ds = List.map (infer_typdef env) ds in
  let ds = Map.fold implicit_typdef env.atoms ds in
  List.iter (infer_gramdef env) ds;
  let ds' = List.concat_map (elab_def env) ds in
  check_dots env;
  let ds' = List.map (populate_def env) ds' in
  recursify_defs ds', env

let elab_exp env e t : Il.exp =
  let env' = local_env env in
  let _ = elab_typ env' t in
  checkpoint (elab_exp env' e t)

let elab_rel env e id : Il.exp =
  let env' = local_env env in
  match elab_prem env' (RulePr (id, e) $ e.at) with
  | [{it = Il.RulePr (_, _, e'); _}] -> e'
  | _ -> assert false
