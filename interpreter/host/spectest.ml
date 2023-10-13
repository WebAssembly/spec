(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types
open Value
open Instance


let global (GlobalT (_, t) as gt) =
  let v =
    match t with
    | NumT I32T -> Num (I32 666l)
    | NumT I64T -> Num (I64 666L)
    | NumT F32T -> Num (F32 (F32.of_float 666.6))
    | NumT F64T -> Num (F64 (F64.of_float 666.6))
    | VecT V128T -> Vec (V128 (V128.I32x4.of_lanes [666l; 666l; 666l; 666l]))
    | RefT (_, t) -> Ref (NullRef t)
    | BotT -> assert false
  in Global.alloc gt v

let table tt = Table.alloc tt (NullRef BotHT)
let memory mt = Memory.alloc mt
let func f ft = Func.alloc_host ft (f ft)

let print_value v =
  Printf.printf "%s : %s\n"
    (string_of_value v) (string_of_val_type (type_of_value v))

let print _ vs =
  List.iter print_value vs;
  flush_all ();
  []


let lookup name t =
  match Utf8.encode name, t with
  | "print", _ -> ExternFunc (func print (FuncT ([], [])))
  | "print_i32", _ -> ExternFunc (func print (FuncT ([NumT I32T], [])))
  | "print_i64", _ -> ExternFunc (func print (FuncT ([NumT I64T], [])))
  | "print_f32", _ -> ExternFunc (func print (FuncT ([NumT F32T], [])))
  | "print_f64", _ -> ExternFunc (func print (FuncT ([NumT F64T], [])))
  | "print_i32_f32", _ -> ExternFunc (func print (FuncT ([NumT I32T; NumT F32T], [])))
  | "print_f64_f64", _ -> ExternFunc (func print (FuncT ([NumT F64T; NumT F64T], [])))
  | "global_i32", _ -> ExternGlobal (global (GlobalT (Cons, NumT I32T)))
  | "global_i64", _ -> ExternGlobal (global (GlobalT (Cons, NumT I64T)))
  | "global_f32", _ -> ExternGlobal (global (GlobalT (Cons, NumT F32T)))
  | "global_f64", _ -> ExternGlobal (global (GlobalT (Cons, NumT F64T)))
  | "table", _ -> ExternTable (table (TableT ({min = 10l; max = Some 20l}, (Null, FuncHT))))
  | "memory", _ -> ExternMemory (memory (MemoryT {min = 1l; max = Some 2l}))
  | _ -> raise Not_found
