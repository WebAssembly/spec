(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types
open Values
open Instance


let global (GlobalType (t, _)) =
  match t with
  | I32Type -> I32 666l
  | I64Type -> I64 666L
  | F32Type -> F32 (F32.of_float 666.6)
  | F64Type -> F64 (F64.of_float 666.6)

let table = Table.create AnyFuncType {min = 10l; max = Some 20l}
let memory = Memory.create {min = 1l; max = Some 2l}

let print_value v =
  Printf.printf "%s : %s\n"
    (Values.string_of_value v) (Types.string_of_value_type (Values.type_of v))

let print (FuncType (_, out)) vs =
  List.iter print_value vs;
  flush_all ();
  List.map default_value out


let lookup name t =
  match Utf8.encode name, t with
  | "print", ExternalFuncType t -> ExternalFunc (HostFunc (t, print t))
  | "print", _ ->
    let t = FuncType ([], []) in ExternalFunc (HostFunc (t, print t))
  | "global", ExternalGlobalType t -> ExternalGlobal (global t)
  | "global", _ -> ExternalGlobal (global (GlobalType (I32Type, Immutable)))
  | "table", _ -> ExternalTable table
  | "memory", _ -> ExternalMemory memory
  | _ -> raise Not_found
