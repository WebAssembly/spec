(* Types *)

type name = int list

and syn_var = int32
and sem_var = ctx_type Lib.Promise.t
and var = SynVar of syn_var | SemVar of sem_var | RecVar of int32

and mutability = Immutable | Mutable
and nullability = NonNullable | Nullable

and pack_size = Pack8 | Pack16 | Pack32 | Pack64

and num_type = I32Type | I64Type | F32Type | F64Type
and vec_type = V128Type
and ref_type = nullability * heap_type
and heap_type =
  | AnyHeapType
  | EqHeapType
  | I31HeapType
  | DataHeapType
  | ArrayHeapType
  | FuncHeapType
  | DefHeapType of var
  | RttHeapType of var
  | BotHeapType
and value_type =
  NumType of num_type | VecType of vec_type | RefType of ref_type | BotType

and result_type = value_type list

and storage_type =
  ValueStorageType of value_type | PackedStorageType of pack_size
and field_type = FieldType of storage_type * mutability

and struct_type = StructType of field_type list
and array_type = ArrayType of field_type
and func_type = FuncType of result_type * result_type

and str_type =
  | StructDefType of struct_type
  | ArrayDefType of array_type
  | FuncDefType of func_type

and sub_type = SubType of var list * str_type
and def_type = RecDefType of sub_type list
and ctx_type = RecCtxType of (var * sub_type) list * int32

type 'a limits = {min : 'a; max : 'a option}
type table_type = TableType of Int32.t limits * ref_type
type memory_type = MemoryType of Int32.t limits
type global_type = GlobalType of value_type * mutability
type extern_type =
  | ExternFuncType of var
  | ExternTableType of table_type
  | ExternMemoryType of memory_type
  | ExternGlobalType of global_type

type export_type = ExportType of extern_type * name
type import_type = ImportType of extern_type * name * name
type module_type =
  ModuleType of def_type list * import_type list * export_type list

(* TODO: these types should move somewhere else *)
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

let value_size = function
  | NumType t -> num_size t
  | VecType t -> vec_size t
  | RefType _ | BotType -> failwith "value_size"

let packed_size = function
  | Pack8 -> 1
  | Pack16 -> 2
  | Pack32 -> 4
  | Pack64 -> 8

let packed_shape_size = function
  | Pack8x8 | Pack16x4 | Pack32x2 -> 8

let storage_size = function
  | PackedStorageType pt -> packed_size pt
  | ValueStorageType t -> value_size t

let is_syn_var = function SynVar _ -> true | _ -> false
let is_sem_var = function SemVar _ -> true | _ -> false
let is_rec_var = function RecVar _ -> true | _ -> false

let as_syn_var = function SynVar x -> x | _ -> assert false
let as_sem_var = function SemVar x -> x | _ -> assert false
let as_rec_var = function RecVar x -> x | _ -> assert false


let is_num_type = function
  | NumType _ | BotType -> true
  | _ -> false

let is_vec_type = function
  | VecType _ | BotType -> true
  | _ -> false

let is_ref_type = function
  | RefType _ | BotType -> true
  | _ -> false


let defaultable_num_type = function
  | _ -> true

let defaultable_vec_type = function
  | _ -> true

let defaultable_ref_type = function
  | (nul, _) -> nul = Nullable

let defaultable_value_type = function
  | NumType t -> defaultable_num_type t
  | VecType t -> defaultable_vec_type t
  | RefType t -> defaultable_ref_type t
  | BotType -> assert false


let is_packed_storage_type = function
  | ValueStorageType _ -> false
  | PackedStorageType _ -> true


(* Projections *)

let unpacked_storage_type = function
  | ValueStorageType t -> t
  | PackedStorageType _ -> NumType I32Type

let unpacked_field_type (FieldType (t, _)) = unpacked_storage_type t


let as_func_str_type (st : str_type) : func_type =
  match st with
  | FuncDefType ft -> ft
  | _ -> assert false

let as_struct_str_type (st : str_type) : struct_type =
  match st with
  | StructDefType st -> st
  | _ -> assert false

let as_array_str_type (st : str_type) : array_type =
  match st with
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
let init p ct = Lib.Promise.fulfill p ct
let alloc ct = let p = alloc_uninit () in init p ct; p

let def_of x = Lib.Promise.value x


(* Substitution *)

let subst_num_type s t = t

let subst_vec_type s t = t

let subst_heap_type s = function
  | AnyHeapType -> AnyHeapType
  | EqHeapType -> EqHeapType
  | I31HeapType -> I31HeapType
  | DataHeapType -> DataHeapType
  | ArrayHeapType -> ArrayHeapType
  | FuncHeapType -> FuncHeapType
  | DefHeapType x -> DefHeapType (s x)
  | RttHeapType x -> RttHeapType (s x)
  | BotHeapType -> BotHeapType

let subst_ref_type s = function
  | (nul, t) -> (nul, subst_heap_type s t)

let subst_value_type s = function
  | NumType t -> NumType (subst_num_type s t)
  | VecType t -> VecType (subst_vec_type s t)
  | RefType t -> RefType (subst_ref_type s t)
  | BotType -> BotType

let subst_stack_type s ts =
 List.map (subst_value_type s) ts

let subst_storage_type s = function
  | ValueStorageType t -> ValueStorageType (subst_value_type s t)
  | PackedStorageType sz -> PackedStorageType sz

let subst_field_type s = function
  | FieldType (t, mut) -> FieldType (subst_storage_type s t, mut)

let subst_struct_type s = function
  | StructType ts -> StructType (List.map (subst_field_type s) ts)

let subst_array_type s = function
  | ArrayType t -> ArrayType (subst_field_type s t)

let subst_func_type s (FuncType (ts1, ts2)) =
  FuncType (subst_stack_type s ts1, subst_stack_type s ts2)

let subst_str_type s = function
  | StructDefType st -> StructDefType (subst_struct_type s st)
  | ArrayDefType at -> ArrayDefType (subst_array_type s at)
  | FuncDefType ft -> FuncDefType (subst_func_type s ft)

let subst_sub_type s = function
  | SubType (xs, st) ->
    SubType (List.map s xs, subst_str_type s st)

let subst_def_type s = function
  | RecDefType sts -> RecDefType (List.map (subst_sub_type s) sts)

let subst_rec_type s (x, st) = (s x, subst_sub_type s st)

let subst_ctx_type s = function
  | RecCtxType (rts, i) -> RecCtxType (List.map (subst_rec_type s) rts, i)


let subst_memory_type s (MemoryType lim) =
  MemoryType lim

let subst_table_type s (TableType (lim, t)) =
  TableType (lim, subst_ref_type s t)

let subst_global_type s (GlobalType (t, mut)) =
  GlobalType (subst_value_type s t, mut)

let subst_extern_type s = function
  | ExternFuncType x -> ExternFuncType (s x)
  | ExternTableType tt -> ExternTableType (subst_table_type s tt)
  | ExternMemoryType mt -> ExternMemoryType (subst_memory_type s mt)
  | ExternGlobalType gt -> ExternGlobalType (subst_global_type s gt)


let subst_export_type s (ExportType (et, name)) =
  ExportType (subst_extern_type s et, name)

let subst_import_type s (ImportType (et, module_name, name)) =
  ImportType (subst_extern_type s et, module_name, name)


(* Recursive types *)

let ctx_types_of_def_type x (dt : def_type) : ctx_type list =
  match dt with
  | RecDefType sts ->
    let rts = Lib.List32.mapi (fun i st -> (SynVar (Int32.add x i), st)) sts in
    Lib.List32.mapi (fun i _ -> RecCtxType (rts, i)) sts

let ctx_types_of_def_types (dts : def_type list) : ctx_type list =
  let rec iter x dts =
    match dts with
    | [] -> []
    | dt::dts' ->
      let cts = ctx_types_of_def_type x dt in
      cts @ iter (Int32.add x (Lib.List32.length cts)) dts'
  in iter 0l dts


let unroll_ctx_type (ct : ctx_type) : sub_type =
  match ct with
  | RecCtxType (rts, i) -> snd (Lib.List32.nth rts i)

let expand_ctx_type (ct : ctx_type) : str_type =
  match unroll_ctx_type ct with
  | SubType (_, st) -> st


(* Conversion *)

let sem_var_type c = function
  | SynVar x -> SemVar (Lib.List32.nth c x)
  | SemVar _ -> assert false
  | RecVar x -> RecVar x

let sem_heap_type c = subst_heap_type (sem_var_type c)
let sem_value_type c = subst_value_type (sem_var_type c)
let sem_func_type c = subst_func_type (sem_var_type c)
let sem_memory_type c = subst_memory_type (sem_var_type c)
let sem_table_type c = subst_table_type (sem_var_type c)
let sem_global_type c = subst_global_type (sem_var_type c)
let sem_extern_type c = subst_extern_type (sem_var_type c)

let sem_sub_type c = subst_sub_type (sem_var_type c)
let sem_ctx_type c = subst_ctx_type (sem_var_type c)

let sem_module_type (ModuleType (dts, its, ets)) =
  let cts = ctx_types_of_def_types dts in
  let c = List.map (fun _ -> alloc_uninit ()) cts in
  let s = sem_var_type c in
  List.iter2 (fun x ct -> init x (subst_ctx_type s ct)) c cts;
  let its = List.map (subst_import_type s) its in
  let ets = List.map (subst_export_type s) ets in
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
        let s = string_of_ctx_type (def_of x) in
        inner := List.tl !inner; "=(" ^ s ^ ")"
      with exn -> inner := []; raise exn
    )
  | RecVar x -> "rec." ^ I32.to_string_u x


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

and string_of_vec_type = function
  | V128Type -> "v128"

and string_of_heap_type = function
  | AnyHeapType -> "any"
  | EqHeapType -> "eq"
  | I31HeapType -> "i31"
  | DataHeapType -> "data"
  | ArrayHeapType -> "array"
  | FuncHeapType -> "func"
  | DefHeapType x -> string_of_var x
  | RttHeapType x -> "(rtt " ^ string_of_var x ^ ")"
  | BotHeapType -> "something"

and string_of_ref_type = function
  | (nul, t) ->
    "(ref " ^ string_of_nullability nul ^ string_of_heap_type t ^ ")"

and string_of_value_type = function
  | NumType t -> string_of_num_type t
  | VecType t -> string_of_vec_type t
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

and string_of_str_type = function
  | StructDefType st -> "struct " ^ string_of_struct_type st
  | ArrayDefType at -> "array " ^ string_of_array_type at
  | FuncDefType ft -> "func " ^ string_of_func_type ft

and string_of_sub_type = function
  | SubType ([], st) -> string_of_str_type st
  | SubType (xs, st) ->
    String.concat " " ("sub" :: List.map string_of_var xs) ^
    " (" ^ string_of_str_type st ^ ")"

and string_of_def_type = function
  | RecDefType [st] -> string_of_sub_type st
  | RecDefType sts ->
    "rec " ^
    String.concat " " (List.map (fun st -> "(" ^ string_of_sub_type st ^ ")") sts)

and string_of_ctx_type = function
  | RecCtxType ([(_, st)], 0l) -> string_of_sub_type st
  | RecCtxType (rts, i) ->
    "(" ^ string_of_def_type (RecDefType (List.map snd rts)) ^ ")." ^
      I32.to_string_u i


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
  | ExternFuncType x -> "func " ^ string_of_var x
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
