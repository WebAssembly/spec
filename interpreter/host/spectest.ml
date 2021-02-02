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

let table = Table.alloc (TableType ({min = 10l; max = Some 20l}, FuncRefType))
let memory = Memory.alloc (MemoryType ({min = 1L; max = Some 2L}, I32IndexType))
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
  | "print", _ -> ExternFunc (func print (FuncType ([], [])))
  | "print_i32", _ -> ExternFunc (func print (FuncType ([I32Type], [])))
  | "print_i32_f32", _ ->
    ExternFunc (func print (FuncType ([I32Type; F32Type], [])))
  | "print_f64_f64", _ ->
    ExternFunc (func print (FuncType ([F64Type; F64Type], [])))
  | "print_f32", _ -> ExternFunc (func print (FuncType ([F32Type], [])))
  | "print_f64", _ -> ExternFunc (func print (FuncType ([F64Type], [])))
  | "global_i32", _ -> ExternGlobal (global (GlobalType (I32Type, Immutable)))
  | "global_f32", _ -> ExternGlobal (global (GlobalType (F32Type, Immutable)))
  | "global_f64", _ -> ExternGlobal (global (GlobalType (F64Type, Immutable)))
  | "table", _ -> ExternTable table
  | "memory", _ -> ExternMemory memory
  | _ -> raise Not_found
