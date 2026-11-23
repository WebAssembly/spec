open Util
open Source
open Il.Ast

(* Errors *)

(* let error at msg = Error.error at "if-then-else introduction" msg *)

(* Environment *)

let env_ref = ref Il.Env.empty

let rec typ_has_prems (pred : deftyp -> bool) typ =
  match typ.it with
  | VarT (id, _) ->
    (match Il.Env.find_opt_typ !env_ref id with
    | Some (_, insts) ->
      List.exists (fun inst ->
        let InstD (_, _, deftyp) = inst.it in
        match deftyp.it with
        | AliasT typ' -> typ_has_prems pred typ'
        | _ -> pred deftyp
      ) insts
    | None -> true (* conservative *)
    )
  | _ -> false

let case_has_prems m deftyp =
  match deftyp.it with
  | VariantT typcases ->
    List.exists (fun (m', (_, _, prems), _) ->
      Il.Eq.eq_mixop m m' && prems <> []
    ) typcases
  | _ -> false

let struct_has_prems deftyp =
  match deftyp.it with
  | StructT typfields ->
    List.exists (fun (_, (_, _, prems), _) -> prems <> []) typfields
  | _ -> false

let is_partial_constructor e =
  match e.it with
  | CaseE (m, _, Unchecked) -> typ_has_prems (case_has_prems m) e.note
  | StrE (_, Unchecked) -> typ_has_prems struct_has_prems e.note
  | _ -> false

let prem_has_partial_constructor prem =
  let c = { Il.Walk.exists_base_checker with
    collect_exp = (fun e -> (is_partial_constructor e, true))
  } in
  Il.Walk.collect_prem c prem

let clause_has_partial_constructor clause =
  match clause.it with
  | DefD (_, _, _, prems) -> List.exists prem_has_partial_constructor prems

let clauses_have_same_args c1 c2 =
  match (c1.it, c2.it) with
  | (DefD (quants1, args1, _, _), DefD (quants2, args2, _, _)) ->
    Il.Eq.eq_list Il.Eq.eq_param quants1 quants2 &&
    Il.Eq.eq_list Il.Eq.eq_arg args1 args2
 
let group_clauses_by_same_args clauses =
  let group_helper acc clause =
    match acc with
    | [] -> [[clause]]
    | group :: rest ->
      let representative = List.hd group in
      if clauses_have_same_args representative clause then
        (group @ [clause]) :: rest
      else
        [clause] :: group :: rest
  in
  List.fold_left group_helper [] clauses |> List.rev

let is_else_premise prem =
  match prem.it with
  | ElsePr -> true
  | _ -> false

let has_only_else_premise clause =
  match clause.it with
  | DefD (_, _, _, ([_] as prems)) ->
    List.for_all is_else_premise prems
  | _ -> false

let mk_and : exp -> exp -> exp = fun e1 e2 ->
  BinE (`AndOp, `BoolT, e1, e2) $$ (no_region, BoolT $ no_region)

let rec prem_to_bool_exp (prem : prem) : exp option =
  match prem.it with
    | IfPr exp -> Some exp
    | NegPr prem' ->
        Option.bind (prem_to_bool_exp prem') (fun exp ->
          Some (UnE (`NotOp, `BoolT, exp) $$ (prem.at, BoolT $ no_region)))
    | _ -> None

and prems_to_bool_exp = function
  | [] -> Some (BoolE true $$ (no_region, BoolT $ no_region))
  | [prem] -> prem_to_bool_exp prem
  | prem :: rest ->
    Option.bind (prem_to_bool_exp prem) (fun exp1 ->
      Option.bind (prems_to_bool_exp rest) (fun exp2 ->
        Some (mk_and exp1 exp2)
      )
    )

let clause_prems_to_bool_exp (clause : clause) : exp option =
  match clause.it with
  | DefD (_, _, _, prems) ->
    prems_to_bool_exp prems

let mk_if (cond : exp) (then_exp : exp) (else_exp : exp) : exp =
  IfE (cond, then_exp, else_exp) $$ (no_region, then_exp.note)

let rec t_clause_group_to_expr (clauses : clause list) : exp option =
  match clauses with
  | [] -> None
  | [clause] ->
    if has_only_else_premise clause then
      match clause.it with
      | DefD (_, _, rhs, _) -> Some rhs
    else
      None
  | clause :: rest_clauses ->
    match clause_prems_to_bool_exp clause with
    | None -> None
    | Some cond ->
      match clause.it with
      | DefD (_, _, rhs, _) ->
        match t_clause_group_to_expr rest_clauses with
        | None -> None
        | Some else_exp -> Some (mk_if cond rhs else_exp)

let t_clause_group (clauses : clause list) : clause list =
  if List.exists clause_has_partial_constructor clauses then clauses else
  match t_clause_group_to_expr clauses with
  | None -> clauses
  | Some exp -> 
    let rep = List.hd clauses in
    let DefD (quants, args, _rhs, _prems) = rep.it in
    [{ rep with it = DefD (quants, args, exp, []) }]


let t_clauses clauses =
  List.concat_map t_clause_group (group_clauses_by_same_args clauses)

let rec t_def (def : def) : def = { def with it = t_def' def.it }
and t_def' = function
  | RecD defs ->
      RecD (List.map t_def defs)
  | DecD (id, params, typ, clauses) ->
    DecD (id, params, typ, t_clauses clauses) 
  | def -> def

let transform (defs : script) : script =
  env_ref := Il.Env.env_of_script defs;
  List.map t_def defs
