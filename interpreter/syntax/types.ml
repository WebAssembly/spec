(* Generic Types *)

type type_idx = int32
type local_idx = int32
type name = Utf8.unicode

type null = NoNull | Null
type mut = Cons | Var
type init = Set | Unset
type 'a limits = {min : 'a; max : 'a option}

type var = StatX of type_idx

type num_type = I32T | I64T | F32T | F64T
type vec_type = V128T
type heap_type = FuncHT | ExternHT | VarHT of var | DefHT of def_type | BotHT
and ref_type = null * heap_type
and val_type = NumT of num_type | VecT of vec_type | RefT of ref_type | BotT

and result_type = val_type list
and instr_type = InstrT of result_type * result_type * local_idx list
and func_type = FuncT of result_type * result_type
and def_type = DefFuncT of func_type

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
type module_type = ModuleT of import_type list * export_type list


(* Attributes *)

let num_size = function
  | I32T | F32T -> 4
  | I64T | F64T -> 8

let vec_size = function
  | V128T -> 16

let is_num_type = function
  | NumT _ | BotT -> true
  | _ -> false

let is_vec_type = function
  | VecT _ | BotT -> true
  | _ -> false

let is_ref_type = function
  | RefT _ | BotT -> true
  | _ -> false

let defaultable = function
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

let string_of_var = function
  | StatX x -> I32.to_string_u x

let string_of_null = function
  | NoNull -> ""
  | Null -> "null "

let string_of_limits = function
  | {min; max} ->
    I32.to_string_u min ^
    (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)


let string_of_num_type = function
  | I32T -> "i32"
  | I64T -> "i64"
  | F32T -> "f32"
  | F64T -> "f64"

let string_of_vec_type = function
  | V128T -> "v128"

let rec string_of_heap_type = function
  | FuncHT -> "func"
  | ExternHT -> "extern"
  | VarHT x -> string_of_var x
  | DefHT dt -> string_of_def_type dt
  | BotHT -> "none"

and string_of_ref_type = function
  | (nul, t) ->
    "(ref " ^ string_of_null nul ^ string_of_heap_type t ^ ")"

and string_of_val_type = function
  | NumT t -> string_of_num_type t
  | VecT t -> string_of_vec_type t
  | RefT t -> string_of_ref_type t
  | BotT -> "bot"

and string_of_result_type = function
  | ts -> "[" ^ String.concat " " (List.map string_of_val_type ts) ^ "]"

and string_of_func_type = function
  | FuncT (ts1, ts2) ->
    string_of_result_type ts1 ^ " -> " ^ string_of_result_type ts2

and string_of_def_type = function
  | DefFuncT ft -> "func " ^ string_of_func_type ft


let string_of_memory_type = function
  | MemoryT lim -> string_of_limits lim

let string_of_table_type = function
  | TableT (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

let string_of_global_type = function
  | GlobalT (Cons, t) -> string_of_val_type t
  | GlobalT (Var, t) -> "(mut " ^ string_of_val_type t ^ ")"

let string_of_local_type = function
  | LocalT (Set, t) -> string_of_val_type t
  | LocalT (Unset, t) -> "(unset " ^ string_of_val_type t ^ ")"

let string_of_extern_type = function
  | ExternFuncT ft -> "func " ^ string_of_func_type ft
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
  | ModuleT (its, ets) ->
    String.concat "" (
      List.map (fun it -> "import " ^ string_of_import_type it ^ "\n") its @
      List.map (fun et -> "export " ^ string_of_export_type et ^ "\n") ets
    )


(* Substitution *)

type subst = var -> heap_type

let subst_num_type s t = t

let subst_vec_type s t = t

let subst_heap_type s = function
  | FuncHT -> FuncHT
  | ExternHT -> ExternHT
  | VarHT x -> s x
  | DefHT ht -> DefHT ht  (* assume closed *)
  | BotHT -> BotHT

let subst_ref_type s = function
  | (nul, t) -> (nul, subst_heap_type s t)

let subst_val_type s = function
  | NumT t -> NumT (subst_num_type s t)
  | VecT t -> VecT (subst_vec_type s t)
  | RefT t -> RefT (subst_ref_type s t)
  | BotT -> BotT

let subst_result_type s = function
  | ts -> List.map (subst_val_type s) ts

let subst_func_type s = function
  | FuncT (ts1, ts2) -> FuncT (subst_result_type s ts1, subst_result_type s ts2)

let subst_def_type s = function
  | DefFuncT ft -> DefFuncT (subst_func_type s ft)

let subst_memory_type s = function
  | MemoryT lim -> MemoryT lim

let subst_table_type s = function
  | TableT (lim, t) -> TableT (lim, subst_ref_type s t)

let subst_global_type s = function
  | GlobalT (mut, t) ->  GlobalT (mut, subst_val_type s t)

let subst_extern_type s = function
  | ExternFuncT ft -> ExternFuncT (subst_func_type s ft)
  | ExternTableT tt -> ExternTableT (subst_table_type s tt)
  | ExternMemoryT mt -> ExternMemoryT (subst_memory_type s mt)
  | ExternGlobalT gt -> ExternGlobalT (subst_global_type s gt)

let subst_export_type s = function
  | ExportT (et, name) -> ExportT (subst_extern_type s et, name)

let subst_import_type s = function
  | ImportT (et, module_name, name) ->
    ImportT (subst_extern_type s et, module_name, name)

let subst_module_type s = function
  | ModuleT (its, ets) ->
    ModuleT (
      List.map (subst_import_type s) its,
      List.map (subst_export_type s) ets
    )
