(*
This transformation replaces SubE expressions with explicit subtype injection
functions.

 1. It traverses all expressions and finds out which type pairs
    occur in SubE expressions
    - all type pairs mentioned in SubE expressions
    - for all variant types: list of constructors
    - for all alias types: right hand side of the alias

 2. It traverses all definitions to collect information about variant types and
    type aliases (assuming only such types occur in type aliases).

 3. It generates explicit injection functions for pairs, and put them in the
 right spot (after both types are defined, but outside `RecD` groups)

 4. It replaces occurrences of SubE with a suitable CallE

Step 1 and 4 are done together, and step 2 and 3

This pass assumes that there is no name shadowing in the type definitions.

*)

open Util
open Source
open Il.Ast
open Il.Walk

(* Errors *)

let error at msg = Error.error at "subtype elimination" msg

(* Environment *)

module M = Map.Make(String)
module S = Set.Make(struct
  type t = id * id
  let compare (t1, t2) (t3, t4) = compare (t1.it, t2.it) (t3.it, t4.it)
end)

(*
The environment consist of:
  * Which constructors the type has (and their non-aliased concrete type)
  * Which SubE type pairs have been observed, but not yet generated
  * Flag that allows the SubE type pairs set to be modified.
*)
type env =
  { mutable typ : (param list * id * arg list * typcase list) M.t;
    mutable pairs : S.t;
    mutable pairs_mutable : bool
  }

let new_env () : env =
  { typ = M.empty;
    pairs = S.empty;
    pairs_mutable = true
  }

let lookup (env : env) (id : id) : param list * id * arg list * typcase list =
  match M.find_opt id.it env.typ with
  | None -> error id.at ("unknown type `" ^ id.it ^ "`")
  | Some t -> t

let arg_of_param param =
  match param.it with
  | ExpP (id, t) -> ExpA (VarE id $$ param.at % t) $ param.at
  | TypP id -> TypA (VarT (id, []) $ param.at) $ param.at
  | DefP (id, _ps, _t) -> DefA id $ param.at
  | GramP (id, _t) -> GramA (VarG (id, []) $ param.at) $ param.at

let register_variant (env : env) (id : id) params (cases : typcase list) =
  if M.mem id.it env.typ then
    error id.at ("duplicate declaration for type `" ^ id.it ^ "`")
  else
    env.typ <- M.add id.it (params, id, List.map arg_of_param params, cases) env.typ

let subst_of_args =
  List.fold_left2 (fun s arg param ->
    match arg.it, param.it with
    | ExpA e, ExpP (id, _) -> Il.Subst.add_varid s id e
    | TypA t, TypP id -> Il.Subst.add_typid s id t
    | DefA x, DefP (id, _, _) -> Il.Subst.add_defid s id x
    | _, _ -> assert false
  ) Il.Subst.empty

let register_alias (env : env) (id : id) params (id2 : id) args =
  match M.find_opt id2.it env.typ with
  | Some (params2, id3, args2, cases) ->
    let s = subst_of_args args params2 in
    let args' = Il.Subst.(subst_list subst_arg s args2) in
    let cases' = Il.Subst.(subst_list subst_typcase s cases) in
    env.typ <- M.add id.it (params, id3, args', cases') env.typ
  | None -> () (* Not an alias of a variant type *)

let injection_name (sub : id) (sup : id) = sup.it ^ "_" ^ sub.it $ no_region

(* Step 1 and 4: Collect SubE occurrences, and replace with function *)

(* The main transformation case *)
let rec t_exp env exp =
  match exp.it with
  | SubE (e, sub_ty, sup_ty) ->
(
(* Printf.eprintf "[sub @ %s] %s  <:  %s\n%!" (string_of_region exp'.at) (Il.Print.string_of_typ sub_ty) (Il.Print.string_of_typ sup_ty); *)
    begin match sub_ty.it, sup_ty.it with
    | VarT (sub, args_sub), VarT (sup, args_sup) ->
      if env.pairs_mutable then
        env.pairs <- S.add (sub, sup) env.pairs;
      { exp with it = CallE (injection_name sub sup, args_sub @ args_sup @ [ExpA (t_exp env e) $ e.at])}
    | NumT _, NumT _ -> exp
    | TupT ts, TupT ts' when List.length ts = List.length ts' ->
      TupE (List.mapi (fun idx ((_, t), (_, t')) ->
        let proj_exp = ProjE (e, idx) $$ e.at % t in
        if Il.Eq.eq_typ t t' then proj_exp else
        t_exp env (SubE (proj_exp, t, t') $$ exp.at % t')
      ) (List.combine ts ts')) $$ exp.at % sup_ty
    | _, _ ->
(* Printf.eprintf "[sub @ %s REMAINS] %s  <:  %s\n%!" (string_of_region exp'.at) (Il.Print.string_of_typ sub_ty) (Il.Print.string_of_typ sup_ty); *)
      error sub_ty.at ("Non-variable or number type expression not supported `" ^ Il.Print.string_of_typ sub_ty ^ "`")
    end
)
  | _ -> exp

(* Step 2 and 3: Traverse definitions, collect type information, insert as soon as possible *)

let rec add_type_info env (def : def) = match def.it with
  | RecD defs -> List.iter (add_type_info env) defs
  | TypD (id, params, [inst]) ->  (* TODO: handle type families *)
    let InstD (_, _, deftyp) = inst.it in
    begin match deftyp.it with
    | VariantT cases -> register_variant env id params cases
    | AliasT {it = VarT (id2, args); _} -> register_alias env id params id2 args
    | _ -> ()
    end
  | _ ->()

let is_ready env (t1, t2) = M.mem t1.it env.typ && M.mem t2.it env.typ

(* Returns type pairs that are defined now, and removes them from the env *)
let ready_pairs (env : env) =
  let (ready, todo) = S.partition (is_ready env) env.pairs in
  env.pairs <- todo;
  S.elements ready

(* Rename parameters to avoid name clashes *)
let rec rename_params s = function
  | [] -> []
  | { it = ExpP (id, t); at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    let t' = Il.Subst.subst_typ s t in
    (ExpP (id', t') $ at) ::
      rename_params (Il.Subst.add_varid s id (VarE id' $$ id.at % t')) params
  | { it = TypP id; at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    (TypP id' $ at) ::
      rename_params (Il.Subst.add_typid s id (VarT (id', []) $ id.at)) params
  | { it = DefP (id, ps, t); at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    (DefP (id', ps, t) $ at) ::
      rename_params (Il.Subst.add_defid s id id') params
  | { it = GramP (id, t); at; _ } :: params ->
    let id' = (id.it ^ "_2") $ id.at in
    (GramP (id', t) $ at) ::
      rename_params (Il.Subst.add_gramid s id (VarG (id', []) $ id.at)) params

let lookup_arg_typ typcases m = 
  List.find_map (fun (m', (_, arg_typ, _), _) -> if Il.Eq.eq_mixop m m' then Some arg_typ else None) typcases

let insert_injections env (def : def) : def list =
  add_type_info env def;
  let pairs = ready_pairs env in
  [ def ] @
  List.map (fun (sub, sup) ->
    let name = injection_name sub sup in
    let (params_sub, real_id_sub, args_sub, cases_sub) = lookup env sub in
    let (params_sup, _, _, cases_sub2) = lookup env sup in
    let params_sup' = rename_params Il.Subst.empty params_sup in
    let sub_ty = VarT (sub, List.map arg_of_param params_sub) $ no_region in
    let sup_ty = VarT (sup, List.map arg_of_param params_sup') $ no_region in
    let real_ty = VarT (real_id_sub, args_sub) $ no_region in
    let clauses = List.map (fun (m, (_binds, arg_typ, _prems), _hints) ->
      let arg_typ2 = lookup_arg_typ cases_sub2 m in
      match arg_typ.it, arg_typ2 with
      | TupT ts, Some {it = TupT ts'; _} ->
        let binds = List.mapi (fun i (_, arg_typ_i) -> ExpB ("x" ^ string_of_int i $ no_region, arg_typ_i) $ no_region) ts in
        let xes is_lhs = List.map2 (fun bind (_, arg_typ_i2) ->
          match bind.it with
          | ExpB (x, arg_typ_i) -> 
            let base_exp = VarE x $$ no_region % arg_typ_i in
            if is_lhs || Il.Eq.eq_typ arg_typ_i arg_typ_i2
            then base_exp
            else SubE (base_exp, arg_typ_i, arg_typ_i2) $$ no_region % arg_typ_i2
          | TypB _ | DefB _ | GramB _ -> assert false) binds ts'
        in
        let xe is_lhs = TupE (xes is_lhs) $$ no_region % arg_typ in
        DefD (binds,
          [ExpA (CaseE (m, xe true) $$ no_region % real_ty) $ no_region],
          t_exp env (CaseE (m, xe false) $$ no_region % sup_ty), []) $ no_region
      | _ ->
        let x = "x" $ no_region in
        let xe = VarE x $$ no_region % arg_typ in
        DefD ([ExpB (x, arg_typ) $ x.at],
          [ExpA (CaseE (m, xe) $$ no_region % real_ty) $ no_region],
          CaseE (m, xe) $$ no_region % sup_ty, []) $ no_region
      ) cases_sub in
    DecD (name, params_sub @ params_sup' @ [ExpP ("_" $ no_region, sub_ty) $ no_region], sup_ty, clauses) $ no_region
  ) pairs


let transform (defs : script) =
  let env = new_env () in
  let transformer = { base_transformer with transform_exp = t_exp env } in
  let defs' = List.map (transform_def transformer) defs in
  env.pairs_mutable <- false;
  let defs'' =  List.concat_map (insert_injections env) defs' in
  S.iter (fun (sub, sup) -> error sup.at ("left-over subtype coercion `" ^ sub.it ^ "` <: `" ^ sup.it ^ "`")) env.pairs;
  defs''  
