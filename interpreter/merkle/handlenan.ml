
open Ast
open Source
open Types
open Values
open Operators

let do_it x f = {x with it=f x.it}

let it e = {it=e; at=no_region}

type ctx = {
   save32: var;
   save64: var;
}

let rec process_inst stepper inst = match inst.it with
 | Block (ty, lst) -> [it (Block (ty, List.flatten (List.map (process_inst stepper) lst)))]
 | Loop (ty, lst) -> [it (Loop (ty, List.flatten (List.map (process_inst stepper) lst)))]
 | If (ty, l1, l2) -> [it (If (ty, List.flatten (List.map (process_inst stepper) l1), List.flatten (List.map (process_inst stepper) l2)))]
 | ( Store {ty=F32Type; _}
   | Convert (I32 I32Op.ReinterpretFloat) 
   | Binary (F32 F32Op.CopySign)) as a ->
   List.map it [
      SetGlobal stepper.save32;
      GetGlobal stepper.save32;
      GetGlobal stepper.save32;
      f32_ne;
      If ([F32Type], List.map it [Const (it (F32 F32.neg_nan))],
                     List.map it [GetGlobal stepper.save32]);
      a]
 | ( Store {ty=F64Type; _}
   | Convert (I64 I64Op.ReinterpretFloat) 
   | Binary (F64 F64Op.CopySign)) as a ->
   List.map it [
      SetGlobal stepper.save64;
      GetGlobal stepper.save64;
      GetGlobal stepper.save64;
      f64_ne;
      If ([F64Type], List.map it [Const (it (F64 F64.neg_nan))],
                     List.map it [GetGlobal stepper.save64]);
      a]
 | a -> [it a]

let process_function stepper f =
  do_it f (fun f -> {f with body=List.flatten (List.map (process_inst stepper) f.body)})

let process m =
  do_it m (fun m ->
    let stepper = {
      save32 = it (Int32.of_int (List.length m.globals));
      save64 = it (Int32.of_int (List.length m.globals + 1)) } in
    {m with funcs=List.map (process_function stepper) m.funcs; globals=m.globals @
     [it {gtype=GlobalType (F32Type, Mutable); value=it [it (Const (it (F32 (F32.of_bits 0l))))]};
      it {gtype=GlobalType (F64Type, Mutable); value=it [it (Const (it (F64 (F64.of_bits 0L))))]}
    ]})



