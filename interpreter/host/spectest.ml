(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types
open Values
open Instance


let global (GlobalType (t, _) as gt) =
  let v =
    match t with
    | I32Type -> I32 666l
    | I64Type -> I64 666L
    | F32Type -> F32 (F32.of_float 666.6)
    | F64Type -> F64 (F64.of_float 666.6)
  in Global.alloc gt v

let table = Table.alloc (TableType ({min = 10l; max = Some 20l}, AnyFuncType))
let memory = Memory.alloc (MemoryType {min = 1l; max = Some 2l})
let func f t = Func.alloc_host t (f t)

let print_value v =
  Printf.printf "%s : %s\n"
    (Values.string_of_value v) (Types.string_of_value_type (Values.type_of v))

let print (FuncType (_, out)) vs =
  List.iter print_value vs;
  flush_all ();
  List.map default_value out


let lookup name t =
  match Utf8.encode name, t with
  | "print", ExternFuncType t -> ExternFunc (func print t)
  | "print", _ ->
    let t = FuncType ([], []) in ExternFunc (func print t)
  | "global", ExternGlobalType t -> ExternGlobal (global t)
  | "global", _ -> ExternGlobal (global (GlobalType (I32Type, Immutable)))
  | "table", _ -> ExternTable table
  | "memory", _ -> ExternMemory memory
  | _ -> raise Not_found
