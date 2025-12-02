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
  in Some (ExternGlobal (Global.alloc gt v))

let table =
  let tt = TableT (I32AT, {min = 10L; max = Some 20L}, (Null, FuncHT)) in
  Some (ExternTable (Table.alloc tt (NullRef FuncHT)))

let table64 =
  let tt = TableT (I64AT, {min = 10L; max = Some 20L}, (Null, FuncHT)) in
  Some (ExternTable (Table.alloc tt (NullRef FuncHT)))

let memory =
  let mt = MemoryT (I32AT, {min = 1L; max = Some 2L}) in
  Some (ExternMemory (Memory.alloc mt))

let func f ts1 ts2 =
  let dt = DefT (RecT [SubT (Final, [], FuncT (ts1, ts2))], 0l) in
  Some (ExternFunc (Func.alloc_host dt (f ts1 ts2)))

let print_value v =
  Printf.printf "%s : %s\n"
    (string_of_value v) (string_of_valtype (type_of_value v))

let print _ts1 _ts2 vs =
  List.iter print_value vs;
  flush_all ();
  []


let lookup name t =
  match Utf8.encode name, t with
  | "print", _ -> func print [] []
  | "print_i32", _ -> func print [NumT I32T] []
  | "print_i64", _ -> func print [NumT I64T] []
  | "print_f32", _ -> func print [NumT F32T] []
  | "print_f64", _ -> func print [NumT F64T] []
  | "print_i32_f32", _ -> func print [NumT I32T; NumT F32T] []
  | "print_f64_f64", _ -> func print [NumT F64T; NumT F64T] []
  | "global_i32", _ -> global (GlobalT (Cons, NumT I32T))
  | "global_i64", _ -> global (GlobalT (Cons, NumT I64T))
  | "global_f32", _ -> global (GlobalT (Cons, NumT F32T))
  | "global_f64", _ -> global (GlobalT (Cons, NumT F64T))
  | "table", _ -> table
  | "table64", _ -> table64
  | "memory", _ -> memory
  | _ -> None
