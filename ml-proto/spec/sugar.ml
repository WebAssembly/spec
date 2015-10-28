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

let if_else (e1, e2, e3) =
  If (e1, e2, e3)

let if_ (e1, e2) =
  If (e1, e2, Nop @@ Source.after e2.at)

let br_if (e, x) =
  if_ (e, Branch (x, None) @@ x.at)

let loop (l1, l2, es) =
  let e = expr_seq es in
  if l2.it = Unlabelled then Loop e else labeling l1 (Loop e)

let label e =
  Label e

let br (x, e) =
  Branch (x, e)

let return (x, eo) =
  Branch (x, eo)

let tableswitch (l, e, cs) =
  labeling l (Switch (e, cs))

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

let host (hostop, es) =
  Host (hostop, es)


let case (c, es) =
  {value = Some c; expr = expr_seq es}

let case_br (c, x) =
  {value = Some c; expr = Branch (x, None) @@ x.at}

let default (es) =
  {value = None; expr = expr_seq es}

let default_br (x) =
  {value = None; expr = Branch (x, None) @@ x.at}


let func_body es =
  Label (expr_seq es)
