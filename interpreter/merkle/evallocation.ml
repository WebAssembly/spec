
open Ast
open Source
open Values
open Types


let do_it x f = {x with it=f x.it}

let it e = {it=e; at=no_region}

let rec process_inst stepper inst = match inst.it with
 | Block (ty, lst) -> [it (Block (ty, List.flatten (List.map (process_inst stepper) lst)))]
 (* at start of each loop, there could be a counter *)
 | Loop (ty, lst) -> [it (Loop (ty, List.flatten (stepper :: List.map (process_inst stepper) lst)))]
 | If (ty, l1, l2) -> [it (If (ty, List.flatten (List.map (process_inst stepper) l1), List.flatten (List.map (process_inst stepper) l2)))]
 | a -> [it a]

let process_function stepper f =
  do_it f (fun f -> {f with body=List.flatten (stepper :: List.map (process_inst stepper) f.body)})

let process m =
  do_it m (fun m ->
    let stepper = [
      it (Const (it (I32 (Int32.of_int 256)))); it (Const (it (I32 (Int32.of_int 256)))); it (Load {ty=I32Type; align=0; offset=Int32.of_int 0; sz=None});
      it (Const (it (I32 (Int32.of_int 1)))); it (Binary (I32 I32Op.Add));
      it (Store {ty=I32Type; align=0; offset=Int32.of_int 0; sz=None});
    ] in
    {m with funcs=List.map (process_function stepper) m.funcs})

