(* Types *)

type value_type = Int32Type | Int64Type | Float32Type | Float64Type
type elem_type = AnyFuncType
type expr_type = value_type option
type func_type = {ins : value_type list; out : expr_type}

type 'a limits = {min : 'a; max : 'a option}
type mutability = Immutable | Mutable
type table_type = TableType of Int32.t limits * elem_type
type memory_type = MemoryType of Int32.t limits
type global_type = GlobalType of value_type * mutability
type external_type =
  | ExternalFuncType of func_type
  | ExternalTableType of table_type
  | ExternalMemoryType of memory_type
  | ExternalGlobalType of global_type


(* Attributes *)

let size = function
  | Int32Type | Float32Type -> 4
  | Int64Type | Float64Type -> 8


(* String conversion *)

let string_of_value_type = function
  | Int32Type -> "i32"
  | Int64Type -> "i64"
  | Float32Type -> "f32"
  | Float64Type -> "f64"

let string_of_value_type_list = function
  | [t] -> string_of_value_type t
  | ts -> "(" ^ String.concat " " (List.map string_of_value_type ts) ^ ")"

let string_of_elem_type = function
  | AnyFuncType -> "anyfunc"

let string_of_limits {min; max} =
  I32.to_string min ^
  (match max with None -> "" | Some n -> I32.to_string n)

let string_of_memory_type = function
  | MemoryType lim -> string_of_limits lim

let string_of_table_type = function
  | TableType (lim, t) -> string_of_limits lim ^ " " ^ string_of_elem_type t

let string_of_global_type = function
  | GlobalType (t, Immutable) -> string_of_value_type t
  | GlobalType (t, Mutable) -> "(mut " ^ string_of_value_type t ^ ")"

let string_of_expr_type = function
  | None -> "()"
  | Some t -> string_of_value_type t

let string_of_func_type {ins; out} =
  string_of_value_type_list ins ^ " -> " ^ string_of_expr_type out
