open Il
open Ast
open Util.Source
open El.Atom


(* Remove or *)
let remove_or_exp e =
  match e.it with (* TODO: recursive *)
  | BinE (OrOp, e1, e2) -> [ e1; e2 ]
  | _ -> [ e ]

let rec remove_or_prem prem =
  match prem.it with
  | IfPr e -> e |> remove_or_exp |> List.map (fun e' -> IfPr e' $ prem.at)
  | IterPr (prem, iterexp) ->
    prem
    |> remove_or_prem
    |> List.map (fun new_prem -> IterPr (new_prem, iterexp) $ prem.at)
  | _ -> [ prem ]

let remove_or_rule rule =
  match rule.it with
  | RuleD (id, binds, mixop, args, prems) ->
    let premss = List.map remove_or_prem prems in
    let premss' = List.fold_right (fun ps pss ->
      (* Duplice pss *)
      List.concat_map (fun cur ->
        List.map (fun p -> p :: cur) ps
      ) pss
    ) premss [[]] in

    if List.length premss' = 1 then [ rule ] else

    List.mapi (fun i prems' ->
      let id' = id.it ^ "-" ^ string_of_int i $ id.at in
      RuleD (id', binds, mixop, args, prems') $ rule.at
    ) premss'

let remove_or_clause clause =
  match clause.it with
  | DefD (binds, args, exp, prems) ->
    let premss = List.map remove_or_prem prems in
    let premss' = List.fold_right (fun ps pss ->
      (* Duplice pss *)
      List.concat_map (fun cur ->
        List.map (fun p -> p :: cur) ps
      ) pss
    ) premss [[]] in

    if List.length premss' = 1 then [ clause ] else

    List.map (fun prems' -> DefD (binds, args, exp, prems') $ clause.at) premss'

let remove_or def =
  match def.it with
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, List.concat_map remove_or_rule rules) $ def.at
  | DecD (id, params, typ, clauses) ->
    DecD (id, params, typ, List.concat_map remove_or_clause clauses) $ def.at
  | _ -> def


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

      (* Add function definition to AL environment *)
      if not (Env.mem_def !Al.Valid.env id) then (
        let param = ExpP ("_" $ no_region, dt.note) $ dt.at in
        Al.Valid.env := Env.bind_def !Al.Valid.env id ([param], ct.note, [])
      );

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

      (* Add function definition to AL environment *)
      if not (Env.mem_def !Al.Valid.env id) then (
        let param = ExpP ("_" $ no_region, lhs.note) $ lhs.at in
        Al.Valid.env := Env.bind_def !Al.Valid.env id ([param], rhs.note, [])
      );

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
  match (remove_or def).it with
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, List.map preprocess_rule rules) $ def.at
  | DecD (id, params, typ, clauses) ->
    DecD (id, params, typ, List.map preprocess_clause clauses) $ def.at
  | RecD defs -> RecD (List.map preprocess_def defs) $ def.at
  | _ -> def

let preprocess: script -> script = List.map preprocess_def
