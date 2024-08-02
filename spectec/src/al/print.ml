open Ast
open Printf
open Util
open Source

module Atom = El.Atom


(* Helper functions *)

let indent = "  "

let string_of_list stringifier sep = function
  | [] -> ""
  | h :: t ->
    let limit = 100 in
    let is_long = List.length t > limit in
    List.fold_left
        (fun acc elem -> acc ^ sep ^ stringifier elem)
        (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
    ^ (if is_long then (sep ^ "..." ^ stringifier (List.hd (List.rev t))) else "")

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)


(* AL stringifier *)

(* Terminals *)

let string_of_atom = El.Print.string_of_atom
let string_of_mixop = Il.Print.string_of_mixop


(* Directions *)

let string_of_dir = function
  | Front -> "Front"
  | Back -> "Back"


(* Values *)

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

and string_of_value =
  function
  | LabelV (v1, v2) ->
    sprintf "Label_%s %s" (string_of_value v1) (string_of_value v2)
  (*| FrameV (None, v2) -> sprintf "(Frame %s)" (string_of_value v2)
  | FrameV (Some v1, v2) -> sprintf "(Frame %s %s)" (string_of_value v1) (string_of_value v2) *)
  | FrameV _ -> "FrameV"
  | ListV lv -> "[" ^ string_of_values ", " (Array.to_list !lv) ^ "]"
  | NumV n -> "0x" ^ Z.format "%X" n
  | BoolV b -> string_of_bool b
  | TextV s -> s
  | TupV vl -> "(" ^ string_of_values ", " vl ^ ")"
  | CaseV (("CONST"|"VCONST"), hd::tl) ->
    "(" ^ string_of_value hd ^ ".CONST " ^ string_of_values " " tl ^ ")"
  | CaseV (s, []) -> s
  | CaseV (s, vl) -> "(" ^ s ^ " " ^ string_of_values " " vl ^ ")"
  | StrV r -> string_of_record r
  | OptV (Some e) -> "?(" ^ string_of_value e ^ ")"
  | OptV None -> "?()"

and string_of_values sep = string_of_list string_of_value sep


(* Operators *)

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
  | ModOp -> "\\"
  | ExpOp -> "^"
  | EqOp -> "is"
  | NeOp -> "is not"
  | LtOp -> "<"
  | GtOp -> ">"
  | LeOp -> "≤"
  | GeOp -> "≥"


(* Iters *)

let rec string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (expr, None) -> "^" ^ string_of_expr expr
  | ListN (expr, Some id) ->
    "^(" ^ id ^ "<" ^ string_of_expr expr^ ")"

and string_of_iters iters = List.map string_of_iter iters |> List.fold_left (^) ""


(* Expressions *)

and string_of_record_expr r =
  Record.fold
    (fun a v acc -> acc ^ string_of_atom a ^ ": " ^ string_of_expr v ^ "; ")
    r "{ "
  ^ "}"

and string_of_expr expr =
  match expr.it with
  | NumE i -> Z.to_string i
  | BoolE b -> string_of_bool b
  | UnE (NotOp, { it = IsCaseOfE (e, a); _ }) ->
    sprintf "%s is not of the case %s" (string_of_expr e) (string_of_atom a)
  | UnE (NotOp, { it = IsDefinedE e; _ }) ->
    sprintf "%s is not defined" (string_of_expr e)
  | UnE (NotOp, { it = IsValidE e; _ }) ->
    sprintf "%s is not valid" (string_of_expr e)
  | UnE (NotOp, { it = MatchE (e1, e2); _ }) ->
    sprintf "%s does not match %s" (string_of_expr e1) (string_of_expr e2)
  | UnE (NotOp, e) -> sprintf "not %s" (string_of_expr e)
  | UnE (op, e) -> sprintf "(%s %s)" (string_of_unop op) (string_of_expr e)
  | BinE (op, e1, e2) ->
    sprintf "(%s %s %s)" (string_of_expr e1) (string_of_binop op) (string_of_expr e2)
  | TupE el -> "(" ^ string_of_exprs ", " el ^ ")"
  | CallE (id, al) -> sprintf "$%s(%s)" id (string_of_args ", " al)
  | InvCallE (id, nl, al) ->
    let id' =
      if List.for_all Option.is_some nl then id
      else
        nl
        |> List.filter_map (fun x -> x)
        |> List.map string_of_int
        |> List.fold_left (^) ""
        |> sprintf "%s_%s" id
    in
    sprintf "$%s^-1(%s)" id' (string_of_args ", " al)
  | CatE (e1, e2) ->
    sprintf "%s ++ %s" (string_of_expr e1) (string_of_expr e2)
  | MemE (e1, e2) ->
    sprintf "%s <- %s" (string_of_expr e1) (string_of_expr e2)
  | LenE e -> sprintf "|%s|" (string_of_expr e)
  | ArityE e -> sprintf "the arity of %s" (string_of_expr e)
  | GetCurStateE -> "the current state"
  | GetCurLabelE -> "the current label"
  | GetCurFrameE -> "the current frame"
  | GetCurContextE -> "the current context"
  | FrameE (None, e2) ->
    sprintf "the activation of %s" (string_of_expr e2)
  | FrameE (Some e1, e2) ->
    sprintf "the activation of %s with arity %s" (string_of_expr e2)
      (string_of_expr e1)
  | ListE el -> "[" ^ string_of_exprs ", " el ^ "]"
  | AccE (e, p) -> sprintf "%s%s" (string_of_expr e) (string_of_path p)
  | ExtE (e1, ps, e2, dir) -> (
    match dir with
    | Front -> sprintf "%s with %s prepended by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
    | Back -> sprintf "%s with %s appended by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2))
  | UpdE (e1, ps, e2) ->
    sprintf "%s with %s replaced by %s" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
  | StrE r -> string_of_record_expr r
  | ContE e -> sprintf "the continuation of %s" (string_of_expr e)
  | ChooseE e -> sprintf "an element of %s" (string_of_expr e)
  | LabelE (e1, e2) ->
    sprintf "the label_%s{%s}" (string_of_expr e1) (string_of_expr e2)
  | VarE id -> id
  | SubE (id, _) -> id
  | IterE (e, _, iter) -> string_of_expr e ^ string_of_iter iter
  | InfixE (e1, a, e2) -> "(" ^ string_of_expr e1 ^ " " ^ string_of_atom a ^ " " ^ string_of_expr e2 ^ ")"
  | CaseE ({ it=Atom.Atom ("CONST" | "VCONST"); _ }, hd::tl) ->
    "(" ^ string_of_expr hd ^ ".CONST " ^ string_of_exprs " " tl ^ ")"
  | CaseE (a, []) -> string_of_atom a
  | CaseE (a, el) -> "(" ^ string_of_atom a ^ " " ^ string_of_exprs " " el ^ ")"
  | CaseE2 (op, el) -> "(" ^ string_of_mixop op ^ "_" ^ string_of_exprs " " el ^ ")"
  | OptE (Some e) -> "?(" ^ string_of_expr e ^ ")"
  | OptE None -> "?()"
  | ContextKindE (a, e) -> sprintf "%s is %s" (string_of_expr e) (string_of_atom a)
  | IsDefinedE e -> sprintf "%s is defined" (string_of_expr e)
  | IsCaseOfE (e, a) -> sprintf "%s is of the case %s" (string_of_expr e) (string_of_atom a)
  | HasTypeE (e, t) -> sprintf "the type of %s is %s" (string_of_expr e) t
  | IsValidE e -> sprintf "%s is valid" (string_of_expr e)
  | TopLabelE -> "a label is now on the top of the stack"
  | TopFrameE -> "a frame is now on the top of the stack"
  | TopValueE (Some e) -> sprintf "a value of value type %s is on the top of the stack" (string_of_expr e)
  | TopValueE None -> "a value is on the top of the stack"
  | TopValuesE e -> sprintf "there are at least %s values on the top of the stack" (string_of_expr e)
  | MatchE (e1, e2) ->
    sprintf "%s matches %s"
      (string_of_expr e1)
      (string_of_expr e2)
  | YetE s -> sprintf "YetE (%s)" s

and string_of_exprs sep = string_of_list string_of_expr sep


(* Paths *)

and string_of_path path =
  match path.it with
  | IdxP e -> sprintf "[%s]" (string_of_expr e)
  | SliceP (e1, e2) ->
    sprintf "[%s : %s]" (string_of_expr e1) (string_of_expr e2)
  | DotP a -> sprintf ".%s" (string_of_atom a)

and string_of_paths paths = List.map string_of_path paths |> List.fold_left (^) ""


(* Args *)

and string_of_arg arg =
  match arg.it with
  | ExpA e -> string_of_expr e
  | TypA -> "T"

and string_of_args sep = string_of_list string_of_arg sep


(* Instructions *)

let _index = ref 0

let get_index () = !_index
let set_index i = _index := i
let enter_block f instrs =
  let index = get_index () in
  set_index 0;
  let res = f instrs in
  set_index index;
  res

let make_index depth =
  _index := !_index + 1;

  let num_idx = string_of_int !_index in
  let alp_idx = Char.escaped (Char.chr (96 + !_index)) in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> assert false

(* Prefix for stack push/pop operations *)
let string_of_stack_prefix expr =
  match expr.it with
  | GetCurContextE
  | GetCurFrameE
  | GetCurLabelE
  | ContE _
  | LabelE _
  | FrameE _
  | VarE ("F" | "L") -> ""
  | IterE _ -> "the values "
  | _ -> "the value "

let rec string_of_instr' depth instr =
  match instr.it with
  | IfI (e, il, []) ->
    sprintf "%s If %s, then:%s" (make_index depth) (string_of_expr e)
      (string_of_instrs' (depth + 1) il)
  | IfI (e, il1, [ { it = IfI (inner_e, inner_il1, []); _ } ]) ->
    let if_index = make_index depth in
    let else_if_index = make_index depth in
    sprintf "%s If %s, then:%s\n%s Else if %s, then:%s"
      if_index
      (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (string_of_expr inner_e)
      (string_of_instrs' (depth + 1) inner_il1)
  | IfI (e, il1, [ { it = IfI (inner_e, inner_il1, inner_il2); _ } ]) ->
    let if_index = make_index depth in
    let else_if_index = make_index depth in
    let else_index = make_index depth in
    sprintf "%s If %s, then:%s\n%s Else if %s, then:%s\n%s Else:%s"
      if_index
      (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth ^ else_if_index)
      (string_of_expr inner_e)
      (string_of_instrs' (depth + 1) inner_il1)
      (repeat indent depth ^ else_index)
      (string_of_instrs' (depth + 1) inner_il2)
  | IfI (e, il1, il2) ->
    let if_index = make_index depth in
    let else_index = make_index depth in
    sprintf "%s If %s, then:%s\n%s Else:%s" if_index (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth ^ else_index)
      (string_of_instrs' (depth + 1) il2)
  | OtherwiseI il ->
    sprintf "%s Otherwise:%s" (make_index depth)
      (string_of_instrs' (depth + 1) il)
  | EitherI (il1, il2) ->
    let either_index = make_index depth in
    let or_index = make_index depth in
    sprintf "%s Either:%s\n%s Or:%s" either_index
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth ^ or_index)
      (string_of_instrs' (depth + 1) il2)
  | AssertI e -> sprintf "%s Assert: Due to validation, %s." (make_index depth) (string_of_expr e)
  | PushI e ->
    sprintf "%s Push %s%s to the stack." (make_index depth)
      (string_of_stack_prefix e) (string_of_expr e)
  | PopI e ->
    sprintf "%s Pop %s%s from the stack." (make_index depth)
      (string_of_stack_prefix e) (string_of_expr e)
  | PopAllI e ->
    sprintf "%s Pop all values %s from the top of the stack." (make_index depth)
      (string_of_expr e)
  | LetI (e1, e2) ->
    sprintf "%s Let %s be %s." (make_index depth) (string_of_expr e1)
      (string_of_expr e2)
  | TrapI -> sprintf "%s Trap." (make_index depth)
  | NopI -> sprintf "%s Do nothing." (make_index depth)
  | ReturnI None -> sprintf "%s Return." (make_index depth)
  | ReturnI (Some e) -> sprintf "%s Return %s." (make_index depth) (string_of_expr e)
  | EnterI (e1, e2, il) ->
    sprintf "%s Enter %s with label %s.%s" (make_index depth)
      (string_of_expr e2) (string_of_expr e1) (string_of_instrs' (depth + 1) il)
  | ExecuteI e ->
    sprintf "%s Execute the instruction %s." (make_index depth) (string_of_expr e)
  | ExecuteSeqI e ->
    sprintf "%s Execute the sequence (%s)." (make_index depth) (string_of_expr e)
  | PerformI (id, al) ->
    sprintf "%s Perform %s." (make_index depth) (string_of_expr (CallE (id, al) $$ instr.at % (Il.Ast.VarT ("TODO" $ no_region, []) $ no_region)))
  | ExitI a ->
    sprintf "%s Exit from %s." (make_index depth) (string_of_atom a)
  | ReplaceI (e1, p, e2) ->
    sprintf "%s Replace %s%s with %s." (make_index depth)
      (string_of_expr e1) (string_of_path p) (string_of_expr e2)
  | AppendI (e1, e2) ->
    sprintf "%s Append %s to the %s." (make_index depth)
      (string_of_expr e2) (string_of_expr e1)
  | YetI s -> sprintf "%s YetI: %s." (make_index depth) s

and string_of_instrs' depth instrs =
  let f acc i =
    acc ^ "\n" ^ repeat indent depth ^ string_of_instr' depth i in
  enter_block (List.fold_left f "") instrs

let string_of_instr instr =
  set_index 0;
  string_of_instr' 0 instr
let string_of_instrs = string_of_instrs' 0

let string_of_algorithm algo = match algo.it with
  | RuleA (a, _anchor, params, instrs) ->
    "execution_of_" ^ string_of_atom a
    ^ List.fold_left
        (fun acc p -> acc ^ " " ^ string_of_arg p)
        "" params
    ^ string_of_instrs instrs ^ "\n"
  | FuncA (id, params, instrs) ->
    id
    ^ List.fold_left
        (fun acc p -> acc ^ " " ^ string_of_arg p)
        "" params
    ^ string_of_instrs instrs ^ "\n"


(* Structured stringfier *)

(* Wasm type *)

(* Names *)

let structured_string_of_ids ids =
  "[" ^ String.concat ", " ids ^ "]"


(* Values *)

let rec structured_string_of_value = function
  | LabelV (v1, v2) -> "LabelV (" ^ structured_string_of_value v1 ^ "," ^ structured_string_of_value v2 ^ ")"
  | FrameV _ -> "FrameV (TODO)"
  | ListV lv -> "ListV" ^ "[" ^ string_of_values ", " (Array.to_list !lv) ^ "]"
  | BoolV b -> "BoolV (" ^ string_of_bool b ^ ")"
  | NumV n -> "NumV (" ^ Z.to_string n ^ ")"
  | TextV s -> "TextV (" ^ s ^ ")"
  | TupV vl ->  "TupV (" ^ structured_string_of_values vl ^ ")"
  | CaseV (s, vl) -> "CaseV(" ^ s ^ ", [" ^ structured_string_of_values vl ^ "])"
  | StrV _r -> "StrV (TODO)"
  | OptV None -> "OptV"
  | OptV (Some e) -> "OptV (" ^ structured_string_of_value e ^ ")"

and structured_string_of_values vl = string_of_list structured_string_of_value ", " vl

(* Iters *)

let rec structured_string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN (expr, None) -> structured_string_of_expr expr
  | ListN (expr, Some id) ->
    id ^ "<" ^ structured_string_of_expr expr


(* Expressions *)

and structured_string_of_record_expr r =
  Record.fold
    (fun a v acc -> acc ^ string_of_atom a ^ ": " ^ string_of_expr v ^ "; ")
    r "{ "
  ^ "}"

and structured_string_of_expr expr =
  match expr.it with
  | NumE i -> Z.to_string i
  | BoolE b -> string_of_bool b
  | UnE (op, e) ->
    "UnE ("
    ^ string_of_unop op
    ^ ", "
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
  | TupE el -> "TupE (" ^ structured_string_of_exprs el ^ ")"
  | CallE (id, al) -> "CallE (" ^ id ^ ", [ " ^ structured_string_of_args al ^ " ])"
  | InvCallE (id, nl, al) ->
    let nl = List.filter_map (fun x -> x) nl in
    sprintf "InvCallE (%s, [%s], [%s])"
      id (string_of_list string_of_int "" nl) (structured_string_of_args al)
  | CatE (e1, e2) ->
    "CatE ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
  | MemE (e1, e2) ->
    "MemE ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
  | LenE e -> "LenE (" ^ structured_string_of_expr e ^ ")"
  | ArityE e -> "ArityE (" ^ structured_string_of_expr e ^ ")"
  | GetCurStateE -> "GetCurStateE"
  | GetCurLabelE -> "GetCurLabelE"
  | GetCurFrameE -> "GetCurFrameE"
  | GetCurContextE -> "GetCurContextE"
  | FrameE _ -> "FrameE TODO"
  | ListE el -> "ListE ([" ^ structured_string_of_exprs el ^ "])"
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
  | ChooseE e1 -> "ChooseE (" ^ structured_string_of_expr e1 ^ ")"
  | LabelE (e1, e2) ->
    "LabelE ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
  | VarE id -> "VarE (" ^ id ^ ")"
  | SubE (id, t) -> "SubE (" ^ id ^ "," ^ t ^ ")"
  | IterE (e, ids, iter) ->
    "IterE ("
    ^ structured_string_of_expr e
    ^ ", "
    ^ structured_string_of_ids ids
    ^ ", "
    ^ string_of_iter iter
    ^ ")"
  | InfixE (e1, a, e2) ->
    "InfixE ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ string_of_atom a
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
  | CaseE (a, el) ->
    "CaseE (" ^ string_of_atom a
    ^ ", [" ^ structured_string_of_exprs el ^ "])"
  | CaseE2 (op, el) ->
    "CaseE2 (" ^ string_of_mixop op
    ^ ", [" ^ structured_string_of_exprs el ^ "])"
  | OptE None -> "OptE"
  | OptE (Some e) -> "OptE (" ^ structured_string_of_expr e ^ ")"
  | ContextKindE (a, e) -> sprintf "ContextKindE (%s, %s)" (string_of_atom a) (structured_string_of_expr e)
  | IsDefinedE e -> "DefinedE (" ^ structured_string_of_expr e ^ ")"
  | IsCaseOfE (e, a) -> "CaseOfE (" ^ structured_string_of_expr e ^ ", " ^ string_of_atom a ^ ")"
  | HasTypeE (e, t) -> "HasTypeE (" ^ structured_string_of_expr e ^ ", " ^ t ^ ")"
  | IsValidE e -> "IsValidE (" ^ structured_string_of_expr e ^ ")"
  | TopLabelE -> "TopLabelE"
  | TopFrameE -> "TopFrameE"
  | TopValueE None -> "TopValueE"
  | TopValueE (Some e) -> "TopValueE (" ^ structured_string_of_expr e ^ ")"
  | TopValuesE e -> "TopValuesE (" ^ structured_string_of_expr e ^ ")"
  | MatchE (e1, e2) ->
    Printf.sprintf "Matches (%s, %s)"
      (structured_string_of_expr e1)
      (structured_string_of_expr e2)
  | YetE s -> "YetE (" ^ s ^ ")"

and structured_string_of_exprs el = string_of_list structured_string_of_expr ", " el


(* Paths *)

and structured_string_of_path path =
  match path.it with
  | IdxP e -> sprintf "IdxP (%s)" (structured_string_of_expr e)
  | SliceP (e1, e2) ->
    sprintf "SliceP (%s,%s)"
      (structured_string_of_expr e1)
      (structured_string_of_expr e2)
  | DotP a -> sprintf "DotP (%s)" (string_of_atom a)

and structured_string_of_paths paths =
  List.map string_of_path paths |> List.fold_left (^) ""


(* Args *)

and structured_string_of_arg arg =
  match arg.it with
  | ExpA e -> sprintf "ExpA (%s)" (structured_string_of_expr e)
  | TypA -> "TypA"

and structured_string_of_args al = string_of_list structured_string_of_arg ", " al

(* Instructions *)

let rec structured_string_of_instr' depth instr =
  match instr.it with
  | IfI (expr, t, e) ->
    "IfI (\n"
    ^ repeat indent (depth + 1)
    ^ structured_string_of_expr expr
    ^ "\n" ^ repeat indent depth ^ "then\n"
    ^ structured_string_of_instrs' (depth + 1) t
    ^ repeat indent depth ^ "else\n"
    ^ structured_string_of_instrs' (depth + 1) e
    ^ repeat indent depth ^ ")"
  | OtherwiseI b ->
    "OtherwiseI (\n"
    ^ structured_string_of_instrs' (depth + 1) b
    ^ repeat indent depth ^ ")"
  | EitherI (il1, il2) ->
    "EitherI (\n"
    ^ structured_string_of_instrs' (depth + 1) il1
    ^ repeat indent depth ^ "Or\n"
    ^ structured_string_of_instrs' (depth + 1) il2
    ^ repeat indent depth ^ ")"
  | AssertI e -> "AssertI (" ^ structured_string_of_expr e ^ ")"
  | PushI e -> "PushI (" ^ structured_string_of_expr e ^ ")"
  | PopI e -> "PopI (" ^ structured_string_of_expr e ^ ")"
  | PopAllI e -> "PopAllI (" ^ structured_string_of_expr e ^ ")"
  | LetI (e1, e2) ->
    "LetI ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
  | TrapI -> "TrapI"
  | NopI -> "NopI"
  | ReturnI None -> "ReturnI"
  | ReturnI (Some e) -> "ReturnI (" ^ structured_string_of_expr e ^ ")"
  | EnterI (e1, e2, il) ->
    "EnterI ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ", "
    ^ structured_string_of_instrs' (depth + 1) il
    ^ ")"
  | ExecuteI e -> "ExecuteI (" ^ structured_string_of_expr e ^ ")"
  | ExecuteSeqI e -> "ExecuteSeqI (" ^ structured_string_of_expr e ^ ")"
  | PerformI (id, el) -> "PerformI (" ^ id ^ ",[ " ^ structured_string_of_args el ^ " ])"
  | ExitI a -> "ExitI (" ^ string_of_atom a ^ ")"
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

and structured_string_of_instrs' depth instrs =
  List.fold_left
    (fun acc i -> acc ^ repeat indent depth ^ structured_string_of_instr' depth i ^ "\n")
    "" instrs

let structured_string_of_instr = structured_string_of_instr' 0
let structured_string_of_instrs = structured_string_of_instrs' 0

let structured_string_of_algorithm algo = match algo.it with
  | RuleA (a, _anchor, params, instrs) ->
      "execution_of_" ^ string_of_atom a
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ structured_string_of_arg p)
          "" params
      ^ ":\n"
      ^ structured_string_of_instrs' 1 instrs
  | FuncA (id, params, instrs) ->
      id
      ^ List.fold_left
          (fun acc p -> acc ^ " " ^ structured_string_of_arg p)
          "" params
      ^ ":\n"
      ^ structured_string_of_instrs' 1 instrs
