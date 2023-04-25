open Types


(* Equivalence *)

let eq_nullability nul1 nul2 =
  nul1 = nul2

let eq_mutability mut1 mut2 =
  mut1 = mut2

let eq_limits lim1 lim2 =
  lim1.min = lim2.min && lim1.max = lim2.max

let eq_num_type t1 t2 =
  t1 = t2

let eq_vec_type t1 t2 =
  t1 = t2

let rec eq_heap_type t1 t2 =
  match t1, t2 with
  | DefHT dt1, DefHT dt2 -> eq_def_type dt1 dt2
  | _, _ -> t1 = t2

and eq_ref_type t1 t2 =
  match t1, t2 with
  | (nul1, t1'), (nul2, t2') ->
    eq_nullability nul1 nul2 && eq_heap_type t1' t2'

and eq_val_type t1 t2 =
  match t1, t2 with
  | NumT t1', NumT t2' -> eq_num_type t1' t2'
  | VecT t1', VecT t2' -> eq_vec_type t1' t2'
  | RefT t1', RefT t2' -> eq_ref_type t1' t2'
  | BotT, BotT -> true
  | _, _ -> false

and eq_result_type ts1 ts2 =
  List.length ts1 = List.length ts2 &&
  List.for_all2 eq_val_type ts1 ts2

and eq_func_type (FuncT (ts11, ts12)) (FuncT (ts21, ts22)) =
  eq_result_type ts11 ts21 && eq_result_type ts12 ts22

and eq_def_type dt1 dt2 =
  match dt1, dt2 with
  | DefFuncT ft1, DefFuncT ft2 -> eq_func_type ft1 ft2


let eq_table_type (TableT (lim1, t1)) (TableT (lim2, t2)) =
  eq_limits lim1 lim2 && eq_ref_type t1 t2

let eq_memory_type (MemoryT lim1) (MemoryT lim2) =
  eq_limits lim1 lim2

let eq_global_type (GlobalT (mut1, t1)) (GlobalT (mut2, t2)) =
  eq_mutability mut1 mut2 && eq_val_type t1 t2

let eq_extern_type et1 et2 =
  match et1, et2 with
  | ExternFuncT ft1, ExternFuncT ft2 -> eq_func_type ft1 ft2
  | ExternTableT tt1, ExternTableT tt2 -> eq_table_type tt1 tt2
  | ExternMemoryT mt1, ExternMemoryT mt2 -> eq_memory_type mt1 mt2
  | ExternGlobalT gt1, ExternGlobalT gt2 -> eq_global_type gt1 gt2
  | _, _ -> false


(* Subtyping *)

let match_nullability nul1 nul2 =
  match nul1, nul2 with
  | NoNull, Null -> true
  | _, _ -> nul1 = nul2

let match_limits lim1 lim2 =
  I32.ge_u lim1.min lim2.min &&
  match lim1.max, lim2.max with
  | _, None -> true
  | None, Some _ -> false
  | Some i, Some j -> I32.le_u i j

let match_num_type t1 t2 =
  t1 = t2

let match_vec_type t1 t2 =
  t1 = t2

let rec match_heap_type t1 t2 =
  match t1, t2 with
  | DefHT (DefFuncT _), FuncHT -> true
  | DefHT dt1, DefHT dt2 -> match_def_type dt1 dt2
  | BotHT, _ -> true
  | _, _ -> eq_heap_type t1 t2

and match_ref_type t1 t2 =
  match t1, t2 with
  | (nul1, t1'), (nul2, t2') ->
    match_nullability nul1 nul2 && match_heap_type t1' t2'

and match_val_type t1 t2 =
  match t1, t2 with
  | NumT t1', NumT t2' -> match_num_type t1' t2'
  | VecT t1', VecT t2' -> match_vec_type t1' t2'
  | RefT t1', RefT t2' -> match_ref_type t1' t2'
  | BotT, _ -> true
  | _, _ -> false

and match_result_type ts1 ts2 =
  List.length ts1 = List.length ts2 &&
  List.for_all2 match_val_type ts1 ts2

and match_func_type ft1 ft2 =
  eq_func_type ft1 ft2

and match_def_type dt1 dt2 =
  match dt1, dt2 with
  | DefFuncT ft1, DefFuncT ft2 -> match_func_type ft1 ft2

let match_table_type (TableT (lim1, t1)) (TableT (lim2, t2)) =
  match_limits lim1 lim2 && eq_ref_type t1 t2

let match_memory_type (MemoryT lim1) (MemoryT lim2) =
  match_limits lim1 lim2

let match_global_type (GlobalT (mut1, t1)) (GlobalT (mut2, t2)) =
  eq_mutability mut1 mut2 &&
  match mut1 with
  | Cons -> match_val_type t1 t2
  | Var -> eq_val_type t1 t2

let match_extern_type et1 et2 =
  match et1, et2 with
  | ExternFuncT ft1, ExternFuncT ft2 -> match_func_type ft1 ft2
  | ExternTableT tt1, ExternTableT tt2 -> match_table_type tt1 tt2
  | ExternMemoryT mt1, ExternMemoryT mt2 -> match_memory_type mt1 mt2
  | ExternGlobalT gt1, ExternGlobalT gt2 -> match_global_type gt1 gt2
  | _, _ -> false
