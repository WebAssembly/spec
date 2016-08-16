open Format
open Source
open Ast
open Values

let list_of_opt = function
  | None -> []
  | Some x -> [x]

let var x = string_of_int x.it

let memop op = "..."
let extop op = "..."
let wrapop op = "..."
let unop op = "unary"
let binop op = "binary"
let selop op = "select"
let relop op = "compare"
let cvtop op = "convert"

let hostop = function
  | MemorySize -> "memory_size"
  | GrowMemory -> "grow_memory"
  | HasFeature s -> "has_feature \"" ^ String.escaped s ^ "\""

let literal v =
  (match v.it with
  | Int32 _ -> "i32.const "
  | Int64 _ -> "i64.const "
  | Float32 _ -> "f32.const "
  | Float64 _ -> "f64.const "
  ) ^ string_of_value v.it

let expr e =
  match e.it with
  | Nop -> "nop", []
  | Unreachable -> "unreachable", []
  | Block es -> "block", es
  | Loop e -> "loop", [e]
  | Break (x, eo) -> "break " ^ var x, list_of_opt eo
  | Br_if (x, eo, e) -> "br_if " ^ var x, list_of_opt eo @ [e]
  | If (e1, e2, e3) -> "if", [e1; e2; e3]
  | Switch (e, xs, x, es) -> "switch", e::es
  | Call (x, es) -> "call " ^ var x, es
  | CallImport (x, es) -> "call_import " ^ var x, es
  | CallIndirect (x, e, es) -> "call_indirect " ^ var x, e::es
  | GetLocal x -> "get_local " ^ var x, []
  | SetLocal (x, e) -> "set_local " ^ var x, [e]
  | Load (op, e) -> "load " ^ memop op, [e]
  | Store (op, e1, e2) -> "store " ^ memop op, [e1; e2]
  | LoadExtend (op, e) -> "load " ^ extop op, [e]
  | StoreWrap (op, e1, e2) -> "store " ^ wrapop op, [e1; e2]
  | Const lit -> literal lit, []
  | Unary (op, e) -> unop op, [e]
  | Binary (op, e1, e2) -> binop op, [e1; e2]
  | Select (op, e1, e2, e3) -> selop op, [e1; e2; e3]
  | Compare (op, e1, e2) -> relop op, [e1; e2]
  | Convert (op, e) -> cvtop op, [e]
  | Host (op, es) -> hostop op, es

type rope = Leaf of string | Concat of rope list
let (^+) s r = Concat [Leaf s; r]
let (+^) r s = Concat [r; Leaf s]

let rec iter f = function
  | Leaf s -> f s
  | Concat rs -> List.iter (iter f) rs

let margin = 80
let rec pp f off x =
  let head, xs = f x in
  let lens, rs = List.split (List.map (pp f (off + 2)) xs) in
  let len = String.length head + List.length rs + List.fold_left (+) 2 lens in
  let sep, fin =
    if off + len <= margin then " ", ""
    else let indent = String.make off ' ' in "\n  " ^ indent, "\n" ^ indent
  in len, "(" ^+ head ^+ Concat (List.map (fun r -> sep ^+ r) rs) +^ fin +^ ")"

let pp_body e = iter print_string (snd (pp expr 0 e)); print_newline ()

(*
let margin = 80
let rec pp_expr off e =
  let head, es = expr e in
  let sss, ns = List.split (List.map (pp_expr (off + 2)) es) in
  let len = 2 + String.length head + List.length ns + List.fold_left (+) 0 ns in
  if off + len <= margin then
    "(" :: head :: List.flatten (List.map (fun ss -> " " :: ss) sss) @ [")"], len
  else
    let indent = String.make off ' ' in
    "(" :: head :: List.flatten (List.map (fun ss -> "\n  " :: indent :: ss) sss) @ ["\n"; indent; ")"], len

let pp_body e = List.iter print_string (fst (pp_expr 0 e)); print_newline ()
*)

(*
let margin = 80
let rec pp_expr off e =
  let head, es = expr e in
  let ss = List.map (pp_expr (off + 2)) es in
  let len = 2 + String.length head + List.length ss + List.fold_left (+) 0 (List.map String.length ss) in
  if off + len <= margin then
    "(" ^ head ^ String.concat " " (""::ss) ^ ")"
  else
    let indent = String.make off ' ' in
    "(" ^ head ^ String.concat ("\n  " ^ indent) (""::ss) ^ "\n" ^ indent ^ ")"

let pp_body e = print_endline (pp_expr 0 e)
*)

(*
let rec pp_expr e =
  let head, es = expr e in
  open_box 2;
  print_string "(";
  print_string head;
  List.iter (fun e -> print_space (); open_box 0; pp_expr e) es;
  List.iter (fun e -> close_box ()) es;
  close_box ();
  print_break 0 0;
  print_string ")"

let pp_body e = pp_expr e; print_newline ()
*)
