(* Types *)

type name = int list

and syn_var = int32
and sem_var = def_type Lib.Promise.t
and var = SynVar of syn_var | SemVar of sem_var

and mutability = Immutable | Mutable
and nullability = NonNullable | Nullable

and pack_size = Pack8 | Pack16 | Pack32
and extension = SX | ZX

and num_type = I32Type | I64Type | F32Type | F64Type
and ref_type = nullability * heap_type
and heap_type =
  | AnyHeapType
  | EqHeapType
  | I31HeapType
  | DataHeapType
  | ArrayHeapType
  | FuncHeapType
  | DefHeapType of var
  | RttHeapType of var * int32 option
  | BotHeapType

and value_type = NumType of num_type | RefType of ref_type | BotType
and result_type = value_type list

and storage_type =
  ValueStorageType of value_type | PackedStorageType of pack_size
and field_type = FieldType of storage_type * mutability

and struct_type = StructType of field_type list
and array_type = ArrayType of field_type
and func_type = FuncType of result_type * result_type

and def_type =
  | StructDefType of struct_type
  | ArrayDefType of array_type
  | FuncDefType of func_type

type 'a limits = {min : 'a; max : 'a option}
type table_type = TableType of Int32.t limits * ref_type
type memory_type = MemoryType of Int32.t limits
type global_type = GlobalType of value_type * mutability
type extern_type =
  | ExternFuncType of func_type
  | ExternTableType of table_type
  | ExternMemoryType of memory_type
  | ExternGlobalType of global_type

type export_type = ExportType of extern_type * name
type import_type = ImportType of extern_type * name * name
type module_type =
  ModuleType of def_type list * import_type list * export_type list


(* Attributes *)

let size = function
  | I32Type | F32Type -> 4
  | I64Type | F64Type -> 8

let packed_size = function
  | Pack8 -> 1
  | Pack16 -> 2
  | Pack32 -> 4


let is_packed_storage_type = function
  | ValueStorageType _ -> false
  | PackedStorageType _ -> true


let is_syn_var = function SynVar _ -> true | SemVar _ -> false
let is_sem_var = function SemVar _ -> true | SynVar _ -> false

let as_syn_var = function SynVar x -> x | SemVar _ -> assert false
let as_sem_var = function SemVar x -> x | SynVar _ -> assert false


let is_num_type = function
  | NumType _ | BotType -> true
  | RefType _ -> false

let is_ref_type = function
  | NumType _ -> false
  | RefType _ | BotType -> true


let defaultable_num_type = function
  | _ -> true

let defaultable_ref_type = function
  | (nul, _) -> nul = Nullable

let defaultable_value_type = function
  | NumType t -> defaultable_num_type t
  | RefType t -> defaultable_ref_type t
  | BotType -> assert false


(* Projections *)

let unpacked_storage_type = function
  | ValueStorageType t -> t
  | PackedStorageType _ -> NumType I32Type

let unpacked_field_type (FieldType (t, _)) = unpacked_storage_type t


let as_func_def_type (dt : def_type) : func_type =
  match dt with
  | FuncDefType ft -> ft
  | _ -> assert false

let as_struct_def_type (dt : def_type) : struct_type =
  match dt with
  | StructDefType st -> st
  | _ -> assert false

let as_array_def_type (dt : def_type) : array_type =
  match dt with
  | ArrayDefType at -> at
  | _ -> assert false

let extern_type_of_import_type (ImportType (et, _, _)) = et
let extern_type_of_export_type (ExportType (et, _)) = et


(* Filters *)

let funcs =
  Lib.List.map_filter (function ExternFuncType t -> Some t | _ -> None)
let tables =
  Lib.List.map_filter (function ExternTableType t -> Some t | _ -> None)
let memories =
  Lib.List.map_filter (function ExternMemoryType t -> Some t | _ -> None)
let globals =
  Lib.List.map_filter (function ExternGlobalType t -> Some t | _ -> None)


(* Allocation *)

let alloc_uninit () = Lib.Promise.make ()
let init p dt = Lib.Promise.fulfill p dt
let alloc dt = let p = alloc_uninit () in init p dt; p

let def_of x = Lib.Promise.value x


(* Conversion *)

let sem_var_type c = function
  | SynVar x -> SemVar (Lib.List32.nth c x)
  | SemVar _ -> assert false

let sem_num_type c t = t

let sem_heap_type c = function
  | AnyHeapType -> AnyHeapType
  | EqHeapType -> EqHeapType
  | I31HeapType -> I31HeapType
  | DataHeapType -> DataHeapType
  | ArrayHeapType -> ArrayHeapType
  | FuncHeapType -> FuncHeapType
  | DefHeapType x -> DefHeapType (sem_var_type c x)
  | RttHeapType (x, no) -> RttHeapType (sem_var_type c x, no)
  | BotHeapType -> BotHeapType

let sem_ref_type c = function
  | (nul, t) -> (nul, sem_heap_type c t)

let sem_value_type c = function
  | NumType t -> NumType (sem_num_type c t)
  | RefType t -> RefType (sem_ref_type c t)
  | BotType -> BotType

let sem_stack_type c ts =
 List.map (sem_value_type c) ts

let sem_storage_type c = function
  | ValueStorageType t -> ValueStorageType (sem_value_type c t)
  | PackedStorageType sz -> PackedStorageType sz

let sem_field_type c = function
  | FieldType (t, mut) -> FieldType (sem_storage_type c t, mut)

let sem_struct_type c = function
  | StructType ts -> StructType (List.map (sem_field_type c) ts)

let sem_array_type c = function
  | ArrayType t -> ArrayType (sem_field_type c t)

let sem_func_type c (FuncType (ins, out)) =
  FuncType (sem_stack_type c ins, sem_stack_type c out)

let sem_def_type c = function
  | StructDefType st -> StructDefType (sem_struct_type c st)
  | ArrayDefType at -> ArrayDefType (sem_array_type c at)
  | FuncDefType ft -> FuncDefType (sem_func_type c ft)


let sem_memory_type c (MemoryType lim) =
  MemoryType lim

let sem_table_type c (TableType (lim, t)) =
  TableType (lim, sem_ref_type c t)

let sem_global_type c (GlobalType (t, mut)) =
  GlobalType (sem_value_type c t, mut)

let sem_extern_type c = function
  | ExternFuncType ft -> ExternFuncType (sem_func_type c ft)
  | ExternTableType tt -> ExternTableType (sem_table_type c tt)
  | ExternMemoryType mt -> ExternMemoryType (sem_memory_type c mt)
  | ExternGlobalType gt -> ExternGlobalType (sem_global_type c gt)


let sem_export_type c (ExportType (et, name)) =
  ExportType (sem_extern_type c et, name)

let sem_import_type c (ImportType (et, module_name, name)) =
  ImportType (sem_extern_type c et, module_name, name)

let sem_module_type (ModuleType (dts, its, ets)) =
  let c = List.map (fun _ -> alloc_uninit ()) dts in
  List.iter2 (fun x dt -> init x (sem_def_type c dt)) c dts;
  let its = List.map (sem_import_type c) its in
  let ets = List.map (sem_export_type c) ets in
  ModuleType ([], its, ets)


(* String conversion *)

let string_of_name n =
  let b = Buffer.create 16 in
  let escape uc =
    if uc < 0x20 || uc >= 0x7f then
      Buffer.add_string b (Printf.sprintf "\\u{%02x}" uc)
    else begin
      let c = Char.chr uc in
      if c = '\"' || c = '\\' then Buffer.add_char b '\\';
      Buffer.add_char b c
    end
  in
  List.iter escape n;
  Buffer.contents b

let rec string_of_var =
  let inner = ref [] in
  function
  | SynVar x -> I32.to_string_u x
  | SemVar x ->
    let h = Hashtbl.hash x in
    string_of_int h ^
    if List.mem h !inner then "" else
    ( inner := h :: !inner;
      try
        let s = string_of_def_type (def_of x) in
        inner := List.tl !inner; "=(" ^ s ^ ")"
      with exn -> inner := []; raise exn
    )


and string_of_nullability = function
  | NonNullable -> ""
  | Nullable -> "null "

and string_of_mutability s = function
  | Immutable -> s
  | Mutable -> "(mut " ^ s ^ ")"

and string_of_num_type = function
  | I32Type -> "i32"
  | I64Type -> "i64"
  | F32Type -> "f32"
  | F64Type -> "f64"

and string_of_heap_type = function
  | AnyHeapType -> "any"
  | EqHeapType -> "eq"
  | I31HeapType -> "i31"
  | DataHeapType -> "data"
  | ArrayHeapType -> "array"
  | FuncHeapType -> "func"
  | DefHeapType x -> string_of_var x
  | RttHeapType (x, None) -> "(rtt " ^ string_of_var x ^ ")"
  | RttHeapType (x, Some n) ->
    "(rtt " ^ Int32.to_string n ^ " " ^ string_of_var x ^ ")"
  | BotHeapType -> "something"

and string_of_ref_type = function
  | (nul, t) ->
    "(ref " ^ string_of_nullability nul ^ string_of_heap_type t ^ ")"

and string_of_value_type = function
  | NumType t -> string_of_num_type t
  | RefType t -> string_of_ref_type t
  | BotType -> "(something)"

and string_of_result_type ts =
  "[" ^ String.concat " " (List.map string_of_value_type ts) ^ "]"

and string_of_storage_type = function
  | ValueStorageType t -> string_of_value_type t
  | PackedStorageType sz -> "i" ^ string_of_int (8 * packed_size sz)

and string_of_field_type = function
  | FieldType (t, mut) -> string_of_mutability (string_of_storage_type t) mut

and string_of_struct_type = function
  | StructType fts ->
    String.concat " " (List.map (fun ft -> "(field " ^ string_of_field_type ft ^ ")") fts)

and string_of_array_type = function
  | ArrayType ft -> string_of_field_type ft

and string_of_func_type = function
  | FuncType (ins, out) ->
    string_of_result_type ins ^ " -> " ^ string_of_result_type out

and string_of_def_type = function
  | StructDefType st -> "struct " ^ string_of_struct_type st
  | ArrayDefType at -> "array " ^ string_of_array_type at
  | FuncDefType ft -> "func " ^ string_of_func_type ft


let string_of_limits {min; max} =
  I32.to_string_u min ^
  (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

let string_of_memory_type = function
  | MemoryType lim -> string_of_limits lim

let string_of_table_type = function
  | TableType (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

let string_of_global_type = function
  | GlobalType (t, mut) -> string_of_mutability (string_of_value_type t) mut

let string_of_extern_type = function
  | ExternFuncType ft -> "func " ^ string_of_func_type ft
  | ExternTableType tt -> "table " ^ string_of_table_type tt
  | ExternMemoryType mt -> "memory " ^ string_of_memory_type mt
  | ExternGlobalType gt -> "global " ^ string_of_global_type gt


let string_of_export_type (ExportType (et, name)) =
  "\"" ^ string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_import_type (ImportType (et, module_name, name)) =
  "\"" ^ string_of_name module_name ^ "\" \"" ^
    string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_module_type (ModuleType (dts, its, ets)) =
  String.concat "" (
    List.mapi (fun i dt -> "type " ^ string_of_int i ^ " = " ^ string_of_def_type dt ^ "\n") dts @
    List.map (fun it -> "import " ^ string_of_import_type it ^ "\n") its @
    List.map (fun et -> "export " ^ string_of_export_type et ^ "\n") ets
  )
