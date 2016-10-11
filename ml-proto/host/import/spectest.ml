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

let print (FuncType (_, out)) vs =
  List.iter Print.print_result (List.map (fun v -> [v]) vs);
  List.map default_value out


let lookup name t =
  match name, t with
  | "print", ExternalFuncType t -> ExternalFunc (HostFunc (t, print t))
  | "print", _ ->
    let t = FuncType ([], []) in ExternalFunc (HostFunc (t, print t))
  | "global", ExternalGlobalType t -> ExternalGlobal (global t)
  | "global", _ -> ExternalGlobal (global (GlobalType (I32Type, Immutable)))
  | "table", _ -> ExternalTable table
  | "memory", _ -> ExternalMemory memory
  | _ -> raise Not_found
