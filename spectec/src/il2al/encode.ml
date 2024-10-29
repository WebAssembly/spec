(**
Encode lhs of a reduction rule into premises.
ex)
  v3* v2^n v1 INSTR ~> eps
  -->
  v3* v2^n v1 INSTR ~> eps
  -- if v1,   _s1 = POP(1), 0
  -- if v2^n, _s2 = POP(n), _s1
  -- if v3* , _s3 = POP(-1), _s2
**)

open Util
open Source

open Free
open Il
open Xl
open Ast
(* open Print *)

(* Helpers *)
let error at msg = Error.error at "prose translation" msg

let mk_id x =
  x $ no_region
let mk_varT xt =
  VarT (mk_id xt, []) $ no_region
let mk_varE xe xt =
  VarE (mk_id xe) $$ no_region % (mk_varT xt)

let is_case e =
  match e.it with
  | CaseE _ -> true
  | _ -> false
let case_of_case e =
  match e.it with
  | CaseE (mixop, _) -> mixop
  | _ -> error e.at "cannot get case of case expression"
let args_of_case e =
  match e.it with
  | CaseE (_, { it = TupE exps; _ }) -> exps
  | CaseE (_, exp) -> [ exp ]
  | _ -> error e.at "cannot get arguments of case expression"

let is_context e =
  is_case e &&
  match case_of_case e with
  | (atom :: _) :: _ ->
    (match it atom with

  | Atom a -> List.mem a Al.Al_util.context_names
    | _ -> false)
  | _ -> false

let rec stack_to_list e =
  match e.it with
  | CatE (e1, e2) -> stack_to_list e1 @ stack_to_list e2
  | ListE es -> es
  (* List.map (fun e -> { e with it = ListE [e] }) es *)
  | _ -> [ e ]

let rec drop_until' acc f xs =
  match xs with
  | [] -> acc, []
  | hd :: tl -> if f hd then acc, xs else drop_until' (hd :: acc) f tl
let drop_until = drop_until' []

let free_ids e =
  (free_exp false e)
  .varid
  |> Set.elements

let dim e =
  let t = (NumT Num.NatT $ no_region) in
  match e.it with
  | IterE (_, (ListN (e_n, _), _)) -> e_n
  | IterE _ -> NumE (Num.Nat Z.minus_one) $$ e.at % t
  | ListE es -> NumE (Num.Nat (List.length es |> Z.of_int)) $$ e.at % t
  | _ -> NumE (Num.Nat Z.one) $$ e.at % t

let arg e =
  ExpA e $ e.at

let input_vars = [
  "input";
  "stack0";
  "ctxt";
  "state";
  "unused";
]

(* Encode stack *)

let encode_inner_stack context_opt stack =
  let dropped, es = stack_to_list stack |> List.rev |> drop_until is_case in

  let unused_prems =
    if List.length dropped = 0 then
      []
    else
      let unused = TupE dropped $$ no_region % (mk_varT "unusedT") in
      [LetPr (unused, mk_varE "unused" "unusedT", free_ids unused) $ no_region]
  in

  match es with
  | [] ->
    (* ASSUMPTION: The target instruction was actually the outer context (i.e. LABEL_) *)
    (
      match context_opt with
      | None -> assert false
      | Some e ->
        Some (LetPr (e, mk_varE "input" "inputT", free_ids e) $ e.at), unused_prems
    )
  | _ ->
    (* ASSUMPTION: The top of the stack should be now the target instruction *)
    let winstr, operands = Lib.List.split_hd es in

    let prem = LetPr (winstr, mk_varE "input" "inputT", free_ids winstr) $ winstr.at in
    let prems = List.mapi (fun i e ->
      let s0 = ("stack" ^ string_of_int i) in
      let s1 = ("stack" ^ string_of_int (i+1)) in
      let t = mk_varT "stackT" in

      let stack1 = mk_varE s1 "stackT" in
      let lhs = TupE [e; stack1] $$ no_region % t in

      let n = dim e in
      let stack0 = mk_varE s0 "stackT" in
      let rhs = CallE (mk_id "pop", [arg n; arg stack0]) $$ no_region % t in

      IfPr (CmpE (EqOp, lhs, rhs) $$ e.at % (BoolT $ no_region)) $ e.at
    ) operands in

    None, prem :: prems @ unused_prems

let encode_stack stack =
  match stack.it with
  | ListE [e] when is_context e ->
    let mixop = case_of_case e in
    let args  = args_of_case e in

    (* ASSUMPTION: the inner stack of the ctxt instruction is always the last arg *)
    let args', inner_stack = Lib.List.split_last args in
    let mixop', _ = Lib.List.split_last mixop in

    let e1 = { e with it = CaseE (mixop', TupE args' $$ no_region % (mk_varT "")) } in
    let e2 = (mk_varE "ctxt" "contextT") in

    let pr = LetPr (e1, e2, free_ids e1) $ e2.at in

    let pr_opt, prs = encode_inner_stack (Some e) inner_stack in
    (
      match pr_opt with
      | None -> pr
      | Some pr -> pr
    ) :: prs
  | _ ->
    encode_inner_stack None stack |> snd

(* Encode lhs *)
let encode_lhs lhs =
  match lhs.it with
  | CaseE ([[]; [{it = Semicolon; _}]; []], {it = TupE [z; stack]; _}) ->
    let prem = LetPr (z, mk_varE "state" "stateT", free_ids z) $ z.at in
    prem :: encode_stack stack
  | _ ->
    let stack = lhs in
    encode_stack stack

(* Encode rule *)
let encode_rule r =
  match r.it with
  | RuleD(id, binds, mixop, args, prems) ->
    match (mixop, args.it) with
    (* lhs ~> rhs *)
    | ([ [] ; [{it = SqArrow; _}] ; []] , TupE ([lhs; _rhs])) ->
      let name = String.split_on_char '-' id.it |> List.hd in
      if List.mem name ["pure"; "read"; "trap"; "ctxt"] then (* Administrative rules *)
        r
      else
        let new_prems = encode_lhs lhs in
        RuleD(id, binds, mixop, args, new_prems @ prems) $ r.at
    | _ -> r

(* Encode defs *)
let rec encode_def d =
  match d.it with
  | RelD (id, mixop, t, rules) ->
    let rules' = List.map encode_rule rules in
    RelD (id, mixop, t, rules') $ d.at
  | RecD ds -> RecD (List.map encode_def ds) $ d.at
  | DecD _ | TypD _ | GramD _ | HintD _ -> d

(* Main entry *)
let transform (defs : script) =
  List.map encode_def defs
