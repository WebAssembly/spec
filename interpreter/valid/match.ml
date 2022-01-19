open Types

type context = Types.def_type list
type assump = (var * var) list


let lookup c = function
  | SynVar x -> Lib.List32.nth c x
  | SemVar x -> def_of x

let equal_var x y =
  match x, y with
  | SynVar x', SynVar y' -> x' = y'
  | SemVar x', SemVar y' -> x' == y'
  | _ -> assert false

let assuming a (x1, x2) =
  List.find_opt (fun (y1, y2) -> equal_var x1 y1 && equal_var x2 y2) a <> None


(* Equivalence *)

let eq_nullability c a nul1 nul2 =
  nul1 = nul2

let eq_mutability c a mut1 mut2 =
  mut1 = mut2

let eq_limits c a lim1 lim2 =
  lim1.min = lim2.min && lim1.max = lim2.max

let rec eq_num_type c a t1 t2 =
  t1 = t2

and eq_heap_type c a t1 t2 =
  match t1, t2 with
  | DefHeapType x1, DefHeapType x2 -> eq_var_type c a x1 x2
  | RttHeapType (x1, no1), RttHeapType (x2, no2) ->
    eq_var_type c a x1 x2 && no1 = no2
  | _, _ -> t1 = t2

and eq_ref_type c a t1 t2 =
  match t1, t2 with
  | (nul1, t1'), (nul2, t2') ->
    eq_nullability c a nul1 nul2 && eq_heap_type c a t1' t2'

and eq_value_type c a t1 t2 =
  match t1, t2 with
  | NumType t1', NumType t2' -> eq_num_type c a t1' t2'
  | RefType t1', RefType t2' -> eq_ref_type c a t1' t2'
  | _, _ -> false

and eq_result_type c a ts1 ts2 =
  List.length ts1 = List.length ts2 &&
  List.for_all2 (eq_value_type c a) ts1 ts2

and eq_packed_type c a t1 t2 =
  t1 = t2

and eq_storage_type c a st1 st2 =
  match st1, st2 with
  | ValueStorageType t1, ValueStorageType t2 -> eq_value_type c a t1 t2
  | PackedStorageType t1, PackedStorageType t2 -> eq_packed_type c a t1 t2
  | _, _ -> false

and eq_field_type c a (FieldType (st1, mut1)) (FieldType (st2, mut2)) =
  eq_storage_type c a st1 st2 && eq_mutability c a mut1 mut2

and eq_struct_type c a (StructType fts1) (StructType fts2) =
  List.length fts1 = List.length fts2 &&
  List.for_all2 (eq_field_type c a) fts1 fts2

and eq_array_type c a (ArrayType ft1) (ArrayType ft2) =
  eq_field_type c a ft1 ft2

and eq_func_type c a (FuncType (ts11, ts12)) (FuncType (ts21, ts22)) =
  eq_result_type c a ts11 ts21 && eq_result_type c a ts12 ts22

and eq_def_type c a dt1 dt2 =
  match dt1, dt2 with
  | StructDefType st1, StructDefType st2 -> eq_struct_type c a st1 st2
  | ArrayDefType at1, ArrayDefType at2 -> eq_array_type c a at1 at2
  | FuncDefType ft1, FuncDefType ft2 -> eq_func_type c a ft1 ft2
  | _, _ -> false

and eq_var_type c a x1 x2 =
  equal_var x1 x2 || assuming a (x1, x2) ||
  eq_def_type c ((x1, x2)::a) (lookup c x1) (lookup c x2)


and eq_table_type c a (TableType (lim1, t1)) (TableType (lim2, t2)) =
  eq_limits c a lim1 lim2 && eq_ref_type c a t1 t2

and eq_memory_type c a (MemoryType lim1) (MemoryType lim2) =
  eq_limits c a lim1 lim2

and eq_global_type c a (GlobalType (t1, mut1)) (GlobalType (t2, mut2)) =
  eq_mutability c a mut1 mut2 && eq_value_type c a t1 t2

and eq_extern_type c a et1 et2 =
  match et1, et2 with
  | ExternFuncType ft1, ExternFuncType ft2 -> eq_func_type c a ft1 ft2
  | ExternTableType tt1, ExternTableType tt2 -> eq_table_type c a tt1 tt2
  | ExternMemoryType mt1, ExternMemoryType mt2 -> eq_memory_type c a mt1 mt2
  | ExternGlobalType gt1, ExternGlobalType gt2 -> eq_global_type c a gt1 gt2
  | _, _ -> false


(* Subtyping *)

let match_nullability c a nul1 nul2 =
  match nul1, nul2 with
  | NonNullable, Nullable -> true
  | _, _ -> nul1 = nul2

let match_limits c a lim1 lim2 =
  I32.ge_u lim1.min lim2.min &&
  match lim1.max, lim2.max with
  | _, None -> true
  | None, Some _ -> false
  | Some i, Some j -> I32.le_u i j

let rec match_num_type c a t1 t2 =
  t1 = t2

and match_heap_type c a t1 t2 =
  match t1, t2 with
  | _, AnyHeapType -> true
  | I31HeapType, EqHeapType -> true
  | DataHeapType, EqHeapType -> true
  | ArrayHeapType, EqHeapType -> true
  | ArrayHeapType, DataHeapType -> true
  | RttHeapType _, EqHeapType -> true
  | DefHeapType x1, EqHeapType ->
    (match lookup c x1 with
    | StructDefType _ | ArrayDefType _ -> true
    | _ -> false
    )
  | DefHeapType x1, DataHeapType ->
    (match lookup c x1 with
    | StructDefType _ | ArrayDefType _ -> true
    | _ -> false
    )
  | DefHeapType x1, ArrayHeapType ->
    (match lookup c x1 with
    | ArrayDefType _ -> true
    | _ -> false
    )
  | DefHeapType x1, FuncHeapType ->
    (match lookup c x1 with
    | FuncDefType _ -> true
    | _ -> false
    )
  | DefHeapType x1, DefHeapType x2 -> match_var_type c a x1 x2
  | RttHeapType (x1, Some _), RttHeapType (x2, None) -> eq_var_type c [] x1 x2
  | BotHeapType, _ -> true
  | _, _ -> eq_heap_type c [] t1 t2

and match_ref_type c a t1 t2 =
  match t1, t2 with
  | (nul1, t1'), (nul2, t2') ->
    match_nullability c a nul1 nul2 && match_heap_type c a t1' t2'

and match_value_type c a t1 t2 =
  match t1, t2 with
  | NumType t1', NumType t2' -> match_num_type c a t1' t2'
  | RefType t1', RefType t2' -> match_ref_type c a t1' t2'
  | BotType, _ -> true
  | _, _ -> false

and match_result_type c a ts1 ts2 =
  List.length ts1 = List.length ts2 &&
  List.for_all2 (match_value_type c a) ts1 ts2

and match_packed_type c a t1 t2 =
  t1 = t2

and match_storage_type c a st1 st2 =
  match st1, st2 with
  | ValueStorageType t1, ValueStorageType t2 -> match_value_type c a t1 t2
  | PackedStorageType t1, PackedStorageType t2 -> match_packed_type c a t1 t2
  | _, _ -> false

and match_field_type c a (FieldType (st1, mut1)) (FieldType (st2, mut2)) =
  eq_mutability c [] mut1 mut2 &&
  match mut1 with
  | Immutable -> match_storage_type c a st1 st2
  | Mutable -> eq_storage_type c [] st1 st2

and match_struct_type c a (StructType fts1) (StructType fts2) =
  List.length fts1 >= List.length fts2 &&
  List.for_all2 (match_field_type c a)
    (Lib.List.take (List.length fts2) fts1) fts2

and match_array_type c a (ArrayType ft1) (ArrayType ft2) =
  match_field_type c a ft1 ft2

and match_func_type c a ft1 ft2 =
  eq_func_type c [] ft1 ft2

and match_table_type c a (TableType (lim1, t1)) (TableType (lim2, t2)) =
  match_limits c a lim1 lim2 && eq_ref_type c [] t1 t2

and match_memory_type c a (MemoryType lim1) (MemoryType lim2) =
  match_limits c a lim1 lim2

and match_global_type c a (GlobalType (t1, mut1)) (GlobalType (t2, mut2)) =
  eq_mutability c [] mut1 mut2 &&
  match mut1 with
  | Immutable -> match_value_type c a t1 t2
  | Mutable -> eq_value_type c [] t1 t2

and match_extern_type c a et1 et2 =
  match et1, et2 with
  | ExternFuncType ft1, ExternFuncType ft2 -> match_func_type c a ft1 ft2
  | ExternTableType tt1, ExternTableType tt2 -> match_table_type c a tt1 tt2
  | ExternMemoryType mt1, ExternMemoryType mt2 -> match_memory_type c a mt1 mt2
  | ExternGlobalType gt1, ExternGlobalType gt2 -> match_global_type c a gt1 gt2
  | _, _ -> false

and match_def_type c a dt1 dt2 =
  match dt1, dt2 with
  | StructDefType st1, StructDefType st2 -> match_struct_type c a st1 st2
  | ArrayDefType at1, ArrayDefType at2 -> match_array_type c a at1 at2
  | FuncDefType ft1, FuncDefType ft2 -> match_func_type c a ft1 ft2
  | _, _ -> false

and match_var_type c a x1 x2 =
  equal_var x1 x2 || assuming a (x1, x2) ||
  match_def_type c ((x1, x2)::a) (lookup c x1) (lookup c x2)
