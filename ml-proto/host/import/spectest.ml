(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types
open Values


let global = function
  | Int32Type -> Int32 666l
  | Int64Type -> Int64 666L
  | Float32Type -> Float32 (F32.of_float 666.0)
  | Float64Type -> Float64 (F64.of_float 666.0)

let table = Table.create {min = 10l; max = Some 20l}
let memory = Memory.create {min = 1l; max = Some 2l}

let print out vs =
  List.iter Print.print_value (List.map (fun v -> Some v) vs);
  Lib.Option.map default_value out


open Instance

let lookup name t =
  match name, t with
  | "print", ExternalFuncType ft -> ExternalFunc (HostFunc (print ft.out))
  | "print", _ -> ExternalFunc (HostFunc (print None))
  | "global", ExternalGlobalType (GlobalType (t, _)) -> ExternalGlobal (global t)
  | "global", _ -> ExternalGlobal (global Int32Type)
  | "table", _ -> ExternalTable table
  | "memory", _ -> ExternalMemory memory
  | _ -> raise Not_found
