open Source
open Ast


type labeling = labeling' phrase
and labeling' = Unlabelled | Labelled

type case = case' phrase
and case' = Case of var | Case_br of var


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
  if_ (e, Break (x, None) @@ x.at)

let loop (l1, l2, es) =
  let e = expr_seq es in
  if l2.it = Unlabelled then Loop e else labeling l1 (Loop e)

let label e =
  Label e

let br (x, e) =
  Break (x, e)

let return (x, eo) =
  Break (x, eo)

let tableswitch (l, e, cs, c, es) =
  let case c (xs, es') =
    match c.it with
    | Case x -> x :: xs, es'
    | Case_br x ->
      (List.length es' @@ c.at) :: xs, (Break (x, None) @@ c.at) :: es'
  in
  let xs, es' = List.fold_right case (c :: cs) ([], []) in
  let es'' = List.map expr_seq es in
  let n = List.length es' in
  let sh x = (if x.it >= n then x.it + n else x.it) @@ x.at in
  labeling l (Switch (e, List.map sh (List.tl xs), sh (List.hd xs), es' @ es''))

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

let select (selop, cond, e1, e2) =
  Select (selop, cond, e1, e2)

let compare (relop, e1, e2) =
  Compare (relop, e1, e2)

let convert (cvt, e) =
  Convert (cvt, e)

let unreachable =
  Unreachable

let host (hostop, es) =
  Host (hostop, es)


let func_body es =
  Label (expr_seq es)
