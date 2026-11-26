open Util
open Source
open Il.Ast
open Il.Walk
open Il

(* Errors *)

let error at msg = Error.error at "totality" msg

(* Environment *)

module S = Set.Make(String)

type env =
  { mutable partial_funs : S.t;
  }

let new_env () : env =
  { partial_funs = S.empty;
  }

let is_partial (env : env) (id : id) = S.mem id.it env.partial_funs

let register_partial (env : env) (id :id) =
  env.partial_funs <- S.add id.it env.partial_funs

(* Transformation *)

(* The main transformation case *)
let t_exp env exp =
  match exp.it with
  | CallE (f, _) when is_partial env f ->
    {exp with it = TheE {exp with note = IterT (exp.note, Opt) $ exp.at}}
  | _ -> exp

let has_partial_call env exp = 
  match exp.it with
  | TheE ({ it = CallE (f, _); _}) when is_partial env f -> (true, false)
  | _ -> (false, true)


(* An expression exp is well formed if:
  - For all sub expressions exp' of exp, 
    - exp' is not a partial function call or 
    - exp' is a partial function call and there does not exist a 
      sub expression exp'' of exp' that is a partial function call.
*)
let wf_exp env exp = 
  let exists_checker = { exists_base_checker with collect_exp = has_partial_call env } in
  match exp.it with
  | TheE ({ it = CallE (f, _); _} as exp') when is_partial env f && collect_exp exists_checker exp' ->
    (false, false)
  | _ -> (true, true)

let fix_exp env eps exp =
  match exp.it with
  | TheE ({ it = CallE (f, _); _} as exp') when is_partial env f ->
    let id = (Fresh.fresh_varid "iter_val") $ exp'.at  in 
    eps := (id, exp') :: !eps;
    { exp with it = VarE id }
  | _ -> exp

let fix_partial_funcs env exp = 
  let forall_checker = { forall_base_checker with collect_exp = wf_exp env } in
  let is_wf = collect_exp forall_checker exp in
  match exp.it with
  (* If there is a call in the root of the RHS then just return that *)
  | TheE ({ it = CallE (f, _); _} as exp') when is_partial env f && is_wf ->
    exp'
  | _ when is_wf ->
    (* Apply transformation to wrap an option iteration on the rhs *)
    let eps_ref = ref [] in 
    let t = { base_transformer with transform_exp = fix_exp env eps_ref } in
    let t_e = transform_exp t exp in 
    let free_vars = Free.free_exp t_e in 
    let eps' = List.filter (fun (id, _) -> Free.Set.mem id.it free_vars.varid) !eps_ref in
    if eps' = [] then 
      { exp with it = OptE (Some exp); note = IterT (exp.note, Opt) $ exp.at } 
    else 
      { exp with it = IterE (t_e, (Opt, eps')); note = IterT (exp.note, Opt) $ exp.at }  
  | _ -> error exp.at "Partial function call chains are not supported."

let has_catch_all clauses = 
  List.exists (fun clause ->
    let DefD (_, args, _, prems) = clause.it in
    List.for_all (fun a -> 
      match a.it with
      | ExpA {it = VarE _; _} -> true
      | TypA _ | DefA _ -> true
      | _ -> false 
    ) args && List.for_all (fun p -> p.it = ElsePr) prems
  ) clauses

let rec t_def env d = 
  let t = { base_transformer with transform_exp = t_exp env } in
  match d.it with
  | RecD defs -> RecD (List.map (t_def env) defs) $ d.at
  | DecD (id, params, typ, clauses) ->
    let params' = List.map (transform_param t) params in
    let typ' = transform_typ t typ in
    let clauses' = List.map (transform_clause t) clauses in
    if is_partial env id then
      let typ'' = IterT (typ', Opt) $ no_region in
      let clauses'' = List.map (fun clause -> match clause.it with
        DefD (quants, lhs, rhs, prems) ->
          { clause with
            it = DefD (List.map (transform_param t) quants, lhs, fix_partial_funcs env rhs, prems) }
        ) clauses' in
      let params, args = List.mapi (fun i param -> match param.it with
        | ExpP (_, typI) ->
          let x = ("x" ^ string_of_int i) $ no_region in
          [ExpP (x, typI) $ x.at], ExpA (VarE x $$ no_region % typI) $ no_region
        | TypP id -> [TypP id $ no_region], TypA (VarT (id, []) $ no_region) $ no_region
        | DefP (id, _, _) -> [], DefA id $ no_region
        | GramP (id, _, _) -> [], GramA (VarG (id, []) $ no_region) $ no_region
        ) params' |> List.split in
      let catch_all = DefD (List.concat params, args,
        OptE None $$ no_region % typ'', [ElsePr $ no_region]) $ no_region in
      let last_c = if has_catch_all clauses'' then [] else [catch_all] in
      DecD (id, params', typ'', clauses'' @ last_c) $ d.at
    else
      DecD (id, params', typ', clauses') $ d.at
  | _ -> transform_def t d

let is_partial_hint hint = hint.hintid.it = "partial"

let register_hints env def =
  match def.it with
  | HintD {it = DecH (id, hints); _} when List.exists is_partial_hint hints ->
    register_partial env id
  | _ -> ()

let transform (defs : script) =
  let env = new_env () in
  List.iter (register_hints env) defs;
  List.map (t_def env) defs
