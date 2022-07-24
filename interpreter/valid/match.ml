(* Generic Matching *)

module type Context =
sig
  type var
  type def_type
  type context
  val lookup : context -> var -> def_type
end

module Make
  (Var : Types.Var)
  (Context : Context
    with type var = Var.var
    with type def_type = Types.Make(Var).def_type
  ) =
struct

  open Types.Make(Var)
  open Context


  (* Assumptions *)

  type assump = (var * var) list

  let assuming a (x1, x2) =
    List.find_opt (fun (y1, y2) -> eq_var x1 y1 && eq_var x2 y2) a <> None


  (* Equivalence *)

  let eq_nullability c a nul1 nul2 =
    nul1 = nul2

  let eq_mutability c a mut1 mut2 =
    mut1 = mut2

  let eq_limits c a lim1 lim2 =
    lim1.min = lim2.min && lim1.max = lim2.max

  let eq_num_type c a t1 t2 =
    t1 = t2

  let eq_vec_type c a t1 t2 =
    t1 = t2

  let rec eq_heap_type c a t1 t2 =
    match t1, t2 with
    | `Def x1, `Def x2 -> eq_var_type c a x1 x2
    | _, _ -> t1 = t2

  and eq_ref_type c a t1 t2 =
    match t1, t2 with
    | `Ref (nul1, t1'), `Ref (nul2, t2') ->
      eq_nullability c a nul1 nul2 && eq_heap_type c a t1' t2'

  and eq_val_type c a t1 t2 =
    match t1, t2 with
    | (#num_type as t1'), (#num_type as t2') -> eq_num_type c a t1' t2'
    | (#vec_type as t1'), (#vec_type as t2') -> eq_vec_type c a t1' t2'
    | (#ref_type as t1'), (#ref_type as t2') -> eq_ref_type c a t1' t2'
    | `Bot, `Bot -> true
    | _, _ -> false

  and eq_result_type c a ts1 ts2 =
    List.length ts1 = List.length ts2 &&
    List.for_all2 (eq_val_type c a) ts1 ts2

  and eq_func_type c a (`Func (ts11, ts12)) (`Func (ts21, ts22)) =
    eq_result_type c a ts11 ts21 && eq_result_type c a ts12 ts22

  and eq_def_type c a dt1 dt2 =
    match dt1, dt2 with
    | (#func_type as ft1), (#func_type as ft2) -> eq_func_type c a ft1 ft2

  and eq_var_type c a x1 x2 =
    eq_var x1 x2 || assuming a (x1, x2) ||
    eq_def_type c ((x1, x2)::a) (lookup c x1) (lookup c x2)


  let eq_table_type c a (`Table (lim1, t1)) (`Table (lim2, t2)) =
    eq_limits c a lim1 lim2 && eq_ref_type c a t1 t2

  let eq_memory_type c a (`Memory lim1) (`Memory lim2) =
    eq_limits c a lim1 lim2

  let eq_global_type c a (`Global (mut1, t1)) (`Global (mut2, t2)) =
    eq_mutability c a mut1 mut2 && eq_val_type c a t1 t2

  let eq_extern_type c a et1 et2 =
    match et1, et2 with
    | (#func_type as ft1), (#func_type as ft2) -> eq_func_type c a ft1 ft2
    | (#table_type as tt1), (#table_type as tt2) -> eq_table_type c a tt1 tt2
    | (#memory_type as mt1), (#memory_type as mt2) -> eq_memory_type c a mt1 mt2
    | (#global_type as gt1), (#global_type as gt2) -> eq_global_type c a gt1 gt2
    | _, _ -> false


  (* Subtyping *)

  let match_nullability c a nul1 nul2 =
    match nul1, nul2 with
    | `NoNull, `Null -> true
    | _, _ -> nul1 = nul2

  let match_limits c a lim1 lim2 =
    I32.ge_u lim1.min lim2.min &&
    match lim1.max, lim2.max with
    | _, None -> true
    | None, Some _ -> false
    | Some i, Some j -> I32.le_u i j

  let match_num_type c a t1 t2 =
    t1 = t2

  let match_vec_type c a t1 t2 =
    t1 = t2

  let rec match_heap_type c a t1 t2 =
    match t1, t2 with
    | `Def x1, `Func ->
      (match lookup c x1 with
      | `Func _ -> true
      )
    | `Def x1, `Def x2 -> match_var_type c a x1 x2
    | `Bot, _ -> true
    | _, _ -> eq_heap_type c [] t1 t2

  and match_ref_type c a t1 t2 =
    match t1, t2 with
    | `Ref (nul1, t1'), `Ref (nul2, t2') ->
      match_nullability c a nul1 nul2 && match_heap_type c a t1' t2'

  and match_val_type c a t1 t2 =
    match t1, t2 with
    | (#num_type as t1'), (#num_type as t2') -> match_num_type c a t1' t2'
    | (#vec_type as t1'), (#vec_type as t2') -> match_vec_type c a t1' t2'
    | (#ref_type as t1'), (#ref_type as t2') -> match_ref_type c a t1' t2'
    | `Bot, _ -> true
    | _, _ -> false

  and match_result_type c a ts1 ts2 =
    List.length ts1 = List.length ts2 &&
    List.for_all2 (match_val_type c a) ts1 ts2

  and match_func_type c a ft1 ft2 =
    eq_func_type c [] ft1 ft2

  and match_def_type c a dt1 dt2 =
    match dt1, dt2 with
    | (#func_type as ft1), (#func_type as ft2) -> match_func_type c a ft1 ft2

  and match_var_type c a x1 x2 =
    eq_var x1 x2 || assuming a (x1, x2) ||
    match_def_type c ((x1, x2)::a) (lookup c x1) (lookup c x2)

  let match_table_type c a (`Table (lim1, t1)) (`Table (lim2, t2)) =
    match_limits c a lim1 lim2 && eq_ref_type c [] t1 t2

  let match_memory_type c a (`Memory lim1) (`Memory lim2) =
    match_limits c a lim1 lim2

  let match_global_type c a (`Global (mut1, t1)) (`Global (mut2, t2)) =
    eq_mutability c [] mut1 mut2 &&
    match mut1 with
    | `Const -> match_val_type c a t1 t2
    | `Var -> eq_val_type c [] t1 t2

  let match_extern_type c a et1 et2 =
    match et1, et2 with
    | (#func_type as ft1), (#func_type as ft2) -> match_func_type c a ft1 ft2
    | (#table_type as tt1), (#table_type as tt2) -> match_table_type c a tt1 tt2
    | (#memory_type as mt1), (#memory_type as mt2) -> match_memory_type c a mt1 mt2
    | (#global_type as gt1), (#global_type as gt2) -> match_global_type c a gt1 gt2
    | _, _ -> false
end


(* Syntactic Matching *)

module SynContext =
struct
  type var = Types.Syn.var
  type def_type = Types.Syn.def_type
  type context = def_type list
  let lookup c x = Lib.List32.nth c x
end

module Syn = Make (Types.SynVar) (SynContext)

include Syn


(* Semantic Matching *)

module SemContext =
struct
  type var = Types.Sem.var
  type def_type = Types.Sem.def_type
  type context = unit
  let lookup c x = Types.Sem.def_of x
end

module Sem = Make (Types.SemVar) (SemContext)
