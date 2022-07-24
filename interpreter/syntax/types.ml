(* Indices and Names *)

type type_idx = int32
type local_idx = int32
type name = Utf8.unicode

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


(* Generic Types *)

module type Var =
sig
  type var
  val eq_var : var -> var -> bool
  val string_of_var : var -> string
end

module Make (Var : Var) =
struct
  include Var

  type init = [`Set | `Unset]
  type nullability = [`NoNull | `Null]
  type num_type = [`I32 | `I64 | `F32 | `F64]
  type vec_type = [`V128]
  type heap_type = [`Func | `Extern | `Def of var | `Bot]
  type ref_type = [`Ref of nullability * heap_type]
  type val_type = [num_type | vec_type | ref_type | `Bot]

  type result_type = val_type list
  type instr_type = [`Instr of result_type * result_type * local_idx list]
  type func_type = [`Func of result_type * result_type]
  type def_type = func_type

  type 'a limits = {min : 'a; max : 'a option}
  type mutability = [`Const | `Var]
  type table_type = [`Table of Int32.t limits * ref_type]
  type memory_type = [`Memory of Int32.t limits]
  type global_type = [`Global of mutability * val_type]
  type local_type = [`Local of init * val_type]
  type extern_type = [func_type | table_type | memory_type | global_type]

  type export_type = [`Export of extern_type * name]
  type import_type = [`Import of extern_type * name * name]
  type module_type =
    [`Module of def_type list * import_type list * export_type list]


  (* Attributes *)

  let num_size : num_type -> int = function
    | `I32 | `F32 -> 4
    | `I64 | `F64 -> 8

  let vec_size : vec_type -> int = function
    | `V128 -> 16

  let is_num_type : val_type -> bool = function
    | #num_type | `Bot -> true
    | _ -> false

  let is_vec_type : val_type -> bool = function
    | #vec_type | `Bot -> true
    | _ -> false

  let is_ref_type : val_type -> bool = function
    | #ref_type | `Bot -> true
    | _ -> false

  let defaultable : [< val_type] -> bool = function
    | #num_type -> true
    | #vec_type -> true
    | `Ref (nul, _) -> nul = `Null
    | `Bot -> assert false


  (* Projections *)

  let as_func_def_type (dt : def_type) : func_type =
    match dt with
    | #func_type as ft -> ft

  let extern_type_of_import_type (`Import (et, _, _)) = et
  let extern_type_of_export_type (`Export (et, _)) = et


  (* Filters *)

  let funcs (ets : extern_type list) : func_type list =
    Lib.List.map_filter (function #func_type as ft -> Some ft | _ -> None) ets
  let tables (ets : extern_type list) : table_type list =
    Lib.List.map_filter (function #table_type as tt -> Some tt | _ -> None) ets
  let memories (ets : extern_type list) : memory_type list =
    Lib.List.map_filter (function #memory_type as mt -> Some mt | _ -> None) ets
  let globals (ets : extern_type list) : global_type list =
    Lib.List.map_filter (function #global_type as gt -> Some gt | _ -> None) ets


  (* String conversion *)

  let string_of_nullability : nullability -> string = function
    | `NoNull -> ""
    | `Null -> "null "

  let string_of_num_type : num_type -> string = function
    | `I32 -> "i32"
    | `I64 -> "i64"
    | `F32 -> "f32"
    | `F64 -> "f64"

  let string_of_vec_type : vec_type -> string = function
    | `V128 -> "v128"

  let string_of_heap_type : heap_type -> string = function
    | `Func -> "func"
    | `Extern -> "extern"
    | `Def x -> string_of_var x
    | `Bot -> "something"

  let string_of_ref_type : ref_type -> string = function
    | `Ref (nul, t) ->
      "(ref " ^ string_of_nullability nul ^ string_of_heap_type t ^ ")"

  let string_of_val_type : val_type -> string = function
    | #num_type as t -> string_of_num_type t
    | #vec_type as t -> string_of_vec_type t
    | #ref_type as t -> string_of_ref_type t
    | `Bot -> "(something)"

  let string_of_result_type : result_type -> string = function
    | ts -> "[" ^ String.concat " " (List.map string_of_val_type ts) ^ "]"

  let string_of_func_type : func_type -> string = function
    | `Func (ts1, ts2) ->
      string_of_result_type ts1 ^ " -> " ^ string_of_result_type ts2

  let string_of_def_type : def_type -> string = function
    | #func_type as ft -> "func " ^ string_of_func_type ft


  let string_of_limits : I32.t limits -> string = function
    | {min; max} ->
      I32.to_string_u min ^
      (match max with None -> "" | Some n -> " " ^ I32.to_string_u n)

  let string_of_memory_type : memory_type -> string = function
    | `Memory lim -> string_of_limits lim

  let string_of_table_type : table_type -> string = function
    | `Table (lim, t) -> string_of_limits lim ^ " " ^ string_of_ref_type t

  let string_of_global_type : global_type -> string = function
    | `Global (`Const, t) -> string_of_val_type t
    | `Global (`Var, t) -> "(mut " ^ string_of_val_type t ^ ")"

  let string_of_local_type : local_type -> string = function
    | `Local (`Set, t) -> string_of_val_type t
    | `Local (`Unset, t) -> "(unset " ^ string_of_val_type t ^ ")"

  let string_of_extern_type : extern_type -> string = function
    | #func_type as ft -> "func " ^ string_of_func_type ft
    | #table_type as tt -> "table " ^ string_of_table_type tt
    | #memory_type as mt -> "memory " ^ string_of_memory_type mt
    | #global_type as gt -> "global " ^ string_of_global_type gt


  let string_of_export_type : export_type -> string = function
    | `Export (et, name) ->
      "\"" ^ string_of_name name ^ "\" : " ^ string_of_extern_type et

  let string_of_import_type : import_type -> string = function
    | `Import (et, module_name, name) ->
      "\"" ^ string_of_name module_name ^ "\" \"" ^
        string_of_name name ^ "\" : " ^ string_of_extern_type et

  let string_of_module_type : module_type -> string = function
    | `Module (dts, its, ets) ->
      String.concat "" (
        List.mapi (fun i dt -> "type " ^ string_of_int i ^ " = " ^ string_of_def_type dt ^ "\n") dts @
        List.map (fun it -> "import " ^ string_of_import_type it ^ "\n") its @
        List.map (fun et -> "export " ^ string_of_export_type et ^ "\n") ets
      )
end


(* Syntactic Types *)

module SynVar =
struct
  type var = type_idx
  let eq_var = (=)
  let string_of_var = string_of_idx
end

module Syn = Make (SynVar)

include Syn


(* Semantic Types *)

module SemVar =
struct
  (* Use extensible type, since recursive modules won't work *)
  type var = ..

  let eq_var = (==)

  let string_of_var' = ref (fun (x : var) -> assert false)
  let string_of_var x = !string_of_var' x
end

module Sem =
struct
  include Make (SemVar)

  type SemVar.var += Var of def_type Lib.Promise.t

  let unwrap = function
    | Var p -> p
    | _ -> assert false

  let alloc_uninit () = Var (Lib.Promise.make ())
  let init x dt = Lib.Promise.fulfill (unwrap x) dt
  let alloc dt = let x = alloc_uninit () in init x dt; x
  let def_of x = Lib.Promise.value (unwrap x)

  let () = SemVar.string_of_var' :=
    let inner = ref false in
    fun x ->
      if !inner then "..." else
      ( inner := true;
        try
          let s = string_of_def_type (def_of x) in
          inner := false; "(" ^ s ^ ")"
        with exn -> inner := false; raise exn
      )

  (* Conversion *)

  let sem_var_type c (x : Syn.var) : var = Lib.List32.nth c x

  let sem_num_type c : Syn.num_type -> num_type = function
    | t -> t

  let sem_vec_type c : Syn.vec_type -> vec_type = function
    | t -> t

  let sem_heap_type c : Syn.heap_type -> heap_type = function
    | `Func -> `Func
    | `Extern -> `Extern
    | `Def x -> `Def (sem_var_type c x)
    | `Bot -> `Bot

  let sem_ref_type c : Syn.ref_type -> ref_type = function
    | `Ref (nul, t) -> `Ref (nul, sem_heap_type c t)

  let sem_val_type c : Syn.val_type -> val_type = function
    | #Syn.num_type as t -> (sem_num_type c t :> val_type)
    | #Syn.vec_type as t -> (sem_vec_type c t :> val_type)
    | #Syn.ref_type as t -> (sem_ref_type c t :> val_type)
    | `Bot -> `Bot

  let sem_result_type c : Syn.result_type -> result_type = function
    | ts -> List.map (sem_val_type c) ts

  let sem_func_type c : Syn.func_type -> func_type = function
    | `Func (ts1, ts2) -> `Func (sem_result_type c ts1, sem_result_type c ts2)

  let sem_def_type c : Syn.def_type -> def_type = function
    | #Syn.func_type as ft -> (sem_func_type c ft :> def_type)

  let sem_limits c : 'a Syn.limits -> 'a limits = function
    | {min; max} -> {min; max}

  let sem_memory_type c : Syn.memory_type -> memory_type = function
    | `Memory lim -> `Memory (sem_limits c lim)

  let sem_table_type c : Syn.table_type -> table_type = function
    | `Table (lim, t) -> `Table (sem_limits c lim, sem_ref_type c t)

  let sem_global_type c : Syn.global_type -> global_type = function
    | `Global (mut, t) -> `Global (mut, sem_val_type c t)

  let sem_extern_type c : Syn.extern_type -> extern_type = function
    | #Syn.func_type as ft -> (sem_func_type c ft :> extern_type)
    | #Syn.table_type as tt -> (sem_table_type c tt :> extern_type)
    | #Syn.memory_type as mt -> (sem_memory_type c mt :> extern_type)
    | #Syn.global_type as gt -> (sem_global_type c gt :> extern_type)

  let sem_export_type c : Syn.export_type -> export_type = function
    | `Export (et, name) -> `Export (sem_extern_type c et, name)

  let sem_import_type c : Syn.import_type -> import_type = function
    | `Import (et, module_name, name) ->
      `Import (sem_extern_type c et, module_name, name)

  let sem_module_type : Syn.module_type -> module_type = function
    | `Module (dts, its, ets) ->
      let c = List.map (fun _ -> alloc_uninit ()) dts in
      List.iter2 (fun x dt -> init x (sem_def_type c dt)) c dts;
      let its = List.map (sem_import_type c) its in
      let ets = List.map (sem_export_type c) ets in
      `Module ([], its, ets)
end
