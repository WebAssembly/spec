open Util.Source
open El.Ast
open El

(* Helpers *)

let _stepIdx = ref 1
let stepIdx _ =
  let i = !_stepIdx in
  _stepIdx := (i + 1);
  i
let printf_step formatted =
  Printf.printf ("%d. " ^^ formatted ^^ "\n") (stepIdx())

(* 1. Pop the values from the stack and obtain input variables *)

let hds l = l |> List.rev |> List.tl

let assert_type e =
  match e.it with
  (* ({CONST I32 c}) *)
  | ParenE({it = SeqE({it = (AtomE (Atom "CONST")); _} :: {it = (AtomE (Atom "I32")); _}  :: _); _}) ->
    printf_step "Assert: Due to validation, a value of value type i32 is on the top of the stack."
  | _ -> 
    printf_step "Assert: Due to validation, a value is on the top of the stack."

let pop left = match left.it with
  | SeqE(es) -> hds es |> List.iter (fun e ->
    assert_type e;
    let v = Print.string_of_exp e in
    printf_step "Pop the value %s from the stack." v
  )
  | _ -> ()
  
(* 2. Calculate the output variables from the input variables from the conditions *)

let calc conds =
  conds |> List.iter (fun c ->
    printf_step "YET: %s" (Print.string_of_premise c)
  )
  
(* 3. Push the value to the stack / execute instructions, based on the output variables *)

let _freshId = ref 0
let fresh _ =
  let id = !_freshId in
  _freshId := (id + 1);
  "tmp" ^ string_of_int id

let bind_argument args =
  args |> List.map (fun arg -> match arg.it with
    | VarE _
    | IterE({it = VarE _; _}, _) -> arg
    | _ ->
      let id = fresh() in
      printf_step "Let %s be %s." id (Print.string_of_exp arg);
      { it = VarE({it = id; at = arg.at}); at = arg.at }
  )

let destruct instr = match instr with
  | {it = AtomE(Atom name); _} :: args -> (name, args)
  | _ -> raise(Invalid_argument "invalid instr")

let push right = match right.it with
  | AtomE(Atom "TRAP") -> printf_step("Trap.")
  | ParenE({it = SeqE(instr); _}) -> (
    match destruct instr with
      | ("LABEL", n :: cont :: vals :: instrs :: []) ->
        printf_step
          "Let L be the label whose arity is %s and whose continuation is %s."
          (Print.string_of_exp n)
          (Print.string_of_exp cont);
        printf_step
          "Enter the block %s %s with label L."
          (Print.string_of_exp vals)
          (Print.string_of_exp instrs)
      | ("FRAME", _) -> 
        printf_step "YET: Push the frame to the stack.";
        printf_step "YET: Enter the block with label."
      | ("CONST" | "REF.NULL" | "REF.FUNC" as name, args) ->
        let args = bind_argument args in
        let str = Print.string_of_exps " " args in
        printf_step "Push the value %s %s to the stack." name str
      | (name, args) ->
        let args = bind_argument args in
        let str = Print.string_of_exps " " args in
        printf_step "Execute the instruction %s %s." name str
    )
  | VarE(id) -> printf_step "Push the value %s to the stack." id.it
  | _ -> ()

let reduce left right conds = 
  (*
  left ~> right
  -- iff cond1
  -- iff cond2
  *)

  (* 1. Pop the values from the stack and obtain input variables *)
  pop left;
  (* 2. Calculate the output variables from the input variables from the conditions *)
  calc conds;
  (* 3. Push the value to the stack / execute instructions, based on the output variables *)
  push right

let handle_reduction red = 
  print_endline (Print.string_of_def red);

  _stepIdx := 1;
  _freshId := 0;
  (
    match red.it with
    | RuleD (_, _, red, cond) -> (
      match red.it with
      | InfixE(left, SqArrow, right) -> (
        match left.it with
        | InfixE(_, Semicolon, left) -> reduce left right cond
        | _ -> reduce left right cond)
      | _ -> ())
    | _ -> ()
  );
  if (!_stepIdx == 1) then printf_step "Do nothing.";
  print_newline()

let translate el =
  print_endline "starting translate";
  let reductions = el |> List.filter (fun def ->
    match def.it with
    | RuleD(name, _, e, _) -> (match e.it with
      | InfixE(_, SqArrow, _) -> String.starts_with ~prefix:"Step_" name.it
      | _ -> false)
    | _ -> false
  ) in

  List.iter handle_reduction reductions;

  print_endline "finishing translate";
