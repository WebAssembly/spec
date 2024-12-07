open Ast
open Xl
open Printf
open Util
open Source


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

let string_of_typ = Il.Print.string_of_typ


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
  | ListV lv -> "[" ^ string_of_values ", " (Array.to_list !lv) ^ "]"
  | NumV n -> Num.to_string n
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
  | FnameV id -> "$" ^ id

and string_of_values sep = string_of_list string_of_value sep


(* Operators *)

let string_of_unop = function
  | #Bool.unop as op -> Bool.string_of_unop op
  | #Num.unop as op -> Num.string_of_unop op

let string_of_binop = function
  | #Bool.binop as op -> Bool.string_of_binop op
  | #Num.binop as op -> Num.string_of_binop op
  | #Bool.cmpop as op -> Bool.string_of_cmpop op
  | #Num.cmpop as op -> Num.string_of_cmpop op


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
  | NumE n -> Num.to_string n
  | BoolE b -> string_of_bool b
  | CvtE (e, _, t) -> sprintf "$%s$(%s)" (Il.Print.string_of_numtyp t) (string_of_expr e)
  | UnE (op, e) -> sprintf "%s(%s)" (string_of_unop op) (string_of_expr e)
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
  | CompE (e1, e2) ->
    sprintf "%s ++ %s" (string_of_expr e1) (string_of_expr e2)
  | CatE (e1, e2) ->
    sprintf "%s :: %s" (string_of_expr e1) (string_of_expr e2)
  | MemE (e1, e2) ->
    sprintf "%s is contained in %s" (string_of_expr e1) (string_of_expr e2)
  | LenE e -> sprintf "|%s|" (string_of_expr e)
  | GetCurStateE -> "current_state()"
  | GetCurContextE None -> "current_context()"
  | GetCurContextE (Some a) -> sprintf "current_context(%s)" (string_of_atom a)
  | ListE el -> "[" ^ string_of_exprs ", " el ^ "]"
  | LiftE e -> "lift(" ^ string_of_expr e ^ ")"
  | AccE (e, p) -> sprintf "%s%s" (string_of_expr e) (string_of_path p)
  | ExtE (e1, ps, e2, dir) -> (
    match dir with
    | Front -> sprintf "prepend(%s%s, %s)" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
    | Back -> sprintf "append(%s%s, %s)" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2))
  | UpdE (e1, ps, e2) ->
    sprintf "update(%s%s, %s)" (string_of_expr e1) (string_of_paths ps) (string_of_expr e2)
  | StrE r -> string_of_record_expr r
  | ChooseE e -> sprintf "choose(%s)" (string_of_expr e)
  | VarE id -> id
  | SubE (id, _) -> id
  | IterE (e, ie) -> string_of_expr e ^ string_of_iterexp ie
  | CaseE ([{ it=Atom.Atom ("CONST" | "VCONST"); _ }]::_tl, hd::tl) ->
    "(" ^ string_of_expr hd ^ ".CONST " ^ string_of_exprs " " tl ^ ")"
  | CaseE ([[ atom ]], []) -> string_of_atom atom
  | CaseE (op, el) ->
    let op' = List.map (fun al -> String.concat "" (List.map string_of_atom al)) op in
    (match op' with
    | [] -> "()"
    | _::tl when List.length tl != List.length el ->
      let res = String.concat ", " (List.map string_of_expr el) in
      "(Invalid CaseE: " ^ (string_of_mixop op) ^ " (" ^ res ^ "))"
    | hd::tl ->
      let res =
        List.fold_left2 (
          fun acc a e ->
            let a' = if a = "" then "" else " " ^ a in
            let acc' = if acc = "" then "" else acc ^ " " in
            acc' ^ string_of_expr e ^ a'
        ) hd tl el in
      "(" ^ res ^ ")"
    )
  | OptE (Some e) -> "?(" ^ string_of_expr e ^ ")"
  | OptE None -> "?()"
  | ContextKindE a -> sprintf "context_kind(%s)" (string_of_atom a)
  | IsDefinedE e -> sprintf "%s != None" (string_of_expr e)
  | IsCaseOfE (e, a) -> sprintf "case(%s) == %s" (string_of_expr e) (string_of_atom a)
  | HasTypeE (e, t) -> sprintf "type(%s) == %s" (string_of_expr e) (string_of_typ t)
  | IsValidE e -> sprintf "valid(%s)" (string_of_expr e)
  | TopValueE (Some e) -> sprintf "top_value(%s)" (string_of_expr e)
  | TopValueE None -> "top_value()"
  | TopValuesE e -> sprintf "top_values(%s)" (string_of_expr e)
  | MatchE (e1, e2) ->
    sprintf "%s <: %s"
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
  | TypA typ -> string_of_typ typ
  | DefA id -> "$" ^ id

and string_of_args sep = string_of_list string_of_arg sep



(* Iter exps *)

and string_of_iterexp (iter, xes) =
  string_of_iter iter ^ "{" ^ String.concat ", "
    (List.map (fun (id, e) -> id ^ " <- " ^ string_of_expr e) xes) ^ "}"


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

(* Prefix for stack push/pop operations *)
let string_of_stack_prefix expr =
  match expr.it with
  | GetCurContextE _
  | VarE ("F" | "L") -> ""
  | IterE _ -> ""
  | _ -> ""

let rec string_of_instr' depth instr =
  match instr.it with
  | IfI (e, il, []) ->
    sprintf " If (%s) {%s\n%s }" (string_of_expr e)
      (string_of_instrs' (depth + 1) il) (repeat indent depth)
  | IfI (e, il1, [ { it = IfI (inner_e, inner_il1, []); _ } ]) ->
    sprintf " If (%s) {%s\n%s }\n%s Else if (%s) {%s\n%s }"
      (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth)
      (repeat indent depth)
      (string_of_expr inner_e)
      (string_of_instrs' (depth + 1) inner_il1)
      (repeat indent depth)
  | IfI (e, il1, [ { it = IfI (inner_e, inner_il1, inner_il2); _ } ]) ->
    sprintf " If (%s) {%s\n%s }\n%s Else if (%s) {%s\n%s }\n%s Else {%s\n%s }"
      (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth)
      (repeat indent depth)
      (string_of_expr inner_e)
      (string_of_instrs' (depth + 1) inner_il1)
      (repeat indent depth)
      (repeat indent depth)
      (string_of_instrs' (depth + 1) inner_il2)
      (repeat indent depth)
  | IfI (e, il1, il2) ->
    sprintf " If (%s) {%s\n%s }\n%s Else {%s\n%s }" (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth)
      (repeat indent depth)
      (string_of_instrs' (depth + 1) il2)
      (repeat indent depth)
  | OtherwiseI il ->
    sprintf " Otherwise:%s"
      (string_of_instrs' (depth + 1) il)
  | EitherI (il1, il2) ->
    sprintf " Either {%s\n%s }\n%s Or {%s\n %s}"
      (string_of_instrs' (depth + 1) il1)
      (repeat indent depth)
      (repeat indent depth)
      (string_of_instrs' (depth + 1) il2)
      (repeat indent depth)
  | AssertI e -> sprintf " Assert (%s)" (string_of_expr e)
  | PushI e ->
    sprintf " Push %s%s"
      (string_of_stack_prefix e) (string_of_expr e)
  | PopI e ->
    sprintf " Pop %s%s"
      (string_of_stack_prefix e) (string_of_expr e)
  | PopAllI e ->
    sprintf " Pop_all %s"
      (string_of_expr e)
  | LetI (e1, e2) ->
    sprintf " Let %s = %s" (string_of_expr e1)
      (string_of_expr e2)
  | TrapI -> sprintf " Trap"
  | ThrowI e -> sprintf " Throw %s" (string_of_expr e)
  | NopI -> sprintf " Nop"
  | ReturnI None -> sprintf " Return"
  | ReturnI (Some e) -> sprintf " Return %s" (string_of_expr e)
  | EnterI (e1, e2, il) ->
    sprintf " Enter (%s, %s) {%s \n%s }"
      (string_of_expr e1) (string_of_expr e2) (string_of_instrs' (depth + 1) il) (repeat indent depth)
  | ExecuteI e ->
    sprintf " Execute %s" (string_of_expr e)
  | ExecuteSeqI e ->
    sprintf " Execute %s" (string_of_expr e)
  | PerformI (id, el) ->
    sprintf " %s" (string_of_expr (CallE (id, el) $$ instr.at % (Il.Ast.VarT ("TODO" $ no_region, []) $ no_region)))
  | ExitI a ->
    sprintf " Exit %s" (string_of_atom a)
  | ReplaceI (e1, p, e2) ->
    sprintf " %s%s := %s"
      (string_of_expr e1) (string_of_path p) (string_of_expr e2)
  | AppendI (e1, e2) ->
    sprintf " %s :+ %s"
      (string_of_expr e2) (string_of_expr e1)
  | FieldWiseAppendI (e1, e2) ->
    sprintf " %s :⨁ %s"
      (string_of_expr e2) (string_of_expr e1)
  | YetI s -> sprintf " YetI: %s." s

and string_of_instrs' depth instrs =
  let f acc i =
    acc ^ "\n" ^ repeat indent depth ^ string_of_instr' depth i in
  enter_block (List.fold_left f "") instrs

let string_of_instr instr =
  set_index 0;
  string_of_instr' 0 instr
let string_of_instrs = string_of_instrs' 0

let string_of_algorithm algo =
  match algo.it with
  | RuleA (_a, anchor, params, instrs) ->
    anchor
    ^ List.fold_left
        (fun acc p -> acc ^ " " ^ string_of_arg p)
        "" params
    ^ " {"
    ^ string_of_instrs instrs ^ "\n}\n"
  | FuncA (id, params, instrs) ->
    id
    ^ List.fold_left
        (fun acc p -> acc ^ " " ^ string_of_arg p)
        "" params
    ^ " {"
    ^ string_of_instrs instrs ^ "\n}\n"


(* Structured stringfier *)

(* Wasm type *)


(* Values *)

let rec structured_string_of_value = function
  | ListV lv -> "ListV" ^ "[" ^ string_of_values ", " (Array.to_list !lv) ^ "]"
  | BoolV b -> "BoolV (" ^ string_of_bool b ^ ")"
  | NumV n -> "NumV (" ^ Num.to_string n ^ ")"
  | TextV s -> "TextV (" ^ s ^ ")"
  | TupV vl ->  "TupV (" ^ structured_string_of_values vl ^ ")"
  | CaseV (s, vl) -> "CaseV(" ^ s ^ ", [" ^ structured_string_of_values vl ^ "])"
  | StrV _r -> "StrV (TODO)"
  | OptV None -> "OptV"
  | OptV (Some e) -> "OptV (" ^ structured_string_of_value e ^ ")"
  | FnameV id -> "FnameV (\"" ^ id ^ "\")"

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
  | NumE _ | BoolE _ -> string_of_expr expr
  | CvtE (e, t1, t2) ->
    "CvtE ("
    ^ structured_string_of_expr e
    ^ ", "
    ^ Il.Print.string_of_numtyp t1
    ^ ", "
    ^ Il.Print.string_of_numtyp t2
    ^ ")"
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
  | CompE (e1, e2) ->
    "CompE ("
    ^ structured_string_of_expr e1
    ^ ", "
    ^ structured_string_of_expr e2
    ^ ")"
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
  | GetCurStateE -> "GetCurStateE"
  | GetCurContextE None -> "GetCurContextE"
  | GetCurContextE (Some a) -> sprintf "GetCurContextE (%s)" (string_of_atom a)
  | ListE el -> "ListE ([" ^ structured_string_of_exprs el ^ "])"
  | LiftE e -> "LiftE (" ^ structured_string_of_expr e ^ ")"
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
  | ChooseE e1 -> "ChooseE (" ^ structured_string_of_expr e1 ^ ")"
  | VarE id -> "VarE (" ^ id ^ ")"
  | SubE (id, t) -> sprintf "SubE (%s, %s)" id (string_of_typ t)
  | IterE (e, (iter, xes)) ->
    "IterE ("
    ^ structured_string_of_expr e
    ^ ", ("
    ^ structured_string_of_iter iter
    ^ ", {"
    ^ string_of_list (fun (x, e) -> x ^ structured_string_of_expr e) ", " xes
    ^ "}))"
  | CaseE (op, el) ->
    "CaseE (" ^ string_of_mixop op
    ^ ", [" ^ structured_string_of_exprs el ^ "])"
  | OptE None -> "OptE"
  | OptE (Some e) -> "OptE (" ^ structured_string_of_expr e ^ ")"
  | ContextKindE a -> sprintf "ContextKindE (%s)" (string_of_atom a)
  | IsDefinedE e -> "DefinedE (" ^ structured_string_of_expr e ^ ")"
  | IsCaseOfE (e, a) -> "CaseOfE (" ^ structured_string_of_expr e ^ ", " ^ string_of_atom a ^ ")"
  | HasTypeE (e, t) ->
    sprintf "HasTypeE (%s, %s)" (structured_string_of_expr e) (string_of_typ t)
  | IsValidE e -> "IsValidE (" ^ structured_string_of_expr e ^ ")"
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
  | TypA typ -> sprintf "TypA (%s)" (string_of_typ typ)
  | DefA id -> sprintf "DefA (%s)" id

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
  | ThrowI e -> "ThrowI (" ^ structured_string_of_expr e ^ ")"
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
  | FieldWiseAppendI (e1, e2) ->
    "FieldWiseAppendI ("
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
  | RuleA (_a, anchor, params, instrs) ->
      anchor
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
