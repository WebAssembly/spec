open Il
open Ast
open Util.Source
open El.Atom

(* Pre-process a premise *)
let rec preprocess_prem prem =
  match prem.it with
  | IterPr (prem, iterexp) ->
    prem
    |> preprocess_prem
    |> List.map (fun new_prem -> IterPr (new_prem, iterexp) $ prem.at)
  | RulePr (id, mixop, exp) when id.it = "Expand" ->
    (match mixop, exp.it with
    (* Expand: `dt` ~~ `ct` *)
    | [[]; [approx]; []], TupE [dt; ct] when approx.it = Approx ->
      (* `$expanddt(dt) = ct` *)
      let expanddt = 
        CallE ("expanddt" $ prem.at, [ExpA dt $ dt.at]) $$ prem.at % ct.note
      in
      let new_prem =
        IfPr (CmpE (EqOp, expanddt, ct) $$ prem.at % (BoolT $ no_region))
      in
      [ new_prem $ prem.at ]
    (* Expand: ??? *)
    | _ -> [ prem ]
    )
  | RulePr (id, mixop, exp) ->
    (match mixop, exp.it with
    (* `id`: |- `lhs` : `rhs` *)
    | [[turnstile]; [colon]; []], TupE [lhs; rhs]
    (* `id`: C |- `lhs` : `rhs` *)
    | [[]; [turnstile]; [colon]; []], TupE [_; lhs; rhs]
    when turnstile.it = Turnstile && colon.it = Colon ->
      (* $`id`(`lhs`) = `rhs` *)
      let typing_function_call =
        CallE (id, [ExpA lhs $ lhs.at]) $$ exp.at % rhs.note
      in
      let new_prem =
        IfPr (CmpE (EqOp, typing_function_call, rhs) $$ exp.at % (BoolT $ no_region))
      in
      [ new_prem $ prem.at ]
    | _ -> [ prem ]
    )
  (* Split -- if e1 /\ e2 *)
  | IfPr ( { it = BinE (AndOp, e1, e2); _ } ) ->
    preprocess_prem (IfPr e1 $ prem.at) @ preprocess_prem (IfPr e2 $ prem.at)
  | _ -> [ prem ]

let preprocess_rule (rule: rule) : rule =
  let RuleD (id, binds, mixop, exp, prems) = rule.it in
  RuleD (id, binds, mixop, exp, List.concat_map preprocess_prem prems) $ rule.at

let preprocess_clause (clause: clause) : clause =
  let DefD (binds, args, exp, prems) = clause.it in
  DefD (binds, args, exp, List.concat_map preprocess_prem prems) $ clause.at

let rec preprocess_def (def: def) : def =
  match def.it with
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, List.map preprocess_rule rules) $ def.at
  | DecD (id, params, typ, clauses) ->
    DecD (id, params, typ, List.map preprocess_clause clauses) $ def.at
  | RecD defs -> RecD (List.map preprocess_def defs) $ def.at
  | _ -> def

let preprocess: script -> script = List.map preprocess_def
