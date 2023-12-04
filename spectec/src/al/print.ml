open Ast
open Printf
open Util.Source
open Util.Record

(* helper functions *)

let indent = "  "

let string_of_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let string_of_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      let limit = 100 in
      let is_long = List.length t > limit in
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "...") else "")
      ^ right

let string_of_array stringifier left sep right a =
  a |> Array.to_list |> string_of_list stringifier left sep right

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

(* AL stringifier *)

let string_of_kwd kwd = let name, _ = kwd in name

let string_of_dir = function
  | Front -> "Front"
  | Back -> "Back"

let depth = ref 0
let rec string_of_record r =
  let base_indent = repeat indent !depth in
  depth := !depth + 1;
  let str = Record.fold
    (fun k v acc -> acc ^ base_indent ^ indent ^ k ^ ": " ^ string_of_value v ^ ";\n")
    r (base_indent ^ "{\n")
  ^ (base_indent ^ "}") in
  depth := !depth - 1;
  str

and string_of_value = function
  | LabelV (v1, v2) ->
      sprintf "Label_%s %s" (string_of_value v1) (string_of_value v2)
  (*| FrameV (None, v2) -> sprintf "(Frame %s)" (string_of_value v2)
  | FrameV (Some v1, v2) -> sprintf "(Frame %s %s)" (string_of_value v1) (string_of_value v2) *)
  | FrameV _ -> "FrameV"
  | StoreV _ -> "StoreV"
  | ListV lv -> string_of_array string_of_value "[" ", " "]" !lv
  | NumV n -> Printf.sprintf "0x%LX" n
  | TextV s -> s
  | TupV vl -> string_of_list string_of_value "(" ", " ")" vl
  | ArrowV (v1, v2) -> "[" ^ string_of_value v1 ^ "]->[" ^ string_of_value v2 ^ "]"
  | CaseV ("CONST", hd::tl) -> "(" ^ string_of_value hd ^ ".CONST" ^ string_of_list string_of_value " " " " "" tl ^ ")"
  | CaseV (s, []) -> s
  | CaseV (s, vl) -> "(" ^ s ^ string_of_list string_of_value " " " " "" vl ^ ")"
  | StrV r -> string_of_record r
  | OptV (Some e) -> "?(" ^ string_of_value e ^ ")"
  | OptV None -> "?()"

let string_of_unop = function
  | NotOp -> "not"
  | MinusOp -> "-"

let string_of_binop = function
  | AndOp -> "and"
  | OrOp -> "or"
  | ImplOp -> "=>"
  | EquivOp -> "<=>"
  | AddOp -> "+"
  | SubOp -> "-"
  | MulOp -> "·"
  | DivOp -> "/"
  | ExpOp -> "^"

let string_of_cmpop = function
  | EqOp -> "is"
  | NeOp -> "is not"
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "≤"
  | GeOp -> "≥"

let rec string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (expr, None) -> "^" ^ string_of_expr expr
  | ListN (expr, Some name) ->
    "^(" ^ name ^ "<" ^ string_of_expr expr^ ")"

and string_of_iters iters = List.map string_of_iter iters |> List.fold_left (^) ""


and string_of_record_expr r =
  Record.fold
    (fun k v acc -> acc ^ string_of_kwd k ^ ": " ^ string_of_expr v ^ "; ")
    r "{ "
  ^ "}"

and string_of_expr = function
  | NumE i -> Int64.to_string i
  | UnE (op, e) -> sprintf "(%s %s)" (string_of_unop op) (string_of_expr e)
  | BinE (op, e1, e2) ->
      sprintf "(%s %s %s)" (string_of_expr e1) (string_of_binop op) (string_of_expr e2)
  | TupE el -> string_of_list string_of_expr "(" ", " ")" el
  | CallE (n, el) ->
      sprintf "$%s(%s)" 
        n (string_of_list string_of_expr "" ", " "" el)
  | CatE (e1, e2) ->
      sprintf "%s ++ %s" (string_of_expr e1) (string_of_expr e2)
  | LenE e -> sprintf "|%s|" (string_of_expr e)
  | ArityE e -> sprintf "the arity of %s" (string_of_expr e)
  | GetCurLabelE -> "the current label"
  | GetCurFrameE -> "the current frame"
  | GetCurContextE -> "the current context"
  | FrameE (None, e2) ->
      sprintf "the activation of %s" (string_of_expr e2)
  | FrameE (Some e1, e2) ->
      sprintf "the activation of %s with arity %s" (string_of_expr e2)
        (string_of_expr e1)
  | ListE el -> string_of_list string_of_expr "[" ", " "]" el
  | AccE (e, p) -> sprintf "%s%s" (string_of_expr e) (string_of_path p)
  | ExtE (e1, ps, e2, dir) -> (
      match dir with
      | Front -> sprintf "%s with %s prepended by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
      | Back -> sprintf "%s with %s appended by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2))
  | UpdE (e1, ps, e2) ->
      sprintf "%s with %s replaced by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
  | StrE r -> string_of_record_expr r
  | ContE e -> sprintf "the continuation of %s" (string_of_expr e)
  | LabelE (e1, e2) ->
      sprintf "the label_%s{%s}" (string_of_expr e1) (string_of_expr e2)
  | VarE n -> n
  | SubE (n, _) -> n
  | IterE (e, _, iter) -> string_of_expr e ^ string_of_iter iter
  | ArrowE (e1, e2) ->
    (match e1 with ListE _ -> string_of_expr e1 | _ -> "[" ^ string_of_expr e1 ^ "]" )
    ^ "->"
    ^ (match e2 with ListE _ -> string_of_expr e2 | _ -> "[" ^ string_of_expr e2 ^ "]" )
  | CaseE (("CONST", _), hd::tl) -> "(" ^ string_of_expr hd ^ ".CONST" ^ string_of_list string_of_expr " " " " "" tl ^ ")"
  | CaseE ((s, _), []) -> s
  | CaseE ((s, _), el) -> "(" ^ s ^ string_of_list string_of_expr " " " " "" el ^ ")"
  | OptE (Some e) -> "?(" ^ string_of_expr e ^ ")"
  | OptE None -> "?()"
  | YetE s -> sprintf "YetE (%s)" s

and string_of_path = function
  | IdxP e -> sprintf "[%s]" (string_of_expr e)
  | SliceP (e1, e2) ->
      sprintf "[%s : %s]" (string_of_expr e1) (string_of_expr e2)
  | DotP (s, _) -> sprintf ".%s" s

and string_of_paths paths = List.map string_of_path paths |> List.fold_left (^) ""

and string_of_cond = function
  | UnC (NotOp, IsCaseOfC (e, c)) ->
      sprintf "%s is not of the case %s" (string_of_expr e) (string_of_kwd c)
  | UnC (NotOp, IsDefinedC e) ->
      sprintf "%s is not defined" (string_of_expr e)
  | UnC (NotOp, IsValidC e) ->
      sprintf "%s is not valid" (string_of_expr e)
  | UnC (NotOp, c) -> sprintf "not %s" (string_of_cond c)
  | UnC _ -> failwith "Unreachable condition"
  | BinC (op, c1, c2) ->
      sprintf "%s %s %s" (string_of_cond c1) (string_of_binop op) (string_of_cond c2)
  | CmpC (op, e1, e2) ->
      sprintf "%s %s %s" (string_of_expr e1) (string_of_cmpop op) (string_of_expr e2)
  | ContextKindC (s, e) -> sprintf "%s is %s" (string_of_expr e) (string_of_kwd s)
  | IsDefinedC e -> sprintf "%s is defined" (string_of_expr e)
  | IsCaseOfC (e, c) -> sprintf "%s is of the case %s" (string_of_expr e) (string_of_kwd c)
  | HasTypeC (e, t) -> sprintf "the type of %s is %s" (string_of_expr e) t
  | IsValidC e -> sprintf "%s is valid" (string_of_expr e)
  | TopLabelC -> "a label is now on the top of the stack"
  | TopFrameC -> "a frame is now on the top of the stack"
  | TopValueC (Some e) -> sprintf "a value of value type %s is on the top of the stack" (string_of_expr e)
  | TopValueC None -> "a value is on the top of the stack"
  | TopValuesC e -> sprintf "there are at least %s values on the top of the stack" (string_of_expr e)
  | MatchC (e1, e2) ->
    sprintf "%s matches %s"
      (string_of_expr e1)
      (string_of_expr e2)
  | YetC s -> sprintf "YetC (%s)" s

let make_index index depth =
  index := !index + 1;

  let num_idx = string_of_int !index in
  let alp_idx = Char.escaped (Char.chr (96 + !index)) in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> assert false

let rec string_of_instr index depth instr =
  match instr.it with
  | IfI (c, il, []) ->
      sprintf "%s If %s, then:%s" (make_index index depth) (string_of_cond c)
        (string_of_instrs (depth + 1) il)
  | IfI (c, il1, [ { it = IfI (inner_c, inner_il1, []); _ } ]) ->
      let if_index = make_index index depth in
      let else_if_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s"
        if_index
        (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (string_of_cond inner_c)
        (string_of_instrs (depth + 1) inner_il1)
  | IfI (c, il1, [ { it = IfI (inner_c, inner_il1, inner_il2); _ } ]) ->
      let if_index = make_index index depth in
      let else_if_index = make_index index depth in
      let else_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s\n%s Else:%s"
        if_index
        (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (string_of_cond inner_c)
        (string_of_instrs (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (string_of_instrs (depth + 1) inner_il2)
  | IfI (c, il1, il2) ->
      let if_index = make_index index depth in
      let else_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else:%s" if_index (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (string_of_instrs (depth + 1) il2)
  | OtherwiseI il ->
      sprintf "%s Otherwise:%s" (make_index index depth)
        (string_of_instrs (depth + 1) il)
  | EitherI (il1, il2) ->
      let either_index = make_index index depth in
      let or_index = make_index index depth in
      sprintf "%s Either:%s\n%s Or:%s" either_index
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (string_of_instrs (depth + 1) il2)
  | AssertI c -> sprintf "%s Assert: Due to validation, %s." (make_index index depth) (string_of_cond c)
  | PushI e ->
      sprintf "%s Push %s to the stack." (make_index index depth)
        (string_of_expr e)
  | PopI e ->
      sprintf "%s Pop %s from the stack." (make_index index depth)
        (string_of_expr e)
  | PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (make_index index depth)
        (string_of_expr e)
  | LetI (n, e) ->
      sprintf "%s Let %s be %s." (make_index index depth) (string_of_expr n)
        (string_of_expr e)
  | TrapI -> sprintf "%s Trap." (make_index index depth)
  | NopI -> sprintf "%s Do nothing." (make_index index depth)
  | ReturnI e_opt ->
      sprintf "%s Return%s." (make_index index depth)
        (string_of_opt " " string_of_expr "" e_opt)
  | EnterI (e1, e2, il) ->
      sprintf "%s Enter %s with label %s:%s" (make_index index depth)
        (string_of_expr e1) (string_of_expr e2) (string_of_instrs (depth + 1) il)
  | ExecuteI e ->
      sprintf "%s Execute %s." (make_index index depth) (string_of_expr e)
  | ExecuteSeqI e ->
      sprintf "%s Execute the sequence (%s)." (make_index index depth) (string_of_expr e)
  | PerformI (n, el) ->
      sprintf "%s Perform %s." (make_index index depth) (string_of_expr (CallE (n, el)))
  | ExitI -> make_index index depth ^ " Exit current context."
  | ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s%s with %s." (make_index index depth)
        (string_of_expr e1) (string_of_path p) (string_of_expr e2)
  | AppendI (e1, e2) ->
      sprintf "%s Append %s to the %s." (make_index index depth)
        (string_of_expr e2) (string_of_expr e1)
  | YetI s -> sprintf "%s YetI: %s." (make_index index depth) s

and string_of_instrs depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun acc i ->
      acc ^ "\n" ^ repeat indent depth ^ string_of_instr index depth i)
    "" instrs

let string_of_algorithm = function
  | RuleA (name, params, instrs) ->
      "execution_of_" ^ string_of_kwd name
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ string_of_expr p)
          "" params
      ^ string_of_instrs 0 instrs ^ "\n"
  | FuncA (name, params, instrs) ->
      name
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ string_of_expr p)
          "" params
      ^ string_of_instrs 0 instrs ^ "\n"

(* structured stringifier *)

(* wasm type *)

(* name *)

let structured_string_of_kwd kwd = let name, note = kwd in sprintf "%s_%s" name note

let structured_string_of_names names =
  "[" ^ String.concat ", " names ^ "]"

(* expression *)

let rec structured_string_of_value = function
  | LabelV (v1, v2) -> "LabelV (" ^ structured_string_of_value v1 ^ "," ^ structured_string_of_value v2 ^ ")"
  | FrameV _ -> "FrameV (TODO)"
  | StoreV _ -> "StoreV"
  | ListV _ -> "ListV"
  | NumV n -> "NumV (" ^ Int64.to_string n ^ ")"
  | TextV s -> "TextV (" ^ s ^ ")"
  | TupV vl -> string_of_list structured_string_of_value "TupV (" ", " ")" vl
  | ArrowV (v1, v2) ->
      "ArrowV("
      ^ structured_string_of_value v1
      ^ ", "
      ^ structured_string_of_value v2
      ^ ")"
  | CaseV (s, vl) ->
      "CaseV(" ^ s ^ ", "
      ^ string_of_list structured_string_of_value "[" ", " "]" vl
      ^ ")"
  | StrV _r -> "StrV (TODO)"
  | OptV o -> "OptV " ^ string_of_opt "(" structured_string_of_value ")" o

(* iter *)

let rec structured_string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (expr, None) -> structured_string_of_expr expr
  | ListN (expr, Some name) ->
    name ^ "<" ^ structured_string_of_expr expr

and structured_string_of_record_expr r =
  Record.fold
    (fun k v acc -> acc ^ structured_string_of_kwd k ^ ": " ^ string_of_expr v ^ "; ")
    r "{ "
  ^ "}"

and structured_string_of_expr = function
  | NumE i -> Int64.to_string i
  | UnE (op, e) ->
     "UnE ("
      ^ string_of_unop op
      ^ structured_string_of_expr e
      ^ ")"
  | BinE (op, e1, e2) ->
      "BinopE ("
      ^ string_of_binop op
      ^ ", "
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | TupE el ->
      string_of_list structured_string_of_expr "TupE (" ", " ")" el
  | CallE (n, nl) ->
      "CallE ("
      ^ n
      ^ ", "
      ^ string_of_list structured_string_of_expr "[ " ", " " ]" nl
      ^ ")"
  | CatE (e1, e2) ->
      "CatE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | LenE e -> "LenE (" ^ structured_string_of_expr e ^ ")"
  | ArityE e -> "ArityE (" ^ structured_string_of_expr e ^ ")"
  | GetCurLabelE -> "GetCurLabelE"
  | GetCurFrameE -> "GetCurFrameE"
  | GetCurContextE -> "GetCurContextE"
  | FrameE _ -> "FrameE TODO"
  | ListE el ->
      "ListE ("
      ^ string_of_list structured_string_of_expr "[" ", " "]" el
      ^ ")"
  | AccE (e, p) ->
      "AccE ("
      ^ structured_string_of_expr e
      ^ ", "
      ^ structured_string_of_path p
      ^ ")"
  | ExtE (e1, ps, e2, dir) ->
      "ExtE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_paths ps
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ", "
      ^ string_of_dir dir
      ^ ")"
  | UpdE (e1, ps, e2) ->
      "UpdE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_paths ps
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | StrE r -> "StrE (" ^ structured_string_of_record_expr r ^ ")"
  | ContE e1 -> "ContE (" ^ structured_string_of_expr e1 ^ ")"
  | LabelE (e1, e2) ->
      "LabelE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | VarE n -> "VarE (" ^ n ^ ")"
  | SubE (n, t) -> "SubE (" ^ n ^ "," ^ t ^ ")"
  | IterE (e, names, iter) ->
      "IterE ("
      ^ structured_string_of_expr e
      ^ ", "
      ^ structured_string_of_names names
      ^ ", "
      ^ string_of_iter iter
      ^ ")"
  | ArrowE (e1, e2) ->
      "ArrowE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | CaseE (s, el) ->
      "CaseE (" ^ structured_string_of_kwd s ^ ", "
      ^ string_of_list structured_string_of_expr "[" ", " "]" el
      ^ ")"
  | OptE o -> "OptE " ^ string_of_opt "(" structured_string_of_expr ")" o
  | YetE s -> "YetE (" ^ s ^ ")"

(* path*)

and structured_string_of_path = function
  | IdxP e -> sprintf "IdxP(%s)" (structured_string_of_expr e)
  | SliceP (e1, e2) ->
      sprintf "SliceP(%s,%s)"
        (structured_string_of_expr e1)
        (structured_string_of_expr e2)
  | DotP (s, _) -> sprintf "DotP(%s)" s

and structured_string_of_paths paths =
  List.map string_of_path paths |> List.fold_left (^) ""

(* condition *)

and structured_string_of_cond = function
  | UnC (op, c) ->
      "UnC ("
      ^ string_of_unop op
      ^ ", "
      ^ structured_string_of_cond c
      ^ ")"
  | BinC (op, c1, c2) ->
      "BinC ("
      ^ string_of_binop op
      ^ ", "
      ^ structured_string_of_cond c1
      ^ ", "
      ^ structured_string_of_cond c2
      ^ ")"
  | CmpC (op, e1, e2) ->
      "CmpC ("
      ^ string_of_cmpop op
      ^ ", "
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | ContextKindC (s, e) -> sprintf "ContextKindC (%s, %s)" (structured_string_of_kwd s) (structured_string_of_expr e)
  | IsDefinedC e -> "DefinedC (" ^ structured_string_of_expr e ^ ")"
  | IsCaseOfC (e, c) -> "CaseOfC (" ^ structured_string_of_expr e ^ ", " ^ structured_string_of_kwd c ^ ")"
  | HasTypeC (e, t) -> "HasTypeC (" ^ structured_string_of_expr e ^ ", " ^ t ^ ")"
  | IsValidC e -> "IsValidC (" ^ structured_string_of_expr e ^ ")"
  | TopLabelC -> "TopLabelC"
  | TopFrameC -> "TopFrameC"
  | TopValueC e_opt -> "TopValueC" ^ string_of_opt " (" structured_string_of_expr ")" e_opt 
  | TopValuesC e -> "TopValuesC (" ^ structured_string_of_expr e ^ ")"
  | MatchC (e1, e2) ->
    Printf.sprintf "Matches (%s, %s)"
      (structured_string_of_expr e1)
      (structured_string_of_expr e2)
  | YetC s -> "YetC (" ^ s ^ ")"

(* instruction *)

let rec structured_string_of_instr depth instr =
  match instr.it with
  | IfI (c, t, e) ->
      "IfI (\n"
      ^ repeat indent (depth + 1)
      ^ structured_string_of_cond c
      ^ "\n" ^ repeat indent depth ^ "then\n"
      ^ structured_string_of_instrs (depth + 1) t
      ^ repeat indent depth ^ "else\n"
      ^ structured_string_of_instrs (depth + 1) e
      ^ repeat indent depth ^ ")"
  | OtherwiseI b ->
      "OtherwiseI (\n"
      ^ structured_string_of_instrs (depth + 1) b
      ^ repeat indent depth ^ ")"
  | EitherI (il1, il2) ->
      "EitherI (\n"
      ^ structured_string_of_instrs (depth + 1) il1
      ^ repeat indent depth ^ "Or\n"
      ^ structured_string_of_instrs (depth + 1) il2
      ^ repeat indent depth ^ ")"
  | AssertI c -> "AssertI (" ^ structured_string_of_cond c ^ ")"
  | PushI e -> "PushI (" ^ structured_string_of_expr e ^ ")"
  | PopI e -> "PopI (" ^ structured_string_of_expr e ^ ")"
  | PopAllI e -> "PopAllI (" ^ structured_string_of_expr e ^ ")"
  | LetI (n, e) ->
      "LetI ("
      ^ structured_string_of_expr n
      ^ ", "
      ^ structured_string_of_expr e
      ^ ")"
  | TrapI -> "TrapI"
  | NopI -> "NopI"
  | ReturnI e_opt ->
      "ReturnI" ^ string_of_opt " (" structured_string_of_expr ")" e_opt
  | EnterI (e1, e2, il) ->
      "EnterI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ", "
      ^ structured_string_of_instrs (depth + 1) il
      ^ ")"
  | ExecuteI e -> "ExecuteI (" ^ structured_string_of_expr e ^ ")"
  | ExecuteSeqI e -> "ExecuteSeqI (" ^ structured_string_of_expr e ^ ")"
  | PerformI (n, el) ->
      "PerformI ("
      ^ n
      ^ ","
      ^ string_of_list structured_string_of_expr "[ " ", " " ]" el
      ^ ")"
  | ExitI -> "ExitI"
  | ReplaceI (e1, p, e2) ->
      "ReplaceI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_path p
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | AppendI (e1, e2) ->
      "AppendI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | YetI s -> "YetI " ^ s

and structured_string_of_instrs depth instrs =
  List.fold_left
    (fun acc i ->
      acc ^ repeat indent depth ^ structured_string_of_instr depth i ^ "\n")
    "" instrs

let structured_string_of_algorithm = function
  | RuleA (name, params, instrs) ->
      "execution_of_" ^ structured_string_of_kwd name
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ structured_string_of_expr p)
          "" params
      ^ ":\n"
      ^ structured_string_of_instrs 1 instrs
  | FuncA (name, params, instrs) ->
      name
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ structured_string_of_expr p)
          "" params
      ^ ":\n"
      ^ structured_string_of_instrs 1 instrs
