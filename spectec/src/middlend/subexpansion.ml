(* 
  This pass expands the subtyping patterns that appear in the LHS of
  function clauses and type family arguments. 
  
  It achieves this through the following steps:
    * For each argument, we collect every unique sub expression.
    * Then, for each sub expression, we collect every case that is
    possible in the subtype. If the specific case additionally carries
    values, then we generate binds to add in the function scope. 
    * With all of these cases, for each unique sub expression, we compute
    the cartesian product in order to absolutely grab all the possible cases.
    See $cvtop to see how this might be done.
    * Once we have calculated the product, we generate a subst for each product
    and proceed to generate the clause/type instance.
    * Finally, we filter out binds that appear in the subst.

  For example, take the following types and function:

  syntax A = t1 nat | t2 nat nat
  syntax B = t1 nat | t2 nat nat | t3 | t4 

  def $foo(B) : nat
  def $foo(x : A <: B) = 1
  def $foo(t3) = 2
  def $foo(t4) = 3

  Would be transformed as such:

  def $foo(B) : nat
  def $foo{n : nat}(t1(n)) = 1
  def $foo{n1 : nat, n2 : nat}(t2(n1, n2)) = 1
  def $foo(t3) = 2
  def $foo(t4) = 3

*)

open Util
open Source
open Il.Ast
open Il
open Il.Walk

(* Errors *)

let error at msg = Error.error at "sub expression expansion" msg

(* Environment *)

(* Global IL env *)
let env_ref = ref Il.Env.empty

let empty_tuple_exp at = TupE [] $$ at % (TupT [] $ at)

(* Computes the cartesian product of a given list. *)
let product_of_lists (lists : 'a list list) = 
  List.fold_left (fun acc lst ->
    List.concat_map (fun existing -> 
      List.map (fun v -> v :: existing) lst) acc) [[]] lists

let product_of_lists_append (lists : 'a list list) = 
  List.fold_left (fun acc lst ->
    List.concat_map (fun existing -> 
      List.map (fun v -> existing @ [v]) lst) acc) [[]] lists

let get_bind_id b =
  match b.it with
  | ExpB (id, _) | TypB id 
  | DefB (id, _, _) | GramB (id, _, _) -> id.it

let eq_sube (id, t1, t2) (id', t1', t2') =
  Eq.eq_id id id' && Eq.eq_typ t1 t1' && Eq.eq_typ t2 t2'

let collect_sube_exp e = 
  match e.it with
  (* Assumption - nested sub expressions do not exist. Must also be a varE. *)
  | SubE ({it = VarE id; _}, t1, t2) -> ([id, t1, t2], false)
  | _ -> ([], true)

let check_matching c_args match_args = 
  Option.is_some (try 
    Eval.match_list Eval.match_arg !env_ref Subst.empty c_args match_args 
    with Eval.Irred -> None)

let get_case_typ t = 
  match t.it with
  | TupT typs -> typs
  | _ -> [VarE ("_" $ t.at) $$ t.at % t, t]

let collect_all_instances case_typ ids at inst =
  match inst.it with
  | InstD (_, _, {it = VariantT typcases; _}) when 
    List.for_all (fun (_, (_, t, _), _) -> t.it = TupT []) typcases  -> 
    List.map (fun (m, _, _) -> ([], CaseE (m, empty_tuple_exp no_region) $$ at % case_typ)) typcases
  | InstD (_, _, {it = VariantT typcases; _}) -> 
    let _, new_cases = 
      List.fold_left (fun (ids', acc) (m, (_, t, _), _) ->
        let typs = get_case_typ t in
        let new_binds, typs' = Utils.improve_ids_binders ids' true t.at typs in
        let exps = List.map fst typs' in 
        let tup_exp = TupE exps $$ at % t in
        let case_exp = CaseE (m, tup_exp) $$ at % case_typ in
        let new_ids = List.map get_bind_id new_binds in 
        (new_ids @ ids', (new_binds, case_exp) :: acc)  
      ) (ids, []) typcases
    in
    new_cases
  | _ -> error at "Expected a variant type"

let rec collect_all_instances_typ ids at typ =
  match typ.it with
  | VarT (var_id, dep_args) -> let (_, insts) = Il.Env.find_typ !env_ref var_id in 
    (match insts with
    | [] -> [] (* Should never happen *)
    | _ -> 
      let inst_opt = List.find_opt (fun inst -> 
        match inst.it with 
        | InstD (_, args, _) -> check_matching dep_args args
      ) insts in
      match inst_opt with
      | None -> error at ("Could not find specific instance for typ: " ^ Il.Print.string_of_typ typ)
      | Some inst -> collect_all_instances typ ids at inst
    )
  | TupT exp_typ_pairs -> 
    let instances_list = List.map (fun (_, t) -> 
      collect_all_instances_typ ids at t
    ) exp_typ_pairs in
    let product = product_of_lists_append instances_list in
    List.map (fun lst -> 
      let binds, exps = List.split lst in 
      List.concat binds, TupE exps $$ at % typ) product
  | _ -> []

let generate_subst_list lhs binds =
  let base_sube_collector : (id * typ * typ) list collector = base_collector [] (@) in
  let collector = { base_sube_collector with collect_exp = collect_sube_exp } in
  (* Collect all unique sub expressions for each argument *)
  let subs = List.concat_map (fun a -> 
    Lib.List.nub eq_sube (collect_arg collector a)
  ) lhs in
  let ids = List.map get_bind_id binds in

  (* Collect all cases for the specific subtype, generating any potential binds in the process *)
  let _, cases = 
    List.fold_left (fun (binds, cases) (id, t1, _) -> 
      let ids' = List.map get_bind_id binds @ ids in
      let instances = collect_all_instances_typ ids' id.at t1 in 
      let new_binds = List.concat_map fst instances in
      let cases'' = List.map (fun case_data -> (id, case_data)) instances in
      (new_binds @ binds, cases'' :: cases)
    ) (binds, []) subs 
  in

  (* Compute cartesian product for all cases and generate a subst *)
  let cases' = product_of_lists cases in
  List.map (List.fold_left (fun (binds, subst) (id, (binds', exp)) -> 
    (binds' @ binds, Il.Subst.add_varid subst id exp)) ([], Il.Subst.empty)
  ) cases' 

let t_clause clause =
  match clause.it with 
  | DefD (binds, lhs, rhs, prems) ->
    let subst_list = generate_subst_list lhs binds in
    List.map (fun (binds', subst) -> 
      (* Subst all occurrences of the subE id *)
      let new_lhs = Il.Subst.subst_args subst lhs in
      let new_prems = Il.Subst.subst_list Il.Subst.subst_prem subst prems in
      let new_rhs = Il.Subst.subst_exp subst rhs in

      (* Filtering binds - only the subst ids *)
      let binds_filtered = Lib.List.filter_not (fun b -> match b.it with
        | ExpB (id, _) -> Il.Subst.mem_varid subst id
        | _ -> false
      ) (binds' @ binds) in 
      let new_binds, _ = Il.Subst.subst_binds subst binds_filtered in
      (* Reduction is done here to remove subtyping expressions *)
      DefD (new_binds, List.map (Il.Eval.reduce_arg !env_ref) new_lhs, new_rhs, new_prems) $ clause.at
    ) subst_list

let t_inst inst =
  match inst.it with 
  | InstD (binds, lhs, deftyp) ->
    let subst_list = generate_subst_list lhs binds in
    List.map (fun (binds', subst) -> 
      (* Subst all occurrences of the subE id *)
      let new_lhs = Il.Subst.subst_args subst lhs in
      let new_rhs = Il.Subst.subst_deftyp subst deftyp in

      (* Filtering binds - only the subst ids *)
      let binds_filtered = Lib.List.filter_not (fun b -> match b.it with
        | ExpB (id, _) -> Il.Subst.mem_varid subst id
        | _ -> false
      ) (binds' @ binds) in 

      let new_binds, _ = Il.Subst.subst_binds subst binds_filtered in
      (* Reduction is done here to remove subtyping expressions *)
      InstD (new_binds, List.map (Il.Eval.reduce_arg !env_ref) new_lhs, new_rhs) $ inst.at
    ) subst_list


let rec t_def def = 
  match def.it with
  | RecD defs -> { def with it = RecD (List.map t_def defs) }
  | DecD (id, params, typ, clauses) ->
    { def with it = DecD (id, params, typ, List.concat_map t_clause clauses) }
  | TypD (id, params, insts) ->
    { def with it = TypD (id, params, List.concat_map t_inst insts)}
  | _ -> def

let transform (defs : script) =
  env_ref := Il.Env.env_of_script defs;
  List.map (t_def) defs