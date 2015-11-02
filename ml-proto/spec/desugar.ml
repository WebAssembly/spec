open Source

module A = Ast
module K = Kernel


(* Expressions *)

let labeling l e' =
  match l.it with
  | A.Unlabelled -> e'
  | A.Labelled -> K.Label (e' @@ l.at)


let rec expr e = expr' e.it @@ e.at
and expr' = function
  | A.Nop -> K.Nop
  | A.Block (l, es) -> labeling l (K.Block (List.map expr es))
  | A.If (e1, e2) -> K.If (expr e1, expr e2, K.Nop @@ Source.after e2.at)
  | A.If_else (e1, e2, e3) -> K.If (expr e1, expr e2, expr e3)
  | A.Br_if (e, x) -> expr' (A.If (e, A.Br (x, None) @@ x.at))
  | A.Loop (l1, l2, es) when l2.it = A.Unlabelled -> K.Loop (seq es)
  | A.Loop (l1, l2, es) -> labeling l1 (K.Loop (seq es))
  | A.Label e -> K.Label (expr e)
  | A.Br (x, eo) -> K.Break (x, Lib.Option.map expr eo)
  | A.Return (x, eo) -> K.Break (x, Lib.Option.map expr eo)
  | A.Tableswitch (l, e, ts, t, es) ->
    let target t (xs, es') =
      match t.it with
      | A.Case x -> x :: xs, es'
      | A.Case_br x ->
        (List.length es' @@ t.at) :: xs, (K.Break (x, None) @@ t.at) :: es'
    in
    let xs, es' = List.fold_right target (t :: ts) ([], []) in
    let es'' = List.map seq es in
    let n = List.length es' in
    let sh x = (if x.it >= n then x.it + n else x.it) @@ x.at in
    labeling l
      (K.Switch (expr e, List.map sh (List.tl xs), sh (List.hd xs), es' @ es''))
  | A.Call (x, es) -> K.Call (x, List.map expr es)
  | A.Call_import (x, es) -> K.CallImport (x, List.map expr es)
  | A.Call_indirect (x, e, es) -> K.CallIndirect (x, expr e, List.map expr es)
  | A.Get_local x -> K.GetLocal x
  | A.Set_local (x, e) -> K.SetLocal (x, expr e)
  | A.Load (memop, e) -> K.Load (memop, expr e)
  | A.Store (memop, e1, e2) -> K.Store (memop, expr e1, expr e2)
  | A.Load_extend (extop, e) -> K.LoadExtend (extop, expr e)
  | A.Store_wrap (wrapop, e1, e2) -> K.StoreWrap (wrapop, expr e1, expr e2)
  | A.Const c -> K.Const c
  | A.Unary (unop, e) -> K.Unary (unop, expr e)
  | A.Binary (binop, e1, e2) -> K.Binary (binop, expr e1, expr e2)
  | A.Select (selop, e1, e2, e3) -> K.Select (selop, expr e1, expr e2, expr e3)
  | A.Compare (relop, e1, e2) -> K.Compare (relop, expr e1, expr e2)
  | A.Convert (cvt, e) -> K.Convert (cvt, expr e)
  | A.Unreachable -> K.Unreachable
  | A.Host (hostop, es) -> K.Host (hostop, List.map expr es)

and seq = function
  | [] -> K.Nop @@ Source.no_region
  | [e] -> expr e
  | es -> K.Block (List.map expr es) @@@ List.map Source.at es


(* Functions and Modules *)

let rec func f = func' f.it @@ f.at
and func' = function
  | {A.body = []; ftype; locals} ->
    {K.body = K.Nop @@ no_region; ftype; locals}
  | {A.body = es; ftype; locals} ->
    {K.body = K.Label (seq es) @@@ List.map at es; ftype; locals}

let rec module_ m = module' m.it @@ m.at
and module' = function
  | {A.funcs = fs; memory; types; imports; exports; table} ->
    {K.funcs = List.map func fs; memory; types; imports; exports; table}

let desugar = module_
