open Util.Source
open El.Ast
open El

(* Output buffer *)
let buf = Buffer.create 4096

(* Helpers *)
let _stepIdx = ref 1
let stepIdx _ =
  let i = !_stepIdx in
  _stepIdx := (i + 1);
  i

let _subIdx = ref 1
let subIdx _ =
  let i = !_subIdx in
  _subIdx := (i + 1);
  i

let _indent = ref false
let indent _ =
  _indent := true;
  _subIdx := 1
let unindent _ =
  _indent := false

let printf_step formatted =
  if !_indent then
    Printf.bprintf buf ("  %d) " ^^ formatted ^^ "\n") (subIdx())
  else
    Printf.bprintf buf ("%d. " ^^ formatted ^^ "\n") (stepIdx())

let check_nothing _ =
  if
    !_indent && !_subIdx = 1 ||
    not !_indent && !_stepIdx = 1
  then
    printf_step "Do nothing."

(* 1. Handle lhs of reduction rules *)

let hds l = l |> List.rev |> List.tl

let assert_type e =
  match e.it with
  (* ({CONST I32 c}) *)
  | ParenE({it = SeqE({it = (AtomE (Atom "CONST")); _} :: {it = (AtomE (Atom "I32")); _}  :: _); _}, _) ->
    printf_step "Assert: Due to validation, a value of value type i32 is on the top of the stack."
  | _ ->
    printf_step "Assert: Due to validation, a value is on the top of the stack."

let pop left = match left.it with
  | SeqE(es) -> hds es |> List.iter (fun e ->
    assert_type e;
    let v = Print.string_of_exp e in
    printf_step "Pop the value %s from the stack." v
  )
  | ParenE({it = SeqE({it = AtomE(Atom "LABEL_"); _} :: _); at = _}, _) ->
    printf_step "YET: Bubble-up semantics."
  | _ -> ()

(* 2. Handle premises *)

let calc (prems: premise nl_list) : unit =
  prems |> List.iter (fun p -> match p with
    | Elem { it = IfPr(e, None); _ } -> printf_step "Let %s." (Print.string_of_exp e)
    | _ -> ()
  )

let cond (prems: premise nl_list) =
  prems
  |> List.map (fun p -> match p with
    | Elem {it = IfPr(e, None); _} -> Print.string_of_exp e
    | Elem p -> Print.string_of_premise p
    | Nl -> "Nl"
  )
  |> String.concat " and "
  |> printf_step "If %s, then:"

(* 3. Handle rhs of reductino rules *)

let _freshId = ref 0
let fresh _ =
  let id = !_freshId in
  _freshId := (id + 1);
  "tmp" ^ string_of_int id

let bind_atomic e =
  let is_call = match e.it with CallE _ -> true | _ -> false in
  let id = fresh() in
  if is_call then
    printf_step "Let %s be the result of computing %s." id (Print.string_of_exp e)
  else
    printf_step "Let %s be %s." id (Print.string_of_exp e)
  ;
  { it = VarE({it = id; at = e.at}); at = e.at }

let rec bind e = match e.it with
  | VarE _
  | IterE({it = VarE _; _}, _)
  | AtomE _
  | NatE _ -> e
  | BinE _ -> { it = ParenE(e, true) ; at = no_region }
  | IdxE(base, idx) ->
    let base = bind base in
    let idx  = bind idx in
    bind_atomic {it = IdxE(base, idx); at = e.at}
  | _ ->
    bind_atomic e

let destruct_instr = function
  | {it = AtomE(Atom name); _} :: args -> (name, args)
  | _ -> raise(Invalid_argument "invalid instr")

let mutate state = match state.it with
  | CallE _ -> printf_step "Perform %s." (Print.string_of_exp state)
  | _ -> ()

let rec push right = match right.it with
  | InfixE(state, Semicolon, stack) ->
    mutate state;
    push stack
  | SeqE seq ->
    List.iter push seq
  | AtomE(Atom "TRAP") -> printf_step "Trap."
  | ParenE({it = SeqE(instr); _}, _) -> (
    match destruct_instr instr with
      | ("LABEL_", n :: cont :: args) ->
        printf_step
          "Let L be the label whose arity is %s and whose continuation is the %s of this instruction."
          (Print.string_of_exp n)
          (
            match cont.it with
            | BrackE(_, {it = EpsE; _}) ->  "end"
            | _ -> "start"
          );
        printf_step
          "Enter the block %s with label L."
          (Print.string_of_exps " " args)
      | ("FRAME_", n :: frame :: label :: []) ->
        printf_step
          "Let F be the frame %s."
          (Print.string_of_exp frame);
        printf_step
          "Push the activation of F with the arity %s to the stack."
          (Print.string_of_exp n);
        push label
      | ("CONST" | "REF.NULL" | "REF.FUNC_ADDR" as name, args) ->
        let args = List.map bind args in
        let str = Print.string_of_exps " " args in
        printf_step "Push the value %s %s to the stack." name str
      | (name, args) ->
        let args = List.map bind args in
        let str = Print.string_of_exps " " args in
        printf_step "Execute the instruction %s %s." name str
    )
  | VarE(id) -> printf_step "Push the value %s to the stack." id.it
  | IterE({it = VarE _; _}, _) -> printf_step "Push the values %s to the stack." (Print.string_of_exp right)
  | EpsE -> ()
  | _ ->
    let e = bind right in
    printf_step "Push the value %s to the stack."  (Print.string_of_exp e)

(* if r is a reduction rule, desturct it into triplet of (lhs, rhs, premises) *)
let destruct_as_rule r = match r.it with
  | RuleD(name, _, e, prems) -> (match e.it with
    | InfixE(left, SqArrow, right) ->
      if String.starts_with ~prefix:"Step_" name.it then
        Some (left, right, prems)
      else
        None
    | _ -> None)
  | _ -> None
let string_of_destructed (left, right, prems) =
  let filter_nl xs = List.filter_map (function Nl -> None | Elem x -> Some x) xs in
  let map_nl_list f xs = List.map f (filter_nl xs) in
  Print.string_of_exp left ^
  " ~> " ^
  Print.string_of_exp right ^
  String.concat "" (map_nl_list (fun x -> "\n    -- " ^ Print.string_of_premise x) prems)

let handle_reduction_group red_group =
  (* assert: every redunction rule in red_group has same lhs *)
  red_group |> List.iter (fun red ->
    Buffer.add_string buf (string_of_destructed red);
    Buffer.add_char buf '\n'
  );
  _stepIdx := 1;
  _freshId := 0;

  let (left, _, _) = List.hd red_group in
  let left = match left.it with
    | InfixE(_, Semicolon, left) -> left
    | _ -> left
  in
  pop left;

  (
    match red_group with
    (* one rule -> premises are highly likely assignment *)
    | [(_, right, prems)] ->
      calc prems;
      push right;
    (* two rules -> premises are highly likely conditions *)
    | [(_, right1, prems1) ; (_, right2, prems2)] ->
      cond prems1;
        indent();
        push right1;
        check_nothing();
        unindent();
      cond prems2;
        indent();
        push right2;
        check_nothing();
        unindent();
    | _ -> raise (Failure "TODO")
  );

  check_nothing();

  Buffer.add_char buf '\n'

let rec group_by f = function
  | [] -> []
  | [x] -> [[x]]
  | hd :: tl ->
    let pred x = (f hd  = f x) in
    let (l, r) = List.partition pred tl in
    (hd :: l) :: (group_by f r)

let translate el =
  (* Filter and destruct redctions only *)
  let reductions = el |> List.filter_map destruct_as_rule in

  (* Group reductions by lefthand side *)
  let reduction_groups = group_by (fun (left, _, _) ->
    Print.string_of_exp left
  ) reductions in

  (* Handle each redction group *)
  List.iter handle_reduction_group reduction_groups;

  Buffer.contents buf
