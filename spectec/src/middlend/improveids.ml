(* 
  This pass simply ensures that there is no ambiguity between any names.
*)

open Il.Ast
open Il
open Il.Walk
open Util.Source
(* open Util *)
open Xl.Atom

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)

type env = {
  mutable atom_str_set : StringSet.t;
  il_env : Il.Env.t;
}

let make_prefix = "mk_"
let var_prefix = "v_"
let fun_prefix = "fun_"
let res_prefix = "r_"

type id_type = 
  | VAR         (* Variables *)
  | USERDEF     (* Types, type constructors and relations *)
  | FUNCDEF     (* function definitions *)

let empty_info: region * Xl.Atom.info = (no_region, {def = ""; case = ""})

(* Id transformation *)
let rec transform_id' (env : env) (id_type : id_type) (s : text) = 
  let t_func = transform_id' env id_type in 
  let change_id s' = 
    String.map (function
     | '.' -> '_'
     | '-' -> '_'
     | c -> c
    ) s'
    (* This suffixes any '*' with '_lst' and '?' with '_opt' for clarity *)
    |> Str.global_replace (Str.regexp {|\(*\)|}) "_lst"
    |> Util.Lib.String.replace "?" "_opt"
  in
  let s' = change_id s in
  match id_type with
  (* Leave naming hole as is *)
  | _ when s' = "_" -> s' 
  | VAR when Il.Env.mem_typ env.il_env (s' $ no_region) 
    || Il.Env.mem_rel env.il_env (s' $ no_region) 
    || Il.Env.mem_def env.il_env (s' $ no_region) 
    || StringSet.mem s' env.atom_str_set -> t_func (var_prefix ^ s')
  | FUNCDEF when Il.Env.mem_typ env.il_env (s' $ no_region) 
    || Il.Env.mem_rel env.il_env (s' $ no_region) 
    || StringSet.mem s' env.atom_str_set -> t_func (fun_prefix ^ s')
  (* Checking whether an id is an int - if so, put a reserved prefix *)
  | _ when Option.is_some (int_of_string_opt s') -> t_func (res_prefix ^ s')
  | _ -> s'

let t_var_id env id = transform_id' env VAR id.it $ id.at
let t_def_id env id = transform_id' env FUNCDEF id.it $ id.at
let t_user_def_id env id = transform_id' env USERDEF id.it $ id.at
let transform_rule_id env rule_id rel_id = 
  match rule_id.it with
  | "" -> make_prefix ^ rel_id.it
  | _ -> transform_id' env USERDEF rule_id.it

let is_atomid a = 
  match a.it with
  | Atom _ -> true
  | _ -> false

let has_atom_hole m =
  match m with
  | [{it = Atom "_"; _}] -> true
  | _ -> false

(* Atom functions *)
let transform_atom env typ_id a = 
  match a.it with
  | Atom s -> Atom (t_user_def_id env (s $ a.at)).it $$ a.at % a.note
  | _ -> Atom (make_prefix ^ typ_id) $$ a.at % a.note

let transform_mixop env typ_id (m : mixop) = 
  let m' = List.map (fun inner_m -> List.filter is_atomid inner_m) m in
  let len = List.length m' in 
  match m' with
  | _ when List.for_all (fun l -> l = [] || has_atom_hole l) m' -> [(Atom (make_prefix ^ typ_id) $$ empty_info)] :: List.init (len - 1) (fun _ -> [])
  | _ -> List.map (List.map (transform_atom env typ_id)) m'

let rec check_iteration_naming e iterexp = 
  match e.it, iterexp with
  | VarE id, (_, [(id', _)]) -> Eq.eq_id id id'
  | IterE (e, ((_, [(_, {it = VarE id; _})]) as i)), (_, [(id', _)]) -> 
    Eq.eq_id id id' && check_iteration_naming e i
  | _ -> false 

and t_typ env t = 
  (match t.it with
  | VarT (id, []) when not (Env.mem_typ env.il_env id) -> 
    (* Type parameter - treat it as such *)
    VarT (t_var_id env id, [])
  | typ -> typ
  ) $ t.at

and t_exp env e = 
  (match e.it with
  | CaseE (m, e1) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    CaseE(transform_mixop env id m, e1)
  | StrE fields -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    StrE (List.map (fun (a, e1) -> (transform_atom env id a, e1)) fields)
  | UncaseE (e1, m) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    UncaseE (e1, transform_mixop env id m)
  | DotE (e1, a) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e1.note) in
    DotE (e1, transform_atom env id a)
  (* Special case for iteration naming - just use the variable it is iterating on *)
  | IterE (e, ((_, [(_, {it = VarE id''; _})]) as iterexp)) when check_iteration_naming e iterexp -> 
    VarE (t_var_id env id'')
  | exp -> exp
  ) $$ e.at % e.note

and t_path env path = 
  (match path.it with
  | DotP (p, a) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env p.note) in
    DotP (p, transform_atom env id a)
  | p -> p
  ) $$ path.at % path.note

let t_inst tf env id inst = 
  (match inst.it with
  | InstD (binds, args, deftyp) -> InstD (List.map (transform_bind tf) binds, List.map (transform_arg tf) args, 
    (match deftyp.it with 
    | AliasT typ -> AliasT (transform_typ tf typ)
    | StructT typfields -> StructT (List.map (fun (a, (c_binds, typ, prems), hints) ->
        (transform_atom env id.it a, 
        (List.map (transform_bind tf) c_binds, transform_typ tf typ, List.map (transform_prem tf) prems), hints)  
      ) typfields)
    | VariantT typcases -> 
      VariantT (List.map (fun (m, (c_binds, typ, prems), hints) -> 
        (transform_mixop env id.it m, 
        (List.map (transform_bind tf) c_binds, transform_typ tf typ, List.map (transform_prem tf) prems), hints)  
      ) typcases)
    ) $ deftyp.at
  )
  ) $ inst.at

let transform_rule tf env rel_id rule = 
  (match rule.it with
  | RuleD (id, binds, m, exp, prems) -> 
    RuleD (transform_rule_id env id rel_id $ id.at, 
    List.map (transform_bind tf) binds, 
    m, 
    transform_exp tf exp, 
    List.map (transform_prem tf) prems
  )
  ) $ rule.at

let rec t_def env def = 
  let tf = { base_transformer with 
    transform_exp = t_exp env;
    transform_typ = t_typ env;
    transform_path = t_path env; 
    transform_var_id = t_var_id env;
    transform_typ_id = t_user_def_id env;
    transform_rel_id = t_user_def_id env;
    transform_def_id = t_def_id env;
  } in
  (match def.it with
  | TypD (id, params, insts) -> 
    TypD (t_user_def_id env id, 
    List.map (transform_param tf) params |> Utils.improve_ids_params, 
    List.map (t_inst tf env id) insts)
  | RelD (id, m, typ, rules) -> 
    RelD (t_user_def_id env id, m, transform_typ tf typ, List.map (transform_rule tf env id) rules)
  | DecD (id, params, typ, clauses) -> 
    DecD (t_def_id env id, 
    List.map (transform_param tf) params |> Utils.improve_ids_params, 
    transform_typ tf typ, 
    List.map (transform_clause tf) clauses)
  | GramD (id, params, typ, prods) -> 
    GramD (id, 
    List.map (transform_param tf) params |> Utils.improve_ids_params, 
    transform_typ tf typ, 
    List.map (transform_prod tf) prods)
  | RecD defs -> RecD (List.map (t_def env) defs)
  | HintD hintdef -> HintD hintdef
  ) $ def.at

let create_env il = {
  atom_str_set = StringSet.empty;
  il_env = Env.env_of_script il
}

let transform (il : script): script =
  let env = create_env il in 
  List.map (t_def env) il