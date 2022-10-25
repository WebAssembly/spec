(* Types *)

type num_type = I32Type | I64Type | F32Type | F64Type
type vec_type = V128Type
type ref_type = FuncRefType | ExternRefType
type value_type = NumType of num_type | VecType of vec_type | RefType of ref_type
type index_type = I32IndexType | I64IndexType
type result_type = value_type list
type func_type = FuncType of result_type * result_type

type 'a limits = {min : 'a; max : 'a option}
type mutability = Immutable | Mutable
type table_type = TableType of Int32.t limits * ref_type
type memory_type = MemoryType of Int64.t limits * index_type
type global_type = GlobalType of value_type * mutability
type extern_type =
  | ExternFuncType of func_type
  | ExternTableType of table_type
  | ExternMemoryType of memory_type
  | ExternGlobalType of global_type

(* TODO: these types should move somewhere else *)
type pack_size = Pack8 | Pack16 | Pack32 | Pack64
type extension = SX | ZX
type pack_shape = Pack8x8 | Pack16x4 | Pack32x2
type vec_extension =
  | ExtLane of pack_shape * extension
  | ExtSplat
  | ExtZero


(* Attributes *)

let num_size = function
  | I32Type | F32Type -> 4
  | I64Type | F64Type -> 8

let vec_size = function
  | V128Type -> 16

let packed_size = function
  | Pack8 -> 1
  | Pack16 -> 2
  | Pack32 -> 4
  | Pack64 -> 8

let packed_shape_size = function
  | Pack8x8 | Pack16x4 | Pack32x2 -> 8

let is_num_type = function
  | NumType _ -> true
  | _ -> false

let is_vec_type = function
  | VecType _ -> true
  | _ -> false

let is_ref_type = function
  | RefType _ -> true
  | _ -> false


(* Filters *)

let funcs =
  Lib.List.map_filter (function ExternFuncType t -> Some t | _ -> None)
let tables =
  Lib.List.map_filter (function ExternTableType t -> Some t | _ -> None)
let memories =
  Lib.List.map_filter (function ExternMemoryType t -> Some t | _ -> None)
let globals =
  Lib.List.map_filter (function ExternGlobalType t -> Some t | _ -> None)

let num_type_of_index_type = function
  | I32IndexType -> I32Type
  | I64IndexType -> I64Type

let value_type_of_index_type t = NumType (num_type_of_index_type t)

(* Subtyping *)

let match_limits ge lim1 lim2 =
  ge lim1.min lim2.min &&
  match lim1.max, lim2.max with
  | _, None -> true
  | None, Some _ -> false
  | Some i, Some j -> ge j i

let match_func_type ft1 ft2 =
  ft1 = ft2

let match_table_type (TableType (lim1, et1)) (TableType (lim2, et2)) =
  et1 = et2 && match_limits I32.ge_u lim1 lim2

let match_memory_type (MemoryType (lim1, it1)) (MemoryType (lim2, it2)) =
  it1 = it2 && match_limits I64.ge_u lim1 lim2

let match_global_type gt1 gt2 =
  gt1 = gt2

let match_extern_type et1 et2 =
  match et1, et2 with
  | ExternFuncType ft1, ExternFuncType ft2 -> match_func_type ft1 ft2
  | ExternTableType tt1, ExternTableType tt2 -> match_table_type tt1 tt2
  | ExternMemoryType mt1, ExternMemoryType mt2 -> match_memory_type mt1 mt2
  | ExternGlobalType gt1, ExternGlobalType gt2 -> match_global_type gt1 gt2
  | _, _ -> false


(* String conversion *)

let string_of_num_type = function
  | I32Type -> "i32"
  | I64Type -> "i64"
  | F32Type -> "f32"
  | F64Type -> "f64"

let string_of_vec_type = function
  | V128Type -> "v128"

let string_of_ref_type = function
  | FuncRefType -> "funcref"
  | ExternRefType -> "externref"

let string_of_refed_type = function
  | FuncRefType -> "func"
  | ExternRefType -> "extern"

let string_of_value_type = function
  | NumType t -> string_of_num_type t
  | VecType t -> string_of_vec_type t
  | RefType t -> string_of_ref_type t

let string_of_value_types = function
  | [t] -> string_of_value_type t
  | ts -> "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"


let string_of_limits to_string {min; max} =
  to_string min ^
  (match max with None -> "" | Some n -> " " ^ to_string n)

let string_of_memory_type = function
  | MemoryType (lim, it) ->
    string_of_num_type (num_type_of_index_type it) ^
    " " ^ string_of_limits I64.to_string_u lim


let string_of_table_type = function
  | TableType (lim, t) -> string_of_limits I32.to_string_u lim ^ " " ^
                          string_of_ref_type t

let string_of_global_type = function
  | GlobalType (t, Immutable) -> string_of_value_type t
  | GlobalType (t, Mutable) -> "(mut " ^ string_of_value_type t ^ ")"

let string_of_result_type ts =
  "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"

let string_of_func_type (FuncType (ins, out)) =
  string_of_result_type ins ^ " -> " ^ string_of_result_type out

let string_of_extern_type = function
  | ExternFuncType ft -> "func " ^ string_of_func_type ft
  | ExternTableType tt -> "table " ^ string_of_table_type tt
  | ExternMemoryType mt -> "memory " ^ string_of_memory_type mt
  | ExternGlobalType gt -> "global " ^ string_of_global_type gt
