(* Generic Types *)

type type_idx = int32
type local_idx = int32
type name = Utf8.unicode

type null = NoNull | Null
type mut = Cons | Var
type init = Set | Unset
type 'a limits = {min : 'a; max : 'a option}

type type_addr = ..
type var = Stat of type_idx | Dyn of type_addr

type num_type = I32T | I64T | F32T | F64T
type vec_type = V128T
type heap_type = FuncHT | ExternHT | DefHT of var | BotHT
type ref_type = null * heap_type
type val_type = NumT of num_type | VecT of vec_type | RefT of ref_type | BotT

type result_type = val_type list
type instr_type = InstrT of result_type * result_type * local_idx list
type func_type = FuncT of result_type * result_type
type def_type = DefFuncT of func_type

type table_type = TableT of Int32.t limits * ref_type
type memory_type = MemoryT of Int32.t limits
type global_type = GlobalT of mut * val_type
type local_type = LocalT of init * val_type
type extern_type =
  | ExternFuncT of func_type
  | ExternTableT of table_type
  | ExternMemoryT of memory_type
  | ExternGlobalT of global_type

type export_type = ExportT of extern_type * name
type import_type = ImportT of extern_type * name * name
type module_type =
  | ModuleT of def_type list * import_type list * export_type list


(* Attributes *)

let num_size : num_type -> int = function
  | I32T | F32T -> 4
  | I64T | F64T -> 8

let vec_size : vec_type -> int = function
  | V128T -> 16

let is_num_type : val_type -> bool = function
  | NumT _ | BotT -> true
  | _ -> false

let is_vec_type : val_type -> bool = function
  | VecT _ | BotT -> true
  | _ -> false

let is_ref_type : val_type -> bool = function
  | RefT _ | BotT -> true
  | _ -> false

let defaultable : val_type -> bool = function
  | NumT _ -> true
  | VecT _ -> true
  | RefT (nul, _) -> nul = Null
  | BotT -> assert false


(* Projections *)

let as_func_def_type (dt : def_type) : func_type =
  match dt with
  | DefFuncT ft -> ft

let extern_type_of_import_type (ImportT (et, _, _)) = et
let extern_type_of_export_type (ExportT (et, _)) = et


(* Filters *)

let funcs (ets : extern_type list) : func_type list =
  Lib.List.map_filter (function ExternFuncT ft -> Some ft | _ -> None) ets
let tables (ets : extern_type list) : table_type list =
  Lib.List.map_filter (function ExternTableT tt -> Some tt | _ -> None) ets
let memories (ets : extern_type list) : memory_type list =
  Lib.List.map_filter (function ExternMemoryT mt -> Some mt | _ -> None) ets
let globals (ets : extern_type list) : global_type list =
  Lib.List.map_filter (function ExternGlobalT gt -> Some gt | _ -> None) ets


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

let string_of_null : null -> string = function
  | NoNull -> ""
  | Null -> "null "

let string_of_addr' = ref (fun (a : type_addr) -> assert false)
let string_of_addr a = !string_of_addr' a

let string_of_var : var -> string = function
  | Stat x -> I32.to_string_u x
  | Dyn a -> string_of_addr a

let string_of_num_type : num_type -> string = function
  | I32T -> "i32"
  | I64T -> "i64"
  | F32T -> "f32"
  | F64T -> "f64"

let string_of_vec_type : vec_type -> string = function
  | V128T -> "v128"

let string_of_heap_type : heap_type -> string = function
  | FuncHT -> "func"
  | ExternHT -> "extern"
  | DefHT x -> string_of_var x
  | BotHT -> "something"

let string_of_ref_type : ref_type -> string = function
  | (nul, t) ->
    "(ref " ^ string_of_null nul ^ string_of_heap_type t ^ ")"

let string_of_val_type : val_type -> string = function
  | NumT t -> string_of_num_type t
  | VecT t -> string_of_vec_type t
  | RefT t -> string_of_ref_type t
  | BotT -> "(something)"

let string_of_result_type : result_type -> string = function
  | ts -> "[" ^ String.concat " " (List.map string_of_val_type ts) ^ "]"

let string_of_func_type : func_type -> string = function
  | FuncT (ts1, ts2) ->
    string_of_result_type ts1 ^ " -> " ^ string_of_result_type ts2

let string_of_def_type : def_type -> string = function
  | DefFuncT ft -> "func " ^ string_of_func_type ft


let string_of_limits : I32.t limits -> string = function
  | {min; max} ->
    I32.to_string_u min ^
    (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

let string_of_memory_type : memory_type -> string = function
  | MemoryT lim -> string_of_limits lim

let string_of_table_type : table_type -> string = function
  | TableT (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

let string_of_global_type : global_type -> string = function
  | GlobalT (Cons, t) -> string_of_val_type t
  | GlobalT (Var, t) -> "(mut " ^ string_of_val_type t ^ ")"

let string_of_local_type : local_type -> string = function
  | LocalT (Set, t) -> string_of_val_type t
  | LocalT (Unset, t) -> "(unset " ^ string_of_val_type t ^ ")"

let string_of_extern_type : extern_type -> string = function
  | ExternFuncT ft -> "func " ^ string_of_func_type ft
  | ExternTableT tt -> "table " ^ string_of_table_type tt
  | ExternMemoryT mt -> "memory " ^ string_of_memory_type mt
  | ExternGlobalT gt -> "global " ^ string_of_global_type gt


let string_of_export_type : export_type -> string = function
  | ExportT (et, name) ->
    "\"" ^ string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_import_type : import_type -> string = function
  | ImportT (et, module_name, name) ->
    "\"" ^ string_of_name module_name ^ "\" \"" ^
      string_of_name name ^ "\" : " ^ string_of_extern_type et

let string_of_module_type : module_type -> string = function
  | ModuleT (dts, its, ets) ->
    String.concat "" (
      List.mapi (fun i dt -> "type " ^ string_of_int i ^ " = " ^ string_of_def_type dt ^ "\n") dts @
      List.map (fun it -> "import " ^ string_of_import_type it ^ "\n") its @
      List.map (fun et -> "export " ^ string_of_export_type et ^ "\n") ets
    )


(* Dynamic Types *)

type type_addr += Addr of def_type Lib.Promise.t

let unwrap = function
  | Addr p -> p
  | _ -> assert false

let alloc_uninit () = Addr (Lib.Promise.make ())
let init x dt = Lib.Promise.fulfill (unwrap x) dt
let alloc dt = let x = alloc_uninit () in init x dt; x
let def_of x = Lib.Promise.value (unwrap x)

let () = string_of_addr' :=
  let inner = ref false in
  fun x ->
    if !inner then "..." else
    ( inner := true;
      try
        let s = string_of_def_type (def_of x) in
        inner := false; "(" ^ s ^ ")"
      with exn -> inner := false; raise exn
    )


(* Instantiation *)

let dyn_var_type c = function
  | Stat x -> Dyn (Lib.List32.nth c x)
  | Dyn a -> assert false

let dyn_num_type c = function
  | t -> t

let dyn_vec_type c = function
  | t -> t

let dyn_heap_type c = function
  | FuncHT -> FuncHT
  | ExternHT -> ExternHT
  | DefHT x -> DefHT (dyn_var_type c x)
  | BotHT -> BotHT

let dyn_ref_type c = function
  | (nul, t) -> (nul, dyn_heap_type c t)

let dyn_val_type c = function
  | NumT t -> NumT (dyn_num_type c t)
  | VecT t -> VecT (dyn_vec_type c t)
  | RefT t -> RefT (dyn_ref_type c t)
  | BotT -> BotT

let dyn_result_type c = function
  | ts -> List.map (dyn_val_type c) ts

let dyn_func_type c = function
  | FuncT (ts1, ts2) -> FuncT (dyn_result_type c ts1, dyn_result_type c ts2)

let dyn_def_type c = function
  | DefFuncT ft -> DefFuncT (dyn_func_type c ft)

let dyn_local_type c = function
  | LocalT (init, t) -> LocalT (init, dyn_val_type c t)

let dyn_memory_type c = function
  | MemoryT lim -> MemoryT lim

let dyn_table_type c = function
  | TableT (lim, t) -> TableT (lim, dyn_ref_type c t)

let dyn_global_type c = function
  | GlobalT (mut, t) -> GlobalT (mut, dyn_val_type c t)

let dyn_extern_type c = function
  | ExternFuncT ft -> ExternFuncT (dyn_func_type c ft)
  | ExternTableT tt -> ExternTableT (dyn_table_type c tt)
  | ExternMemoryT mt -> ExternMemoryT (dyn_memory_type c mt)
  | ExternGlobalT gt -> ExternGlobalT (dyn_global_type c gt)

let dyn_export_type c = function
  | ExportT (et, name) -> ExportT (dyn_extern_type c et, name)

let dyn_import_type c = function
  | ImportT (et, module_name, name) ->
    ImportT (dyn_extern_type c et, module_name, name)

let dyn_module_type = function
  | ModuleT (dts, its, ets) ->
    let c = List.map (fun _ -> alloc_uninit ()) dts in
    List.iter2 (fun a dt -> init a (dyn_def_type c dt)) c dts;
    let its = List.map (dyn_import_type c) its in
    let ets = List.map (dyn_export_type c) ets in
    ModuleT ([], its, ets)
