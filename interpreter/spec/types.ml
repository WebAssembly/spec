(* Types *)

type value_type = I32Type | I64Type | F32Type | F64Type
type elem_type = AnyFuncType
type stack_type = value_type list
type func_type = FuncType of stack_type * stack_type

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
  | I32Type | F32Type -> 4
  | I64Type | F64Type -> 8


(* Filters *)

let rec funcs = function
  | [] -> []
  | ExternalFuncType ft :: ets -> ft :: funcs ets
  | _ :: ets -> funcs ets

let rec tables = function
  | [] -> []
  | ExternalTableType tt :: ets -> tt :: tables ets
  | _ :: ets -> tables ets

let rec memories = function
  | [] -> []
  | ExternalMemoryType mt :: ets -> mt :: memories ets
  | _ :: ets -> memories ets

let rec globals = function
  | [] -> []
  | ExternalGlobalType ft :: ets -> ft :: globals ets
  | _ :: ets -> globals ets


(* String conversion *)

let string_of_value_type = function
  | I32Type -> "i32"
  | I64Type -> "i64"
  | F32Type -> "f32"
  | F64Type -> "f64"

let string_of_value_types = function
  | [t] -> string_of_value_type t
  | ts -> "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"

let string_of_elem_type = function
  | AnyFuncType -> "anyfunc"

let string_of_limits {min; max} =
  I32.to_string_u min ^
  (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

let string_of_memory_type = function
  | MemoryType lim -> string_of_limits lim

let string_of_table_type = function
  | TableType (lim, t) -> string_of_limits lim ^ " " ^ string_of_elem_type t

let string_of_global_type = function
  | GlobalType (t, Immutable) -> string_of_value_type t
  | GlobalType (t, Mutable) -> "(mut " ^ string_of_value_type t ^ ")"

let string_of_stack_type ts =
  "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"

let string_of_func_type (FuncType (ins, out)) =
  string_of_stack_type ins ^ " -> " ^ string_of_stack_type out
