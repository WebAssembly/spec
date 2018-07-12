
open Ast
open Source
open Types
open Values

let do_it x f = {x with it=f x.it}

let it e = {it=e; at=no_region}

let rec process_inst stepper inst = match inst.it with
 | Block (ty, lst) -> List.map it [GetGlobal stepper; Const (it (I64 1L)); Operators.i64_add; SetGlobal stepper; (Block (ty, List.flatten (List.map (process_inst stepper) lst)))]
 | Loop (ty, lst) -> List.map it [GetGlobal stepper; Const (it (I64 1L)); Operators.i64_add; SetGlobal stepper; (Loop (ty, List.flatten (List.map (process_inst stepper) lst)))]
 | If (ty, l1, l2) -> List.map it [ GetGlobal stepper; Const (it (I64 1L)); Operators.i64_add; SetGlobal stepper; (If (ty, List.flatten (List.map (process_inst stepper) l1), List.flatten (List.map (process_inst stepper) l2)))]
 | Br _ as a -> List.map it [GetGlobal stepper; Const (it (I64 1L)); Operators.i64_add; SetGlobal stepper; a]
 | Return as a ->  List.map it [GetGlobal stepper; Const (it (I64 1L)); Operators.i64_add; SetGlobal stepper; a]
 | a -> List.map it [a]

let process_function stepper f =
  do_it f (fun f -> {f with body=List.flatten (List.map (process_inst stepper) f.body)})

let process m =
  do_it m (fun m ->
    let stepper = it (Int32.of_int (List.length m.globals)) in
    {m with funcs=List.map (process_function stepper) m.funcs; globals=m.globals @ [it {gtype=GlobalType (I64Type, Mutable); value=it [it (Const (it (I64 0L)))]}]})


