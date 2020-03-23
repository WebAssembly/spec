(* Types *)

type var = Int32.t

type nullability = NonNullable | Nullable
type num_type = I32Type | I64Type | F32Type | F64Type
type ref_type =
  | NullRefType
  | AnyRefType
  | FuncRefType
  | DefRefType of nullability * var

type value_type = NumType of num_type | RefType of ref_type | BotType
type stack_type = value_type list
type func_type = FuncType of stack_type * stack_type
type def_type = FuncDefType of func_type

type 'a limits = {min : 'a; max : 'a option}
type mutability = Immutable | Mutable
type table_type = TableType of Int32.t limits * ref_type
type memory_type = MemoryType of Int32.t limits
type global_type = GlobalType of value_type * mutability
type extern_type =
  | ExternFuncType of func_type
  | ExternTableType of table_type
  | ExternMemoryType of memory_type
  | ExternGlobalType of global_type


(* Projections *)

let as_func_def_type (dt : def_type) : func_type =
  match dt with
  | FuncDefType ft -> ft


(* Attributes *)

let size = function
  | I32Type | F32Type -> 4
  | I64Type | F64Type -> 8

let is_num_type = function
  | NumType _ | BotType -> true
  | RefType _ -> false

let is_ref_type = function
  | NumType _ -> false
  | RefType _ | BotType -> true

let defaultable_num_type = function
  | _ -> true

let defaultable_ref_type = function
  | AnyRefType | NullRefType | FuncRefType | DefRefType (Nullable, _) -> true
  | DefRefType (NonNullable, _) -> false

let defaultable_value_type = function
  | NumType t -> defaultable_num_type t
  | RefType t -> defaultable_ref_type t
  | BotType -> false


(* Filters *)

let funcs =
  Lib.List.map_filter (function ExternFuncType t -> Some t | _ -> None)
let tables =
  Lib.List.map_filter (function ExternTableType t -> Some t | _ -> None)
let memories =
  Lib.List.map_filter (function ExternMemoryType t -> Some t | _ -> None)
let globals =
  Lib.List.map_filter (function ExternGlobalType t -> Some t | _ -> None)


(* String conversion *)

let string_of_nullability = function
  | NonNullable -> ""
  | Nullable -> "null "

let string_of_num_type = function
  | I32Type -> "i32"
  | I64Type -> "i64"
  | F32Type -> "f32"
  | F64Type -> "f64"

let string_of_ref_type = function
  | NullRefType -> "nullref"
  | AnyRefType -> "anyref"
  | FuncRefType -> "funcref"
  | DefRefType (nul, x) ->
    "(ref " ^ string_of_nullability nul ^ Int32.to_string x ^ ")"

let string_of_value_type = function
  | NumType t -> string_of_num_type t
  | RefType t -> string_of_ref_type t
  | BotType -> "impossible"

let string_of_value_types = function
  | [t] -> string_of_value_type t
  | ts -> "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"


let string_of_limits {min; max} =
  I32.to_string_u min ^
  (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

let string_of_memory_type = function
  | MemoryType lim -> string_of_limits lim

let string_of_table_type = function
  | TableType (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

let string_of_global_type = function
  | GlobalType (t, Immutable) -> string_of_value_type t
  | GlobalType (t, Mutable) -> "(mut " ^ string_of_value_type t ^ ")"

let string_of_func_type (FuncType (ins, out)) =
  string_of_value_types ins ^ " -> " ^ string_of_value_types out

let string_of_extern_type = function
  | ExternFuncType ft -> "func " ^ string_of_func_type ft
  | ExternTableType tt -> "table " ^ string_of_table_type tt
  | ExternMemoryType mt -> "memory " ^ string_of_memory_type mt
  | ExternGlobalType gt -> "global " ^ string_of_global_type gt
