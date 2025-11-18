open Util
open Source
open El
open Xl
open Ast
open Convert
open Print

module Il = struct include Il include Ast include Print end

module Set = Free.Set
module Map = Map.Make (String)

module Debug = struct include El.Debug include Il.Debug end


(* Errors *)

let lax_num = true

exception Error = Error.Error

let error at msg = Error.error at "type" msg

let error_atom at atom t msg =
  error at (msg ^ " `" ^ string_of_atom atom ^
    "` in type `" ^ Il.string_of_typ t ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")


(* Helpers *)

let unparen_exp e =
  match e.it with
  | ParenE e1 -> e1
  | _ -> e

let unseq_exp e =
  match e.it with
  | EpsE -> []
  | SeqE es -> es
  | _ -> [e]

let untup_typ' t' =
  match t'.it with
  | Il.TupT xts' -> List.map snd xts'
  | _ -> [t']

let tup_typ' ts' at =
  match ts' with
  | [t'] -> t'
  | _ -> Il.TupT (List.map (fun t' -> "_" $ t'.at, t') ts') $ at

let tup_typ_bind' es' ts' at =
  (* Translate a pattern into suitable path expressions on a variable *)
  let rec decompose e' p' s =
    match e'.it with
    | Il.VarE x -> Il.Subst.add_varid s x p'
    | Il.TupE es' ->
      List.fold_left (fun (s', i) eI' ->
        decompose eI' (Il.ProjE (p', i) $$ eI'.at % eI'.note) s', i + 1
      ) (s, 0) es' |> fst
    | Il.IterE _ -> s  (* TODO *)
    | _ -> assert false
  and combine es' ts' s =
    match es', ts' with
    | [], [] -> []
    | e'::es', t'::ts' ->
      let x', s' =
        match e'.it with
        | Il.VarE x -> x, s
        | _ ->
          let x' = Il.Fresh.fresh_varid "pat" $ e'.at in
          x', decompose e' (Il.VarE x' $$ e'.at % e'.note) s
      in
      let xts'' = combine es' ts' s' in
      (x', Il.Subst.subst_typ s t')::xts''
    | _, _ -> assert false
  in Il.TupT (combine es' ts' Il.Subst.empty) $ at

let tup_exp_bind' es' at =
  Il.TupE es' $$ (at, tup_typ' (List.map note es') at)

let tup_exp' es' at =
  match es' with
  | [e'] -> e'
  | _ -> tup_exp_bind' es' at

let lift_exp' e' iter' =
  if iter' = Il.Opt then
    Il.OptE (Some e')
  else
    Il.ListE [e']

let cat_exp' e1' e2' =
  match e1'.it, e2'.it with
  | _, Il.ListE [] -> e1'.it
  | Il.ListE [], _ -> e2'.it
  | Il.ListE es1, Il.ListE es2 -> Il.ListE (es1 @ es2)
  | _ -> Il.CatE (e1', e2')


(* Notation *)

type notation = Il.typ Mixop.mixop


let rec subst_notation s not =
  let open Mixop in
  match not with
  | Arg t -> Arg (Il.Subst.subst_typ s t)
  | Seq nots -> Seq (List.map (subst_notation s) nots)
  | Atom at -> Atom at
  | Brack (at1, not, at2) -> Brack (at1, subst_notation s not, at2)
  | Infix (not1, at, not2) ->
    Infix (subst_notation s not1, at, subst_notation s not2)

let rec apply_notation' ts not =
  let open Mixop in
  match not with
  | Arg () -> List.tl ts, Arg (List.hd ts)
  | Seq nots ->
    let ts', nots' = List.fold_left_map apply_notation' ts nots in
    ts', Seq nots'
  | Atom at -> ts, Atom at
  | Brack (at1, not, at2) ->
    let ts', not' = apply_notation' ts not in
    ts', Brack (at1, not', at2)
  | Infix (not1, at, not2) ->
    let ts', not1' = apply_notation' ts not1 in
    let ts'', not2' = apply_notation' ts' not2 in
    ts'', Infix (not1', at, not2')

let apply_notation not ts =
  let ts', not' = apply_notation' ts not in
  assert (ts' = []);
  not'

let rec string_of_notation = function
  | Mixop.Arg t -> Il.string_of_typ t
  | Mixop.Seq nots ->
    "{" ^ String.concat " " (List.map string_of_notation nots) ^ "}"
  | Mixop.Atom atom -> string_of_atom atom
  | Mixop.Brack (l, not, r) ->
    "`" ^ string_of_atom l ^ string_of_notation not ^ string_of_atom r
  | Mixop.Infix (not1, atom, not2) ->
    string_of_notation not1 ^ " " ^ string_of_atom atom ^ " " ^
    string_of_notation not2


(* Environment *)

type kind =
  | Transp  (* forward alias types or notation types *)
  | Opaque  (* forward structures or variants, type parameter *)
  | Defined of Il.deftyp * id list * dots
  | Family of Il.inst list (* family of types *)

type var_typ = Il.typ
type typ_typ = Il.param list * kind
type gram_typ = Il.param list * Il.typ * gram option * (id * Il.prod) list
type rel_typ = Il.typ * (id * Il.rule) list
type def_typ = Il.param list * Il.typ * (def * Il.clause) list

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
      |> Map.add "bool" (no_region, Il.BoolT $ no_region)
      |> Map.add "nat" (no_region, Il.NumT `NatT $ no_region)
      |> Map.add "int" (no_region, Il.NumT `IntT $ no_region)
      |> Map.add "rat" (no_region, Il.NumT `RatT $ no_region)
      |> Map.add "real" (no_region, Il.NumT `RealT $ no_region)
      |> Map.add "text" (no_region, Il.TextT $ no_region);
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

let find_case cs atom at t =
  match List.find_opt
    (function ((atom'::_)::_, _, _) -> Atom.eq atom' atom | _ -> false) cs
  with
  | Some (_, x, _) -> x
  | None -> error_atom at atom t "unknown case"

let find_case_sub cases atom at t =
  match List.find_opt
    (function ((atom'::_)::_, _, _) -> Atom.(eq atom' atom || sub atom' atom)
    | _ -> false
    ) cases
  with
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

let bind_quant env q =
  match q.it with
  | Il.ExpP (x, t) -> env.vars <- bind "variable" env.vars x t
  | Il.TypP x -> env.typs <- bind "syntax type" env.typs x ([], Opaque)
  | Il.DefP (x, ps, t) -> env.defs <- bind "definition" env.defs x (ps, t, [])
  | Il.GramP (x, ps, t) -> env.grams <- bind "grammar" env.grams x (ps, t, None, [])


let vars env = Map.fold (fun id (at, _) ids -> (id $ at)::ids) env.vars []

let il_arg_of_param p =
  (match p.it with
  | Il.ExpP (id, t) -> Il.ExpA (Il.VarE id $$ id.at % t)
  | Il.TypP id -> Il.TypA (Il.VarT (id, []) $ id.at)
  | Il.DefP (id, _, _) -> Il.DefA id
  | Il.GramP (id, _, _) -> Il.GramA (Il.VarG (id, []) $ id.at)
  ) $ p.at

let il_args_of_params = List.map il_arg_of_param

let to_il_var (_at, t) = t
let to_il_def (_at, (ps, t, clauses)) = (ps, t, List.map snd clauses)
let to_il_gram (_at, (ps, t, _, prods)) = (ps, t, List.map snd prods)

let to_il_typ id (at, (ps, k)) =
  match k with
  | Opaque | Transp -> ps, []
  | Family insts -> ps, insts
  | Defined (dt, _, _) ->
    ps, [Il.InstD ([], List.map il_arg_of_param ps, dt) $ dt.at]

let to_il_env env =
  (* Need to include gvars, since matching can encounter implicit vars *)
  let gvars = Map.map to_il_var env.gvars in
  let vars = Map.map to_il_var env.vars in
  let typs = Map.mapi to_il_typ env.typs in
  let defs = Map.map to_il_def env.defs in
  let grams = Map.map to_il_gram env.grams in
  Il.Env.{
    vars = Map.union (fun _ _ t -> Some t) gvars vars;
    typs;
    defs;
    rels = Map.empty;
    grams;
  }


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
    Fail [Trace (at, "cannot parse expression as `" ^ Il.string_of_typ t ^ "`", traces)]

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
  fail at (msg ^ " `" ^ string_of_atom atom ^ "` in type `" ^ Il.string_of_typ t ^ "`")

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
  let t' = Il.Eval.reduce_typ (to_il_env env) t in
  let s = Il.string_of_typ t in
  let s' = Il.string_of_typ t' in
  if s = s' then
    "`" ^ s ^ "`"
  else
    "`" ^ s ^ " = " ^ s' ^ "`"

let msg_typ env phrase t =
  phrase ^ " does not match type " ^ typ_string env t

let msg_typ2 env phrase t1 t2 reason =
  phrase ^ "'s type " ^ typ_string env t1 ^
    " does not match type " ^ typ_string env t2 ^ reason

let msg_not _env phrase not =
  phrase ^ " does not match notation " ^ string_of_notation not

let error_typ env at phrase t =
  error at (msg_typ env phrase t)

let error_typ2 env at phrase t1 t2 reason =
  error at (msg_typ2 env phrase t1 t2 reason)

let fail_typ env at phrase t =
  fail at (msg_typ env phrase t)

let fail_typ2 env at phrase t1 t2 reason =
  fail at (msg_typ2 env phrase t1 t2 reason)

let fail_not env at phrase not =
  fail at (msg_not env phrase not)


type direction = Infer | Check

let fail_dir_typ env at phrase dir t expected =
  match dir with
  | Check -> fail_typ env at phrase t
  | Infer ->
    fail at (phrase ^ "'s type " ^ typ_string env t ^
      " does not match type " ^ expected)


(* Type Accessors *)

(*
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
let as_defined_typid' env x as' at : Il.deftyp' =
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
*)


(* TODO(2, rossberg): avoid repeated env conversion *)
let expand env t : Il.typ' = (Il.Eval.reduce_typ (to_il_env env) t).it

let expand_def env t : Il.deftyp' * dots =
  match expand env t with
  | Il.VarT (x, as') ->
    let x' = strip_var_suffix x in
    let _ps, k = find "syntax type" env.typs x' in
    (Il.Eval.reduce_typdef (to_il_env env) (Il.VarT (x', as') $ x.at)).it,
    (match k with Defined (_, _, dots) -> dots | _ -> NoDots)
  | t' -> Il.AliasT (t' $ t.at), NoDots

let expand_notation env t =
  match expand env t with
  | Il.VarT (x, as') as t' ->
    let x' = strip_var_suffix x in
    (match find "syntax type" env.typs x' with
    | ps, Defined ({it = Il.VariantT [tc]; _}, _, _) ->
      let as_ = List.map il_arg_of_param ps in
      Il.Eval.(match_list match_arg (to_il_env env) Il.Subst.empty as' as_) |>
        Option.map (fun s ->
          let mixop, (qs, t, _prems), _ = Il.Subst.subst_typcase s tc in
          qs, t, mixop, apply_notation mixop (untup_typ' t)
        )
    | _, _ -> None
    )
  | _ -> None

let expand_id env t =
  match expand env t with
  | Il.VarT (id, _) -> id
  | _ -> "" $ no_region


(*
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
  match (Il.reduce_typ (to_il_env env) t).it with
  | Il.VarT (x, as_) as t' ->
    (match as_defined_typid' env id args id.at with
    | t1', _ -> t1'
    | exception Error _ -> t'
    )
  | t' -> t'

let rec expand_notation env t =
  match expand env t with
  | Il.VarT (x, as') as t' ->
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
*)


let as_nat_typ_opt env t : unit option =
  match expand env t with
  | Il.NumT `NatT -> Some ()
  | _ -> None

let as_num_typ_opt env t : numtyp option =
  match expand env t with
  | Il.NumT nt -> Some nt
  | _ -> None

let as_iter_typ_opt env t : (Il.typ * Il.iter) option =
  match expand env t with
  | Il.IterT (t1, iter) -> Some (t1, iter)
  | _ -> None

let as_list_typ_opt env t : Il.typ option =
  match expand env t with
  | Il.IterT (t1, Il.List) -> Some t1
  | _ -> None

let as_tup_typ_opt env t : (Il.id * Il.typ) list option =
  match expand env t with
  | Il.TupT xts -> Some xts
  | _ -> None

(*
let as_iter_notation_typ_opt env t : (typ * iter) option =
  match expand_iter_notation env t with
  | Il.IterT (t1, iter) -> Some (t1, iter) | _ -> None
*)

let as_empty_notation_typ_opt env t : unit option =
  match expand_notation env t with
  | Some (_, _, _, Seq []) -> Some ()
  | _ -> None


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
  as_x_typ as_tup_typ_opt phrase env dir t at "(_,...,_)"
(*
let as_iter_notation_typ phrase env dir t at =
  as_x_typ as_iter_notation_typ_opt phrase env dir t at "(_)*"
*)
let as_empty_notation_typ phrase env dir t at =
  as_x_typ as_empty_notation_typ_opt phrase env dir t at "()"


let as_struct_typ phrase env dir t at : (Il.typfield list * dots) attempt =
  match expand_def env t with
  | Il.StructT tfs, dots -> Ok (tfs, dots)
  | _ -> fail_dir_typ env at phrase dir t "{...}"

let as_variant_typ phrase env dir t at : (Il.typcase list * dots) attempt =
  match expand_def env t with
  | Il.VariantT tcs, dots -> Ok (tcs, dots)
  | _ -> fail_dir_typ env at phrase dir t "| ..."

let rec as_cat_typ phrase env dir t at : unit attempt =
  match expand_def env t with
  | Il.AliasT {it = Il.IterT _; _}, _ -> Ok ()
  | Il.StructT tfs, dots ->
    if dots = Dots then
      error at "used record type is only partially defined at this point";
    iter_attempt (fun (_, (qs, t, _), _) ->
      let env' = if qs = [] then env else local_env env in
      List.iter (bind_quant env') qs;
      as_cat_typ phrase env' dir t at
    ) tfs
  | _ ->
    fail at (phrase ^ "'s type " ^ typ_string env t ^ " is not concatenable")

let as_notation_typ phrase env dir t at : (Il.quant list * Il.typ * _ Mixop.mixop * notation) attempt =
  match expand_notation env t with
  | Some x -> Ok x
  | _ -> fail_dir_typ env at phrase dir t "_ ... _"

let is_x_typ as_x_typ env t =
  match as_x_typ "" env Check t no_region with
  | Ok _ -> true
  | Fail _ -> false

let is_nat_typ = is_x_typ as_nat_typ
let is_iter_typ = is_x_typ as_iter_typ
(*
let is_iter_notation_typ = is_x_typ as_iter_notation_typ
*)
let is_variant_typ = is_x_typ as_variant_typ
let is_notation_typ = is_x_typ as_notation_typ
let is_empty_notation_typ = is_x_typ as_empty_notation_typ


(* Type Equivalence and Shallow Numeric Subtyping *)

let equiv_typ env t1 t2 =
  Il.Eval.equiv_typ (to_il_env env) t1 t2

let sub_typ env t1 t2 =
  Il.Eval.sub_typ (to_il_env env) t1 t2

let narrow_typ env t1 t2 =
  Debug.(log "el.narrow_typ"
    (fun _ -> fmt "%s <: %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match expand env t1, expand env t2 with
  | Il.NumT nt1, Il.NumT nt2 -> Num.sub nt1 nt2
  | _, _ -> equiv_typ env t1 t2


(* Hints *)

let elab_hint tid case {hintid; hintexp} : Il.hint =
  let module IterAtoms =
    Iter.Make(
      struct
        include Iter.Skip
        let visit_atom atom =
          assert (valid_tid tid);
          assert (atom.note.Atom.def = "");
          atom.note.Atom.def <- tid.it;
          atom.note.Atom.case <- case
      end
    )
  in
  IterAtoms.exp hintexp;
  {Il.hintid; Il.hintexp}

let elab_hints tid case = List.map (elab_hint tid case)


(* Atoms and Operators *)

let fresh_note note = Atom.{note with def = ""}
let fresh_atom atom = {atom with note = fresh_note atom.note}
let fresh_mixop mixop = Mixop.map_atoms fresh_atom mixop
let fresh_typfield (atom, t_prs, hints) = (fresh_atom atom, t_prs, hints)
let fresh_typcase (mixop, t_prs, hints) = (fresh_mixop mixop, t_prs, hints)

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
  List.map (fun t -> op, (t :> Il.optyp), Il.NumT t, Il.NumT t) ts

let infer_binop'' op ts =
  List.map (fun t -> op, (t :> Il.optyp), Il.NumT t, Il.NumT t, Il.NumT t) ts

let infer_cmpop'' op ts =
  List.map (fun t -> op, (t :> Il.optyp), Il.NumT t) ts

let infer_unop' = function
  | #Bool.unop as op -> [op, `BoolT, Il.BoolT, Il.BoolT]
  | #Num.unop as op -> infer_unop'' op [`IntT; `RatT; `RealT]
  | `PlusMinusOp -> infer_unop'' `PlusOp [`IntT; `RatT; `RealT]
  | `MinusPlusOp -> infer_unop'' `MinusOp [`IntT; `RatT; `RealT]

let infer_binop' = function
  | #Bool.binop as op -> [op, `BoolT, Il.BoolT, Il.BoolT, Il.BoolT]
  | `AddOp as op -> infer_binop'' op [`NatT; `IntT; `RatT; `RealT]
  | `SubOp as op -> infer_binop'' op [`IntT; `RatT; `RealT]
  | `MulOp as op -> infer_binop'' op [`NatT; `IntT; `RatT; `RealT]
  | `DivOp as op -> infer_binop'' op [`RatT; `RealT]
  | `ModOp as op -> infer_binop'' op [`NatT; `IntT]
  | `PowOp as op ->
    infer_binop'' op [`NatT; `RatT; `RealT] |>
      List.map (fun (op, nt, t1, t2, t3) ->
        (op, nt, t1, (if t2 = Il.NumT `NatT then t2 else Il.NumT `IntT), t3))

let infer_cmpop' = function
  | #Bool.cmpop as op -> `Poly op
  | #Num.cmpop as op -> `Over (infer_cmpop'' op [`NatT; `IntT; `RatT; `RealT])

let infer_unop env op t1 at : (Il.unop * Il.optyp * Il.typ * Il.typ) attempt =
  let ops = infer_unop' op in
  match List.find_opt (fun (_, _, t1', _) -> narrow_typ env t1 (t1' $ at)) ops with
  | Some (op', nt, t1', t2') -> Ok (op', nt, t1' $ at, t2' $ at)
  | None ->
    fail at ("unary operator `" ^ string_of_unop op ^
      "` is not defined for operand type " ^ typ_string env t1
    )

let infer_binop env op t1 t2 at : (Il.binop * Il.optyp * Il.typ * Il.typ * Il.typ) attempt =
  let ops = infer_binop' op in
  match
    List.find_opt (fun (_, _, t1', t2', _) ->
      narrow_typ env t1 (t1' $ at) && (lax_num || narrow_typ env t2 (t2' $ at))) ops
  with
  | Some (op', nt, t1', t2', t3') -> Ok (op', nt, t1' $ at, t2' $ at, t3' $ at)
  | None ->
    fail at ("binary operator `" ^ string_of_binop op ^
      "` is not defined for operand types `" ^ typ_string env t1 ^
      " and " ^ typ_string env t2
    )

let infer_cmpop env op
  : [`Poly of Il.cmpop | `Over of (Il.typ -> Il.typ -> region -> (Il.cmpop * Il.optyp * Il.typ) attempt)] =
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
        "` is not defined for operand types " ^ typ_string env t1 ^
        " and " ^ typ_string env t2
      )
    )

let merge_mixop mixop1 mixop2 =
  match mixop1, mixop2 with
  | _, [] -> mixop1
  | [], _ -> mixop2
  | mixop1, atoms2::mixop2' ->
    let mixop1', atoms1 = Lib.List.split_last mixop1 in
    mixop1' @ [atoms1 @ atoms2] @ mixop2'


let check_atoms phrase item to_atom list at =
  let _, dups =
    List.fold_right (fun (op, _, _) (set, dups) ->
      let s = Print.string_of_atom (to_atom op) in
      if Set.mem s set then (set, s::dups) else (Set.add s set, dups)
    ) list (Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let rec elab_iter env iter : Il.quant list * Il.iter =
  match iter with
  | Opt -> [], Il.Opt
  | List -> [], Il.List
  | List1 -> [], Il.List1
  | ListN (e, xo) ->
    Option.iter (fun x ->
      let t = Il.NumT `NatT $ x.at in
      let qs, e' = checkpoint (elab_exp env (VarE (x, []) $ x.at) t) in
      match e'.it with
      | Il.VarE _ -> assert (qs = [])
      | _ -> error_typ env x.at "iteration variable" t
    ) xo;
    let qs, e' = checkpoint (elab_exp env e (Il.NumT `NatT $ e.at)) in
    qs, Il.ListN (e', xo)

and elab_typiter env iter : Il.iter =
  let iter =
    match iter with
    | List1 | ListN _ -> List
    | _ -> iter
  in
  let qs, iter' = elab_iter env iter in
  assert (qs = []);
  iter'


(* Types *)

and elab_typ env t : Il.typ =
  match t.it with
  | VarT (x, as_) ->
    let x' = strip_var_suffix x in
    if x'.it <> x.it && as_ = [] then
      elab_typ env (Convert.typ_of_varid x')
    else
      let ps, _ = find "syntax type" env.typs x' in
      let qs, as', _s = elab_args `Rhs env as_ ps t.at in
      if qs <> [] then
        error t.at "illegal expression form in type instantiation";
      Il.VarT (x', as') $ t.at
  | BoolT -> Il.BoolT $ t.at
  | NumT t' -> Il.NumT t' $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT {it = SeqT []; _} -> Il.TupT [] $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> tup_typ' (List.map (elab_typ env) ts) t.at
  | IterT (t1, iter) ->
    let iter' = elab_typiter env iter in
    let t1' = elab_typ env t1 in
    Il.IterT (t1', iter') $ t.at
  | StrT _ | CaseT _ | ConT _ | RangeT _
  | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    error t.at "this type is only allowed in type definitions"

and elab_typ_definition env tid t : Il.deftyp * dots =
  Debug.(log_at "el.elab_typ_definition" t.at
    (fun _ -> fmt "%s = %s" tid.it (el_typ t))
    (fun (dt, _) -> il_deftyp dt)
  ) @@ fun _ ->
  assert (valid_tid tid);
  match t.it with
  | StrT (dots1, ts, tfs, dots2) ->
    let tfs1 =
      if dots1 = NoDots then [] else
      let t1 = Il.VarT (tid, []) $ tid.at in
      if not (bound env.typs tid) then
        error t.at "extension of previously undefined syntax type";
      let tfs1, dots = checkpoint (as_struct_typ "own type" env Check t1 t1.at) in
      if dots = NoDots then
        error t.at "extension of non-extensible syntax type";
      List.map fresh_typfield tfs1  (* ensure atom annotations are fresh *)
    in
    let tfs2 =
      concat_map_filter_nl_list (fun t ->
        let t' = elab_typ env t in
        let tfs, dots = checkpoint (as_struct_typ "parent type" env Infer t' t'.at) in
        if dots = Dots then
          error t.at "inclusion of incomplete syntax type";
        List.map fresh_typfield tfs  (* ensure atom annotations are fresh *)
      ) ts
    in
    let tfs' = tfs1 @ tfs2 @ map_filter_nl_list (elab_typfield env tid t.at) tfs in
    check_atoms "record" "field" Fun.id tfs' t.at;
    Il.StructT tfs' $ t.at, dots2
  | CaseT (dots1, ts, tcs, dots2) ->
    let tcs1 =
      if dots1 = NoDots then [] else
      let t1 = Il.VarT (tid, []) $ tid.at in
      if not (bound env.typs tid) then
        error t.at "extension of previously undefined syntax type";
      let tcs1, dots = checkpoint (as_variant_typ "own type" env Check t1 t1.at) in
      if dots = NoDots then
        error t.at "extension of non-extensible syntax type";
      List.map fresh_typcase tcs1  (* ensure atom annotations are fresh *)
    in
    let tcs2 =
      concat_map_filter_nl_list (fun t ->
        let t' = elab_typ env t in
        let tcs, dots = checkpoint (as_variant_typ "parent type" env Infer t' t'.at) in
        if dots = Dots then
          error t.at "inclusion of incomplete syntax type";
        List.map fresh_typcase tcs  (* ensure atom annotations are fresh *)
      ) ts
    in
    let tcs' = tcs1 @ tcs2 @ map_filter_nl_list (elab_typcase env tid t.at) tcs in
    check_atoms "variant" "case" (fun op -> Option.get (Mixop.head op)) tcs' t.at;
    Il.VariantT tcs' $ t.at, dots2
  | ConT tc ->
    let tc' = elab_typcon env tid t.at tc in
    Il.VariantT [tc'] $ t.at, NoDots
  | RangeT tes ->
    let ts_fes' = map_filter_nl_list (elab_typenum env tid) tes in
    let t', fe' =
      List.fold_left (fun (t, fe') (tI, feI') ->
        (if narrow_typ env tI t then t else tI),
        fun eid' nt ->
        let e' = fe' eid' nt and eI' = feI' eid' nt in
        let at = Source.over_region [e'.at; eI'.at] in
        Il.(BinE (`OrOp, `BoolT, e', eI') $$ at % (Il.BoolT $ at))
      ) (List.hd ts_fes') (List.tl ts_fes')
    in
    let nt = match t'.it with Il.NumT nt -> nt | _ -> assert false in
    let x = "i" $ t.at in
    let eid' = Il.VarE x $$ t.at % t' in
    let qs = [Il.ExpP (x, t') $ t.at] in
    let prems' = [Il.IfPr (fe' eid' nt) $ t.at] in
    let tc' = (Mixop.Arg (), (qs, Il.TupT [(x, t')] $ t.at, prems'), []) in
    Il.VariantT [tc'] $ t.at, NoDots
  | _ ->
    let t' = elab_typ env t in
    Il.AliasT t' $ t.at, NoDots

and typ_rep env t : Il.typ =
  Debug.(log_at "el.typ_rep" t.at
    (fun _ -> fmt "%s" (il_typ t))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match expand env t with
  | Il.VarT _ as t' ->
    (match expand_def env (t' $ t.at) with
    | Il.VariantT [_, (_, t1, _), _], NoDots -> t1
    | _ -> t' $ t.at
  )
  | t' -> t' $ t.at

and elab_typfield env tid at (atom, (t, prems), hints) : Il.typfield =
  let _mixop, qs, t', prems' = elab_typ_notation' env tid at t prems in
  let hints' = elab_hints tid "" hints in
  let t'' =  (* TODO(4, rossberg): remove this hack *)
    match t'.it with
    | Il.TupT [(_, t1')] when prems' = [] -> t1'
    | _ -> t'
  in
  (elab_atom atom tid, (qs, t'', prems'), hints')

and elab_typcase env tid at (_atom, (t, prems), hints) : Il.typcase =
  let mixop, qs, t', prems' = elab_typ_notation' env tid at t prems in
  let hints' = elab_hints tid "" hints in
  (mixop, (qs, t', prems'), hints')

and elab_typcon env tid at ((t, prems), hints) : Il.typcase =
  let mixop, qs, t', prems' = elab_typ_notation' env tid at t prems in
  let hints' = elab_hints tid tid.it hints in
  (mixop, (qs, t', prems'), hints')

and elab_typenum env tid (e1, e2o) : Il.typ * (Il.exp -> numtyp -> Il.exp) =
  assert (valid_tid tid);
  let _e1' = elab_exp env e1 (Il.NumT `IntT $ e1.at) in (* ensure it's <= int *)
  let _qs1, _, t1 = checkpoint (infer_exp env e1) in (* get precise type *)
  match e2o with
  | None ->
    t1,
    fun eid' nt ->
    let qs1, e1' = checkpoint (elab_exp env e1 (Il.NumT nt $ e1.at)) in  (* redo with overall type *)
    if qs1 <> [] then
      error e1.at "illegal expression form in range type";
    Il.(CmpE (`EqOp, `BoolT, eid', e1') $$ e1'.at % (Il.BoolT $ e1.at))
  | Some e2 ->
    let at = Source.over_region [e1.at; e2.at] in
    let _qs21', _e2' = checkpoint (elab_exp env e2 (Il.NumT `IntT $ e2.at)) in
    let _qs22, _, t2 = checkpoint (infer_exp env e2) in
    (if narrow_typ env t2 t1 then t1 else t2).it $ at,
    fun eid' nt ->
    let qs1, e1' = checkpoint (elab_exp env e1 (Il.NumT nt $ e1.at)) in
    let qs2, e2' = checkpoint (elab_exp env e2 (Il.NumT nt $ e2.at)) in
    if qs1 <> [] then
      error e1.at "illegal expression form in range type";
    if qs2 <> [] then
      error e2.at "illegal expression form in range type";
    Il.(BinE (`AndOp, `BoolT,
      CmpE (`GeOp, (nt :> Il.optyp), eid', e1') $$ e1'.at % (Il.BoolT $ e1.at),
      CmpE (`LeOp, (nt :> Il.optyp), eid', e2') $$ e2'.at % (Il.BoolT $ e2.at)
    ) $$ at % (Il.BoolT $ at))



(* Like Convert.* but for IL *)
and varid_of_typ' t =
  (match t.it with
  | Il.VarT (id, _) -> id.it
  | Il.BoolT -> "bool"
  | Il.NumT `NatT -> "nat"
  | Il.NumT `IntT -> "int"
  | Il.NumT `RatT -> "rat"
  | Il.NumT `RealT -> "real"
  | Il.TextT -> "text"
  | _ -> "_"
  ) $ t.at

and expify' t = function
  | Some e -> e
  | None -> Il.VarE ("_" $ t.at) $$ t.at % t

and pat'_of_typ' s t : Il.exp option =
  let (let*) = Option.bind in
  let module Il = Il.Ast in
  match t.it with
  | Il.VarT (id, _args) ->
    if Set.mem id.it !s then None else
    (
      (* Suppress duplicates. *)
      s := Set.add id.it !s;
      Some (Il.VarE id $$ t.at % t)
    )
  | Il.BoolT | Il.NumT _ | Il.TextT ->
    let id = varid_of_typ' t in
    if Set.mem id.it !s then None else
    (
      (* Suppress duplicates. *)
      s := Set.add id.it !s;
      Some (Il.VarE id $$ t.at % t)
    )
  | Il.TupT xts ->
    let* es = pats'_of_typs' s (List.map snd xts) in
    Some (Il.TupE es $$ t.at % t)
  | Il.IterT (t1, iter) ->
    let* e1 = pat'_of_typ' s t1 in
    Some (Il.IterE (e1, (iter, [])) $$ t.at % t)

and pats'_of_typs' s ts : Il.exp list option =
  let eos = List.map (pat'_of_typ' s) ts in
  if List.for_all ((=) None) eos then None else
  Some (List.map2 expify' ts eos)

and pat'_of_typ t = expify' t (pat'_of_typ' (ref Set.empty) t)
and pats'_of_typs ts = List.map2 expify' ts (List.map (pat'_of_typ' (ref Set.empty)) ts)

and elab_typ_notation' env tid at t prems :
    Il.mixop * Il.quant list * Il.typ * Il.prem list =
  assert (valid_tid tid);
  let env' = local_env env in
  let mixop, ts' = elab_typ_notation env' tid t in
  let es' = pats'_of_typs ts' in
  let dims = Dim.check_typdef (vars env) t prems in
  let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
  let es' = List.map (Dim.annot_exp dims') es' in
  let qss, premss' = List.split (map_filter_nl_list (elab_prem env') prems) in
  let prems' = List.map (Dim.annot_prem dims') (List.concat premss') in
  let det = Free.(diff (union (det_typ t) (det_prems prems)) (bound_env env)) in
  let free = Free.(diff (union (free_typ t) (free_prems prems)) (union det (bound_env env))) in
  if free <> Free.empty then
(Printf.printf "[notation] t = %s\n%!" (Debug.el_typ t);
List.iteri (fun i e -> Printf.printf "[notation] t%d' = %s\n%!" i (Il.Print.string_of_typ e)) ts';
List.iteri (fun i e -> Printf.printf "[notation] e%d' = %s\n%!" i (Il.Print.string_of_exp e)) es';
    error at ("premise contains indeterminate variable(s) `" ^
      String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
);
  let acc_qs, (module Arg : Iter.Arg) = make_quants_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  Acc.typ t;
  Acc.prems prems;
  mixop, !acc_qs @ List.concat qss, tup_typ_bind' es' ts' t.at, prems'

and elab_typ_notation env tid t : Il.mixop * Il.typ list =
  Debug.(log_at "el.elab_typ_notation" t.at
    (fun _ -> fmt "(%s) %s" tid.it (el_typ t))
    (fun (mixop, ts') -> fmt "%s(%s)" (il_mixop mixop) (list il_typ ts'))
  ) @@ fun _ ->
  assert (valid_tid tid);
  match t.it with
  | VarT (x, as_) ->
    let x' = strip_var_suffix x in
    (match (Convert.typ_of_varid x').it with
    | VarT _ ->
      (match find "syntax type" env.typs x' with
      | _, Transp -> error_id x "invalid forward reference to syntax type"
      | ps, _ ->
        let qs, as', _s = elab_args `Rhs env as_ ps t.at in
        if qs <> [] then
          error t.at "illegal expression forms in type instantiation";
        let t' = Il.VarT (x', as') $ t.at in
        Arg (), [t']
      )
    | t1 ->
      assert (as_ = []);
      let t' = elab_typ env (t1 $ x.at) in
      Arg (), [t']
    )
  | AtomT atom ->
    let atom' = elab_atom atom tid in
    Atom atom', []
  | SeqT [] ->
    Seq [], []
  | SeqT (t1::ts2) ->
    let mixop1, ts1' = elab_typ_notation env tid t1 in
    let mixop2, ts2' = elab_typ_notation env tid (SeqT ts2 $ t.at) in
    (match mixop2 with Seq mixops2 -> Seq (mixop1::mixops2) | _ -> assert false),
    ts1' @ ts2'
  | InfixT (t1, atom, t2) ->
    let mixop1, ts1' = elab_typ_notation env tid t1 in
    let mixop2, ts2' = elab_typ_notation env tid t2 in
    let atom' = elab_atom atom tid in
    Infix (mixop1, atom', mixop2), ts1' @ ts2'
  | BrackT (l, t1, r) ->
    let mixop1, ts1' = elab_typ_notation env tid t1 in
    let l' = elab_atom l tid in
    let r' = elab_atom r tid in
    Brack (l', mixop1, r'), ts1'
  | _ ->
    let t' = elab_typ env t in
    Arg (), [t']


and (!!!) env tid t =
  let _, ts' = elab_typ_notation env tid t in tup_typ' ts' t.at


(* Expressions *)

(* Returns
 * - Ok (il_exp, typ) if the type can be inferred
 * - Fail (at, s) when it cannot, where s is the name of the failing construct
 * - raises Error.Error on fatal, unrecoverable errors
 *)
and infer_exp env e : (Il.quant list * Il.exp * Il.typ) attempt =
  Debug.(log_at "el.infer_exp" e.at
    (fun _ -> fmt "%s" (el_exp e))
    (function Ok (qs, e', t) -> fmt "%s%s : %s" (il_quants qs) (il_exp e') (il_typ t) | _ -> "fail")
  ) @@ fun _ ->
  let* qs, e', t' = infer_exp' env e in
  let t = t' $ e.at in
  Ok (qs, e' $$ e.at % t, t)

and infer_exp' env e : (Il.quant list * Il.exp' * Il.typ') attempt =
  match e.it with
  | VarE (x, args) ->
    (* Args may only occur due to syntactic overloading with types *)
    if args <> [] then error e.at "malformed expression";
    if x.it = "_" then fail_infer e.at "wildcard" else
    let* t =
      if bound env.vars x then
        Ok (find "variable" env.vars x)
      else if bound env.gvars (strip_var_suffix x) then
        (* If the variable itself is not yet declared, use type hint. *)
        let t = find "variable" env.gvars (strip_var_suffix x) in
        env.vars <- bind "variable" env.vars x t;
        Ok t
      else fail_infer e.at "variable"
    in Ok ([], Il.VarE x, t.it)
  | AtomE _ ->
    fail_infer e.at "atom"
  | BoolE b ->
    Ok ([], Il.BoolE b, Il.BoolT)
  | NumE (_op, n) ->
    Ok ([], Il.NumE n, Il.NumT (Num.to_typ n))
  | TextE s ->
    Ok ([], Il.TextE s, Il.TextT)
  | CvtE (e1, nt) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* nt1 = as_num_typ "conversion" env Infer t1 e1.at in
    let* qs1', e1'' = cast_exp "operand" env e1' t1 (Il.NumT nt1 $ e1.at) in
    Ok (qs1 @ qs1', Il.CvtE (e1'', nt1, nt), Il.NumT nt)
  | UnE (op, e1) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* op', ot, t1', t = infer_unop env op (typ_rep env t1) e.at in
    let* qs1', e1'' = cast_exp "operand" env e1' t1 t1' in
    if op = `PlusMinusOp || op = `MinusPlusOp then env.pm <- true;
    Ok (qs1 @ qs1', Il.UnE (op', ot, e1''), t.it)
  | BinE (e1, op, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* qs2, e2', t2 = infer_exp env e2 in
    let* op', ot, t1', t2', t = infer_binop env op (typ_rep env t1) (typ_rep env t2) e.at in
    let* qs1', e1'' = cast_exp "operand" env e1' t1 t1' in
    let* qs2', e2'' = cast_exp "operand" env e2' t2 t2' in
    Ok (qs1 @ qs1' @ qs2 @ qs2', Il.BinE (op', ot, e1'', e2''), t.it)
  | CmpE (e1, op, ({it = CmpE (e21, _, _); _} as e2)) ->
    let* qs1, e1', _t1 = infer_exp env (CmpE (e1, op, e21) $ e.at) in
    let* qs2, e2', _t2 = infer_exp env e2 in
    Ok (qs1 @ qs2, Il.BinE (`AndOp, `BoolT, e1', e2'), Il.BoolT)
  | CmpE (e1, op, e2) ->
    (match infer_cmpop env op with
    | `Poly op' ->
      let* qs, e1', e2' =
        choice env [
          (fun env ->
            let* qs2, e2', t2 = infer_exp env e2 in
            let* qs1, e1' = elab_exp env e1 t2 in
            Ok (qs1 @ qs2, e1', e2')
          );
          (fun env ->
            let* qs1, e1', t1 = infer_exp env e1 in
            let* qs2, e2' = elab_exp env e2 t1 in
            Ok (qs1 @ qs2, e1', e2')
          );
        ]
      in
      Ok (qs, Il.CmpE (op', `BoolT, e1', e2'), Il.BoolT)
    | `Over elab_cmpop'  ->
      let* qs1, e1', t1 = infer_exp env e1 in
      let* qs2, e2', t2 = infer_exp env e2 in
      let* op', ot, t = elab_cmpop' (typ_rep env t1) (typ_rep env t2) e.at in
      let* qs1', e1'' = cast_exp "operand" env e1' t1 t in
      let* qs2', e2'' = cast_exp "operand" env e2' t2 t in
      Ok (qs1 @ qs1' @ qs2 @ qs2', Il.CmpE (op', ot, e1'', e2''), Il.BoolT)
    )
  | IdxE (e1, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* t = as_list_typ "expression" env Infer t1 e1.at in
    let* qs2, e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    Ok (qs1 @ qs2, Il.IdxE (e1', e2'), t.it)
  | SliceE (e1, e2, e3) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* _t' = as_list_typ "expression" env Infer t1 e1.at in
    let* qs2, e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    let* qs3, e3' = elab_exp env e3 (Il.NumT `NatT $ e3.at) in
    Ok (qs1 @ qs2 @ qs3, Il.SliceE (e1', e2', e3'), t1.it)
  | UpdE (e1, p, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* qs, p', t2 = elab_path env p t1 in
    let* qs2, e2' = elab_exp env e2 t2 in
    Ok (qs1 @ qs  @ qs2, Il.UpdE (e1', p', e2'), t1.it)
  | ExtE (e1, p, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* qs, p', t2 = elab_path env p t1 in
    let* _t21 = as_list_typ "path" env Infer t2 p.at in
    let* qs2, e2' = elab_exp env e2 t2 in
    Ok (qs1 @ qs @ qs2, Il.ExtE (e1', p', e2'), t1.it)
  | StrE _ ->
    fail_infer e.at "record"
  | DotE (e1, atom) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* tfs, dots = as_struct_typ "expression" env Infer t1 e1.at in
    if dots = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* qsF, tF, prems = attempt (find_field tfs atom e1.at) t1 in
    let qs', s = Il.Fresh.refresh_quants qsF in
    let as' = il_args_of_params qs' in
    let tF' = Il.Subst.subst_typ s tF in
    let e' = Il.DotE (e1', elab_atom atom (expand_id env t1), as') in
    let e'' = if prems = [] then e' else Il.ProjE (e' $$ e.at % tF', 0) in
    Ok (qs1 @ qs', e'', tF'.it)
  | CommaE (e1, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* tfs, dots = as_struct_typ "expression" env Infer t1 e1.at in
    if dots = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* () = as_cat_typ "expression" env Infer t1 e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _t2 = attempt (find_field tfs atom at) t1 in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* qs2, e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t1 in
      Ok (qs1 @ qs2, Il.CompE (e2', e1'), t1.it)
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* () = as_cat_typ "operand" env Infer t1 e1.at in
    let* qs2, e2' = elab_exp env e2 t1 in
    Ok (qs1 @ qs2,
      (if is_iter_typ env t1 then Il.CatE (e1', e2') else Il.CompE (e1', e2')), t1.it)
  | MemE (e1, e2) ->
    choice env [
      (fun env ->
        let* qs1, e1', t1 = infer_exp env e1 in
        let* qs2, e2' = elab_exp env e2 (Il.IterT (t1, Il.List) $ e2.at) in
        Ok (qs1 @ qs2, Il.MemE (e1', e2'), Il.BoolT)
      );
      (fun env ->
        let* qs2, e2', t2 = infer_exp env e2 in
        let* t1 = as_list_typ "operand" env Infer t2 e2.at in
        let* qs1, e1' = elab_exp env e1 t1 in
        Ok (qs1 @ qs2, Il.MemE (e1', e2'), Il.BoolT)
      );
    ]
  | LenE e1 ->
    let* qs1, e1', t1 = infer_exp env e1 in
    let* _t11 = as_list_typ "expression" env Infer t1 e1.at in
    Ok (qs1, Il.LenE e1', Il.NumT `NatT)
  | SizeE id ->
    let _ = find "grammar" env.grams id in
    Ok ([], Il.NumE (`Nat Z.zero), Il.NumT `NatT)
  | ParenE e1 | ArithE e1 ->
    infer_exp' env e1
  | TupE es ->
    let* qs, es', ts = infer_exp_list env es in
    Ok (qs, Il.TupE es', (tup_typ' ts e.at).it)
  | CallE (id, as_) ->
    let ps, t, _ = find "definition" env.defs id in
    let qs, as', s = elab_args `Rhs env as_ ps e.at in
    Ok (qs, Il.CallE (id, as'), (Il.Subst.subst_typ s t).it)
  | EpsE ->
    fail_infer e.at "empty sequence"
  | SeqE [] ->  (* treat as empty tuple, not principal *)
    Ok ([], Il.TupE [], Il.TupT [])
  | SeqE es | ListE es ->  (* treat as homogeneous sequence, not principal *)
    let* qs, es', ts = infer_exp_list env es in
    let t = List.hd ts in
    if List.for_all (equiv_typ env t) (List.tl ts) then
      Ok (qs, Il.ListE es', Il.IterT (t, Il.List))
    else
      fail_infer e.at "expression sequence"
  | InfixE _ -> fail_infer e.at "infix expression"
  | BrackE _ -> fail_infer e.at "bracket expression"
  | IterE (e1, iter) ->
    let qs, iter' = elab_iterexp env iter in
    let* qs1, e1', t1 = infer_exp env e1 in
    let iter'' = match fst iter' with Il.Opt -> Il.Opt | _ -> Il.List in
    Ok (qs1 @ qs, Il.IterE (e1', iter'), Il.IterT (t1, iter''))
  | TypE (e1, t) ->
    let t' = elab_typ env t in
    let* qs1, e1' = elab_exp env e1 t' in
    Ok (qs1, e1'.it, t'.it)
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token concatenation"
  | UnparenE _ -> error e.at "misplaced unparenthesize"
  | LatexE _ -> error e.at "misplaced latex literal"

and infer_exp_list env = function
  | [] -> Ok ([], [], [])
  | e::es ->
    let* qs1, e', t = infer_exp env e in
    let* qs2, es', ts = infer_exp_list env es in
    Ok (qs1 @ qs2, e'::es', t::ts)


and elab_exp env e t : (Il.quant list * Il.exp) attempt =
  Debug.(log_at "el.elab_exp" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (il_typ t))
    (function Ok (qs, e') -> fmt "%s%s" (il_quants qs) (il_exp e') | _ -> "fail")
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
            let* qs, e' = elab_exp env e t1 in
            Ok (qs, lift_exp' e' iter $$ e.at % t)
        );
        (fun env -> elab_exp_plain env e t);
      ]
    else if is_notation_typ env t then
      let* not = as_notation_typ "" env Check t e.at in
      choice env [
        (fun env -> elab_exp_plain env e t);
        (fun env -> elab_exp_notation env (expand_id env t) e not t);
      ]
    else
      elab_exp_plain env e t
  )

and elab_exp_plain env e t : (Il.quant list * Il.exp) attempt =
  Debug.(log_at "el.elab_exp_plain" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (il_typ t))
    (function Ok (qs, e') -> fmt "%s%s" (il_quants qs) (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  let* qs, e' = elab_exp_plain' env e t in
  Ok (qs, e' $$ e.at % t)

and elab_exp_plain' env e t : (Il.quant list * Il.exp') attempt =
  match e.it with
  | BoolE _ | NumE _ | CvtE _ | UnE _ | BinE _ | CmpE _
  | IdxE _ | DotE _ | MemE _ | LenE _ | SizeE _ | CallE _ | TypE _
  | HoleE _ | FuseE _ | UnparenE _ | LatexE _ ->
    let* qs1, e', t' = infer_exp env e in
    let* qs2, e'' = cast_exp' "expression" env e' t' t in
    Ok (qs1 @ qs2, e'')
  | TextE s ->
    let cs = try Utf8.decode s with Utf8.Utf8 -> [] in
    (* Allow treatment as character constant *)
    if List.length cs = 1 && is_nat_typ env t then
      let e' = Il.NumE (`Nat (Z.of_int (List.hd cs))) $$ e.at %
        (Il.NumT `NatT $ e.at) in
      cast_exp' "character" env e' (Il.NumT `NatT $ e.at) t
    else
      let* qs1, e', t' = infer_exp env e in
      let* qs2, e'' = cast_exp' "expression" env e' t' t in
      Ok (qs1 @ qs2, e'')
  | VarE (id, _) when id.it = "_" ->
    Ok ([], Il.VarE id)
  | VarE (id, _) ->
    choice env [
      (fun env ->
        let* qs1, e', t' = infer_exp env e in
        let* qs2, e'' = cast_exp' "expression" env e' t' t in
        Ok (qs1 @ qs2, e'')
      );
      (fun env ->
        if is_iter_typ env t && id.it <> "_" then
          (* Never infer an iteration type for a variable *)
          let* t1, iter = as_iter_typ "" env Check t e.at in
          let* qs, e' = elab_exp env e t1 in
          Ok (qs, lift_exp' e' iter)
        else if not (bound env.vars id || bound env.gvars (strip_var_suffix id)) then
          let _ = () in
          env.vars <- bind "variable" env.vars id t;
          Ok ([], Il.VarE id)
        else
          fail_silent  (* suitable error was produced by infer_exp already *)
      );
    ]
  | SliceE (e1, e2, e3) ->
    let* _t' = as_list_typ "expression" env Check t e1.at in
    let* qs1, e1' = elab_exp env e1 t in
    let* qs2, e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    let* qs3, e3' = elab_exp env e3 (Il.NumT `NatT $ e3.at) in
    Ok (qs1 @ qs2 @ qs3, Il.SliceE (e1', e2', e3'))
  | UpdE (e1, p, e2) ->
    let* qs1, e1' = elab_exp env e1 t in
    let* qs, p', t2 = elab_path env p t in
    let* qs2, e2' = elab_exp env e2 t2 in
    Ok (qs1 @ qs @ qs2, Il.UpdE (e1', p', e2'))
  | ExtE (e1, p, e2) ->
    let* qs1, e1' = elab_exp env e1 t in
    let* qs, p', t2 = elab_path env p t in
    let* _t21 = as_list_typ "path" env Check t2 p.at in
    let* qs2, e2' = elab_exp env e2 t2 in
    Ok (qs1 @ qs @ qs2, Il.ExtE (e1', p', e2'))
  | StrE efs ->
    let* tfs, dots = as_struct_typ "record" env Check t e.at in
    if dots = Dots then
      error e.at "used record type is only partially defined at this point";
    let* qs, efs' = elab_expfields env (expand_id env t) (filter_nl efs) tfs t e.at in
    Ok (qs, Il.StrE efs')
  | CommaE (e1, e2) ->
    let* qs1, e1' = elab_exp env e1 t in
    let* tfs, dots1 = as_struct_typ "expression" env Check t e1.at in
    if dots1 = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* () = as_cat_typ "expression" env Check t e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _t2 = attempt (find_field tfs atom at) t in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* qs2, e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t in
      Ok (qs1 @ qs2, Il.CompE (e2', e1'))
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* () = as_cat_typ "expression" env Check t e.at in
    let* qs1, e1' = elab_exp env e1 t in
    let* qs2, e2' = elab_exp env e2 t in
    Ok (qs1 @ qs2,
      if is_iter_typ env t then Il.CatE (e1', e2') else Il.CompE (e1', e2'))
  | ParenE e1 | ArithE e1 ->
    elab_exp_plain' env e1 t
  | TupE es ->
    let* xts = as_tup_typ "tuple" env Check t e.at in
    let* qs, es' = elab_exp_list env es xts e.at in
    Ok (qs, Il.TupE es')
  | ListE es ->
    let* t1, iter = as_iter_typ "list" env Check t e.at in
    if iter <> Il.List then fail_typ env e.at "list" t else
    let xts = List.init (List.length es) (fun _ -> "_" $ t1.at, t1) in
    let* qs, es' = elab_exp_list env es xts e.at in
    Ok (qs, Il.ListE es')
  | SeqE [] when is_empty_notation_typ env t ->
    let* qs1, e', t' = infer_exp env e in
    let* qs2, e'' = cast_exp' "empty expression" env e' t' t in
    Ok (qs1 @ qs2, e'')
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
      let* not = as_notation_typ "" env Check t e.at in
      let* qs, e' = elab_exp_notation env (expand_id env t) e not t in
      Ok (qs, e'.it)
    else if is_variant_typ env t then
      let* tcs, _ = as_variant_typ "" env Check t e.at in
      let* qs, e' = elab_exp_variant env (expand_id env t) e tcs t e.at in
      Ok (qs, e'.it)
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
    let qs2, iter2' = elab_iterexp env iter2 in
    let* qs1, e1' = elab_exp env e1 t1 in
    let qs = qs1 @ qs2 in
    let e' = Il.IterE (e1', iter2') in
    match iter2, iter with
    | Opt, Il.Opt -> Ok (qs, e')
    | Opt, Il.List ->
      Ok (qs, Il.LiftE (e' $$ e.at % (Il.IterT (t1, Il.Opt) $ e1.at)))
    | _, Il.Opt -> fail_typ env e.at "iteration" t
    | _, _ -> Ok (qs, e')

and elab_exp_list env es xts at : (Il.quant list * Il.exp list) attempt =
  match es, xts with
  | [], [] -> Ok ([], [])
  | e::es, (_x, t)::xts ->
    let* qs1, e' = elab_exp env e t in
    let* qs2, es' = elab_exp_list env es xts at in
    Ok (qs1 @ qs2, e'::es')
  | _, _ ->
    fail at "arity mismatch for expression list"

and elab_expfields env tid efs tfs t0 at : (Il.quant list * Il.expfield list) attempt =
  Debug.(log_in_at "el.elab_expfields" at
    (fun _ -> fmt "{%s} : {%s} = %s" (list el_expfield efs) (list (il_typfield `H) tfs) (il_typ t0))
  );
  assert (valid_tid tid);
  match efs, tfs with
  | [], [] -> Ok ([], [])
  | (atom1, e)::efs2, (atom2, (qs, t, prems), _)::tfs2 when atom1.it = atom2.it ->
    let not = Mixop.(Seq [Atom atom2; Arg t]) in
    let* qs1, es', s = elab_exp_notation' env tid e not in
    let* qs2, efs2' = elab_expfields env tid efs2 tfs2 t0 at in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') es' e.at in
    let as' = Il.Subst.subst_args s (il_args_of_params qs) in
    Ok (qs1 @ qs2, (elab_atom atom1 tid, as', e') :: efs2')
  | _, (atom, (_qs, t, prems), _)::tfs2 ->
    let atom' = string_of_atom atom in
    let* qs1, e1' = cast_empty ("omitted record field `" ^ atom' ^ "`") env t at in
    let e' = (if prems = [] then tup_exp' else tup_exp_bind') [e1'] at in
    let* qs2, efs2' = elab_expfields env tid efs tfs2 t0 at in
(*TODO*)
    Ok (qs1 @ qs2, (elab_atom atom tid, [], e') :: efs2')
  | (atom, e)::_, [] ->
    fail_atom e.at atom t0 "undefined or misplaced record field"

and elab_exp_iter env es (t1, iter) t at : (Il.quant list * Il.exp) attempt =
  let* qs, e' = elab_exp_iter' env es (t1, iter) t at in
  Ok (qs, e' $$ at % t)

and elab_exp_iter' env es (t1, iter) t at : (Il.quant list * Il.exp') attempt =
  Debug.(log_at "el.elab_exp_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (il_typ t) (il_typ t1) (il_iter iter))
    (function Ok (qs, e') -> fmt "%s%s" (il_quants qs) (il_exp (e' $$ at % t)) | _ -> "fail")
  ) @@ fun _ ->
  match es, iter with
  | [], Opt ->
    Ok ([], Il.OptE None)
  | [e1], Opt ->
    let* qs1, e1' = elab_exp env e1 t1 in
    Ok (qs1, Il.OptE (Some e1'))
  | _::_::_, Opt ->
    fail_typ env at "expression" t

  | [], List ->
    Ok ([], Il.ListE [])
  | e1::es2, List ->
    let* qs1, e1' = elab_exp env e1 t in
    let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
    let* qs2, e2' = elab_exp_iter env es2 (t1, iter) t at' in
    Ok (qs1 @ qs2, cat_exp' e1' e2')

  | _, (List1 | ListN _) ->
    assert false

and elab_exp_notation env tid e (qs, t1, mixop, not) t : (Il.quant list * Il.exp) attempt =
  (* Convert notation into applications of mixin operators *)
  assert (valid_tid tid);
  let* qs', es', s = elab_exp_notation' env tid e not in
  let as' = Il.Subst.subst_args s (il_args_of_params qs) in
  Ok (qs', Il.CaseE (mixop, as', Il.TupE es' $$ e.at % t1) $$ e.at % t)

and elab_exp_notation' env tid e not : (Il.quant list * Il.exp list * Il.Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (string_of_notation not))
    (function Ok (qs, es', _) -> fmt "%s %s" (il_quants qs) (seq il_exp es') | _ -> "fail")
  ) @@ fun _ ->
  assert (valid_tid tid);
  match e.it, not with
  | AtomE atom, Atom atom' ->
    if atom.it <> atom'.it then fail_not env e.at "atom" not else
    let _ = elab_atom atom tid in
    Ok ([], [], Il.Subst.empty)
  | InfixE (e1, atom, e2), Infix (_, atom', _) when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ e2.at) $ e2.at in
    elab_exp_notation' env tid
      (InfixE (e1, atom', SeqE [e21; e2] $ e2.at) $ e.at) not
  | InfixE (e1, atom, e2), Infix (not1, atom', not2) ->
    if atom.it <> atom'.it then fail_not env e.at "infix expression" not else
    let* qs1, es1', s1 = elab_exp_notation' env tid e1 not1 in
    let* qs2, es2', s2 = elab_exp_notation' env tid e2 (subst_notation s1 not2) in
    let _ = elab_atom atom tid in
    Ok (qs1 @ qs2, es1' @ es2', Il.Subst.union s1 s2)
  | BrackE (l, e1, r), Brack (l', not1, r') ->
    if (l.it, r.it) <> (l'.it, r'.it) then fail_not env e.at "bracket expression" not else
    let _ = elab_atom l tid in
    let _ = elab_atom r tid in
    elab_exp_notation' env tid e1 not1

  | SeqE [], Seq [] ->
    Ok ([], [], Il.Subst.empty)
  | _, Seq ((Arg t1)::nots2) when is_iter_typ env t1 ->
    let* t11, iter = as_iter_typ "iteration" env Check t1 e.at in
    elab_exp_notation_iter env tid (unseq_exp e) (t11, iter) t1 nots2 e.at
  | SeqE ({it = AtomE atom; at; _}::es2), Seq ((Atom atom')::_)
    when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ at) $ at in
    elab_exp_notation' env tid (SeqE ((AtomE atom' $ at) :: e21 :: es2) $ e.at) not
  (* Trailing notation can be flattened *)
  | SeqE (e1::es2), Seq [Arg t1 as not1] ->
    choice env [
      (fun env ->
        let* qs1, es1', s1 = elab_exp_notation' env tid (unparen_exp e1) not1 in
        let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* qs2, es2', s2 = elab_exp_notation' env tid e2 (Seq []) in
        Ok (qs1 @ qs2, es1' @ es2', Il.Subst.union s1 s2)
      );
      (fun env ->
        let* qs, e' = elab_exp env e t1 in
        Ok (qs, [e'], Il.Subst.empty)
      )
    ]
  | SeqE (e1::es2), Seq (not1::nots2) ->
    let* qs1, es1', s1 = elab_exp_notation' env tid (unparen_exp e1) not1 in
    let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
    let not2 = Mixop.Seq nots2 in
    let* qs2, es2', s2 = elab_exp_notation' env tid e2 (subst_notation s1 not2) in
    Ok (qs1 @ qs2, es1' @ es2', Il.Subst.union s1 s2)
  (* Trailing elements can be omitted if they can be eps *)
  | SeqE [], Seq ((Arg t1)::nots2) ->
    let* qs1, e1' = cast_empty "omitted sequence tail" env t1 e.at in
    let* qs2, es2', s2 = elab_exp_notation' env tid e (Seq nots2) in
    Ok (qs1 @ qs2, e1' :: es2', s2)
  | SeqE (e1::_), Seq [] ->
    fail e1.at "expression is not empty"
  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, Seq _ ->
    elab_exp_notation' env tid (SeqE [e] $ e.at) not

(*
  | ParenE e1, _
  | ArithE e1, _ ->
    elab_exp_notation' env tid e1 not
*)

  | _, Arg t ->
    let* qs, e' = elab_exp env e t in
    Ok (qs, [e'], Il.Subst.add_varid Il.Subst.empty (varid_of_typ' t) e')

  | _, (Atom _ | Brack _ | Infix _) ->
    fail e.at "expression does not match expected notation"

and elab_exp_notation_iter env tid es (t1, iter) t nots at : (Il.quant list * Il.exp list * Il.Subst.t) attempt =
  assert (valid_tid tid);
  let* qs, e', es', s = elab_exp_notation_iter' env tid es (t1, iter) t nots at in
  Ok (qs, e'::es', s)

and elab_exp_notation_iter' env tid es (t1, iter) t nots at : (Il.quant list * Il.exp * Il.exp list * Il.Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (il_typ t) (il_typ t1) (il_iter iter))
    (function Ok (qs, e', es', _) -> fmt "%s %s" (il_quants qs) (seq il_exp (e'::es')) | _ -> "fail")
  ) @@ fun _ ->
  match es, iter with
  | [], Il.Opt ->
    let* qs, es', s = elab_exp_notation' env tid (SeqE [] $ at) (Seq nots) in
    Ok (qs, Il.OptE None $$ at % t, es', s)
  | e1::es2, Opt ->
    choice env [
      (fun env ->
        let* qs, es', s = elab_exp_notation' env tid (SeqE (e1::es2) $ at) (Seq nots) in
        Ok (qs, Il.OptE None $$ Source.before_region e1.at % t, es', s)
      );
      (fun env ->
        let* qs1, e1' = elab_exp env e1 t in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* qs2, es2', s = elab_exp_notation' env tid (SeqE es2 $ at') (Seq nots) in
        Ok (qs1 @ qs2, e1', es2', s)
      );
    ]

  | [], List ->
    let* qs, es', s = elab_exp_notation' env tid (SeqE [] $ at) (Seq nots) in
    Ok (qs, Il.ListE [] $$ at % t, es', s)
  | e1::es2, List ->
    choice env [
      (fun env ->
        let* qs, es', s = elab_exp_notation' env tid (SeqE (e1::es2) $ at) (Seq nots) in
        Ok (qs, Il.ListE [] $$ at % t, es', s)
      );
      (fun env ->
        let* qs1, e1' = elab_exp env e1 t in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* qs2, e2', es2', s = elab_exp_notation_iter' env tid es2 (t1, iter) t nots at' in
        Ok (qs1 @ qs2, cat_exp' e1' e2' $$ Source.over_region [e1'.at; e2'.at] % t, es2', s)
      );
    ]

  | _, (List1 | ListN _) ->
    assert false

and elab_exp_variant env tid e cases t at : (Il.quant list * Il.exp) attempt =
  Debug.(log_at "el.elab_exp_variant" e.at
    (fun _ -> fmt "%s : %s = %s" (el_exp e) tid.it (il_typ t))
    (function Ok (qs, e') -> fmt "%s%s" (il_quants qs) (il_exp e') | _ -> "fail")
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
  let* not1, _prems = attempt (find_case_sub cases atom atom.at) t in
  let* qs1, es', _s = elab_exp_notation' env tid e not1 in
  let t2 = expand env t $ at in
  let t2' = elab_typ env t2 in

  let mixop, qs2, t1', _prems', _ = elab_typ_notation' env tid e.at not1 [] in
(*TODO*)
  let* qs3, e' = cast_exp "variant case" env
    (Il.CaseE (mixop, Il.TupE es' $$ at % t1') $$ at % t2') t2 t in
  Ok (qs1 @ qs2 @ qs3, e')
(*
  let mixop, ts', _ = elab_typ_notation env tid t1 in
  assert (List.length es' = List.length ts');
  cast_exp "variant case" env
    (Il.CaseE (mixop, tup_exp_bind' es' at) $$ at % t2') t2 t
*)

and elab_path env p t : (Il.quant list * Il.path * Il.typ) attempt =
  let* qs, p', t' = elab_path' env p t in
  Ok (qs, p' $$ p.at % t', t')

and elab_path' env p t : (Il.quant list * Il.path' * Il.typ) attempt =
  match p.it with
  | RootP ->
    Ok ([], Il.RootP, t)
  | IdxP (p1, e1) ->
    let* qs1, p1', t1 = elab_path env p1 t in
    let qs2, e1' = checkpoint (elab_exp env e1 (Il.NumT `NatT $ e1.at)) in
    let* t' = as_list_typ "path" env Check t1 p1.at in
    Ok (qs1 @ qs2, Il.IdxP (p1', e1'), t')
  | SliceP (p1, e1, e2) ->
    let* qs, p1', t1 = elab_path env p1 t in
    let qs1, e1' = checkpoint (elab_exp env e1 (Il.NumT `NatT $ e1.at)) in
    let qs2, e2' = checkpoint (elab_exp env e2 (Il.NumT `NatT $ e2.at)) in
    let* _ = as_list_typ "path" env Check t1 p1.at in
    Ok (qs @ qs1 @ qs2, Il.SliceP (p1', e1', e2'), t1)
  | DotP (p1, atom) ->
    let* qs1, p1', t1 = elab_path env p1 t in
    let* tfs, dots = as_struct_typ "path" env Check t1 p1.at in
    if dots = Dots then
      error p1.at "used record type is only partially defined at this point";
(*TODO*)
    let* t', _prems = attempt (find_field tfs atom p1.at) t1 in
    Ok (qs1, Il.DotP (p1', elab_atom atom (expand_id env t1)), t')


and cast_empty phrase env t at : (Il.quant list * Il.exp) attempt =
  Debug.(log_at "el.elab_exp_cast_empty" at
    (fun _ -> fmt "%s  >>  (%s)" (il_typ t) (il_typ t))
    (function Ok (qs, e') -> fmt "%s%s" (il_quants qs) (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  nest at t (
    match expand env t with
    | Il.IterT (_, Opt) -> Ok ([], Il.OptE None $$ at % t')
    | Il.IterT (_, List) -> Ok ([], Il.ListE [] $$ at % t')
    | VarT _ when is_notation_typ env t ->
      (match expand_notation env t with
      | SeqT [] -> Ok ([], Il.ListE [] $$ at % t')
      | _ -> fail_typ env at phrase t
      )
(*
    | VarT _ when is_iter_notation_typ env t ->
      (match expand_iter_notation env t with
      | IterT (_, iter) as t1 ->
(*TODO*)
        let mixop, ts', _ts = elab_typ_notation env (expand_id env t) (t1 $ t.at) in
        assert (List.length ts' = 1);
        let e1' = if iter = Opt then Il.OptE None else Il.ListE [] in
        Ok ([], Il.CaseE (mixop, tup_exp_bind' [e1' $$ at % List.hd ts'] at) $$ at % t')
      | _ -> fail_typ env at phrase t
      )
*)
    | _ -> fail_typ env at phrase t
  )

and cast_exp phrase env e' t1 t2 : (Il.quant list * Il.exp) attempt =
  let* qs, e'' = nest e'.at t2 (cast_exp' phrase env e' t1 t2) in
  Ok (qs, e'' $$ e'.at % elab_typ env (expand_nondef env t2))

and cast_exp' phrase env e' t1 t2 : (Il.quant list * Il.exp') attempt =
  Debug.(log_at "el.elab_exp_cast" e'.at
    (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s)" (il_typ t1) (il_typ t2)
      (il_deftyp (expand_def env t1 $ t1.at)) (il_deftyp (expand_def env t2 $ t2.at))
      (il_typ (expand_nondef env t2))
    )
    (function Ok (qs, e'') -> fmt "%s%s" (il_quants qs) (il_exp (e'' $$ e'.at % t2)) | _ -> "fail")
  ) @@ fun _ ->
  if equiv_typ env t1 t2 then Ok ([], e'.it) else
  match expand env t1, expand env t2 with
  | t1', t2' when sub_typ env t1' t2' ->
    Ok ([], Il.SubE (e', t1', t2'))
  | Il.NumT nt1, Il.NumT nt2 when nt1 < nt2 || lax_num && nt1 <> `RealT ->
    Ok ([], Il.CvtE (e', nt1, nt2))

  | Il.TupT [], Il.VarT _ as t2' when is_empty_typ t2' ->
    Ok ([], e'.it)

  | IterT (t11, Opt), IterT (t21, List) ->
    choice env [
      (fun env ->
        let t1' = Il.IterT (t11, Il.List) $ e'.at in
        let e'' = Il.LiftE e' $$ e'.at % t1' in
        cast_exp' phrase env e'' t1' t2
      );
      (fun env ->
        let* qs, e'' = cast_exp phrase env e' t1 t21 in
        Ok (qs, Il.ListE [e''])
      );
    ]
  | _, IterT (t21, (List | List1)) ->
    let* qs, e'' = cast_exp phrase env e' t1 t21 in
    Ok (qs, Il.ListE [e''])

  | Il.VarT _ as t1', Il.VarT _ as t2' ->
    (match expand_def env t1', expand_def env t2' with
    | Il.VariantT [mixop1, (qs1, t11, _), _],
      Il.VariantT [mixop2, (qs2, t21, _), _] ->
      if mixop1 = mixop2 then
      (* Two ConT's with the same operator can be cast pointwise *)
        let e'' = Il.UncaseE (e', mixop1) $$ e'.at % t1' in
        let ts1 = match t11.it with Il.TupT xts -> List.map snd xts | _ -> [t11] in
        let es' = List.mapi (fun i t1I -> Il.ProjE (e'', i) $$ e''.at % t1I) ts1 in
        let* qss_es'' = map2_attempt (fun eI' (t1I, t2I) ->
          cast_exp phrase env eI' t1I t2I) es' (List.combine ts1 ts2) in
        let qss, es'' = List.split qss_es'' in
        Ok (qs1 @ qs2 @ List.concat qss, Il.CaseE (mixop2, tup_exp_bind' es'' e'.at))
      else
        (* Two unary ConT's can be cast transitively *)
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 1" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let* t111, t111' = match ts, t11.it with [t111], Il.TupT [_, t111'] -> Ok (t111, t111') | _ ->
          fail_typ2 env e'.at phrase t1 t2 "" in
        let e'' = Il.UncaseE (e', mixop) $$ e'.at % t11 in
        let* qs, e''' = cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2' in
        Ok (qs @ qs, e''')

    | Il.VariantT [mixop1, (qs1, t11, _), _], _ ->
      choice env [
        (fun env ->
          let* qs, e'' =
            match t2' with
            | IterT (t21, iter) ->
              let* qs1, e1' = cast_exp phrase env e' t1 t21 in
              (match iter with
              | Opt -> Ok (qs1, Il.OptE (Some e1'))
              | List -> Ok (qs1, Il.ListE [e1'])
              | _ -> assert false
              )
            | _ -> fail_silent
          in
          Ok (qs, e'')
        );
        (fun env ->
          (* A ConT can be cast to its payload *)
          Debug.(log_in_at "el.cast_exp" e'.at
            (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 2" (el_typ t1) (el_typ t2)
              (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
              (el_typ (expand_nondef env t2))
            )
          );
          let* t111, t111' = match ts, t11.it with [t111], Il.TupT [_, t111'] -> Ok (t111, t111') | _ ->
            fail_typ2 env e'.at phrase t1 t2 "" in
(*TODO*)
          let e'' = Il.UncaseE (e', mixop) $$ e'.at % t11 in
          let* qs, e''' = cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2 in
          Ok (qs @ qs, e''')
        );
      ]

    | _, Il.VariantT [mixop2, (qs2, t21, _), _] ->
      (* A ConT payload can be cast to the ConT *)
      let* t211 = match ts with [t211] -> Ok t211 | _ ->
        fail_typ2 env e'.at phrase t1 t2 "" in
      let* qs, e1' = cast_exp phrase env e' t1 t211 in
(*TODO*)
      Ok (qs2 @ qs, Il.CaseE (mixop2, Il.TupE [e1'] $$ e'.at % t'))

    | (Il.VariantT tcs1, dots1), (Il.VariantT tcs2, dots2) ->
      if dots2 = Dots then
        error e'.at "used variant type is only partially defined at this point";
      let* () =
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
      let t11' = elab_typ env (expand env t1) in
      let t21' = elab_typ env (expand env t2) in
      let* qs1, e'' = cast_exp phrase env e' t1 t11 in
      let e''' = Il.SubE (e'', t11', t21') in
      let* qs2, e'''' = cast_exp' phrase env (e''' $$ e'.at % t21') t21 t2 in
      Ok (qs1 @ qs2, e'''')

    | _, _ ->
      fail_typ2 env e'.at phrase t1 t2 ""
    )

  | _, _ ->
    fail_typ2 env e'.at phrase t1 t2 ""

(*
  | ConT ((t11, _), _), ConT ((t21, _), _) ->
    choice env [
      (fun env ->
        (* Two ConT's with the same operator can be cast pointwise *)
        let mixop1, qs1, t1', _prems1', ts1 = elab_typ_notation' env (expand_id env t1) t1.at t11 [] in
        let mixop2, qs2, _t2', _prems2', ts2 = elab_typ_notation' env (expand_id env t2) t2.at t21 [] in
(*
        let mixop1, ts1', ts1 = elab_typ_notation env (expand_id env t1) t11 in
        let mixop2, _ts2', ts2 = elab_typ_notation env (expand_id env t2) t21 in
*)
        if mixop1 <> mixop2 then
          fail_typ2 env e'.at phrase t1 t2 "" else
        let e'' = Il.UncaseE (e', mixop1) $$ e'.at % t1' in
        let ts1' = match t1'.it with Il.TupT xts -> List.map snd xts | _ -> [t1'] in
        let es' = List.mapi (fun i t1I' -> Il.ProjE (e'', i) $$ e''.at % t1I') ts1' in
        let* qss_es'' = map2_attempt (fun eI' (t1I, t2I) ->
          cast_exp phrase env eI' t1I t2I) es' (List.combine ts1 ts2) in
        let qss, es'' = List.split qss_es'' in
        Ok (qs1 @ qs2 @ List.concat qss, Il.CaseE (mixop2, tup_exp_bind' es'' e'.at))
      );
      (fun env ->
        (* Two unary ConT's can be cast transitively *)
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 1" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let mixop, qs, t1', _prems', ts = elab_typ_notation' env (expand_id env t1) t1.at t11 [] in
(*
        let mixop, ts', ts = elab_typ_notation env (expand_id env t1) t11 in
*)
        let* t111, t111' = match ts, t1'.it with [t111], Il.TupT [_, t111'] -> Ok (t111, t111') | _ ->
          fail_typ2 env e'.at phrase t1 t2 "" in
        let e'' = Il.UncaseE (e', mixop) $$ e'.at % t1' in
        let* qs, e''' = cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2 in
        Ok (qs @ qs, e''')
      );
    ]
  | ConT ((t11, _), _), t2' ->
    choice env [
      (fun env ->
        let* qs, e'' =
          match t2' with
          | IterT (t21, iter) ->
            let* qs1, e1' = cast_exp phrase env e' t1 t21 in
            (match iter with
            | Opt -> Ok (qs1, Il.OptE (Some e1'))
            | List -> Ok (qs1, Il.ListE [e1'])
            | _ -> assert false
            )
          | _ -> fail_silent
        in
        Ok (qs, e'')
      );
      (fun env ->
        (* A ConT can be cast to its payload *)
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 2" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let mixop, qs, t1', _prems', ts = elab_typ_notation' env (expand_id env t1) t1.at t11 [] in
(*
        let mixop, ts', ts = elab_typ_notation env (expand_id env t1) t11 in
*)
        let* t111, t111' = match ts, t1'.it with [t111], Il.TupT [_, t111'] -> Ok (t111, t111') | _ ->
          fail_typ2 env e'.at phrase t1 t2 "" in
Printf.printf "[3] %s => %s\n%!" (Debug.el_typ t1) (Debug.il_typ t1');
        let e'' = Il.UncaseE (e', mixop) $$ e'.at % t1' in
        let* qs, e''' = cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t111') t111 t2 in
        Ok (qs @ qs, e''')
      );
    ]
  | _, ConT ((t21, _), _) ->
    (* A ConT payload can be cast to the ConT *)
    let mixop, qs, t', _prems', ts = elab_typ_notation' env (expand_id env t2) t2.at t21 [] in
(*
    let mixop, _ts', ts = elab_typ_notation env (expand_id env t2) t21 in
*)
    let* t211 = match ts with [t211] -> Ok t211 | _ ->
      fail_typ2 env e'.at phrase t1 t2 "" in
    let* qs1, e1' = cast_exp phrase env e' t1 t211 in
    Ok (qs @ qs1, Il.CaseE (mixop, Il.TupE [e1'] $$ e'.at % t'))
  | RangeT _, t2' ->
    choice env [
      (fun env ->
        let* qs, e'' =
          match t2' with
          | IterT (t21, iter) ->
            let* qs1, e1' = cast_exp phrase env e' t1 t21 in
            (match iter with
            | Opt -> Ok (qs1, Il.OptE (Some e1'))
            | List -> Ok (qs1, Il.ListE [e1'])
            | _ -> assert false
            )
          | _ -> fail_silent
        in
        Ok (qs, e'')
      );
      (fun env ->
        (* A RangeT can be cast to its carrier type *)
        Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 3" (el_typ t1) (el_typ t2)
            (el_typ (expand_def env t1 $ t1.at)) (el_typ (expand_def env t2 $ t2.at))
            (el_typ (expand_nondef env t2))
          )
        );
        let t11 = typ_rep env t1 in
        let t11' = elab_typ env t11 in
Printf.printf "[4] %s => %s\n%!" (Debug.el_typ t11) (Debug.il_typ t11');
        let e'' = Il.UncaseE (e', [[]; []]) $$ e'.at % t11' in
        let e''' = Il.ProjE (e'', 0) $$ e'.at % t11' in
        cast_exp' phrase env e''' t11 t2
      );
    ]
  | _, RangeT _ ->
    (* A respective carrier type can be cast to RangeT *)
    let t21 = typ_rep env t2 in
    let* qs, e'' = cast_exp phrase env e' t1 t21 in
    Ok (qs, Il.CaseE ([[]; []], Il.TupE [e''] $$ e'.at % elab_typ env t21))
  | _, IterT (t21, Opt) ->
    let* qs, e'' = cast_exp phrase env e' t1 t21 in
    Ok (qs, Il.OptE (Some e''))
(* TODO(3, rossberg): enable; violates invariant that all iterexps are initially empty
  | IterT (t11, List), IterT (t21, List) ->
    choice env [
      (fun env ->
        let id = x $ e'.at in
        let t11' = elab_typ env t11 in
        let* qs, e'' = cast_exp phrase env (Il.VarE id $$ e'.at % t11') t11 t21 in
        Ok (qs, Il.IterE (e'', (List, [x, e'])))
      );
      (fun env ->
        let* qs, e'' = cast_exp phrase env e' t1 t21 in
        Ok (qs, Il.ListE [e''])
      );
    ]
*)

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
    let* qs1, e'' = cast_exp phrase env e' t1 t11 in
    let e''' = Il.SubE (e'', t11', t21') in
    let* qs2, e'''' = cast_exp' phrase env (e''' $$ e'.at % t21') t21 t2 in
    Ok (qs1 @ qs2, e'''')
*)


and elab_iterexp env iter : Il.quant list * Il.iterexp =
  let qs, iter' = elab_iter env iter in
  (qs, (iter', []))


(* Premises *)

and elab_prem env prem : Il.quant list * Il.prem list =
  match prem.it with
  | VarPr (id, t) ->
    env.vars <- bind "variable" env.vars id t;
    [], []
  | RulePr (id, e) ->
    let mixop, not, _ = find "relation" env.rels id in
    let qs, es', _s = checkpoint (elab_exp_notation' env id e not) in
    qs, [Il.RulePr (id, mixop, tup_exp' es' e.at) $ prem.at]
  | IfPr e ->
    let qs, e' = checkpoint (elab_exp env e (BoolT $ e.at)) in
    qs, [Il.IfPr e' $ prem.at]
  | ElsePr ->
    [], [Il.ElsePr $ prem.at]
  | IterPr ({it = VarPr _; at; _}, _iter) ->
    error at "misplaced variable premise"
  | IterPr (prem1, iter) ->
    let qs, iter' = elab_iterexp env iter in
    let qs1, prems1' = elab_prem env prem1 in
    assert (List.length prems1' = 1);
    qs @ qs1, [Il.IterPr (List.hd prems1', iter') $ prem.at]


(* Grammars *)

and infer_sym env g : (Il.quant list * Il.sym * Il.typ) attempt =
  Debug.(log_at "el.infer_sym" g.at
    (fun _ -> fmt "%s" (el_sym g))
    (function Ok (qs, g', t) -> fmt "%s %s : %s" (il_quants qs) (il_sym g') (il_typ t) | _ -> "fail")
  ) @@ fun _ ->
  nest g.at (TupT [] $ g.at) (
    match g.it with
    | VarG (x, as_) ->
      let ps, t, _gram, _prods' = find "grammar" env.grams x in
      let qs, as', s = elab_args `Rhs env as_ ps g.at in
      Ok (qs, Il.VarG (x, as') $ g.at, Il.Subst.subst_typ s t)
    | NumG (`CharOp, n) ->
(*
      let s = try Utf8.encode [Z.to_int n] with Z.Overflow | Utf8.Utf8 ->
        error g.at "character value out of range" in
      Il.TextG s $ g.at, TextT $ g.at, env
*)
      if n < Z.of_int 0x00 || n > Z.of_int 0x10ffff then
        fail g.at "unicode value out of range"
      else
        Ok ([], Il.NumG (Z.to_int n) $ g.at, Il.NumT `NatT $ g.at)
    | NumG (_, n) ->
      if n < Z.of_int 0x00 || n > Z.of_int 0xff then
        fail g.at "byte value out of range"
      else
        Ok ([], Il.NumG (Z.to_int n) $ g.at, Il.NumT `NatT $ g.at)
    | TextG s ->
      Ok ([], Il.TextG s $ g.at, Il.TextT $ g.at)
    | EpsG ->
      Ok ([], Il.EpsG $ g.at, Il.TupT [] $ g.at)
    | SeqG gs ->
      let* qs, gs' = elab_sym_list env (filter_nl gs) (Il.TupT [] $ g.at) in
      Ok (qs, Il.SeqG gs' $ g.at, Il.TupT [] $ g.at)
    | AltG gs ->
      choice env [
        (fun env ->
          let* qs, gs', ts = infer_sym_list env (filter_nl gs) in
          if qs <> [] then
            fail g.at "invalid expressions in alternative"
          else if  ts <> [] && List.for_all (equiv_typ env (List.hd ts)) ts then
            Ok ([], Il.AltG gs' $ g.at, List.hd ts)
          else fail g.at "inconsistent types"
        );
        (fun env ->
          (* HACK to treat singleton strings in short grammar as characters *)
          let* qs, g' = elab_sym env g (Il.NumT `NatT $ g.at) in
          Ok (qs, g', Il.NumT `NatT $ g.at)
        );
        (fun env ->
          let* qs, g' = elab_sym env g (Il.TupT [] $ g.at) in
          Ok (qs, g', Il.TupT [] $ g.at)
        )
      ]
    | RangeG (g1, g2) ->
      let env1 = local_env env in
      let env2 = local_env env in
      let* qs1, g1' = elab_sym env1 g1 (Il.NumT `NatT $ g1.at) in
      let* qs2, g2' = elab_sym env2 g2 (Il.NumT `NatT $ g2.at) in
      if env1.vars != env.vars then
        error g1.at "invalid symbol in range";
      if env2.vars != env.vars then
        error g2.at "invalid symbol in range";
      Ok (qs1 @ qs2, Il.RangeG (g1', g2') $ g.at, Il.NumT `NatT $ g.at)
    | ParenG g1 ->
      infer_sym env g1
    | TupG _ -> error g.at "malformed grammar"
    | ArithG e ->
      infer_sym env (sym_of_exp e)
    | IterG (g1, iter) ->
      let qs, iterexp' = elab_iterexp env iter in
      let* qs1, g1', t1 = infer_sym env g1 in
      Ok (
        qs1 @ qs,
        Il.IterG (g1', iterexp') $ g.at,
        Il.IterT (t1, match iter with Opt -> Il.Opt | _ -> Il.List) $ g.at
      )
    | AttrG (e, g1) ->
      choice env [
        (fun env ->
          (* HACK to treat singleton strings in short grammar as characters *)
          let t1 = Il.NumT `NatT $ g1.at in
          let* qs1, g1' = elab_sym env g1 t1 in
          let* qs2, e' = elab_exp env e t1 in
          Ok (qs2 @ qs1, Il.AttrG (e', g1') $ g.at, t1)
        );
        (fun env ->
          let* qs1, g1', t1 = infer_sym env g1 in
          let* qs2, e' = elab_exp env e t1 in
          Ok (qs1 @ qs2, Il.AttrG (e', g1') $ g.at, t1)
        );
      ]
  (*
      let qs1, g1', t1 = infer_sym env g1 in
      let qs2, e' = checkpoint (elab_exp env e t1) in
      Ok (qs1 @ qs2, Il.AttrG (e', g1') $ g.at, t1)
  *)
    | FuseG _ -> error g.at "misplaced token concatenation"
    | UnparenG _ -> error g.at "misplaced token unparenthesize"
  )

and infer_sym_list env es : (Il.quant list * Il.sym list * Il.typ list) attempt =
  match es with
  | [] -> Ok ([], [], [])
  | g::gs ->
    let* qs1, g', t = infer_sym env g in
    let* qs2, gs', ts = infer_sym_list env gs in
    Ok (qs1 @ qs2, g'::gs', t::ts)

and elab_sym env g t : (Il.quant list * Il.sym) attempt =
  Debug.(log_at "el.elab_sym" g.at
    (fun _ -> fmt "%s : %s" (el_sym g) (il_typ t))
    (function Ok (qs, g') -> fmt "%s%s" (il_quants qs) (il_sym g') | _ -> "fail")
  ) @@ fun _ ->
  nest g.at t (
    match g.it with
    | TextG s when is_nat_typ env t ->
      let cs = try Utf8.decode s with Utf8.Utf8 -> [] in
      (* Allow treatment as character constant *)
      if List.length cs = 1 then
        Ok ([], Il.NumG (List.hd cs) $ g.at)
      else
        let* qs1, g', t' = infer_sym env g in
        let* qs2, g'' = cast_sym env g' t' t in
        Ok (qs1 @ qs2, g'')
    | AltG gs ->
      let* qs, gs' = elab_sym_list env (filter_nl gs) t in
      Ok (qs, Il.AltG gs' $ g.at)
    | ParenG g1 ->
      elab_sym env g1 t
    | _ ->
      let* qs1, g', t' = infer_sym env g in
      let* qs2, g'' = cast_sym env g' t' t in
      Ok (qs1 @ qs2, g'')
  )

and elab_sym_list env es t : (Il.quant list * Il.sym list) attempt =
  match es with
  | [] -> Ok ([], [])
  | g::gs ->
    let* qs1, g' = elab_sym env g t in
    let* qs2, gs' = elab_sym_list env gs t in
    Ok (qs1 @ qs2, g'::gs')

and cast_sym env g' t1 t2 : (Il.quant list * Il.sym) attempt =
  Debug.(log_at "el.elab_cast_sym" g'.at
    (fun _ -> fmt "%s : %s :> %s" (il_sym g') (il_typ t1) (il_typ t2))
    (function Ok (qs, g'') -> fmt "%s%s" (il_quants qs) (il_sym g'') | _ -> "fail")
  ) @@ fun _ ->
  nest g'.at t2 (
    if equiv_typ env t1 t2 then
      Ok ([], g')
    else if equiv_typ env t2 (Il.TupT [] $ t2.at) then
      Ok ([], Il.SeqG [g'] $ g'.at)
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
    let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
    let qs1, g', _t = checkpoint (infer_sym env' g) in
    let g' = Dim.annot_sym dims' g' in
    let qs2, e' =
      checkpoint (
        let t_unit = Il.TupT [] $ e.at in
        if equiv_typ env' t t_unit then
          (* Special case: ignore unit attributes *)
          (* TODO(4, rossberg): introduce proper top type? *)
          let* qs, e', _t = infer_exp env' e in
          Ok (qs, Il.ProjE (
            Il.TupE [
              e'; Il.TupE [] $$ e.at % t_unit
            ] $$ e.at % (Il.TupT ["_" $ e.at, e'.note; "_" $ e.at, t_unit] $ e.at), 1
          ) $$ e.at % t'_unit)
        else
          elab_exp env' e t
      )
    in
    let e' = Dim.annot_exp dims' e' in
    let qss3, premss' = List.split (map_filter_nl_list (elab_prem env') prems) in
    let prems' = List.map (Dim.annot_prem dims') (List.concat premss') in
    let det = Free.(diff (union (det_sym g) (det_prems prems)) (bound_env env)) in
    let free = Free.(diff (free_prod prod) (union (det_prod prod) (bound_env env'))) in
    if free <> Free.empty then
      error prod.at ("grammar rule contains indeterminate variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
    let acc_qs, (module Arg : Iter.Arg) = make_quants_iter_arg env' det dims in
    let module Acc = Iter.Make(Arg) in
    Acc.sym g;
    Acc.exp e;
    Acc.prems prems;
    let prod' = Il.ProdD (!acc_qs @ qs1 @ qs2 @ List.concat qss3, g', e', prems') $ prod.at in
    if not env'.pm then
      [prod']
    else
      prod' :: elab_prod env Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t
  | RangeP (g1, e1, g2, e2) ->
    let t = Il.NumT `NatT $ prod.at in
    let qs11', g1' = checkpoint (elab_sym env g1 t) in
    let qs12', e1' = checkpoint (elab_exp env e1 t) in
    let qs21', g2' = checkpoint (elab_sym env g2 t) in
    let qs22', e2' = checkpoint (elab_exp env e2 t) in
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
      Il.ProdD (qs11' @ qs12' @ qs21' @ qs22', g', e', []) $ prod.at
    )
  | EquivP (g1, g2, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_prod (vars env) prod in
    let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
    let qs1, g1', _t1 = checkpoint (infer_sym env' g1) in
    let g1' = Dim.annot_sym dims' g1' in
    let qs2, g2', _t2 = checkpoint (infer_sym env' g2) in
    let g2' = Dim.annot_sym dims' g2' in
    let qss3, premss' = List.split (map_filter_nl_list (elab_prem env') prems) in
    let prems' = List.map (Dim.annot_prem dims') (List.concat premss') in
    let det = Free.(diff (union (det_sym g1) (det_prems prems)) (bound_env env)) in
    let free = Free.(diff (free_prod prod) (union (det_prod prod) (bound_env env'))) in
    if free <> Free.empty then
      error prod.at ("grammar rule contains indeterminate variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free.varid) ^ "`");
    let acc_qs, (module Arg : Iter.Arg) = make_quants_iter_arg env' det dims in
    let module Acc = Iter.Make(Arg) in
    Acc.sym g1;
    Acc.sym g2;
    Acc.prems prems;
    ignore (!acc_qs @ qs1 @ qs2 @ List.concat qss3, g1', g2', prems');
    []  (* TODO(4, rossberg): translate equiv grammars properly *)
(*
    let prod' = Il.ProdD (!acc_qs, g1', e', prems') $ prod.at in
    if not env'.pm then
      [prod']
    else
      prod' :: elab_prod env Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t
*)

and elab_gram env gram t : Il.prod list =
  let (_dots1, prods, _dots2) = gram.it in
  concat_map_filter_nl_list (fun prod -> elab_prod env prod t) prods


(* Definitions *)

and make_quants_iter_arg env free dims : Il.quant list ref * (module Iter.Arg) =
  let module Arg =
    struct
      include Iter.Skip

      let left = ref free
      let acc = ref []

      let visit_typid id =
        if Free.Set.mem id.it !left.typid then (
          acc := !acc @ [Il.TypP id $ id.at];
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
          acc := !acc @ [Il.ExpP (Dim.annot_varid id ctx', t') $ id.at];
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
          acc := !acc @ [Il.DefP (id, ps', t') $ id.at];
          left := Free.{!left with defid = Set.remove id.it !left.defid};
        )
    end
  in Arg.acc, (module Arg)

and elab_arg in_lhs env a p s : Il.quant list * Il.arg list * Subst.subst =
  (match !(a.it), p.it with  (* HACK: handle shorthands *)
  | ExpA e, TypP _ -> a.it := TypA (typ_of_exp e)
  | ExpA e, GramP _ -> a.it := GramA (sym_of_exp e)
  | ExpA {it = CallE (id, []); _}, DefP _ -> a.it := DefA id
  | _, _ -> ()
  );
  match !(a.it), (Subst.subst_param s p).it with
  | ExpA e, ExpP (id, t) ->
    let qs, e' = checkpoint (elab_exp env e t) in
    qs, [Il.ExpA e' $ a.at], Subst.add_varid s id e
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
    [], [Il.TypA (Il.VarT (id'', []) $ t.at) $ a.at], Subst.add_typid s id t
  | TypA t, TypP _ when in_lhs = `Lhs ->
    error t.at "misplaced syntax type"
  | TypA t, TypP id ->
    let t' = elab_typ env t in
    [], [Il.TypA t' $ a.at], Subst.add_typid s id t
  | GramA g, GramP _ when in_lhs = `Lhs ->
    error g.at "misplaced grammar symbol"
  | GramA g, GramP (id', t) ->
    let qs, g', t' = checkpoint (infer_sym env g) in
    let s' = subst_implicit env s t t' in
    if not (equiv_typ env t' (Subst.subst_typ s' t)) then
      error_typ2 env a.at "argument" t' t "";
    let as' = List.map (fun (_id, t) -> Il.TypA (elab_typ env t) $ t.at) Subst.(Map.bindings s'.typid) in
    qs, as' @ [Il.GramA g' $ a.at], Subst.add_gramid s' id' g
  | DefA id, DefP (id', ps', t') when in_lhs = `Lhs ->
    env.defs <- bind "definition" env.defs id (ps', t', []);
    [], [Il.DefA id $ a.at], Subst.add_defid s id' id
  | DefA id, DefP (id', ps', t') ->
    let ps, t, _ = find "definition" env.defs id in
    if not (Eval.equiv_functyp (to_eval_env env) (ps, t) (ps', t')) then
      error a.at ("type mismatch in function argument, expected `" ^
        (spaceid "definition" id').it ^ Print.(string_of_params ps' ^ " : " ^ string_of_typ ~short:true t') ^
        "` but got `" ^
        (spaceid "definition" id).it ^ Print.(string_of_params ps ^ " : " ^ string_of_typ ~short:true t ^ "`")
      );
    [], [Il.DefA id $ a.at], Subst.add_defid s id id'
  | _, _ ->
    error a.at "sort mismatch for argument"

and elab_args in_lhs env as_ ps at : Il.quant list * Il.arg list * Il.Subst.subst =
  Debug.(log_at "el.elab_args" at
    (fun _ -> fmt "(%s) : (%s)" (list el_arg as_) (list el_param ps))
    (fun (qs, as', _) -> fmt "%s(%s)" (il_quants qs) (list il_arg as'))
  ) @@ fun _ ->
  elab_args' in_lhs env as_ ps [] [] Subst.empty at

and elab_args' in_lhs env as_ ps qs as' s at : Il.quant list * Il.arg list * Il.Subst.subst =
  match as_, ps with
  | [], [] -> qs, List.concat (List.rev as'), s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as1, p::ps1 ->
    let qs', a', s' = elab_arg in_lhs env a p s in
    elab_args' in_lhs env as1 ps1 (qs @ qs') (a'::as') s' at

and subst_implicit env s t t' : Il.Subst.subst =
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
  | StrT (d1, ts, tfs, d2) ->
    StrT (d1, ts, Convert.map_nl_list (fun (a, (t, p), h) ->
      a, (infer_typ_notation env is_con t, p), h) tfs, d2)
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
        match t.it with
        | CaseT (Dots, _, _, _) | StrT (Dots, _, _, _) -> true
        | _ -> false
      in
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
    [Il.HintD (Il.TypH (id1, elab_hints id1 "" hints) $ hd.at) $ hd.at]
  | RelH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RelH (id, elab_hints id "" hints) $ hd.at) $ hd.at]
  | DecH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.DecH (id, elab_hints id "" hints) $ hd.at) $ hd.at]
  | AtomH (id, atom, _hints) ->
    let _ = elab_atom atom id in []
  | GramH _ | VarH _ ->
    []


let infer_quants env env' dims d : Il.quant list =
  Debug.(log_in_at "el.infer_quants" d.at
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
  let acc_qs, (module Arg : Iter.Arg) = make_quants_iter_arg env' det dims in
  let module Acc = Iter.Make(Arg) in
  Acc.def d;
  !acc_qs

let infer_no_quants env dims d =
  let qs = infer_quants env env dims d in
  assert (qs = [])


let rec elab_def env d : Il.def list =
  Debug.(log_in "el.elab_def" line);
  Debug.(log_in_at "el.elab_def" d.at (fun _ -> el_def d));
  match d.it with
  | FamD (id, ps, hints) ->
    env.pm <- false;
    let ps' = elab_params (local_env env) ps in
    if env.pm then error d.at "misplaced +- or -+ operator in syntax type declaration";
    let dims = Dim.check_def d in
    infer_no_quants env dims d;
    env.typs <- rebind "syntax type" env.typs id (ps, Family []);
    [Il.TypD (id, ps', []) $ d.at]
      @ elab_hintdef env (TypH (id, "" $ id.at, hints) $ d.at)
  | TypD (id1, id2, as_, t, hints) ->
    let env' = local_env env in
    env'.pm <- false;
    let ps1, k1 = find "syntax type" env.typs id1 in
    let qs1, as', _s = elab_args `Lhs env' as_ ps1 d.at in
    let dt' = elab_typ_definition env' id1 t in
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
    let qs = infer_quants env env' dims d in
    let inst' = Il.InstD (qs @ qs1, List.map (Dim.annot_arg dims') as', dt') $ d.at in
    let k1', closed =
      match k1, t.it with
      | Opaque, (CaseT (Dots, _, _, _) | StrT (Dots, _, _, _)) ->
        error_id id1 "extension of not yet defined syntax type"
      | Opaque, (CaseT (NoDots, _, _, dots2) | StrT (NoDots, _, _, dots2)) ->
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
      | Defined ({it = StrT (dots1, ts1, tfs1, Dots); at; _}, ids, _),
          StrT (Dots, ts2, tfs2, dots2) ->
        let ps = List.map Convert.param_of_arg as_ in
        if List.exists (fun id -> id.it = id2.it) ids then
          error d.at ("duplicate syntax fragment name `" ^ id1.it ^
            (if id2.it = "" then "" else "/" ^ id2.it) ^ "`");
        if not Eq.(eq_list eq_param ps ps1) then
          error d.at "syntax parameters differ from previous fragment";
        let t1 = StrT (dots1, ts1 @ ts2, tfs1 @ tfs2, dots2) $ over_region [at; t.at] in
        Defined (t1, id2::ids, dt'), dots2 = NoDots
      | Defined _, (CaseT (Dots, _, _, _) | StrT (Dots, _, _, _)) ->
        error_id id1 "extension of non-extensible syntax type"
      | Defined _, _ ->
        error_id id1 "duplicate declaration for syntax type";
      | Family _, (CaseT (dots1, _, _, dots2) | StrT (dots1, _, _, dots2))
        when dots1 = Dots || dots2 = Dots ->
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
    infer_no_quants env' dims d;
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
    infer_no_quants env dims d;
    env.rels <- bind "relation" env.rels id (t, []);
    [Il.RelD (id, mixop, tup_typ' ts' t.at, []) $ d.at]
      @ elab_hintdef env (RelH (id, hints) $ d.at)
  | RuleD (id1, id2, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
    let t, rules' = find "relation" env.rels id1 in
    if List.exists (fun (id, _) -> id.it = id2.it) rules' then
      error d.at ("duplicate rule name `" ^ id1.it ^
        (if id2.it = "" then "" else "/" ^ id2.it) ^ "`");
    let mixop, _, _ = elab_typ_notation env id1 t in
    let qs1, es', _ = checkpoint (elab_exp_notation' env' id1 e t) in
    let es' = List.map (Dim.annot_exp dims') es' in
    let qss2, premss' = List.split (map_filter_nl_list (elab_prem env') prems) in
    let prems' = List.map (Dim.annot_prem dims') (List.concat premss') in
    let qs = infer_quants env env' dims d in
    let rule' = Il.RuleD (id2, qs @ qs1 @ List.concat qss2, mixop, tup_exp' es' e.at, prems') $ d.at in
    env.rels <- rebind "relation" env.rels id1 (t, rules' @ [id2, rule']);
    if not env'.pm then [] else elab_def env Subst.(subst_def pm_snd (Iter.clone_def d))
  | VarD (id, t, _hints) ->
    env.pm <- false;
    let _t' = elab_typ env t in
    if env.pm then error d.at "misplaced +- or -+ operator in variable declaration";
    let dims = Dim.check_def d in
    infer_no_quants env dims d;
    env.gvars <- rebind "variable" env.gvars id t;
    []
  | DecD (id, ps, t, hints) ->
    let env' = local_env env in
    env'.pm <- false;
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    if env'.pm then error d.at "misplaced +- or -+ operator in declaration";
    let dims = Dim.check_def d in
    infer_no_quants env dims d;
    env.defs <- bind "definition" env.defs id (ps, t, []);
    [Il.DecD (id, ps', t', []) $ d.at]
      @ elab_hintdef env (DecH (id, hints) $ d.at)
  | DefD (id, as_, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let dims = Dim.check_def d in
    let dims' = Dim.Env.map (List.map (elab_typiter env')) dims in
    let ps, t, clauses' = find "definition" env.defs id in
    let qs1, as', s = elab_args `Lhs env' as_ ps d.at in
    let as' = List.map (Dim.annot_arg dims') as' in
    let qss2, premss' = List.split (map_filter_nl_list (elab_prem env') prems) in
    let prems' = List.map (Dim.annot_prem dims') (List.concat premss') in
    let qs3, e' = checkpoint (elab_exp env' e (Subst.subst_typ s t)) in
    let e' = Dim.annot_exp dims' e' in
    let qs = infer_quants env env' dims d in
    let clause' = Il.DefD (qs @ qs1 @ List.concat qss2 @ qs3, as', e', prems') $ d.at in
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
    | Defined ({it = (CaseT (_, _, _, Dots) | StrT (_, _, _, Dots)); _}, _, _) ->
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
  snd (checkpoint (elab_exp env' e t))

let elab_rel env e id : Il.exp =
  let env' = local_env env in
  match elab_prem env' (RulePr (id, e) $ e.at) with
  | _, [{it = Il.RulePr (_, _, e'); _}] -> e'
  | _ -> assert false
