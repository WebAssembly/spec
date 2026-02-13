open Util
open Source
open El
open Xl
open Ast
open Convert
open Print

module Il = struct include Il include Ast include Print end

module Set = Il.Free.Set
module Map = Map.Make (String)

module Debug = struct include El.Debug include Il.Debug end


(* Errors *)

let lax_num = true

exception Error = Error.Error

let error at msg = Error.error at "type" msg

let error_atom at atom t msg =
  error at (msg ^ " `" ^ string_of_atom atom ^
    "` in type `" ^ Il.string_of_typ t ^ "`")

let error_mixop at mixop t msg =
  error at (msg ^ " `" ^ Il.string_of_mixop mixop ^
    "` in type `" ^ Il.string_of_typ t ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")

let quote s = "`" ^ s ^ "`"


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
  | Il.TupT xts' -> xts'
  | _ -> [("_" $ t'.at, t')]

let tup_typ' ts' at =
  match ts' with
  | [t'] -> t'
  | _ -> Il.TupT (List.map (fun t' -> "_" $ t'.at, t') ts') $ at

let tup_exp' es' at =
  Il.TupE es' $$ (at, tup_typ' (List.map note es') at)

let tup_exp_nary' es' at =
  match es' with
  | [e'] -> e'
  | _ -> tup_exp' es' at

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


(* Environment *)

type notation = (Il.id * Il.typ) Mixop.mixop

type kind =
  | Transp  (* forward alias types or notation types *)
  | Opaque  (* forward structures or variants, type parameter *)
  | Defined of Il.deftyp * id list * dots
  | Family of Il.inst list (* family of types *)

type var_typ = Il.typ
type typ_typ = Il.param list * kind
type gram_typ = Il.param list * Il.typ * (id * Il.prod) list * dots option
type rel_typ = Il.param list * Il.typ * (id * Il.rule) list * Il.mixop * notation
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

let find_field tfs atom at t =
  match List.find_opt (fun (atom', _, _) -> Atom.eq atom' atom) tfs with
  | Some tf -> tf
  | None -> error_atom at atom t "unbound field"

let find_case tcs mixop at t =
  match List.find_opt (fun (mixop', _, _) -> Mixop.eq mixop' mixop) tcs with
  | Some tc -> tc
  | None -> error_mixop at mixop t "unknown case"

let find_case_atom tcs atom at t =
  match List.find_opt
    (fun (mixop, _, _) ->
      match Mixop.head mixop with
      | Some atom' -> Atom.(eq atom' atom || sub atom' atom)
      | None -> false
    ) tcs
  with
  | Some tc -> tc
  | None -> error_atom at atom t "unknown case"

let bound_env' env' = Map.fold (fun id _ s -> Il.Free.Set.add id s) env' Il.Free.Set.empty
let bound_env env =
  Il.Free.{
    varid = bound_env' env.vars;
    typid = bound_env' env.typs;
    relid = bound_env' env.rels;
    defid = bound_env' env.defs;
    gramid = bound_env' env.grams;
  }


let il_arg_of_param p =
  (match p.it with
  | Il.ExpP (id, t) -> Il.ExpA (Il.VarE id $$ id.at % t)
  | Il.TypP id -> Il.TypA (Il.VarT (id, []) $ id.at)
  | Il.DefP (id, _, _) -> Il.DefA id
  | Il.GramP (id, _, _) -> Il.GramA (Il.VarG (id, []) $ id.at)
  ) $ p.at

let to_il_var (_at, t) = t
let to_il_def (_at, (ps, t, clauses)) = (ps, t, List.map snd clauses)
let to_il_gram (_at, (ps, t, prods, _)) = (ps, t, List.map snd prods)

let to_il_typ (_at, (ps, k)) =
  match k with
  | Opaque | Transp -> ps, []
  | Family insts -> ps, insts
  | Defined (dt, _, _) ->
    ps, [Il.InstD ([], List.map il_arg_of_param ps, dt) $ dt.at]

let to_il_env env =
  (* Need to include gvars, since matching can encounter implicit vars *)
  let gvars = Map.map to_il_var env.gvars in
  let vars = Map.map to_il_var env.vars in
  let typs = Map.map to_il_typ env.typs in
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


(* Quantifiers inference *)

let annot_env env dims =
  let vars =
    Map.fold (fun x (at, t) vars ->
      let x', t' =
        match Map.find_opt x dims with
        | None -> x, t
        | Some (_at, ctx) ->
          (Dim.annot_varid (x $ at) ctx).it,
          List.fold_left (fun t iter ->
            let iter' = match iter with Il.Opt -> Il.Opt | _ -> Il.List in
            Il.IterT (t, iter') $ t.at
          ) t ctx
      in Map.add x' (at, t') vars
    ) env.vars Map.empty
  in {env with vars}

let make_quants_iter_arg env (free : Il.Free.sets) dims : Il.quant list ref * (module Il.Iter.Arg) =
  let module Arg =
    struct
      include Il.Iter.Skip

      type scope = var_typ env'

      let left = ref free  (* free variables not yet quantified *)
      let acc = ref []     (* quantifiers introduced so far *)

      let scope_enter x t =
        let varenv = env.vars in
        if x.it <> "_" then env.vars <- Map.add x.it (x.at, t) env.vars;
        varenv

      let scope_exit _x varenv =
        env.vars <- varenv

      let visit_typid id =
        if Il.Free.Set.mem id.it !left.typid then (
          acc := !acc @ [Il.TypP id $ id.at];
          left := Il.Free.{!left with typid = Set.remove id.it !left.typid};
        )

      let visit_varid id =
        if Il.Free.(Set.mem id.it !left.varid) then (
          let t =
            try find "variable" env.vars id with Error _ ->
              find "variable" env.gvars (strip_var_suffix id)
          in
          (* Raise variable type to its inferred dimension *)
          let ctx' =
            match Map.find_opt id.it dims with
            | None -> []  (* for inherited variables *)
            | Some (_, ctx) -> List.map Il.(function Opt -> Opt | _ -> List) ctx
          in
          let t' =
            List.fold_left (fun t iter -> Il.IterT (t, iter) $ t.at) t ctx' in
          acc := !acc @ [Il.ExpP (Dim.annot_varid id ctx', t') $ id.at];
          left := Il.Free.{!left with varid = Set.remove id.it !left.varid};
        )

      let visit_gramid id =
        if Il.Free.(Set.mem id.it !left.gramid) then (
          let ps, t, _gram, _prods' = find "grammar" env.grams id in
          acc := !acc @ [Il.GramP (id, ps, t) $ id.at];
          left := Il.Free.{!left with varid = Set.remove id.it !left.gramid};
        )

      let visit_defid id =
        if Il.Free.Set.mem id.it !left.defid then (
          let ps, t, _ = find "definition" env.defs id in
          acc := !acc @ [Il.DefP (id, ps, t) $ id.at];
          left := Il.Free.{!left with defid = Set.remove id.it !left.defid};
        )
    end
  in Arg.acc, (module Arg)

let infer_quants env env' dims det ps' as' ts' es' gs' prs' at : Il.quant list =
  let env' = annot_env env' dims in
  Debug.(log_at "il.infer_quants" at
    (fun _ ->
      "\n  ps'=[" ^ list il_param ps' ^ "]" ^
      "\n  as'=[" ^ list il_arg as' ^ "]" ^
      "\n  ts'=[" ^ list il_typ ts' ^ "]" ^
      "\n  es'=[" ^ list il_exp es' ^ "]" ^
      "\n  gs'=[" ^ list il_sym gs' ^ "]" ^
      "\n  prs'=[" ^ list il_prem prs' ^ "]" ^
      "\n  locals=" ^
      (Map.fold (fun id _ ids ->
        if Map.mem id env.vars then ids else id::ids
      ) env'.vars [] |> List.rev |> String.concat " ") ^
      "\n  dims=" ^
      (Map.fold (fun id (_, ctx) ids ->
        (id ^ ":" ^ String.concat "" (List.map Il.Print.string_of_iter ctx)) :: ids
      ) dims [] |> List.rev |> String.concat " ") ^
      "\n  dets=" ^
      (Set.elements det.Det.varid |> String.concat " ")
    )
    (fun qs -> fmt "\n... %s" (il_quants qs))
  ) @@ fun _ ->

  (* Check that everything is determined (this is an approximation!) *)
  let bound = bound_env env in
  let free = Il.Free.(
      free_list free_param ps' ++
      free_list free_arg as' ++
      free_list free_typ ts' ++
      free_list free_exp es' ++
      free_list free_sym gs' ++
      free_list free_prem prs'
      -- bound -- bound_list bound_param ps' -- det
    )
  in
  if free <> Il.Free.empty then
    error at ("definition contains indeterminate variable(s) " ^
      String.concat ", " (List.map quote (Il.Free.Set.elements free.varid)));

  (* Gather quantifiers *)
  let det' = Il.Free.(det -- bound) in
  let acc_qs, (module Arg : Il.Iter.Arg) = make_quants_iter_arg env' det' dims in
  let module Acc = Il.Iter.Make(Arg) in
  Acc.(list param ps');
  Acc.(list arg as');
  Acc.(list typ ts');
  Acc.(list exp es');
  Acc.(list sym gs');
  Acc.(list prem prs');

  (* Order quantifiers for dependencies by simple fixpoint iteration *)
  let qsf = List.map Il.Free.(fun q -> q, bound_quant q, free_quant q) !acc_qs in
  let rec iterate bound_ok ok qfs defer progress =
    match qfs with
    | (q, bound, free)::qfs when Il.Free.subset free bound_ok ->
      iterate Il.Free.(bound_ok ++ bound) (q::ok) qfs defer true
    | qf1::qfs -> iterate bound_ok ok qfs (qf1::defer) progress
    | [] ->
      match defer with
      | [] -> List.rev ok
      | _ when progress -> iterate bound_ok ok (List.rev defer) [] false
      | (q, _, free)::_ ->
        let fwd = Il.Free.(free -- bound_ok) in
        error q.at ("the type of `" ^ Il.Print.string_of_quant q ^ "` depends on " ^
          ( Il.Free.Set.(elements fwd.typid @ elements fwd.gramid @ elements fwd.varid @ elements fwd.defid) |>
            List.map (fun id -> "`" ^ id ^ "`") |>
            String.concat ", " ) ^
          ", which only occur(s) to its right; " ^
          "try to reorder parameters or premises or introduce an extra parameter")
  in
  iterate bound [] qsf [] false

let infer_no_quants env dims det ps' as' ts' es' gs' prs' at =
  let qs = infer_quants env env dims det ps' as' ts' es' gs' prs' at in
  if qs <> [] then
    let bound = Il.Free.bound_quants qs in
    error at ("definition contains free variable(s) " ^
      String.concat ", " (List.map quote (Il.Free.Set.elements bound.varid)))


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

let nest at t r =  (* nest parsing error trace *)
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

let fail_mixop at mixop t msg =
  fail at (msg ^ " `" ^ Il.string_of_mixop mixop ^ "` in type `" ^ Il.string_of_typ t ^ "`")

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
  phrase ^ " does not match notation " ^ Mixop.to_string not

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

(* TODO(2, rossberg): avoid repeated env conversion *)
let reduce env t : Il.typ = Il.Eval.reduce_typ (to_il_env env) t
let expand env t : Il.typ' = (reduce env t).it

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
  | Il.VarT (x, as') ->
    let x' = strip_var_suffix x in
    (match find "syntax type" env.typs x' with
    | ps, Defined ({it = Il.VariantT [tc]; _}, _, _) ->
      let as_ = List.map il_arg_of_param ps in
      Il.Eval.(match_list match_arg (to_il_env env) Il.Subst.empty as' as_) |>
        Option.map (fun s ->
          let mixop, (t, _qs, _prems), _ = Il.Subst.subst_typcase s tc in
          t, mixop, Mixop.apply mixop (untup_typ' t)
        )
    | _, _ -> None
    )
  | _ -> None

let expand_id env t =
  match expand env t with
  | Il.VarT (id, _) -> id
  | _ -> "" $ no_region


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

let as_empty_notation_typ_opt env t : unit option =
  match expand_notation env t with
  | Some (_, _, Seq []) -> Some ()
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
    iter_attempt (fun (_, (t, _, _), _) -> as_cat_typ phrase env dir t at) tfs
  | _ ->
    fail at (phrase ^ "'s type " ^ typ_string env t ^ " is not concatenable")

let as_notation_typ phrase env dir t at : (Il.typ * _ Mixop.mixop * notation) attempt =
  match expand_notation env t with
  | Some not -> Ok not
  | _ -> fail_dir_typ env at phrase dir t "_ ... _"

let is_x_typ as_x_typ env t =
  match as_x_typ "" env Check t no_region with
  | Ok _ -> true
  | Fail _ -> false

let is_nat_typ = is_x_typ as_nat_typ
let is_iter_typ = is_x_typ as_iter_typ
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

let elab_atom atom tid =
  assert (valid_tid tid);
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
  Debug.(log "el.infer_binop"
    (fun _ -> fmt "%s : %s" (el_binop op) (il_typ t1))
    (function Ok _ -> "true" | _ -> "false")
  ) @@ fun _ ->
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


let check_atoms phrase item to_atom list at =
  let _, dups =
    List.fold_right (fun (op, _, _) (set, dups) ->
      let s = Print.string_of_atom (to_atom op) in
      if Set.mem s set then (set, s::dups) else (Set.add s set, dups)
    ) list (Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) " ^
      String.concat ", " (List.map quote dups))


(* Iteration *)

let rec elab_iter env (it : iter) : Il.iter =
  match it with
  | Opt -> Il.Opt
  | List -> Il.List
  | List1 -> Il.List1
  | ListN (e, xo) ->
    Option.iter (fun x ->
      let t = Il.NumT `NatT $ x.at in
      let e' = checkpoint (elab_exp env (VarE (x, []) $ x.at) t) in
      match e'.it with
      | Il.VarE _ -> ()
      | _ -> error_typ env x.at "iteration variable" t
    ) xo;
    let e' = checkpoint (elab_exp env e (Il.NumT `NatT $ e.at)) in
    Il.ListN (e', xo)

and elab_itertyp env (it : iter) : Il.iter =
  let it =
    match it with
    | List1 | ListN _ -> List
    | _ -> it
  in
  elab_iter env it

and elab_iterexp : 'a 'b. env -> (env -> 'a -> 'b attempt) -> 'a -> iter -> Source.region -> ('b * Il.iterexp * Il.iter) attempt =
  fun env f body (it : iter) at ->
  let it'' = match it with Opt -> Il.Opt | _ -> Il.List in
  nest at (Il.IterT (Il.TupT [] $ at, it'') $ at) (
    let xo = match it with ListN (_, xo) -> xo | _ -> None in
    let to_ = Option.join (Option.map (fun x -> Map.find_opt x.it env.vars) xo) in
    let it' = elab_iter env it in
    let* body' = f env body in
    (* Remove local and restore outer if present *)
    Option.iter (fun x ->
      env.vars <-
        match to_ with
        | None -> Map.remove x.it env.vars
        | Some t -> Map.add x.it t env.vars
    ) xo;
    (* Iterator list is injected after dimension analysis, leave it empty here *)
    Ok (body', (it', []), match it with Opt -> Il.Opt | _ -> Il.List)
  )


(* Types *)

and elab_typ env ?(fwd = true) (t : typ) : Il.typ =
  match t.it with
  | VarT (x, as_) ->
    let x' = strip_var_suffix x in
    if x'.it <> x.it && as_ = [] then
      elab_typ env (Convert.typ_of_varid x')
    else
      let ps, k = find "syntax type" env.typs x' in
      if not fwd && k = Transp then
        error_id x "invalid forward reference to syntax type";
      let as', _s = elab_args `Rhs env as_ ps t.at in
      Il.VarT (x', as') $ t.at
  | BoolT -> Il.BoolT $ t.at
  | NumT t' -> Il.NumT t' $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT {it = SeqT []; _} -> Il.TupT [] $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> tup_typ' (List.map (elab_typ env) ts) t.at
  | IterT (t1, iter) ->
    let iter' = elab_itertyp env iter in
    let t1' = elab_typ env t1 in
    Il.IterT (t1', iter') $ t.at
  | StrT _ | CaseT _ | ConT _ | RangeT _
  | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    error t.at "this type is only allowed in type definitions"

and elab_typ_definition env outer_dims tid (t : typ) : dots * Il.deftyp * dots =
  Debug.(log_at "el.elab_typ_definition" t.at
    (fun _ -> fmt "%s = %s" tid.it (el_typ t))
    (fun (_, dt, _) -> il_deftyp dt)
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
      tfs1
    in
    let tfs2 =
      concat_map_filter_nl_list (fun t ->
        let t' = elab_typ env t in
        let tfs, dots = checkpoint (as_struct_typ "parent type" env Infer t' t'.at) in
        if dots = Dots then
          error t.at "inclusion of incomplete syntax type";
        tfs
      ) ts
    in
    let tfs' = tfs1 @ tfs2 @ map_filter_nl_list (elab_typfield env outer_dims tid t.at) tfs in
    check_atoms "record" "field" Fun.id tfs' t.at;
    dots1, Il.StructT tfs' $ t.at, dots2
  | CaseT (dots1, ts, tcs, dots2) ->
    let tcs1 =
      if dots1 = NoDots then [] else
      let t1 = Il.VarT (tid, []) $ tid.at in
      if not (bound env.typs tid) then
        error t.at "extension of previously undefined syntax type";
      let tcs1, dots = checkpoint (as_variant_typ "own type" env Check t1 t1.at) in
      if dots = NoDots then
        error t.at "extension of non-extensible syntax type";
      tcs1
    in
    let tcs2 =
      concat_map_filter_nl_list (fun t ->
        let t' = elab_typ env t in
        let tcs, dots = checkpoint (as_variant_typ "parent type" env Infer t' t'.at) in
        if dots = Dots then
          error t.at "inclusion of incomplete syntax type";
        tcs
      ) ts
    in
    let tcs' = tcs1 @ tcs2 @ map_filter_nl_list (elab_typcase env outer_dims tid t.at) tcs in
    check_atoms "variant" "case" (fun op -> Option.get (Mixop.head op)) tcs' t.at;
    dots1, Il.VariantT tcs' $ t.at, dots2
  | ConT tc ->
    let tc' = elab_typcon env outer_dims tid t.at tc in
    NoDots, Il.VariantT [tc'] $ t.at, NoDots
  | RangeT tes ->
    let ts_fes' = map_filter_nl_list (elab_typenum env outer_dims tid) tes in
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
    let prems' = [Il.IfPr (fe' eid' nt) $ t.at] in
    let tc' = (Mixop.Arg (), (Il.TupT [(x, t')] $ t.at, [], prems'), []) in
    NoDots, Il.VariantT [tc'] $ t.at, NoDots
  | _ ->
    let t' = elab_typ env t in
    NoDots, Il.AliasT t' $ t.at, NoDots

and typ_rep env t : Il.typ =
  Debug.(log_at "el.typ_rep" t.at
    (fun _ -> fmt "%s" (il_typ t))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match expand env t with
  | Il.VarT _ as t' ->
    (match expand_def env (t' $ t.at) with
    | Il.VariantT [_, (t1, _, _), _], NoDots -> typ_rep env t1
    | _ -> t' $ t.at
    )
  | Il.TupT [_, t1] -> typ_rep env t1
  | t' -> t' $ t.at

and elab_typfield env outer_dims tid at (tf : typfield) : Il.typfield =
  let atom, (t, prems), hints = tf in
  let _mixop, t', qs, prems' = elab_typ_notation env outer_dims tid at t prems in
  let hints' = elab_hints tid "" hints in
  let t'' =
    match t'.it with
    | Il.TupT [(_, t1')] when prems' = [] -> t1'
    | _ -> t'
  in
  (elab_atom atom tid, (t'', qs, prems'), hints')

and elab_typcase env outer_dims tid at (tc : typcase) : Il.typcase =
  let _atom, (t, prems), hints = tc in
  let mixop, t', qs, prems' = elab_typ_notation env outer_dims tid at t prems in
  let hints' = elab_hints tid "" hints in
  (mixop, (t', qs, prems'), hints')

and elab_typcon env outer_dims tid at (tc : typcon) : Il.typcase =
  let (t, prems), hints = tc in
  let mixop, t', qs, prems' = elab_typ_notation env outer_dims tid at t prems in
  let hints' = elab_hints tid tid.it hints in
  (mixop, (t', qs, prems'), hints')

and elab_typenum env outer_dims tid (te : typenum) : Il.typ * (Il.exp -> numtyp -> Il.exp) =
  assert (valid_tid tid);
  let e1, e2o = te in
  let _e1' = elab_exp env e1 (Il.NumT `IntT $ e1.at) in (* ensure it's <= int *)
  let _, t1 = checkpoint (infer_exp env e1) in (* get precise type *)
  match e2o with
  | None ->
    t1,
    fun eid' nt ->
    let e1' = checkpoint (elab_exp env e1 (Il.NumT nt $ e1.at)) in  (* redo with overall type *)
    let dims = Dim.check outer_dims [] [] [] [e1'] [] [] in
    let e1' = Dim.annot_exp dims e1' in
    infer_no_quants env dims Det.empty [] [] [] [e1'] [] [] e1.at;
    Il.(CmpE (`EqOp, `BoolT, eid', e1') $$ e1'.at % (Il.BoolT $ e1.at))
  | Some e2 ->
    let at = Source.over_region [e1.at; e2.at] in
    let _e2' = checkpoint (elab_exp env e2 (Il.NumT `IntT $ e2.at)) in
    let _, t2 = checkpoint (infer_exp env e2) in
    (if narrow_typ env t2 t1 then t1 else t2).it $ at,
    fun eid' nt ->
    let e1' = checkpoint (elab_exp env e1 (Il.NumT nt $ e1.at)) in
    let e2' = checkpoint (elab_exp env e2 (Il.NumT nt $ e2.at)) in
    let dims = Dim.check outer_dims [] [] [] [e1'; e2'] [] [] in
    let e1' = Dim.annot_exp dims e1' in
    let e2' = Dim.annot_exp dims e2' in
    infer_no_quants env dims Det.empty [] [] [] [e1'; e2'] [] [] at;
    Il.(BinE (`AndOp, `BoolT,
      CmpE (`GeOp, (nt :> Il.optyp), eid', e1') $$ e1'.at % (Il.BoolT $ e1.at),
      CmpE (`LeOp, (nt :> Il.optyp), eid', e2') $$ e2'.at % (Il.BoolT $ e2.at)
    ) $$ at % (Il.BoolT $ at))


and elab_typ_notation env outer_dims tid at (t : typ) (prems : prem nl_list) :
    Il.mixop * Il.typ * Il.quant list * Il.prem list =
  assert (valid_tid tid);
  let env1 = local_env env in
  let mixop, xts' = elab_typ_notation' env1 tid t in
  let xs', ts' = List.split xts' in
  let dims1 = Dim.check outer_dims [] [] ts' [] [] [] in
  let ts' = List.map (Dim.annot_typ dims1) ts' in
  let t' = Il.TupT (List.combine xs' ts') $ t.at in
  let det1 = Det.det_typ t' in
  infer_no_quants env dims1 det1 [] [] [t'] [] [] [] at;

  let env2 = local_env env1 in
  let prems' = List.concat (map_filter_nl_list (elab_prem env2) prems) in
  let dims2 = Dim.check (Dim.union outer_dims dims1) [] [] [] [] [] prems' in
  let prems' = List.map (Dim.annot_prem dims2) prems' in
  let det2 = Det.(det_list det_prem prems') in
  let qs = infer_quants env1 env2 dims2 det2 [] [] [] [] [] prems' at in
  mixop, t', qs, prems'

and elab_typ_notation' env tid (t : typ) : Il.mixop * (Il.id * Il.typ) list =
  Debug.(log_at "el.elab_typ_notation" t.at
    (fun _ -> fmt "(%s) %s" tid.it (el_typ t))
    (fun (mixop, xts') -> fmt "%s(%s)" (il_mixop mixop) (list (pair il_id ":" il_typ) xts'))
  ) @@ fun _ ->
  assert (valid_tid tid);
  match t.it with
  | AtomT atom ->
    let atom' = elab_atom atom tid in
    Atom atom', []
  | SeqT [] ->
    Seq [], []
  | SeqT (t1::ts2) ->
    let mixop1, xts1' = elab_typ_notation' env tid t1 in
    let mixop2, xts2' = elab_typ_notation' env tid (SeqT ts2 $ t.at) in
    (match mixop2 with Seq mixops2 -> Seq (mixop1::mixops2) | _ -> assert false),
    xts1' @ xts2'
  | InfixT (t1, atom, t2) ->
    let mixop1, xts1' = elab_typ_notation' env tid t1 in
    let mixop2, xts2' = elab_typ_notation' env tid t2 in
    let atom' = elab_atom atom tid in
    Infix (mixop1, atom', mixop2), xts1' @ xts2'
  | BrackT (l, t1, r) ->
    let mixop1, xts1' = elab_typ_notation' env tid t1 in
    let l' = elab_atom l tid in
    let r' = elab_atom r tid in
    Brack (l', mixop1, r'), xts1'
  | VarT _ | IterT _ | ParenT _ ->
    let rec id_of t ctx =
      match t.it with
      | VarT (x, []) -> Dim.annot_varid x ctx
      | ParenT t1 -> id_of t1 ctx
      | IterT (t1, iter) ->
        let iter' = match iter with Opt -> Il.Opt | _ -> Il.List in
        id_of t1 (iter'::ctx)
      | _ -> "_" $ t.at
    in
    let x' = id_of t [] in
    let t' = elab_typ env t in
    (* Ignore name if already bound. This may happen if the same type name
     * occurs multiple times as a parameter. *)
    if not (bound env.vars x') then env.vars <- bind "variable" env.vars x' t';
    Arg (), [x', t']
  | _ ->
    let t' = elab_typ env t in
    Arg (), ["_" $ t.at, t']


(* Expressions *)

(* Returns
 * - Ok (il_exp, typ) if the type can be inferred
 * - Fail (at, s) when it cannot, where s is the name of the failing construct
 * - raises Error.Error on fatal, unrecoverable errors
 *)
and infer_exp env e : (Il.exp * Il.typ) attempt =
  Debug.(log_at "el.infer_exp" e.at
    (fun _ -> fmt "%s" (el_exp e))
    (function Ok (e', t) -> fmt "%s : %s" (il_exp e') (il_typ t) | _ -> "fail")
  ) @@ fun _ ->
  let* e', t' = infer_exp' env e in
  let t = t' $ e.at in
  Ok (e' $$ e.at % t, t)

and infer_exp' env e : (Il.exp' * Il.typ') attempt =
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
    in Ok (Il.VarE x, t.it)
  | AtomE _ ->
    fail_infer e.at "atom"
  | BoolE b ->
    Ok (Il.BoolE b, Il.BoolT)
  | NumE (_op, n) ->
    Ok (Il.NumE n, Il.NumT (Num.to_typ n))
  | TextE s ->
    Ok (Il.TextE s, Il.TextT)
  | CvtE (e1, nt) ->
    let* e1', t1 = infer_exp env e1 in
    let* nt1 = as_num_typ "conversion" env Infer t1 e1.at in
    let* e1'' = cast_exp "operand" env e1' t1 (Il.NumT nt1 $ e1.at) in
    Ok (Il.CvtE (e1'', nt1, nt), Il.NumT nt)
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
    Ok (Il.BinE (`AndOp, `BoolT, e1', e2'), Il.BoolT)
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
      Ok (Il.CmpE (op', `BoolT, e1', e2'), Il.BoolT)
    | `Over elab_cmpop'  ->
      let* e1', t1 = infer_exp env e1 in
      let* e2', t2 = infer_exp env e2 in
      let* op', ot, t = elab_cmpop' (typ_rep env t1) (typ_rep env t2) e.at in
      let* e1'' = cast_exp "operand" env e1' t1 t in
      let* e2'' = cast_exp "operand" env e2' t2 t in
      Ok (Il.CmpE (op', ot, e1'', e2''), Il.BoolT)
    )
  | IdxE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* t = as_list_typ "expression" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    Ok (Il.IdxE (e1', e2'), t.it)
  | SliceE (e1, e2, e3) ->
    let* e1', t1 = infer_exp env e1 in
    let* _t' = as_list_typ "expression" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    let* e3' = elab_exp env e3 (Il.NumT `NatT $ e3.at) in
    Ok (Il.SliceE (e1', e2', e3'), t1.it)
  | UpdE (e1, p, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* p', t2 = elab_path env p t1 in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.UpdE (e1', p', e2'), t1.it)
  | ExtE (e1, p, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* p', t2 = elab_path env p t1 in
    let* _ = as_list_typ "path" env Infer t2 p.at in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.ExtE (e1', p', e2'), t1.it)
  | StrE _ ->
    fail_infer e.at "record"
  | DotE (e1, atom) ->
    let* e1', t1 = infer_exp env e1 in
    let* tfs, dots = as_struct_typ "expression" env Infer t1 e1.at in
    if dots = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* _, (tF, _qs, prems), _ = attempt (find_field tfs atom e1.at) t1 in
    let e' = Il.DotE (e1', elab_atom atom (expand_id env t1)) in
    let e'' = if prems = [] then e' else Il.ProjE (e' $$ e.at % tF, 0) in
    Ok (e'', tF.it)
  | CommaE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* tfs, dots = as_struct_typ "expression" env Infer t1 e1.at in
    if dots = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* () = as_cat_typ "expression" env Infer t1 e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _ = attempt (find_field tfs atom at) t1 in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t1 in
      Ok (Il.CompE (e2', e1'), t1.it)
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* e1', t1 = infer_exp env e1 in
    let* () = as_cat_typ "operand" env Infer t1 e1.at in
    let* e2' = elab_exp env e2 t1 in
    Ok ((if is_iter_typ env t1 then Il.CatE (e1', e2') else Il.CompE (e1', e2')), t1.it)
  | MemE (e1, e2) ->
    choice env [
      (fun env ->
        let* e1', t1 = infer_exp env e1 in
        let* e2' = elab_exp env e2 (Il.IterT (t1, Il.List) $ e2.at) in
        Ok (Il.MemE (e1', e2'), Il.BoolT)
      );
      (fun env ->
        let* e2', t2 = infer_exp env e2 in
        let* t1 = as_list_typ "operand" env Infer t2 e2.at in
        let* e1' = elab_exp env e1 t1 in
        Ok (Il.MemE (e1', e2'), Il.BoolT)
      );
    ]
  | LenE e1 ->
    let* e1', t1 = infer_exp env e1 in
    let* _t11 = as_list_typ "expression" env Infer t1 e1.at in
    Ok (Il.LenE e1', Il.NumT `NatT)
  | SizeE id ->
    let _ = find "grammar" env.grams id in
    Ok (Il.NumE (`Nat Z.zero), Il.NumT `NatT)
  | ParenE e1 | ArithE e1 ->
    infer_exp' env e1
  | TupE es ->
    let* es', ts = infer_exp_list env es in
    Ok (Il.TupE es', (tup_typ' ts e.at).it)
  | CallE (id, as_) ->
    let ps, t, _ = find "definition" env.defs id in
    let as', s = elab_args `Rhs env as_ ps e.at in
    Ok (Il.CallE (id, as'), (Il.Subst.subst_typ s t).it)
  | EpsE ->
    fail_infer e.at "empty sequence"
  | SeqE [] ->  (* treat as empty tuple, not principal *)
    Ok (Il.TupE [], Il.TupT [])
  | SeqE es | ListE es ->  (* treat as homogeneous sequence, not principal *)
    let* es', ts = infer_exp_list env es in
    let t = List.hd ts in
    if List.for_all (equiv_typ env t) (List.tl ts) then
      Ok (Il.ListE es', Il.IterT (t, Il.List))
    else
      fail_infer e.at "expression sequence"
  | InfixE _ -> fail_infer e.at "infix expression"
  | BrackE _ -> fail_infer e.at "bracket expression"
  | IterE (e1, it) ->
    let* (e1', t1), ite', itt' = elab_iterexp env infer_exp e1 it e.at in
    Ok (Il.IterE (e1', ite'), Il.IterT (t1, itt'))
  | TypE (e1, t) ->
    let t' = elab_typ env t in
    let* e1' = elab_exp env e1 t' in
    Ok (e1'.it, t'.it)
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


and elab_exp env (e : exp) (t : Il.typ) : Il.exp attempt =
  Debug.(log_at "el.elab_exp" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (il_typ t))
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
            Ok (lift_exp' e' iter $$ e.at % t)
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

and elab_exp_plain env (e : exp) (t : Il.typ) : Il.exp attempt =
  Debug.(log_at "el.elab_exp_plain" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (il_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  let* e' = elab_exp_plain' env e t in
  Ok (e' $$ e.at % t)

and elab_exp_plain' env (e : exp) (t : Il.typ) : Il.exp' attempt =
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
      cast_exp' "character" env e' (Il.NumT `NatT $ e.at) t
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
    let* e2' = elab_exp env e2 (Il.NumT `NatT $ e2.at) in
    let* e3' = elab_exp env e3 (Il.NumT `NatT $ e3.at) in
    Ok (Il.SliceE (e1', e2', e3'))
  | UpdE (e1, p, e2) ->
    let* e1' = elab_exp env e1 t in
    let* p', t2 = elab_path env p t in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.UpdE (e1', p', e2'))
  | ExtE (e1, p, e2) ->
    let* e1' = elab_exp env e1 t in
    let* p', t2 = elab_path env p t in
    let* _ = as_list_typ "path" env Check t2 p.at in
    let* e2' = elab_exp env e2 t2 in
    Ok (Il.ExtE (e1', p', e2'))
  | StrE efs ->
    let* tfs, dots = as_struct_typ "record" env Check t e.at in
    if dots = Dots then
      error e.at "used record type is only partially defined at this point";
    let* efs' = elab_expfields env (expand_id env t) (filter_nl efs) tfs t e.at in
    Ok (Il.StrE efs')
  | CommaE (e1, e2) ->
    let* e1' = elab_exp env e1 t in
    let* tfs, dots1 = as_struct_typ "expression" env Check t e1.at in
    if dots1 = Dots then
      error e1.at "used record type is only partially defined at this point";
    let* () = as_cat_typ "expression" env Check t e.at in
    (* TODO(4, rossberg): this is a bit of a hack, can we avoid it? *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let* _ = attempt (find_field tfs atom at) t in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let* e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t in
      Ok (Il.CompE (e2', e1'))
    | _ -> error e.at "malformed comma operator"
    )
  | CatE (e1, e2) ->
    let* () = as_cat_typ "expression" env Check t e.at in
    let* e1' = elab_exp env e1 t in
    let* e2' = elab_exp env e2 t in
    Ok (if is_iter_typ env t then Il.CatE (e1', e2') else Il.CompE (e1', e2'))
  | ParenE e1 | ArithE e1 ->
    elab_exp_plain' env e1 t
  | TupE es ->
    let* xts = as_tup_typ "tuple" env Check t e.at in
    let* es' = elab_exp_list env es xts e.at in
    Ok (Il.TupE es')
  | ListE es ->
    let* t1, iter = as_iter_typ "list" env Check t e.at in
    if iter <> Il.List then fail_typ env e.at "list" t else
    let xts = List.init (List.length es) (fun _ -> "_" $ t1.at, t1) in
    let* es' = elab_exp_list env es xts e.at in
    Ok (Il.ListE es')
  | SeqE [] when is_empty_notation_typ env t ->
    let* e', t' = infer_exp env e in
    let* e'' = cast_exp' "empty expression" env e' t' t in
    Ok (e'')
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
      let* e' = elab_exp_notation env (expand_id env t) e not t in
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
  | IterE (e1, it2) ->
    let* t1, it = as_iter_typ "iteration" env Check t e.at in
    let* e1', ite2', itt2' = elab_iterexp env
      (fun env (e, t) -> elab_exp env e t) (e1, t1) it2 e.at in
    let e' = Il.IterE (e1', ite2') in
    match it2, it with
    | Opt, Il.Opt -> Ok e'
    | Opt, Il.List ->
      Ok (Il.LiftE (e' $$ e.at % (Il.IterT (t1, itt2') $ e1.at)))
    | _, Il.Opt -> fail_typ env e.at "iteration" t
    | _, _ -> Ok e'

and elab_exp_list env (es : exp list) (xts : (id * Il.typ) list) at
  : Il.exp list attempt =
  match es, xts with
  | [], [] -> Ok []
  | e::es, (_x, t)::xts ->
    let* e' = elab_exp env e t in
    let* es' = elab_exp_list env es xts at in
    Ok (e'::es')
  | _, _ ->
    fail at "arity mismatch for expression list"

and elab_expfields env tid (efs : expfield list) (tfs : Il.typfield list) (t0 : Il.typ) at
  : Il.expfield list attempt =
  Debug.(log_in_at "el.elab_expfields" at
    (fun _ -> fmt "{%s} : {%s} = %s" (list el_expfield efs) (list il_typfield tfs) (il_typ t0))
  );
  assert (valid_tid tid);
  match efs, tfs with
  | [], [] -> Ok []
  | (atom1, e)::efs2, (atom2, (tF, _qs, prems), _)::tfs2 when atom1.it = atom2.it ->
    let* e' = elab_exp env e tF in
    let* efs2' = elab_expfields env tid efs2 tfs2 t0 at in
    let e' = if prems = [] then e' else tup_exp' [e'] e.at in
    Ok ((elab_atom atom1 tid, e') :: efs2')
  | _, (atom, (tF, _qs, prems), _)::tfs2 ->
    let atom' = string_of_atom atom in
    let* e1' = cast_empty ("omitted record field `" ^ atom' ^ "`") env tF at in
    let e' = if prems = [] then e1' else tup_exp' [e1'] at in
    let* efs2' = elab_expfields env tid efs tfs2 t0 at in
    Ok ((elab_atom atom tid, e') :: efs2')
  | (atom, e)::_, [] ->
    fail_atom e.at atom t0 "undefined or misplaced record field"

and elab_exp_iter env (es : exp list) (t1, iter) t at : Il.exp attempt =
  let* e' = elab_exp_iter' env es (t1, iter) t at in
  Ok (e' $$ at % t)

and elab_exp_iter' env (es : exp list) (t1, iter) t at : Il.exp' attempt =
  Debug.(log_at "el.elab_exp_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (il_typ t) (il_typ t1) (il_iter iter))
    (function Ok e' -> fmt "%s" (il_exp (e' $$ at % t)) | _ -> "fail")
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

and elab_exp_notation env tid (e : exp) (t1, mixop, not) t : Il.exp attempt =
  (* Convert notation into applications of mixin operators *)
  assert (valid_tid tid);
  let* es', _s = elab_exp_notation' env tid e not in
  Ok (Il.CaseE (mixop, Il.TupE es' $$ e.at % t1) $$ e.at % t)

and elab_exp_notation' env tid (e : exp) not : (Il.exp list * Il.Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation" e.at
    (fun _ -> fmt "%s : %s" (el_exp e) (Mixop.to_string_with il_typbind " " not))
    (function Ok (es', s) -> fmt "{%s} [%s]" (seq il_exp es') (il_subst s) | _ -> "fail")
  ) @@ fun _ ->
  assert (valid_tid tid);
  match e.it, not with
  | AtomE atom, Atom atom' ->
    if atom.it <> atom'.it then fail_not env e.at "atom" not else
    let _ = elab_atom atom tid in
    Ok ([], Il.Subst.empty)

  | InfixE (e1, atom, e2), Infix (_, atom', _) when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ e2.at) $ e2.at in
    elab_exp_notation' env tid
      (InfixE (e1, atom', SeqE [e21; e2] $ e2.at) $ e.at) not

  | InfixE (e1, atom, e2), Infix (not1, atom', not2) ->
    if atom.it <> atom'.it then fail_not env e.at "infix expression" not else
    let* es1', s1 = elab_exp_notation' env tid e1 not1 in
    let not2' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not2 in
    let* es2', s2 = elab_exp_notation' env tid e2 not2' in
    let _ = elab_atom atom tid in
    Ok (es1' @ es2', Il.Subst.union s1 s2)

  | BrackE (l, e1, r), Brack (l', not1, r') ->
    if (l.it, r.it) <> (l'.it, r'.it) then fail_not env e.at "bracket expression" not else
    let _ = elab_atom l tid in
    let _ = elab_atom r tid in
    elab_exp_notation' env tid e1 not1

  | SeqE [], Seq [] ->
    Ok ([], Il.Subst.empty)

  | _, Seq ((Arg (x1, t1))::nots2) when is_iter_typ env t1 ->
    let* t11, iter = as_iter_typ "iteration" env Check t1 e.at in
    elab_exp_notation_iter env tid (unseq_exp e) (t11, iter) x1 t1 nots2 e.at

  | SeqE ({it = AtomE atom; at; _}::es2), Seq ((Atom atom')::_)
    when Atom.sub atom' atom ->
    let e21 = ParenE (SeqE [] $ at) $ at in
    elab_exp_notation' env tid (SeqE ((AtomE atom' $ at) :: e21 :: es2) $ e.at) not

  (* Trailing notation can be flattened *)
  | SeqE (e1::es2), Seq [Arg (x1, t1) as not1] ->
    choice env [
      (fun env ->
        let* es1', s1 = elab_exp_notation' env tid (unparen_exp e1) not1 in
        let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* es2', s2 = elab_exp_notation' env tid e2 (Seq []) in
        Ok (es1' @ es2', Il.Subst.union s1 s2)
      );
      (fun env ->
        let* e' = elab_exp env e t1 in
        Ok ([e'], Il.Subst.add_varid Il.Subst.empty x1 e')
      )
    ]

  | SeqE (e1::es2), Seq (not1::nots2) ->
    let* es1', s1 = elab_exp_notation' env tid (unparen_exp e1) not1 in
    let e2 = SeqE es2 $ Source.over_region (after_region e1.at :: List.map Source.at es2) in
    let not2 = Mixop.Seq nots2 in
    let not2' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not2 in
    let* es2', s2 = elab_exp_notation' env tid e2 not2' in
    Ok (es1' @ es2', Il.Subst.union s1 s2)

  (* Trailing elements can be omitted if they can be eps *)
  | SeqE [], Seq ((Arg (x1, t1))::nots2) ->
    let* e1' = cast_empty "omitted sequence tail" env t1 e.at in
    let s1 = Il.Subst.add_varid Il.Subst.empty x1 e1' in
    let not2 = Mixop.Seq nots2 in
    let not2' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not2 in
    let* es2', s2 = elab_exp_notation' env tid e not2' in
    Ok (e1' :: es2', Il.Subst.union s1 s2)

  | SeqE (e1::_), Seq [] ->
    fail e1.at "expression is not empty"

  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, Seq _ ->
    elab_exp_notation' env tid (SeqE [e] $ e.at) not

  | _, Arg (x, t) ->
    let* e' = elab_exp env e t in
    Ok ([e'], Il.Subst.add_varid Il.Subst.empty x e')

  | _, (Atom _ | Brack _ | Infix _) ->
    fail e.at "expression does not match expected notation"

and elab_exp_notation_iter env tid (es : exp list) (t1, iter) x t nots at
  : (Il.exp list * Il.Subst.t) attempt =
  assert (valid_tid tid);
  let* e', es', s = elab_exp_notation_iter' env tid es (t1, iter) x t None nots at in
  Ok (e'::es', s)

and elab_exp_notation_iter' env tid (es : exp list) (t1, iter) x t eo' nots at
  : (Il.exp * Il.exp list * Il.Subst.t) attempt =
  Debug.(log_at "el.elab_exp_notation_iter" at
    (fun _ -> fmt "%s : %s = (%s)%s" (seq el_exp es) (il_typ t) (il_typ t1) (il_iter iter))
    (function Ok (e', es', _) -> fmt "%s" (seq il_exp (e'::es')) | _ -> "fail")
  ) @@ fun _ ->
  match es, iter with
  | [], Il.Opt ->
    (* Empty option *)
    assert (eo' = None);
    let e0' = Il.OptE None $$ at % t in
    let s0 = Il.Subst.add_varid Il.Subst.empty x e0' in
    let not = Mixop.Seq nots in
    let not' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s0 t) not in
    let* es', s = elab_exp_notation' env tid (SeqE [] $ at) not' in
    Ok (e0', es', Il.Subst.union s0 s)

  | e1::es2, Il.Opt ->
    assert (eo' = None);
    choice env [
      (fun env ->
        (* Try parsing as empty option *)
        let e0' = Il.OptE None $$ Source.before_region e1.at % t in
        let s0 = Il.Subst.add_varid Il.Subst.empty x e0' in
        let not = Mixop.Seq nots in
        let not' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s0 t) not in
        let* es', s = elab_exp_notation' env tid (SeqE es $ at) not' in
        Ok (e0', es', Il.Subst.union s0 s)
      );
      (fun env ->
        (* Parse as non-empty option *)
        let* e1' = elab_exp env e1 t in
        let s1 = Il.Subst.add_varid Il.Subst.empty x e1' in
        let not = Mixop.Seq nots in
        let not' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* es2', s = elab_exp_notation' env tid (SeqE es2 $ at') not' in
        Ok (e1', es2', Il.Subst.union s1 s)
      );
    ]

  | [], Il.List ->
    (* Empty list *)
    let e' =
      match eo' with
      | Some e0' -> e0'
      | None -> Il.ListE [] $$ at % t
    in
    let s1 = Il.Subst.add_varid Il.Subst.empty x e' in
    let not = Mixop.Seq nots in
    let not' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not in
    let* es', s2 = elab_exp_notation' env tid (SeqE [] $ at) not' in
    Ok (e', es', Il.Subst.union s1 s2)

  | e1::es2, Il.List ->
    choice env [
      (fun env ->
        (* Try parsing as empty list *)
        let e' =
          match eo' with
          | Some e0' -> e0'
          | None -> Il.ListE [] $$ at % t
        in
        let s1 = Il.Subst.add_varid Il.Subst.empty x e' in
        let not = Mixop.Seq nots in
        let not' = Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s1 t) not in
        let* es', s2 = elab_exp_notation' env tid (SeqE es $ at) not' in
        Ok (e', es', Il.Subst.union s1 s2)
      );
      (fun env ->
        (* Try parsing as list element or concatenation *)
        let* e1' = elab_exp env e1 t in
        let e0'' =
          match eo' with
          | None -> e1'
          | Some e0' -> cat_exp' e0' e1' $$ Source.over_region [e0'.at; e1'.at] % t
        in
        let at' = Source.over_region (after_region e1.at :: List.map Source.at es2) in
        let* e', es2', s =
          elab_exp_notation_iter' env tid es2 (t1, iter) x t (Some e0'') nots at' in
        Ok (e', es2', s)
      );
    ]

  | _, Il.(List1 | ListN _) ->
    assert false

and elab_exp_variant env tid (e : exp) (tcs : Il.typcase list) t at : Il.exp attempt =
  Debug.(log_at "el.elab_exp_variant" e.at
    (fun _ -> fmt "%s : %s = %s" (el_exp e) tid.it (il_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  assert (valid_tid tid);
  let rec head e =
    match e.it with
    | AtomE atom
    | InfixE (_, atom, _)
    | BrackE (atom, _, _) -> Ok atom
    | SeqE (e1::es) ->
      (match head e1 with Ok _ as ok -> ok | _ -> head (SeqE es $ e.at))
    | _ -> fail_typ env at "expression" t
  in
  let* atom = head e in
  let* mixop, (tC, _, _), _ = attempt (find_case_atom tcs atom atom.at) t in
  let* xts = as_tup_typ "tuple" env Check tC e.at in
  let not = Mixop.apply mixop xts in
  let* es', _s = elab_exp_notation' env tid e not in
  Ok (Il.CaseE (mixop, tup_exp' es' e.at) $$ at % t)


(*
r[. = e]    ~>  e
r[[i] = e]  ~>  [r0,...,e,...,rN]  if r = [r0,...,rN]
r[.l = e]   ~>  {l0 a0*=r0,...,l a*=e,...,lN aN*=rN}  if r = {l0 a0*=r0,...,lN aN*=rN}
                    a* = q*
*)
and elab_path env (p : path) (t : Il.typ) : (Il.path * Il.typ) attempt =
  let* p', t' = elab_path' env p t in
  Ok (p' $$ p.at % t', t')

and elab_path' env (p : path) (t : Il.typ) : (Il.path' * Il.typ) attempt =
  match p.it with
  | RootP ->
    Ok (Il.RootP, t)
  | IdxP (p1, e1) ->
    let* p1', t1 = elab_path env p1 t in
    let e1' = checkpoint (elab_exp env e1 (Il.NumT `NatT $ e1.at)) in
    let* t' = as_list_typ "path" env Check t1 p1.at in
    Ok (Il.IdxP (p1', e1'), t')
  | SliceP (p1, e1, e2) ->
    let* p1', t1 = elab_path env p1 t in
    let e1' = checkpoint (elab_exp env e1 (Il.NumT `NatT $ e1.at)) in
    let e2' = checkpoint (elab_exp env e2 (Il.NumT `NatT $ e2.at)) in
    let* _ = as_list_typ "path" env Check t1 p1.at in
    Ok (Il.SliceP (p1', e1', e2'), t1)
  | DotP (p1, atom) ->
    let* p1', t1 = elab_path env p1 t in
    let* tfs, dots = as_struct_typ "path" env Check t1 p1.at in
    if dots = Dots then
      error p1.at "used record type is only partially defined at this point";
    let* _, (tF, _, _), _ = attempt (find_field tfs atom p1.at) t1 in
    Ok (Il.DotP (p1', elab_atom atom (expand_id env t1)), tF)


and cast_empty phrase env (t : Il.typ) at : Il.exp attempt =
  Debug.(log_at "el.elab_exp_cast_empty" at
    (fun _ -> fmt "%s  >>  (%s)" (il_typ t) (il_typ t))
    (function Ok e' -> fmt "%s" (il_exp e') | _ -> "fail")
  ) @@ fun _ ->
  nest at t (
    match expand env t with
    | Il.IterT (_, Opt) -> Ok (Il.OptE None $$ at % t)
    | Il.IterT (_, List) -> Ok (Il.ListE [] $$ at % t)
    | VarT _ when is_notation_typ env t ->
      (match expand_notation env t with
      | Some (_, _, Mixop.Seq []) -> Ok (Il.ListE [] $$ at % t)
      | _ -> fail_typ env at phrase t
      )
    | _ -> fail_typ env at phrase t
  )

and cast_exp phrase env (e' : Il.exp) t1 t2 : Il.exp attempt =
  let* e'' = nest e'.at t2 (cast_exp' phrase env e' t1 t2) in
  Ok (e'' $$ e'.at % t2)

and cast_exp' phrase env (e' : Il.exp) t1 t2 : Il.exp' attempt =
  Debug.(log_at "el.elab_exp_cast" e'.at
    (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s)" (il_typ t1) (il_typ t2)
      (il_deftyp (fst (expand_def env t1) $ t1.at))
      (il_deftyp (fst (expand_def env t2) $ t2.at))
      (il_typ (reduce env t2))
    )
    (function Ok e'' -> fmt "%s" (il_exp (e'' $$ e'.at % t2)) | _ -> "fail")
  ) @@ fun _ ->
  if equiv_typ env t1 t2 then Ok e'.it else
  let t1', t2' = reduce env t1, reduce env t2 in
  match t1'.it, t2'.it with
  | _, _ when sub_typ env t1' t2' ->
    Ok (Il.SubE (e', t1', t2'))
  | Il.NumT nt1, Il.NumT nt2 when nt1 < nt2 || lax_num && nt1 <> `RealT ->
    Ok (Il.CvtE (e', nt1, nt2))

  | Il.TupT [], Il.VarT _ when is_empty_notation_typ env t2' ->
    Ok e'.it

  | Il.VarT (x1, _), Il.VarT (x2, _) ->
    (match expand_def env t1', expand_def env t2' with
    | (Il.VariantT [mixop1, (tC1, _, _), _], NoDots),
      (Il.VariantT [mixop2, (tC2, _, _), _], NoDots) ->
      if mixop1 = mixop2 then
      (
        (* Two ConT's with the same operator can be cast pointwise *)
        let ts1 = match tC1.it with Il.TupT xts -> List.map snd xts | _ -> [tC1] in
        let ts2 = match tC2.it with Il.TupT xts -> List.map snd xts | _ -> [tC2] in
        let e'' = Il.UncaseE (e', mixop1) $$ e'.at % tC1 in
        let es' = List.mapi (fun i t1I -> Il.ProjE (e'', i) $$ e''.at % t1I) ts1 in
        let* es'' = map2_attempt (fun eI' (t1I, t2I) ->
          cast_exp phrase env eI' t1I t2I) es' (List.combine ts1 ts2) in
        Ok (Il.CaseE (mixop2, tup_exp' es'' e'.at))
      )
      else
      (
        (* Two unary ConT's can be cast transitively
         * (composing the to/from payload cases below). *)
        let _ = Debug.(log_in_at "el.cast_exp" e'.at
          (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 1"
            (il_typ t1) (il_typ t2)
            (il_deftyp (fst (expand_def env t1) $ t1.at))
            (il_deftyp (fst (expand_def env t2) $ t2.at))
            (il_typ (reduce env t2))
          )
        ) in
        match expand env tC1 with
        | Il.TupT [_, t11'] ->
          let e'' = Il.UncaseE (e', mixop1) $$ e'.at % t11' in
          cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t11') t11' t2'
        | _ -> fail_typ2 env e'.at phrase t1 t2 ""
      )

    | (Il.VariantT tcs1, dots1), (Il.VariantT tcs2, dots2) ->
      let* () =
        (* Recursive subtyping on variants *)
        match
          iter_attempt (fun (mixop, (tC1, _, _), _) ->
            let* _, (tC2, _, _), _ = attempt (find_case tcs2 mixop t1.at) t2 in
            if sub_typ env tC1 tC2 then
              Ok ()
            else
              fail_mixop e'.at mixop t1 "type mismatch for case"
          ) tcs1
        with
        | Ok () -> Ok ()
        | Fail (Trace (_, msg, _) :: _) -> fail_typ2 env e'.at phrase t1 t2 (", " ^ msg)
        | Fail [] -> assert false
      in
      if dots1 = Dots then
        error e'.at ("used variant type `" ^ x1.it ^
          "` is only partially defined at this point")
      else if dots2 = Dots then
        error e'.at ("used variant type `" ^ x2.it ^
          "` is only partially defined at this point");
      Ok (Il.SubE (e', t1', t2'))

    | _, _ ->
      fail_typ2 env e'.at phrase t1 t2 ""
    )

  | Il.VarT _, _ ->
    (match expand_def env t1' with
    | Il.VariantT [mixop1, (tC1, _, _), _], NoDots ->
      choice env [
        (fun env ->
          (* A ConT can always be cast to a (singleton) iteration *)
          match t2'.it with
          | Il.IterT (t21, iter) ->
            let* e1' = cast_exp phrase env e' t1 t21 in
            (match iter with
            | Opt -> Ok (Il.OptE (Some e1'))
            | List -> Ok (Il.ListE [e1'])
            | _ -> assert false
            )
          | _ -> fail_silent
        );
        (fun env ->
          (* A ConT can be cast to its payload *)
          Debug.(log_in_at "el.cast_exp" e'.at
            (fun _ -> fmt "%s <: %s  >>  (%s) <: (%s) = (%s) # backtrack 2"
              (il_typ t1) (il_typ t2)
              (il_deftyp (fst (expand_def env t1) $ t1.at))
              (il_deftyp (fst (expand_def env t2) $ t2.at))
              (il_typ (reduce env t2))
            )
          );
          match expand env tC1 with
          | Il.TupT [_, t11'] ->
            let e'' = Il.UncaseE (e', mixop1) $$ e'.at % t11' in
            cast_exp' phrase env (Il.ProjE (e'', 0) $$ e'.at % t11') t11' t2'
          | _ -> fail_typ2 env e'.at phrase t1 t2 ""
        );
      ]

    | _ ->
      fail_typ2 env e'.at phrase t1 t2 ""
    )

  | _, Il.VarT _ ->
    (match expand_def env t2' with
    | Il.VariantT [mixop2, (tC2, _, _), _], NoDots ->
      (* A ConT payload can be cast to the ConT *)
      (match expand env tC2 with
      | Il.TupT [_, t21'] ->
        let* e1' = cast_exp phrase env e' t1' t21' in
        Ok (Il.CaseE (mixop2, Il.TupE [e1'] $$ e'.at % tC2))
      | _ -> fail_typ2 env e'.at phrase t1 t2 ""
      )

    | _ ->
      fail_typ2 env e'.at phrase t1 t2 ""
    )

  | Il.IterT (t11, Opt), Il.IterT (t21, List) ->
    choice env [
      (fun env ->
        let t1' = Il.IterT (t11, Il.List) $ e'.at in
        let e'' = Il.LiftE e' $$ e'.at % t1' in
        cast_exp' phrase env e'' t1' t2
      );
      (fun env ->
        let* e'' = cast_exp phrase env e' t1 t21 in
        Ok (Il.ListE [e''])
      );
    ]
  | _, Il.IterT (t21, (List | List1)) ->
    let* e'' = cast_exp phrase env e' t1 t21 in
    Ok (Il.ListE [e''])

  | _, _ ->
    fail_typ2 env e'.at phrase t1 t2 ""


(* Premises *)

and elab_prem env (pr : prem) : Il.prem list =
  match pr.it with
  | VarPr (id, t) ->
    let t' = elab_typ env t in
    env.vars <- bind "variable" env.vars id t';
    []
  | RulePr (id, as_, e) ->
    let ps', t, _, mixop, not = find "relation" env.rels id in
    let as', s = elab_args `Rhs env as_ ps' pr.at in
    let not' = Xl.Mixop.map (fun (x, t) -> x, Il.Subst.subst_typ s t) not in
    let es', _s = checkpoint (nest pr.at t (elab_exp_notation' env id e not')) in
    [Il.RulePr (id, as', mixop, tup_exp_nary' es' e.at) $ pr.at]
  | IfPr e ->
    let e' = checkpoint (elab_exp env e (Il.BoolT $ e.at)) in
    [Il.IfPr e' $ pr.at]
  | ElsePr ->
    [Il.ElsePr $ pr.at]
  | IterPr ({it = VarPr _; at; _}, _iter) ->
    error at "misplaced variable premise"
  | IterPr (pr1, it) ->
    let prs1', ite', _itt' = checkpoint (elab_iterexp env
      (fun env pr -> Ok (elab_prem env pr)) pr1 it pr.at) in
    assert (List.length prs1' = 1);
    [Il.IterPr (List.hd prs1', ite') $ pr.at]


(* Grammars *)

and infer_sym env (g : sym) : (Il.sym * Il.typ) attempt =
  Debug.(log_at "el.infer_sym" g.at
    (fun _ -> fmt "%s" (el_sym g))
    (function Ok (g', t) -> fmt "%s : %s" (il_sym g') (il_typ t) | _ -> "fail")
  ) @@ fun _ ->
  nest g.at (Il.TupT [] $ g.at) (
    match g.it with
    | VarG (x, as_) ->
      let ps, t, _gram, _prods' = find "grammar" env.grams x in
      let as', s = elab_args `Rhs env as_ ps g.at in
      Ok (Il.VarG (x, as') $ g.at, Il.Subst.subst_typ s t)
    | NumG (`CharOp, n) ->
(*
      let s = try Utf8.encode [Z.to_int n] with Z.Overflow | Utf8.Utf8 ->
        error g.at "character value out of range" in
      Il.TextG s $ g.at, TextT $ g.at, env
*)
      if n < Z.of_int 0x00 || n > Z.of_int 0x10ffff then
        fail g.at "unicode value out of range"
      else
        Ok (Il.NumG (Z.to_int n) $ g.at, Il.NumT `NatT $ g.at)
    | NumG (_, n) ->
      if n < Z.of_int 0x00 || n > Z.of_int 0xff then
        fail g.at "byte value out of range"
      else
        Ok (Il.NumG (Z.to_int n) $ g.at, Il.NumT `NatT $ g.at)
    | TextG s ->
      Ok (Il.TextG s $ g.at, Il.TextT $ g.at)
    | EpsG ->
      Ok (Il.EpsG $ g.at, Il.TupT [] $ g.at)
    | SeqG gs ->
      let* gs' = elab_sym_list env (filter_nl gs) (Il.TupT [] $ g.at) in
      Ok (Il.SeqG gs' $ g.at, Il.TupT [] $ g.at)
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
          let* g' = elab_sym env g (Il.NumT `NatT $ g.at) in
          Ok (g', Il.NumT `NatT $ g.at)
        );
        (fun env ->
          let* g' = elab_sym env g (Il.TupT [] $ g.at) in
          Ok (g', Il.TupT [] $ g.at)
        )
      ]
    | RangeG (g1, g2) ->
      let env1 = local_env env in
      let env2 = local_env env in
      let* g1' = elab_sym env1 g1 (Il.NumT `NatT $ g1.at) in
      let* g2' = elab_sym env2 g2 (Il.NumT `NatT $ g2.at) in
      if env1.vars != env.vars then
        error g1.at "invalid symbol in range";
      if env2.vars != env.vars then
        error g2.at "invalid symbol in range";
      Ok (Il.RangeG (g1', g2') $ g.at, Il.NumT `NatT $ g.at)
    | ParenG g1 ->
      infer_sym env g1
    | TupG _ -> error g.at "malformed grammar"
    | ArithG e ->
      infer_sym env (sym_of_exp e)
    | IterG (g1, it) ->
      let* (g1', t1), ite', itt' = elab_iterexp env infer_sym g1 it g.at in
      Ok (Il.IterG (g1', ite') $ g.at, Il.IterT (t1, itt') $ g.at)
    | AttrG (e, g1) ->
      choice env [
        (fun env ->
          (* HACK to treat singleton strings in short grammar as characters *)
          let t1 = Il.NumT `NatT $ g1.at in
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
      Ok (Il.AttrG (e', g1') $ g.at, t1)
  *)
    | FuseG _ -> error g.at "misplaced token concatenation"
    | UnparenG _ -> error g.at "misplaced token unparenthesize"
  )

and infer_sym_list env (gs : sym list) : (Il.sym list * Il.typ list) attempt =
  match gs with
  | [] -> Ok ([], [])
  | g::gs ->
    let* g', t = infer_sym env g in
    let* gs', ts = infer_sym_list env gs in
    Ok (g'::gs', t::ts)

and elab_sym env (g : sym) (t : Il.typ) : Il.sym attempt =
  Debug.(log_at "el.elab_sym" g.at
    (fun _ -> fmt "%s : %s" (el_sym g) (il_typ t))
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

and elab_sym_list env (gs : sym list) (t : Il.typ) : Il.sym list attempt =
  match gs with
  | [] -> Ok ([])
  | g::gs ->
    let* g' = elab_sym env g t in
    let* gs' = elab_sym_list env gs t in
    Ok (g'::gs')

and cast_sym env (g' : Il.sym) t1 t2 : Il.sym attempt =
  Debug.(log_at "el.elab_cast_sym" g'.at
    (fun _ -> fmt "%s : %s :> %s" (il_sym g') (il_typ t1) (il_typ t2))
    (function Ok g'' -> fmt "%s" (il_sym g'') | _ -> "fail")
  ) @@ fun _ ->
  nest g'.at t2 (
    if equiv_typ env t1 t2 then
      Ok g'
    else if equiv_typ env t2 (Il.TupT [] $ t2.at) then
      Ok (Il.SeqG [g'] $ g'.at)
    else
      fail_typ2 env g'.at "symbol" t1 t2 ""
  )

and elab_prod env outer_dims (prod : prod) (t : Il.typ) : Il.prod list =
  Debug.(log_in_at "el.elab_prod" prod.at
    (fun _ -> fmt "%s : %s" (el_prod prod) (il_typ t))
  );
  match prod.it with
  | SynthP (g, e, prems) ->
    let env' = local_env env in
    env'.pm <- false;
    let g', _t' = checkpoint (infer_sym env' g) in
    let e' =
      checkpoint (
        let t_unit = Il.TupT [] $ e.at in
        if equiv_typ env' t t_unit then
          (* Special case: ignore unit attributes *)
          (* TODO(4, rossberg): introduce proper top type? *)
          let* e', _t = infer_exp env' e in
          Ok (Il.ProjE (
            Il.TupE [
              e'; Il.TupE [] $$ e.at % t_unit
            ] $$ e.at % (Il.TupT ["_" $ e.at, e'.note; "_" $ e.at, t_unit] $ e.at), 1
          ) $$ e.at % t_unit)
        else
          elab_exp env' e t
      )
    in
    let prems' = List.concat (map_filter_nl_list (elab_prem env') prems) in
    let dims = Dim.check outer_dims [] [] [] [e'] [g'] prems' in
    let g' = Dim.annot_sym dims g' in
    let e' = Dim.annot_exp dims e' in
    let prems' = List.map (Dim.annot_prem dims) prems' in
    let det = Det.(det_exp e' ++ det_sym g' ++ det_list det_prem prems') in
    let qs = infer_quants env env' dims det [] [] [] [e'] [g'] prems' prod.at in
    let prod' = Il.ProdD (qs, g', e', prems') $ prod.at in
    let free = Il.Free.(free_prod prod' -- bound_env env') in
    if free <> Il.Free.empty then
      error prod.at ("grammar rule contains indeterminate variable(s) " ^
        String.concat ", " (List.map quote (Il.Free.Set.elements free.varid)));
    if not env'.pm then
      [prod']
    else
      prod' ::
      elab_prod env outer_dims Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t

  | RangeP (g1, e1, g2, e2) ->
    let t = Il.NumT `NatT $ prod.at in
    let g1' = checkpoint (elab_sym env g1 t) in
    let e1' = checkpoint (elab_exp env e1 t) in
    let g2' = checkpoint (elab_sym env g2 t) in
    let e2' = checkpoint (elab_exp env e2 t) in
    let dims = Dim.check outer_dims [] [] [] [e1'; e2'] [g1'; g2'] [] in
    let g1' = Dim.annot_sym dims g1' in
    let g2' = Dim.annot_sym dims g2' in
    let e1' = Dim.annot_exp dims e1' in
    let e2' = Dim.annot_exp dims e2' in
    let det = Det.(det_list det_exp [e1'; e2'] ++ det_list det_sym [g1'; g2']) in
    infer_no_quants env dims det [] [] [] [e1'; e2'] [g1'; g2'] [] prod.at;
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
    let g1', _t1' = checkpoint (infer_sym env' g1) in
    let g2', _t2' = checkpoint (infer_sym env' g2) in
    let prems' = List.concat (map_filter_nl_list (elab_prem env') prems) in
    let dims = Dim.check outer_dims [] [] [] [] [g1'; g2'] prems' in
    let g1' = Dim.annot_sym dims g1' in
    let g2' = Dim.annot_sym dims g2' in
    let prems' = List.map (Dim.annot_prem dims) prems' in
    let det = Det.(det_sym g1' ++ det_sym g2' ++ det_list det_prem prems') in
    ignore (infer_quants env env' dims det [] [] [] [] [g1'; g2'] prems' prod.at);
    []  (* TODO(4, rossberg): translate equiv grammars properly *)
(*
    let prod' = Il.ProdD (!acc_qs, g1', e', prems') $ prod.at in
    if not env'.pm then
      [prod']
    else
      prod' :: elab_prod env Subst.(subst_prod pm_snd (Iter.clone_prod prod)) t
*)

and elab_gram env outer_dims (gram : gram) (t : Il.typ) : Il.prod list =
  let (_dots1, prods, _dots2) = gram.it in
  concat_map_filter_nl_list (fun prod -> elab_prod env outer_dims prod t) prods


(* Definitions *)

and elab_arg in_lhs env (a : arg) (p : Il.param) s : Il.arg list * Il.Subst.subst =
  (match !(a.it), p.it with  (* HACK: handle shorthands *)
  | ExpA e, Il.TypP _ -> a.it := TypA (typ_of_exp e)
  | ExpA e, Il.GramP _ -> a.it := GramA (sym_of_exp e)
  | ExpA {it = CallE (id, []); _}, Il.DefP _ -> a.it := DefA id
  | _, _ -> ()
  );
  match !(a.it), (Il.Subst.subst_param s p).it with
  | ExpA e, Il.ExpP (x, t) ->
    let e' = checkpoint (elab_exp env e t) in
    [Il.ExpA e' $ a.at], Il.Subst.add_varid s x e'
  | TypA {it = VarT (x', []); _}, Il.TypP x when in_lhs = `Lhs ->
    let x'' = strip_var_suffix x' in
    let is_prim =
      match (Convert.typ_of_varid x'').it with
      | VarT _ -> false
      | _ -> true
    in
    let t' = Il.VarT (x'', []) $ x''.at in
    env.typs <- bind "syntax type" env.typs x'' ([], Opaque);
    if not is_prim then
      env.gvars <- bind "variable" env.gvars (strip_var_sub x'') t';
    [Il.TypA t' $ a.at], Il.Subst.add_typid s x t'
  | TypA t, Il.TypP _ when in_lhs = `Lhs ->
    error t.at "misplaced syntax type"
  | TypA t, Il.TypP x ->
    let t' = elab_typ env t in
    [Il.TypA t' $ a.at], Il.Subst.add_typid s x t'
  | GramA g, Il.GramP _ when in_lhs = `Lhs ->
    error g.at "misplaced grammar symbol"
  | GramA g, Il.GramP (x', [], t) ->
    let g', t' = checkpoint (infer_sym env g) in
    let s' = subst_implicit env s t t' in
    if not (equiv_typ env t' (Il.Subst.subst_typ s' t)) then
      error_typ2 env a.at "argument" t' t "";
    let as' = List.map (fun (_x, t) -> Il.TypA t $ t.at) Il.Subst.(Map.bindings s'.typid) in
    as' @ [Il.GramA g' $ a.at], Il.Subst.add_gramid s' x' g'
  | GramA g, Il.GramP (x', ps', t') ->
    (match g.it with
    | VarG (x, []) ->
      let ps, t, _ = find "grammar" env.defs x in
      if not (Il.Eval.equiv_functyp (to_il_env env) (ps, t) (ps', t')) then
        error a.at ("type mismatch in grammar argument, expected `" ^
          (spaceid "grammar" x').it ^ Il.Print.(string_of_params ps' ^ " : " ^ typ_string env t') ^
          "` but got `" ^
          (spaceid "grammar" x).it ^ Il.Print.(string_of_params ps ^ " : " ^ typ_string env t ^ "`")
        );
      let g' = Il.VarG (x, []) $ a.at in
      [Il.GramA g' $ a.at], Il.Subst.add_gramid s x g'
    | _ ->
      error g.at "grammar identifier expected for paramaterised grammar parameter"
    )
  | DefA x, Il.DefP (x', ps', t') when in_lhs = `Lhs ->
    env.defs <- bind "definition" env.defs x (ps', t', []);
    [Il.DefA x $ a.at], Il.Subst.add_defid s x' x
  | DefA x, Il.DefP (x', ps', t') ->
    let ps, t, _ = find "definition" env.defs x in
    if not (Il.Eval.equiv_functyp (to_il_env env) (ps, t) (ps', t')) then
      error a.at ("type mismatch in function argument, expected `" ^
        (spaceid "definition" x').it ^ Il.Print.(string_of_params ps' ^ " : " ^ typ_string env t') ^
        "` but got `" ^
        (spaceid "definition" x).it ^ Il.Print.(string_of_params ps ^ " : " ^ typ_string env t ^ "`")
      );
    [Il.DefA x $ a.at], Il.Subst.add_defid s x x'
  | _, _ ->
    error a.at "sort mismatch for argument"

and elab_args in_lhs env (as_ : arg list) (ps : Il.param list) at : Il.arg list * Il.Subst.subst =
  Debug.(log_at "el.elab_args" at
    (fun _ -> fmt "(%s) : (%s)" (list el_arg as_) (list il_param ps))
    (fun (as', _) -> fmt "(%s)" (list il_arg as'))
  ) @@ fun _ ->
  elab_args' in_lhs env as_ ps [] Il.Subst.empty at

and elab_args' in_lhs env (as_ : arg list) (ps : Il.param list) as' s at : Il.arg list * Il.Subst.subst =
  match as_, ps with
  | [], [] -> List.concat (List.rev as'), s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | _, {it = Il.TypP _; at; _}::ps1 when at = Source.no_region ->
    (* Implicitly inserted type parameter *)
    elab_args' in_lhs env as_ ps1 as' s at
  | a::as1, p::ps1 ->
    let a', s' = elab_arg in_lhs env a p s in
    elab_args' in_lhs env as1 ps1 (a'::as') s' at

and subst_implicit env s t t' : Il.Subst.subst =
  let free = Il.Free.(Set.filter (fun x -> not (Map.mem x env.typs)) (free_typ t).typid) in
  let rec inst s t t' =
    match t.it, t'.it with
    | Il.VarT (x, []), _
      when Il.Free.Set.mem x.it free && not (Il.Subst.mem_typid s x) ->
      Il.Subst.add_typid s x t'
    | Il.TupT ((x, t1)::ts), Il.TupT ((x', t1')::ts') ->
      let s' = Il.Subst.add_varid (inst s t1 t1') x' (Il.VarE x $$ x.at % t1) in
      inst s' (Il.TupT ts $ t.at) (Il.TupT ts' $ t'.at)
    | Il.IterT (t1, _), Il.IterT (t1', _) -> inst s t1 t1'
    | _ -> s
  in inst s t t'

and elab_param env (p : param) : Il.param list =
  match p.it with
  | ExpP (x, t) ->
    let t' = elab_typ env t in
    (* If a variable isn't globally declared, this is a local declaration. *)
    let x' = strip_var_suffix x in
    if bound env.gvars x' then (
      let t2 = find "" env.gvars x' in
      if not (sub_typ env t' t2) then
        error_typ2 env x.at "local variable" t' t2 ", shadowing with different type"
    );
    (* Shadowing is allowed, but only with consistent type. *)
    if bound env.vars x' then (
      let t2 = find "" env.vars x' in
      if not (equiv_typ env t' t2) then
        error_typ2 env x.at "local variable" t' t2 ", shadowing with different type"
    )
    else
      env.vars <- bind "variable" env.vars x t';
    [Il.ExpP (x, t') $ p.at]

  | TypP x ->
    env.typs <- bind "syntax type" env.typs x ([], Opaque);
    env.gvars <- bind "variable" env.gvars (strip_var_sub x) (Il.VarT (x, []) $ x.at);
    [Il.TypP x $ p.at]

  | GramP (x, ps, t) ->
    let env' = local_env env in
    let ps' = elab_params env' ps in
    (* Treat unbound type identifiers in t as implicitly bound. *)
    let free = Free.free_typ t in
    let ps_implicit' =
      Free.Set.fold (fun x' ps' ->
        if Map.mem x' env'.typs then ps' else (
          let x = x' $ t.at in
          if x.it <> (strip_var_suffix x).it then
            error_id x "invalid identifer suffix in binding position";
          env'.typs <- bind "syntax type" env.typs x ([], Opaque);
          env.typs <- bind "syntax type" env.typs x ([], Opaque);
          env.gvars <- bind "variable" env.gvars (strip_var_sub x)
            (Il.VarT (x, []) $ x.at);
          (* Mark as implicit type parameter via empty region. *)
          (Il.TypP x $ Source.no_region) :: ps'
        )
      ) free.typid []
    in
    let t' = elab_typ env' t in
    env.grams <- bind "grammar" env.grams x ([], t', [], None);
    ps_implicit' @ [Il.GramP (x, ps', t') $ p.at]

  | DefP (x, ps, t) ->
    let env' = local_env env in
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    env.defs <- bind "definition" env.defs x (ps', t', []);
    [Il.DefP (x, ps', t') $ p.at]

and elab_params env (ps : param list) : Il.param list =
  List.concat_map (elab_param env) ps


(* To allow optional atoms such as `MUT?`, preprocess type
 * definitions to insert implicit type definition
 * `syntax MUT hint(show MUT) = MUT` and replace atom with type id. *)
and infer_typ_notation env is_con (t : typ) : typ =
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

let infer_typ_definition _env (t : typ) : kind =
  match t.it with
  | StrT _ | CaseT _ -> Opaque
  | ConT _ | RangeT _ -> Transp
  | _ -> Transp

let infer_typdef env (d : def) : def =
  match d.it with
  | FamD (x, ps, _hints) ->
    let ps' = elab_params (local_env env) ps in
    env.typs <- bind "syntax type" env.typs x (ps', Family []);
    if ps = [] then  (* only types without parameters double as variables *)
      env.gvars <- bind "variable" env.gvars (strip_var_sub x) (Il.VarT (x, []) $ x.at);
    d
  | TypD (x1, x2, as_, t, hints) ->
    let is_con = ref false in
    let t = infer_typ_notation env is_con t in
    if bound env.typs x1 then (
      let _ps, k = find "syntax type" env.typs x1 in
      let extension =
        match t.it with
        | CaseT (Dots, _, _, _) | StrT (Dots, _, _, _) -> true
        | _ -> false
      in
      if k <> Family [] && not extension then (* force error *)
        ignore (env.typs <- bind "syntax type" env.typs x1 ([], Family []))
    )
    else (
      let ps = List.map Convert.param_of_arg as_ in
      let env' = local_env env in
      let ps' = elab_params env' ps in
      let k = infer_typ_definition env' t in
      env.typs <- bind "syntax type" env.typs x1 (ps', k);
      if ps = [] then  (* only types without parameters double as variables *)
        env.gvars <- bind "variable" env.gvars (strip_var_sub x1) (Il.VarT (x1, []) $ x1.at);
    );
    TypD (x1, x2, as_, t, hints) $ d.at
  | VarD (x, t, _hints) ->
    let t' = elab_typ env t in
    (* This is to ensure that we get rebind errors in syntactic order. *)
    env.gvars <- bind "variable" env.gvars x t';
    d
  | _ -> d

let elab_hintdef _env (hd : hintdef) : Il.def list =
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
  | GramH (id1, _id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.GramH (id1, elab_hints id1 "" hints) $ hd.at) $ hd.at]
  | RuleH (id1, id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RuleH (id1, id2, elab_hints id1 "" hints) $ hd.at) $ hd.at]
  | VarH _ ->
    []


let rec elab_def_pass1 env (d : def) : Il.def list =
  Debug.(log_in "el.elab_def_pass1" line);
  Debug.(log_in_at "el.elab_def_pass1" d.at (fun _ -> el_def d));
  let env' = local_env env in
  env'.pm <- false;
  match d.it with
  | FamD (x, ps, hints) ->
    let ps' = elab_params env' ps in
    if env'.pm then
      error d.at "misplaced +- or -+ operator in syntax type declaration";
    let dims = Dim.check Map.empty ps' [] [] [] [] [] in
    let ps' = List.map (Dim.annot_param dims) ps' in
    infer_no_quants env dims Det.empty ps' [] [] [] [] [] d.at;
    env.typs <- rebind "syntax type" env.typs x (ps', Family []);
    [Il.TypD (x, ps', []) $ d.at]
      @ elab_hintdef env (TypH (x, "" $ x.at, hints) $ d.at)

  | TypD (x1, x2, as_, t, hints) ->
    let ps', k = find "syntax type" env.typs x1 in
    let as', _s = elab_args `Lhs env' as_ ps' d.at in
    let dims = Dim.check Map.empty [] as' [] [] [] [] in
    let dots1, dt', dots2 = elab_typ_definition env' dims x1 t in
    let as' = List.map (Dim.annot_arg dims) as' in
    let det = Det.(det_list det_arg as') in
    let qs = infer_quants env env' dims det [] as' [] [] [] [] d.at in
    let inst' = Il.InstD (qs, as', dt') $ d.at in
    let k', last =
      match k with
      | (Opaque | Transp) ->
        if dots1 = Dots then
          error_id x1 "extension of not yet defined syntax type";
        Defined (dt', [x2], dots2), dots2 = NoDots
      | Defined (_, xs, dots) ->
        if dots = NoDots then
          error_id x1 "extension of non-extensible syntax type";
        if List.exists (fun x -> x.it = x2.it) xs then
          error d.at ("duplicate syntax fragment name `" ^ x1.it ^
            (if x2.it = "" then "" else "/" ^ x2.it) ^ "`");
        Defined (dt', x2::xs, dots2), dots2 = NoDots
      | Family insts ->
        if dots1 = Dots || dots2 = Dots then
          error_id x1 "syntax type family cases are not extensible";
        Family (insts @ [inst']), false
    in
    env.typs <- rebind "syntax type" env.typs x1 (ps', k');
    (if not last then [] else [Il.TypD (x1, ps', [inst']) $ d.at])
      @ elab_hintdef env (TypH (x1, x2, hints) $ d.at) @
    (if not env'.pm then [] else elab_def_pass1 env Subst.(subst_def pm_snd (Iter.clone_def d)))

  | GramD (x1, _x2, ps, t, _gram, _hints) ->
    if not (bound env.grams x1) then (
      let env' = local_env env in
      let ps' = elab_params env' ps in
      let t' = elab_typ env' t in
      env.grams <- bind "grammar" env.grams x1 (ps', t', [], None);
    );
    []

  | RelD (x, ps, t, hints) ->
    let ps' = elab_params env' ps in
    let mixop, xts' = elab_typ_notation' env' x t in
    let ts' = List.map snd xts' in
    if env'.pm then error d.at "misplaced +- or -+ operator in relation";
    let dims = Dim.check Map.empty [] [] ts' [] [] [] in
    let ts' = List.map (Dim.annot_typ dims) ts' in
    infer_no_quants env' dims Det.empty [] [] ts' [] [] [] d.at;
    let not = Mixop.apply mixop (List.map (fun t' -> "_" $ d.at, t') ts') in
    let t' = tup_typ' ts' t.at in
    env.rels <- bind "relation" env.rels x (ps', t', [], mixop, not);
    [Il.RelD (x, ps', mixop, t', []) $ d.at]
      @ elab_hintdef env (RelH (x, hints) $ d.at)

  | RuleD _ -> []

  | VarD (x, t, _hints) ->
    let t' = elab_typ env' t in
    if env'.pm then
      error d.at "misplaced +- or -+ operator in variable declaration";
    let dims = Dim.check Map.empty [] [] [t'] [] [] [] in
    let t' = Dim.annot_typ dims t' in
    infer_no_quants env' dims Det.empty [] [] [t'] [] [] [] d.at;
    env.gvars <- rebind "variable" env.gvars x t';
    []

  | DecD (x, ps, t, hints) ->
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    if env'.pm then error d.at "misplaced +- or -+ operator in declaration";
    let d' = Il.DecD (x, ps', t', []) $ d.at in
    let dims = Dim.check Map.empty ps' [] [t'] [] [] [] in
    let t' = Dim.annot_typ dims t' in
    infer_no_quants env dims Det.empty ps' [] [t'] [] [] [] d.at;
    env.defs <- bind "definition" env.defs x (ps', t', []);
    [d'] @ elab_hintdef env (DecH (x, hints) $ d.at)

  | DefD _ -> []

  | SepD -> []

  | HintD hd ->
    elab_hintdef env' hd


let rec elab_def_pass2 env (d : def) : Il.def list =
  Debug.(log_in "el.elab_def_pass2" line);
  Debug.(log_in_at "el.elab_def_pass2" d.at (fun _ -> el_def d));
  let env' = local_env env in
  env'.pm <- false;
  match d.it with
  | FamD _ -> []

  | TypD _ -> []

  | GramD (x1, x2, ps, t, gram, hints) ->
    let ps' = elab_params env' ps in
    let t' = elab_typ env' t in
    let dims = Dim.check Map.empty ps' [] [t'] [] [] [] in
    let outer_dims = Dim.restrict dims (Il.Free.bound_params ps') in
    let prods' = elab_gram env' outer_dims gram t' in
    let xprods2' = List.map (fun pr -> x2, pr) prods' in
    if env'.pm then error d.at "misplaced +- or -+ operator in grammar";
    let t' = Dim.annot_typ dims t' in
    infer_no_quants env' outer_dims Det.empty ps' [] [t'] [] [] [] d.at;
    let ps1', t1', xprods1', dots_opt = find "grammar" env.grams x1 in
    let dots1, _, dots2 = gram.it in
    let xprods' =
      match dots_opt with
      | None ->
        if dots1 = Dots then
          error_id x1 "extension of not yet defined grammar";
        xprods2'
      | Some dots ->
        if dots = NoDots then
          error_id x1 "extension of non-extensible grammar";
        if List.exists (fun (x, _) -> x.it = x2.it) xprods1' then
          error d.at ("duplicate grammar fragment name `" ^ x1.it ^
            (if x2.it = "" then "" else "/" ^ x2.it) ^ "`");
        if not Il.Eq.(eq_list eq_param ps' ps1') then
          error d.at "grammar parameters differ from previous fragment";
        if not (equiv_typ env' t' t1') then
          error_typ2 env d.at "grammar" t1' t' " of previous fragment";
        xprods1' @ xprods2'
    in
    env.grams <- rebind "grammar" env.grams x1 (ps', t', xprods', Some dots2);
    (* Only add last fragment to IL defs, so that populate finds it only once *)
    (if dots2 = Dots then [] else [Il.GramD (x1, ps', t', []) $ d.at])
      @ elab_hintdef env (GramH (x1, x2, hints) $ d.at)

  | RelD _ -> []

  | RuleD (x1, ps, x2, e, prems, hints) ->
    let ps', t', rules', mixop, not' = find "relation" env.rels x1 in
    if List.exists (fun (x, _) -> x.it = x2.it) rules' then
      error d.at ("duplicate rule name `" ^ x1.it ^
        (if x2.it = "" then "" else "/" ^ x2.it) ^ "`");
    let ps'' = elab_params env' ps in
    if not Il.Eq.(eq_list eq_param ps' ps'') then
      error d.at ("parameter list on rule differs from relation");
    let es', _ = checkpoint (elab_exp_notation' env' x1 e not') in
    let prems' = List.concat (map_filter_nl_list (elab_prem env') prems) in
    let dims = Dim.check Map.empty [] [] [] es' [] prems' in
    let es' = List.map (Dim.annot_exp dims) es' in
    let e' = tup_exp_nary' es' e.at in
    let prems' = List.map (Dim.annot_prem dims) prems' in
    let det = Det.(det_exp e' ++ det_list det_prem prems') in
    let qs = infer_quants env env' dims det [] [] [] es' [] prems' d.at in
    let rule' = Il.RuleD (x2, qs, mixop, e', prems') $ d.at in
    env.rels <- rebind "relation" env.rels x1 (ps', t', rules' @ [x2, rule'], mixop, not');
    (if not env'.pm then [] else elab_def_pass2 env Subst.(subst_def pm_snd (Iter.clone_def d)))
      @ elab_hintdef env (RuleH (x1, x2, hints) $ d.at)

  | VarD _ -> []

  | DecD _ -> []

  | DefD (x, as_, e, prems) ->
    let ps', t', clauses' = find "definition" env.defs x in
    let as', s = elab_args `Lhs env' as_ ps' d.at in
    let prems' = List.concat (map_filter_nl_list (elab_prem env') prems) in
    (* Elab e after premises, so that type information can flow to it *)
    let e' = checkpoint (elab_exp env' e (Il.Subst.subst_typ s t')) in
    let dims = Dim.check Map.empty [] as' [] [e'] [] prems' in
    let as' = List.map (Dim.annot_arg dims) as' in
    let e' = Dim.annot_exp dims e' in
    let prems' = List.map (Dim.annot_prem dims) prems' in
    let det = Det.(det_list det_arg as' ++ det_exp e' ++ det_list det_prem prems') in
    let qs = infer_quants env env' dims det [] as' [] [e'] [] prems' d.at in
    let clause' = Il.DefD (qs, as', e', prems') $ d.at in
    env.defs <- rebind "definition" env.defs x (ps', t', clauses' @ [(d, clause')]);
    if not env'.pm then [] else elab_def_pass2 env Subst.(subst_def pm_snd (Iter.clone_def d))

  | SepD -> []

  | HintD _ -> []


let check_dots env =
  Map.iter (fun x (at, (_ps, k)) ->
    match k with
    | Transp | Opaque -> assert false
    | Defined (_, _, Dots) ->
      error_id (x $ at) "missing final extension to syntax type"
    | Family [] ->
      error_id (x $ at) "no defined cases for syntax type family"
    | Defined _ | Family _ -> ()
  ) env.typs;
  Map.iter (fun x (at, (_ps, _t, _prods', dots_opt)) ->
    match dots_opt with
    | None -> assert false
    | Some Dots ->
      error_id (x $ at) "missing final extension to grammar"
    | Some _ -> ()
  ) env.grams


let populate_hint env (hd' : Il.hintdef) =
  match hd'.it with
  | Il.TypH (x, _) -> ignore (find "syntax type" env.typs x)
  | Il.RelH (x, _) -> ignore (find "relation" env.rels x)
  | Il.DecH (x, _) -> ignore (find "definition" env.defs x)
  | Il.GramH (x, _) -> ignore (find "grammar" env.grams x)
  | Il.RuleH (x, _, _) -> ignore (find "relation" env.rels x)

let populate_def env (d' : Il.def) : Il.def =
  Debug.(log_in "el.populate_def" dline);
  Debug.(log_in_at "el.populate_def" d'.at (Fun.const ""));
  match d'.it with
  | Il.TypD (x, ps', _dt') ->
    (match find "syntax type" env.typs x with
    | _ps, Family insts' -> Il.TypD (x, ps', insts') $ d'.at
    | _ps, _k -> d'
    )
  | Il.RelD (x, ps', mixop, t', []) ->
    let _, _, rules', _, _ = find "relation" env.rels x in
    Il.RelD (x, ps', mixop, t', List.map snd rules') $ d'.at
  | Il.DecD (x, ps', t', []) ->
    let _, _, clauses' = find "definition" env.defs x in
    Il.DecD (x, ps', t', List.map snd clauses') $ d'.at
  | Il.GramD (x, ps', t', []) ->
    let _, _, prods', _ = find "grammar" env.grams x in
    Il.GramD (x, ps', t', List.map snd prods') $ d'.at
  | Il.HintD hd' -> populate_hint env hd'; d'
  | _ -> assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id ->
    try Map.find id map with Not_found -> failwith ("recursify dep " ^ id)
  ) (Array.of_seq (Il.Free.Set.to_seq set))


let check_recursion (ds' : Il.def list) =
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

let recursify_defs (ds' : Il.def list) : Il.def list =
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


let implicit_typdef id (at, atom) (ds : def list) : def list =
  let hint = {hintid = "show" $ at; hintexp = AtomE atom $ at} in
  let t = ConT ((AtomT (El.Iter.clone_atom atom) $ at, []), []) $ at in
  let d = TypD (id $ at, "" $ at, [], t, [hint]) $ at in
  d :: ds

let elab (ds : script) : Il.script * env =
  let env = new_env () in
  let ds = List.map (infer_typdef env) ds in
  let ds = Map.fold implicit_typdef env.atoms ds in
  let ds1' = List.concat_map (elab_def_pass1 env) ds in
  let ds2' = List.concat_map (elab_def_pass2 env) ds in
  check_dots env;
  let ds' = List.map (populate_def env) (ds1' @ ds2') in
  recursify_defs ds', env

let elab_exp env (e : exp) (t : typ) : Il.exp =
  let env' = local_env env in
  let t' = elab_typ env' t in
  checkpoint (elab_exp env' e t')

let elab_rel env (e : exp) (x : id) : Il.exp =
  let env' = local_env env in
  match elab_prem env' (RulePr (x, [], e) $ e.at) with
  | [{it = Il.RulePr (_, _, _, e'); _}] -> e'
  | _ -> assert false
