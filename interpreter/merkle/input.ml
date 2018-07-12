(*
 * External functions for reading input from the block chain.
 *
 * Based on interpreter/host/env.ml
 *)

open Values
open Types
open Instance

let read vs = [I64 1234L]

let lookup name t =
  match Utf8.encode name, t with
  | "read", ExternalFuncType (FuncType ([I64Type],[I64Type])) ->
    ExternalFunc (HostFunc (FuncType ([I64Type], [I64Type]), read))
  | _ -> raise Not_found

