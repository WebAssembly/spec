open Source
open Ast


let expr_seq es =
  match es with
  | [] -> Nop @@ Source.no_region
  | [e] -> e
  | es -> Block es @@@ List.map Source.at es


let labelled_block at es =
  Label (Block es @@ at)

let if_only (e1, e2) =
  If (e1, e2, Nop @@ Source.after e2.at)

let return (x, eo) =
  Break (x, eo)

let loop_seq at es =
  Loop (expr_seq es)

let labelled_loop_seq at es =
  Label (Loop (expr_seq es) @@ at)

let labelled_loop_seq2 at es =
  Label (Loop (Label (expr_seq es) @@ at) @@ at)

let labelled_switch at (t, e1, arms, e2) =
  Label (Switch (t, e1, arms, e2) @@ at)


let case_seq (l, es, fallthru) =
  {value = l; expr = expr_seq es; fallthru}

let case_only l =
  {value = l; expr = Nop @@ Source.after l.at; fallthru = true}


let func_body es =
  Label (expr_seq es)

