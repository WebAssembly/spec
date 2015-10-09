open Source
open Ast


type labeling = labeling' phrase
and labeling' = Unlabelled | Labelled

let labeling l e =
  match l.it with
  | Unlabelled -> e
  | Labelled -> Label (e @@ l.at)

let expr_seq es =
  match es with
  | [] -> Nop @@ Source.no_region
  | [e] -> e
  | es -> Block es @@@ List.map Source.at es


let nop =
  Nop

let block (l, es) =
 labeling l (Block es)

let if_ (e1, e2, eo) =
  let e3 = Lib.Option.get eo (Nop @@ Source.after e2.at) in
  If (e1, e2, e3)

let loop (l1, l2, es) =
  let e = expr_seq es in
  labeling l1 (Loop (labeling l2 e.it @@ e.at))

let label e =
  Label e

let break (x, e) =
  Break (x, e)

let return (x, eo) =
  Break (x, eo)

let switch (l, t, e1, cs, e2) =
  labeling l (Switch (t, e1, cs, e2))

let call (x, es) =
  Call (x, es)

let call_import (x, es) =
  CallImport (x, es)

let call_indirect (x, e, es) =
  CallIndirect (x, e, es)

let get_local x =
  GetLocal x

let set_local (x, e) =
  SetLocal (x, e)

let load (memop, e) =
  Load (memop, e)

let store (memop, e1, e2) =
  Store (memop, e1, e2)

let load_extend (extop, e) =
  LoadExtend (extop, e)

let store_wrap (wrapop, e1, e2) =
  StoreWrap (wrapop, e1, e2)

let const c =
  Const c

let unary (unop, e) =
  Unary (unop, e)

let binary (binop, e1, e2) =
  Binary (binop, e1, e2)

let compare (relop, e1, e2) =
  Compare (relop, e1, e2)

let convert (cvt, e) =
  Convert (cvt, e)

let page_size =
  PageSize

let memory_size =
  MemorySize

let resize_memory e =
  ResizeMemory e


let case (c, br) =
  match br with
  | Some (es, fallthru) -> {value = c; expr = expr_seq es; fallthru}
  | None -> {value = c; expr = Nop @@ Source.after c.at; fallthru = true}


let func_body es =
  Label (expr_seq es)
