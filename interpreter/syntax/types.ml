(* Generic Types *)

type type_idx = int32
type local_idx = int32
type name = Utf8.unicode

type null = NoNull | Null
type mut = Cons | Var
type init = Set | Unset
type 'a limits = {min : 'a; max : 'a option}

type type_addr = ..
type var = StatX of type_idx | DynX of type_addr | RecX of int32

type num_type = I32T | I64T | F32T | F64T
type vec_type = V128T
type heap_type =
  | AnyHT | NoneHT | EqHT | I31HT | StructHT | ArrayHT
  | FuncHT | NoFuncHT
  | ExternHT | NoExternHT
  | DefHT of var
  | BotHT
type ref_type = null * heap_type
type val_type = NumT of num_type | VecT of vec_type | RefT of ref_type | BotT

type result_type = val_type list
type instr_type = InstrT of result_type * result_type * local_idx list

type storage_type = ValStorageT of val_type | PackStorageT of Pack.pack_size
type field_type = FieldT of mut * storage_type

type struct_type = StructT of field_type list
type array_type = ArrayT of field_type
type func_type = FuncT of result_type * result_type

type str_type =
  | DefStructT of struct_type
  | DefArrayT of array_type
  | DefFuncT of func_type

type sub_type = SubT of var list * str_type
type def_type = RecT of sub_type list
type ctx_type = CtxT of (var * sub_type) list * int32

type table_type = TableT of Int32.t limits * ref_type
type memory_type = MemoryT of Int32.t limits
type global_type = GlobalT of mut * val_type
type local_type = LocalT of init * val_type
type extern_type =
  | ExternFuncT of var
  | ExternTableT of table_type
  | ExternMemoryT of memory_type
  | ExternGlobalT of global_type

type export_type = ExportT of extern_type * name
type import_type = ImportT of extern_type * name * name
type module_type =
  | ModuleT of def_type list * import_type list * export_type list


(* Attributes *)

let num_size = function
  | I32T | F32T -> 4
  | I64T | F64T -> 8

let vec_size = function
  | V128T -> 16

let val_size = function
  | NumT t -> num_size t
  | VecT t -> vec_size t
  | RefT _ | BotT -> failwith "val_size"

let storage_size = function
  | ValStorageT t -> val_size t
  | PackStorageT p -> Pack.packed_size p

let is_stat_var = function StatX _ -> true | _ -> false
let is_dyn_var = function DynX _ -> true | _ -> false
let is_rec_var = function RecX _ -> true | _ -> false

let as_stat_var = function StatX x -> x | _ -> assert false
let as_dyn_var = function DynX x -> x | _ -> assert false
let as_rec_var = function RecX x -> x | _ -> assert false


let is_num_type = function
  | NumT _ | BotT -> true
  | _ -> false

let is_vec_type = function
  | VecT _ | BotT -> true
  | _ -> false

let is_ref_type = function
  | RefT _ | BotT -> true
  | _ -> false

let is_packed_storage_type = function
  | ValStorageT _ -> false
  | PackStorageT _ -> true


let defaultable = function
  | NumT _ -> true
  | VecT _ -> true
  | RefT (nul, _) -> nul = Null
  | BotT -> assert false


(* Projections *)

let inv_null = function
  | Null -> NoNull
  | NoNull -> Null

let unpacked_storage_type = function
  | ValStorageT t -> t
  | PackStorageT _ -> NumT I32T

let unpacked_field_type (FieldT (_mut, t)) = unpacked_storage_type t


let as_func_str_type (st : str_type) : func_type =
  match st with
  | DefFuncT ft -> ft
  | _ -> assert false

let as_struct_str_type (st : str_type) : struct_type =
  match st with
  | DefStructT st -> st
  | _ -> assert false

let as_array_str_type (st : str_type) : array_type =
  match st with
  | DefArrayT at -> at
  | _ -> assert false

let extern_type_of_import_type (ImportT (et, _, _)) = et
let extern_type_of_export_type (ExportT (et, _)) = et


(* Filters *)

let funcs = List.filter_map (function ExternFuncT ft -> Some ft | _ -> None)
let tables = List.filter_map (function ExternTableT tt -> Some tt | _ -> None)
let memories = List.filter_map (function ExternMemoryT mt -> Some mt | _ -> None)
let globals = List.filter_map (function ExternGlobalT gt -> Some gt | _ -> None)


(* String conversion *)

let string_of_idx x =
  I32.to_string_u x

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

let string_of_addr' = ref (fun (a : type_addr) -> assert false)
let string_of_addr a = !string_of_addr' a

let string_of_var = function
  | StatX x -> I32.to_string_u x
  | DynX a -> string_of_addr a
  | RecX x -> "rec." ^ I32.to_string_u x

let string_of_null = function
  | NoNull -> ""
  | Null -> "null "

and string_of_mut s = function
  | Cons -> s
  | Var -> "(mut " ^ s ^ ")"


let string_of_num_type = function
  | I32T -> "i32"
  | I64T -> "i64"
  | F32T -> "f32"
  | F64T -> "f64"

let string_of_vec_type = function
  | V128T -> "v128"

let string_of_heap_type = function
  | AnyHT -> "any"
  | NoneHT -> "none"
  | EqHT -> "eq"
  | I31HT -> "i31"
  | StructHT -> "struct"
  | ArrayHT -> "array"
  | FuncHT -> "func"
  | NoFuncHT -> "nofunc"
  | ExternHT -> "extern"
  | NoExternHT -> "noextern"
  | DefHT x -> string_of_var x
  | BotHT -> "something"

let string_of_ref_type = function
  | (nul, t) -> "(ref " ^ string_of_null nul ^ string_of_heap_type t ^ ")"

let string_of_val_type = function
  | NumT t -> string_of_num_type t
  | VecT t -> string_of_vec_type t
  | RefT t -> string_of_ref_type t
  | BotT -> "(something)"

let string_of_result_type = function
  | ts -> "[" ^ String.concat " " (List.map string_of_val_type ts) ^ "]"


let string_of_storage_type = function
  | ValStorageT t -> string_of_val_type t
  | PackStorageT p -> "i" ^ string_of_int (8 * Pack.packed_size p)

let string_of_field_type = function
  | FieldT (mut, t) -> string_of_mut (string_of_storage_type t) mut

let string_of_struct_type = function
  | StructT fts ->
    String.concat " " (List.map (fun ft -> "(field " ^ string_of_field_type ft ^ ")") fts)

let string_of_array_type = function
  | ArrayT ft -> string_of_field_type ft

let string_of_func_type = function
  | FuncT (ts1, ts2) ->
    string_of_result_type ts1 ^ " -> " ^ string_of_result_type ts2

let string_of_str_type = function
  | DefStructT st -> "struct " ^ string_of_struct_type st
  | DefArrayT at -> "array " ^ string_of_array_type at
  | DefFuncT ft -> "func " ^ string_of_func_type ft

let string_of_sub_type = function
  | SubT ([], st) -> string_of_str_type st
  | SubT (xs, st) ->
    String.concat " " ("sub" :: List.map string_of_var xs) ^
    " (" ^ string_of_str_type st ^ ")"

let string_of_def_type = function
  | RecT [st] -> string_of_sub_type st
  | RecT sts ->
    "rec " ^
    String.concat " " (List.map (fun st -> "(" ^ string_of_sub_type st ^ ")") sts)

let string_of_ctx_type = function
  | CtxT ([(_, st)], 0l) -> string_of_sub_type st
  | CtxT (rts, i) ->
    "(" ^ string_of_def_type (RecT (List.map snd rts)) ^ ")." ^ I32.to_string_u i

let string_of_limits = function
  | {min; max} ->
    I32.to_string_u min ^
    (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

let string_of_memory_type = function
  | MemoryT lim -> string_of_limits lim

let string_of_table_type = function
  | TableT (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

let string_of_global_type = function
  | GlobalT (mut, t) -> string_of_mut (string_of_val_type t) mut

let string_of_local_type = function
  | LocalT (Set, t) -> string_of_val_type t
  | LocalT (Unset, t) -> "(unset " ^ string_of_val_type t ^ ")"

let string_of_extern_type = function
  | ExternFuncT x -> "func " ^ string_of_var x
  | ExternTableT tt -> "table " ^ string_of_table_type tt
  | ExternMemoryT mt -> "memory " ^ string_of_memory_type mt
  | ExternGlobalT gt -> "global " ^ string_of_global_type gt


let string_of_export_type = function
  | ExportT (et, name) ->
    "\"" ^ string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_import_type = function
  | ImportT (et, module_name, name) ->
    "\"" ^ string_of_name module_name ^ "\" \"" ^
      string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_module_type = function
  | ModuleT (dts, its, ets) ->
    String.concat "" (
      List.mapi (fun i dt -> "type " ^ string_of_int i ^ " = " ^ string_of_def_type dt ^ "\n") dts @
      List.map (fun it -> "import " ^ string_of_import_type it ^ "\n") its @
      List.map (fun et -> "export " ^ string_of_export_type et ^ "\n") ets
    )


(* Substitution *)

let subst_num_type s t = t

let subst_vec_type s t = t

let subst_heap_type s = function
  | AnyHT -> AnyHT
  | NoneHT -> NoneHT
  | EqHT -> EqHT
  | I31HT -> I31HT
  | StructHT -> StructHT
  | ArrayHT -> ArrayHT
  | FuncHT -> FuncHT
  | NoFuncHT -> NoFuncHT
  | ExternHT -> ExternHT
  | NoExternHT -> NoExternHT
  | DefHT x -> DefHT (s x)
  | BotHT -> BotHT

let subst_ref_type s = function
  | (nul, t) -> (nul, subst_heap_type s t)

let subst_val_type s = function
  | NumT t -> NumT (subst_num_type s t)
  | VecT t -> VecT (subst_vec_type s t)
  | RefT t -> RefT (subst_ref_type s t)
  | BotT -> BotT

let subst_result_type s ts =
 List.map (subst_val_type s) ts


let subst_storage_type s = function
  | ValStorageT t -> ValStorageT (subst_val_type s t)
  | PackStorageT p -> PackStorageT p

let subst_field_type s = function
  | FieldT (mut, t) -> FieldT (mut, subst_storage_type s t)

let subst_struct_type s = function
  | StructT ts -> StructT (List.map (subst_field_type s) ts)

let subst_array_type s = function
  | ArrayT t -> ArrayT (subst_field_type s t)

let subst_func_type s = function
  | FuncT (ts1, ts2) -> FuncT (subst_result_type s ts1, subst_result_type s ts2)

let subst_str_type s = function
  | DefStructT st -> DefStructT (subst_struct_type s st)
  | DefArrayT at -> DefArrayT (subst_array_type s at)
  | DefFuncT ft -> DefFuncT (subst_func_type s ft)

let subst_sub_type s = function
  | SubT (xs, st) -> SubT (List.map s xs, subst_str_type s st)

let subst_def_type s = function
  | RecT sts -> RecT (List.map (subst_sub_type s) sts)

let subst_rec_type s (x, st) = (s x, subst_sub_type s st)

let subst_ctx_type s = function
  | CtxT (rts, i) -> CtxT (List.map (subst_rec_type s) rts, i)


let subst_memory_type s = function
  | MemoryT lim -> MemoryT lim

let subst_table_type s = function
  | TableT (lim, t) -> TableT (lim, subst_ref_type s t)

let subst_global_type s = function
  | GlobalT (mut, t) ->  GlobalT (mut, subst_val_type s t)

let subst_extern_type s = function
  | ExternFuncT x -> ExternFuncT (s x)
  | ExternTableT tt -> ExternTableT (subst_table_type s tt)
  | ExternMemoryT mt -> ExternMemoryT (subst_memory_type s mt)
  | ExternGlobalT gt -> ExternGlobalT (subst_global_type s gt)

let subst_export_type s = function
  | ExportT (et, name) -> ExportT (subst_extern_type s et, name)

let subst_import_type s = function
  | ImportT (et, module_name, name) ->
    ImportT (subst_extern_type s et, module_name, name)


(* Recursive types *)

let ctx_types_of_def_type x (dt : def_type) : ctx_type list =
  match dt with
  | RecT sts ->
    let rts = Lib.List32.mapi (fun i st -> (StatX (Int32.add x i), st)) sts in
    Lib.List32.mapi (fun i _ -> CtxT (rts, i)) sts

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
  | CtxT (rts, i) -> snd (Lib.List32.nth rts i)

let expand_ctx_type (ct : ctx_type) : str_type =
  match unroll_ctx_type ct with
  | SubT (_, st) -> st


(* Dynamic Types *)

type type_addr += Addr of ctx_type Lib.Promise.t

let unwrap = function
  | Addr p -> p
  | _ -> assert false

let alloc_uninit () = Addr (Lib.Promise.make ())
let init x dt = Lib.Promise.fulfill (unwrap x) dt
let alloc dt = let x = alloc_uninit () in init x dt; x
let def_of x = Lib.Promise.value (unwrap x)

let () = string_of_addr' :=
  let inner = ref [] in
  fun x ->
    let h = Hashtbl.hash x land 0xffff in
    Printf.sprintf "@%x" h ^
    if List.mem h !inner then "" else
    ( inner := h :: !inner;
      try
        let s = string_of_ctx_type (def_of x) in
        inner := List.tl !inner; "=(" ^ s ^ ")"
      with exn -> inner := []; raise exn
    )


(* Instantiation *)

let dyn_var_type c = function
  | StatX x -> DynX (Lib.List32.nth c x)
  | DynX _ -> assert false
  | RecX x -> RecX x

let dyn_heap_type c = subst_heap_type (dyn_var_type c)
let dyn_ref_type c = subst_ref_type (dyn_var_type c)
let dyn_val_type c = subst_val_type (dyn_var_type c)
let dyn_func_type c = subst_func_type (dyn_var_type c)
let dyn_memory_type c = subst_memory_type (dyn_var_type c)
let dyn_table_type c = subst_table_type (dyn_var_type c)
let dyn_global_type c = subst_global_type (dyn_var_type c)
let dyn_extern_type c = subst_extern_type (dyn_var_type c)

let dyn_sub_type c = subst_sub_type (dyn_var_type c)
let dyn_ctx_type c = subst_ctx_type (dyn_var_type c)

let dyn_module_type (ModuleT (dts, its, ets)) =
  let cts = ctx_types_of_def_types dts in
  let c = List.map (fun _ -> alloc_uninit ()) cts in
  let s = dyn_var_type c in
  List.iter2 (fun x ct -> init x (subst_ctx_type s ct)) c cts;
  let its = List.map (subst_import_type s) its in
  let ets = List.map (subst_export_type s) ets in
  ModuleT ([], its, ets)
