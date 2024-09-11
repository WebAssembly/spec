open Al.Ast
open Prose
open Printf
open Util.Source

(* Helpers *)

let string_of_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let string_of_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) t
      ^ right

let string_of_nullable_list stringifier left sep right = function
  | [] -> ""
  | l -> string_of_list stringifier left sep right l

let indent_depth = ref 0
let indent () = ((List.init !indent_depth (fun _ -> "  ")) |> String.concat "") ^ "- "



let string_of_atom = El.Print.string_of_atom
let string_of_typ = Il.Print.string_of_typ

(* Operators *)

let string_of_unop = function
  | NotOp -> "not"
  | MinusOp -> "-"

let string_of_binop = function
  | AndOp -> "and"
  | OrOp -> "or"
  | ImplOp -> "implies"
  | EquivOp -> "is equivalent to"
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


(* Expressions *)

and string_of_record_expr r =
  Util.Record.fold
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
  | UnE (NotOp, { it = MemE (e1, e2); _ }) ->
    sprintf "%s is not contained in %s" (string_of_expr e1) (string_of_expr e2)
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
  | CompE (e1, e2) ->
    sprintf "%s ++ %s" (string_of_expr e1) (string_of_expr e2)
  | CatE (e1, e2) ->
    sprintf "%s :: %s" (string_of_expr e1) (string_of_expr e2)
  | MemE (e1, e2) ->
    sprintf "%s is contained in %s" (string_of_expr e1) (string_of_expr e2)
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
  | IterE (e, ie) -> string_of_expr e ^ string_of_iterexp ie
  | CaseE ([{ it=El.Atom.Atom ("CONST" | "VCONST"); _ }]::_tl, hd::tl) ->
    "(" ^ string_of_expr hd ^ ".CONST " ^ string_of_exprs " " tl ^ ")"
  | CaseE (op, el) ->
    (* Current rules for omitting parenthesis around a CaseE:
       1) Has no argument
       2) Is infix notation *)
    let op' = List.map (string_of_list string_of_atom "" "" "") op in
    let el' = List.map string_of_expr el in

    let s = Prose_util.alternate op' el'
    |> List.filter (fun s -> s <> "")
    |> String.concat " " in

    let has_no_arg = List.length el = 0 in
    let is_infix = List.hd op' = "" && String.concat "" op' <> "" in
    if has_no_arg || is_infix then s else "(" ^ s ^ ")"
  | OptE (Some e) -> "?(" ^ string_of_expr e ^ ")"
  | OptE None -> "?()"
  | ContextKindE a -> sprintf "the top of the stack is a %s" (string_of_atom a)
  | IsDefinedE e -> sprintf "%s is defined" (string_of_expr e)
  | IsCaseOfE (e, a) -> sprintf "%s is of the case %s" (string_of_expr e) (string_of_atom a)
  | HasTypeE (e, t) -> sprintf "the type of %s is %s" (string_of_expr e) (string_of_typ t)
  | IsValidE e -> sprintf "%s is valid" (string_of_expr e)
  | TopLabelE -> "a label is now on the top of the stack"
  | TopFrameE -> "a frame is now on the top of the stack"
  | TopHandlerE -> "a handler is now on the top of the stack"
  | TopValueE (Some e) -> sprintf "a value of value type %s is on the top of the stack" (string_of_expr e)
  | TopValueE None -> "a value is on the top of the stack"
  | TopValuesE e -> sprintf "there are at least %s values on the top of the stack" (string_of_expr e)
  | MatchE (e1, e2) ->
    sprintf "%s matches %s"
      (string_of_expr e1)
      (string_of_expr e2)
  | YetE s -> sprintf "YetE (%s)" s

and string_of_exprs sep =
  let string_of_list stringifier sep = function
    | [] -> ""
    | h :: t ->
      let limit = 100 in
      let is_long = List.length t > limit in
      List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "..." ^ stringifier (List.hd (List.rev t))) else "")
  in
  string_of_list string_of_expr sep

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

and string_of_args sep =
  let string_of_list stringifier sep = function
    | [] -> ""
    | h :: t ->
      let limit = 100 in
      let is_long = List.length t > limit in
      List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "..." ^ stringifier (List.hd (List.rev t))) else "")
  in
  string_of_list string_of_arg sep


(* Iter exps *)

and string_of_iterexp (iter, xes) =
  let suffix = "{"
    ^ String.concat ", " (List.map (fun (id, e) -> id ^ " <- " ^ string_of_expr e) xes)
  ^ "}"
  in
  ignore suffix;
  string_of_iter iter

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
  | _ when Il.Eq.eq_typ expr.note Al.Al_util.handlerT -> "the handler "
  | IterE _ -> "the values "
  | _ -> "the value "

let rec string_of_instr' depth instr =

  let indent = "  " in
  let rec repeat str num =
    if num = 0 then ""
    else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
    else str ^ repeat (str ^ str) (num / 2)
  in

  let open Al.Ast in
  match instr.it with
  | IfI (e, il1, il2) ->
    let if_index = make_index depth in
    let if_prose = sprintf "%s If %s, then:%s" if_index (string_of_expr e)
      (string_of_instrs' (depth + 1) il1)
    in

    let rec collect_clause il =
      match il with
      | [ {it = IfI (c, il1, il2); _} ] -> (Some c, il1) :: collect_clause il2
      | _ -> [(None, il)]
    in
    let else_clauses = collect_clause il2 |> List.filter (fun (_, x) -> x <> []) in
    let else_proses = List.map (fun (cond_opt, il)->
      let else_index = make_index depth in
      match cond_opt with
      | None -> sprintf "%s Else:%s"
        (repeat indent depth ^ else_index)
        (string_of_instrs' (depth + 1) il)
      | Some e ->  sprintf "%s Else if %s, then:%s"
        (repeat indent depth ^ else_index) (string_of_expr e)
        (string_of_instrs' (depth + 1) il)
    ) else_clauses in

    String.concat "\n" (if_prose :: else_proses)
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
  | ThrowI e ->
    sprintf "%s Throw the exception %s as a result." (make_index depth) (string_of_expr e)
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
  | FieldWiseAppendI (e1, e2) ->
    sprintf "%s Append %s to the %s, fieldwise." (make_index depth)
      (string_of_expr e2) (string_of_expr e1)
  | YetI s -> sprintf "%s YetI: %s." (make_index depth) s

and string_of_instrs' depth instrs =

  let indent = "  " in
  let rec repeat str num =
    if num = 0 then ""
    else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
    else str ^ repeat (str ^ str) (num / 2)
  in

  let f acc i =
    acc ^ "\n" ^ repeat indent depth ^ string_of_instr' depth i in
  enter_block (List.fold_left f "") instrs

let string_of_instrs = string_of_instrs' 0

let string_of_algorithm algo = match algo.it with
  | RuleA (_a, anchor, params, instrs) ->
    anchor
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

let render_type_visit = ref []
let init_render_type () = render_type_visit := []
let string_of_expr_with_type e =
  let s = string_of_expr e in
  if List.mem s !render_type_visit then s else (
    render_type_visit := s :: !render_type_visit;
    let t = Prose_util.extract_desc e.note in
    if t = "" then
      string_of_expr e
    else
      "the " ^ t ^ " " ^ string_of_expr e
  )

let string_of_cmpop = function
  | Eq -> "is"
  | Ne -> "is different with"
  | Lt -> "is less than"
  | Gt -> "is greater than"
  | Le -> "is less than or equal to"
  | Ge -> "is greater than or equal to"

let rec raw_string_of_stmt stmt =
  let string_of_block = function
    | [s] -> " " ^ raw_string_of_stmt s
    | ss -> "\n" ^ indented_string_of_stmts ss
  in
  match stmt with
  | LetS (e1, e2) ->
      sprintf "Let %s be %s."
        (string_of_expr e1)
        (string_of_expr_with_type e2)
  | CondS e ->
      sprintf "%s."
        (string_of_expr e)
  | CmpS (e1, cmpop, e2) ->
      sprintf "%s %s %s."
        (string_of_expr_with_type e1)
        (string_of_cmpop cmpop)
        (string_of_expr e2)
  | IsValidS (c_opt, e, es) ->
      sprintf "%s%s is valid%s."
        (string_of_opt "Under the context " string_of_expr ", " c_opt)
        (string_of_expr_with_type e)
        (string_of_nullable_list string_of_expr_with_type " with " " and " "" es)
  | MatchesS (e1, e2) ->
      sprintf "%s matches %s."
        (string_of_expr_with_type e1)
        (string_of_expr_with_type e2)
  | IsConstS (c_opt, e) ->
      sprintf "%s%s is constant."
        (string_of_opt "Under the context " string_of_expr ", " c_opt)
        (string_of_expr_with_type e)
  | IfS (c, ss) ->
      sprintf "If %s,%s"
        (string_of_expr c)
        (string_of_block ss)
  | ForallS (iters, ss) ->
      let string_of_iter (e1, e2) = (string_of_expr e1) ^ " in " ^ (string_of_expr e2) in
      sprintf "For all %s,%s"
        (string_of_list string_of_iter "" " and " "" iters)
        (string_of_block ss)
  | EitherS sss ->
        string_of_list string_of_block "Either:" ("\n" ^ indent () ^ "Or:") "" sss
  | RelS (s, es) ->
      let template = String.split_on_char '%' s in
      let args = List.map string_of_expr es in

      Prose_util.alternate template args |> String.concat ""
  | YetS s -> indent () ^ " Yet: " ^ s

and string_of_stmt stmt = indent () ^ raw_string_of_stmt stmt

and indented_string_of_stmt i =
  indent_depth := !indent_depth + 1;
  let result = string_of_stmt i in
  indent_depth := !indent_depth - 1;
  result

and indented_string_of_stmts is =
  (string_of_list indented_string_of_stmt "" "\n" "" is)

let string_of_def = function
| RuleD (anchor, _e, concl, []) ->
    anchor
    (* ^ " " ^ string_of_expr e ^ "\n" *)
    ^ "\n"
    ^ string_of_stmt concl ^ "\n"
| RuleD (anchor, _e, concl, prems) ->
    init_render_type ();
    let concl_str = string_of_stmt concl in
    let drop_last x = String.sub x 0 (String.length x - 1) in
    anchor
    (* ^ " " ^ string_of_expr e ^ "\n" *)
    ^ "\n"
    ^ drop_last concl_str
    ^ " if:\n"
    ^ string_of_list indented_string_of_stmt "" "\n" "\n" prems
| AlgoD algo -> string_of_algorithm algo

let string_of_prose prose = List.map string_of_def prose |> String.concat "\n"

let file_of_prose file prose =
  let prose = string_of_prose prose in
  let oc = Out_channel.open_text file in
  Fun.protect (fun () -> Out_channel.output_string oc prose)
    ~finally:(fun () -> Out_channel.close oc)
