(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types.Sem
open Value
open Instance


let global (`Global (_, t) as gt) =
  let v =
    match t with
    | `I32 -> Num (I32 666l)
    | `I64 -> Num (I64 666L)
    | `F32 -> Num (F32 (F32.of_float 666.6))
    | `F64 -> Num (F64 (F64.of_float 666.6))
    | `V128 -> Vec (V128 (V128.I32x4.of_lanes [666l; 666l; 666l; 666l]))
    | `Ref (_, t) -> Ref (NullRef t)
    | `Bot -> assert false
  in Global.alloc gt v

let table =
  Table.alloc (`Table ({min = 10l; max = Some 20l}, `Ref (`Null, `Func)))
    (NullRef `Func)
let memory = Memory.alloc (`Memory {min = 1l; max = Some 2l})
let func f ft = Func.alloc_host (Types.Sem.alloc (ft :> def_type)) (f ft)

let print_value v =
  Printf.printf "%s : %s\n"
    (string_of_value v) (string_of_val_type (type_of_value v))

let print _ vs =
  List.iter print_value vs;
  flush_all ();
  []


let lookup name t =
  match Utf8.encode name, t with
  | "print", _ -> ExternFunc (func print (`Func ([], [])))
  | "print_i32", _ -> ExternFunc (func print (`Func ([`I32], [])))
  | "print_i64", _ -> ExternFunc (func print (`Func ([`I64], [])))
  | "print_f32", _ -> ExternFunc (func print (`Func ([`F32], [])))
  | "print_f64", _ -> ExternFunc (func print (`Func ([`F64], [])))
  | "print_i32_f32", _ -> ExternFunc (func print (`Func ([`I32; `F32], [])))
  | "print_f64_f64", _ -> ExternFunc (func print (`Func ([`F64; `F64], [])))
  | "global_i32", _ -> ExternGlobal (global (`Global (`Const, `I32)))
  | "global_i64", _ -> ExternGlobal (global (`Global (`Const, `I64)))
  | "global_f32", _ -> ExternGlobal (global (`Global (`Const, `F32)))
  | "global_f64", _ -> ExternGlobal (global (`Global (`Const, `F64)))
  | "table", _ -> ExternTable table
  | "memory", _ -> ExternMemory memory
  | _ -> raise Not_found
