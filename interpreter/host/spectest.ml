(*
 * Simple collection of functions useful for writing test cases.
 *)

open Types
open Value
open Instance


let global (GlobalType (t, _) as gt) =
  let v =
    match t with
    | NumType I32Type -> Num (I32 666l)
    | NumType I64Type -> Num (I64 666L)
    | NumType F32Type -> Num (F32 (F32.of_float 666.6))
    | NumType F64Type -> Num (F64 (F64.of_float 666.6))
    | VecType V128Type -> Vec (V128 (V128.I32x4.of_lanes [666l; 666l; 666l; 666l]))
    | RefType (_, t) -> Ref (NullRef t)
    | BotType -> assert false
  in ExternGlobal (Global.alloc gt v)

let table =
  let tt = TableType ({min = 10l; max = Some 20l}, (Nullable, FuncHeapType)) in
  ExternTable (Table.alloc tt (NullRef FuncHeapType))

let memory =
  let mt = MemoryType {min = 1l; max = Some 2l} in
  ExternMemory (Memory.alloc mt)

let func f ft =
  let x = Types.alloc_uninit () in
  Types.init x (RecCtxType ([(SemVar x, SubType ([], FuncDefType ft))], 0l));
  ExternFunc (Func.alloc_host x (f ft))


let print_value v =
  Printf.printf "%s : %s\n"
    (string_of_value v) (string_of_value_type (type_of_value v))

let print (FuncType (_, out)) vs =
  List.iter print_value vs;
  flush_all ();
  List.map default_value out


let lookup name t =
  match Utf8.encode name, t with
  | "print", _ -> func print (FuncType ([], []))
  | "print_i32", _ -> func print (FuncType ([NumType I32Type], []))
  | "print_i64", _ -> func print (FuncType ([NumType I64Type], []))
  | "print_f32", _ -> func print (FuncType ([NumType F32Type], []))
  | "print_f64", _ -> func print (FuncType ([NumType F64Type], []))
  | "print_i32_f32", _ ->
    func print (FuncType ([NumType I32Type; NumType F32Type], []))
  | "print_f64_f64", _ ->
    func print (FuncType ([NumType F64Type; NumType F64Type], []))
  | "global_i32", _ -> global (GlobalType (NumType I32Type, Immutable))
  | "global_i64", _ -> global (GlobalType (NumType I64Type, Immutable))
  | "global_f32", _ -> global (GlobalType (NumType F32Type, Immutable))
  | "global_f64", _ -> global (GlobalType (NumType F64Type, Immutable))
  | "table", _ -> table
  | "memory", _ -> memory
  | "debug_print", ExternFuncType x ->
    func print (as_func_str_type (expand_ctx_type (def_of (as_sem_var x))))
  | _ -> raise Not_found
