(* 
  This pass simply ensures that there is no ambiguity between any names.
*)

open Il.Ast
open Il
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

let transform_var_id env id = transform_id' env VAR id.it $ id.at
let transform_fun_id env id = transform_id' env FUNCDEF id.it $ id.at
let transform_user_def_id env id = transform_id' env USERDEF id.it $ id.at
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
  | Atom s -> Atom (transform_user_def_id env (s $ a.at)).it $$ a.at % a.note
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

let rec transform_iter env i =
  match i with 
  | ListN (exp, id_opt) -> ListN (transform_exp env exp, id_opt)
  | _ -> i

and transform_typ env t = 
  (match t.it with
  | VarT (id, []) when not (Env.mem_typ env.il_env id) -> 
    (* Type parameter - treat it as such *)
    VarT (transform_var_id env id, [])
  | VarT (id, args) -> VarT (transform_user_def_id env id, List.map (transform_arg env) args)
  | TupT exp_typ_pairs -> TupT (List.map (fun (e, t) -> (transform_exp env e, transform_typ env t)) exp_typ_pairs)
  | IterT (typ, iter) -> IterT (transform_typ env typ, transform_iter env iter)
  | typ -> typ
  ) $ t.at

and transform_exp env e = 
  let t_func = transform_exp env in
  (match e.it with
  (* Improve naming of variables and functions and type constructors *)
  | VarE id -> VarE (transform_var_id env id)
  | CallE (id, args) -> CallE (transform_fun_id env id, List.map (transform_arg env) args)

  | CaseE (m, e1) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    CaseE(transform_mixop env id m, t_func e1)

  | StrE fields -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    StrE (List.map (fun (a, e1) -> (transform_atom env id a, t_func e1)) fields)

  | UncaseE (e1, m) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e.note) in
    UncaseE (t_func e1, transform_mixop env id m )
  
  | DotE (e1, a) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env e1.note) in
    DotE (t_func e1, transform_atom env id a)
  
  (* Special case for iteration naming - just use the variable it is iterating on *)
  | IterE (e, ((_, [(_, {it = VarE id''; _})]) as iterexp)) when check_iteration_naming e iterexp -> 
    VarE (transform_var_id env id'')
  
  (* Boilerplate Traversal *)
  | UnE (unop, optyp, e1) -> UnE (unop, optyp, t_func e1)
  | BinE (binop, optyp, e1, e2) -> BinE (binop, optyp, t_func e1, t_func e2)
  | CmpE (cmpop, optyp, e1, e2) -> CmpE (cmpop, optyp, t_func e1, t_func e2)
  | TupE (exps) -> TupE (List.map t_func exps)
  | ProjE (e1, n) -> ProjE (t_func e1, n)
  | OptE e1 -> OptE (Option.map t_func e1)
  | TheE e1 -> TheE (t_func e1)
  | CompE (e1, e2) -> CompE (t_func e1, t_func e2)
  | ListE entries -> ListE (List.map t_func entries)
  | LiftE e1 -> LiftE (t_func e1)
  | MemE (e1, e2) -> MemE (t_func e1, t_func e2)
  | LenE e1 -> LenE (t_func e1)
  | CatE (e1, e2) -> CatE (t_func e1, t_func e2)
  | IdxE (e1, e2) -> IdxE (t_func e1, t_func e2)
  | SliceE (e1, e2, e3) -> SliceE (t_func e1, t_func e2, t_func e3)
  | UpdE (e1, p, e2) -> UpdE (t_func e1, transform_path env p, t_func e2)
  | ExtE (e1, p, e2) -> ExtE (t_func e1, transform_path env p, t_func e2)
  | IterE (e1, (iter, id_exp_pairs)) -> IterE (t_func e1, (transform_iter env iter, List.map (fun (id', exp) -> (transform_var_id env id', t_func exp)) id_exp_pairs))
  | CvtE (e1, nt1, nt2) -> CvtE (t_func e1, nt1, nt2)
  | SubE (e1, t1, t2) -> SubE (t_func e1, transform_typ env t1, transform_typ env t2)
  | IfE (b, e1, e2) -> IfE (t_func b, t_func e1, t_func e2)
  | exp -> exp
  ) $$ e.at % (transform_typ env e.note)

and transform_path env path = 
  (match path.it with
  | RootP -> RootP
  | IdxP (p, e) -> IdxP (transform_path env p, transform_exp env e)
  | SliceP (p, e1, e2) -> SliceP (transform_path env p, transform_exp env e1, transform_exp env e2)
  | DotP (p, a) -> 
    let id = Print.string_of_typ_name (Eval.reduce_typ env.il_env p.note) in
    DotP (transform_path env p, transform_atom env id a)
  ) $$ path.at % (transform_typ env path.note)

and transform_sym env s = 
  (match s.it with
  | VarG (id, args) -> VarG (id, List.map (transform_arg env) args)
  | SeqG syms -> SeqG (List.map (transform_sym env) syms)
  | AltG syms -> AltG (List.map (transform_sym env) syms)
  | RangeG (syml, symu) -> RangeG (transform_sym env syml, transform_sym env symu)
  | IterG (sym, (iter, id_exp_pairs)) -> IterG (transform_sym env sym, (transform_iter env iter, 
      List.map (fun (id, exp) -> (transform_var_id env id, transform_exp env exp)) id_exp_pairs)
    )
  | AttrG (e, sym) -> AttrG (transform_exp env e, transform_sym env sym)
  | sym -> sym 
  ) $ s.at 

and transform_arg env a =
  (match a.it with
  | ExpA exp -> ExpA (transform_exp env exp)
  | TypA typ -> TypA (transform_typ env typ)
  | DefA id -> DefA (transform_fun_id env id)
  | GramA sym -> GramA (transform_sym env sym)
  ) $ a.at

and transform_bind env b =
  (match b.it with
  | ExpB (id, typ) -> ExpB (transform_var_id env id, transform_typ env typ)
  | TypB id -> TypB (transform_var_id env id)
  | DefB (id, params, typ) -> DefB (transform_fun_id env id, List.map (transform_param env) params, transform_typ env typ)
  | GramB (id, params, typ) -> GramB (id, List.map (transform_param env) params, transform_typ env typ)
  ) $ b.at 
  
and transform_param env p =
  (match p.it with
  | ExpP (id, typ) -> ExpP (transform_var_id env id, transform_typ env typ)
  | TypP id -> TypP (transform_var_id env id)
  | DefP (id, params, typ) -> DefP (id, List.map (transform_param env) params, transform_typ env typ)
  | GramP (id, typ) -> GramP (id, transform_typ env typ)
  ) $ p.at 

let rec transform_prem env prem = 
  (match prem.it with
  | RulePr (id, m, e) -> RulePr (transform_user_def_id env id, m, transform_exp env e)
  | IfPr e -> IfPr (transform_exp env e)
  | LetPr (e1, e2, ids) -> LetPr (transform_exp env e1, transform_exp env e2, ids)
  | ElsePr -> ElsePr
  | IterPr (prem1, (iter, id_exp_pairs)) -> IterPr (transform_prem env prem1, 
      (transform_iter env iter, List.map (fun (id, exp) -> (transform_var_id env id, transform_exp env exp)) id_exp_pairs)
    )
  | NegPr p -> NegPr (transform_prem env p)
  ) $ prem.at

let transform_inst env id inst = 
  (match inst.it with
  | InstD (binds, args, deftyp) -> InstD (List.map (transform_bind env) binds, List.map (transform_arg env) args, 
    (match deftyp.it with 
    | AliasT typ -> AliasT (transform_typ env typ)
    | StructT typfields -> StructT (List.map (fun (a, (c_binds, typ, prems), hints) ->
        (transform_atom env id.it a, 
        (List.map (transform_bind env) c_binds, transform_typ env typ, List.map (transform_prem env) prems), hints)  
      ) typfields)
    | VariantT typcases -> 
      VariantT (List.map (fun (m, (c_binds, typ, prems), hints) -> 
        (transform_mixop env id.it m, 
        (List.map (transform_bind env) c_binds, transform_typ env typ, List.map (transform_prem env) prems), hints)  
      ) typcases)
    ) $ deftyp.at
  )
  ) $ inst.at

let transform_rule env rel_id rule = 
  (match rule.it with
  | RuleD (id, binds, m, exp, prems) -> 
    RuleD (transform_rule_id env id rel_id $ id.at, 
    List.map (transform_bind env) binds, 
    m, 
    transform_exp env exp, 
    List.map (transform_prem env) prems
  )
  ) $ rule.at

let transform_clause env clause =
  (match clause.it with 
  | DefD (binds, args, exp, prems) -> DefD (List.map (transform_bind env) binds, 
    List.map (transform_arg env) args,
    transform_exp env exp, 
    List.map (transform_prem env) prems
  )
  ) $ clause.at

let transform_prod env prod = 
  (match prod.it with 
  | ProdD (binds, sym, exp, prems) -> ProdD (List.map (transform_bind env) binds,
    transform_sym env sym,
    transform_exp env exp,
    List.map (transform_prem env) prems
  )
  ) $ prod.at

let rec transform_def env def = 
  (match def.it with
  | TypD (id, params, insts) -> 
    TypD (transform_user_def_id env id, 
    List.map (transform_param env) params |> Utils.improve_ids_params, 
    List.map (transform_inst env id) insts)
  | RelD (id, m, typ, rules) -> 
    RelD (transform_user_def_id env id, m, transform_typ env typ, List.map (transform_rule env id) rules)
  | DecD (id, params, typ, clauses) -> 
    DecD (transform_fun_id env id, 
    List.map (transform_param env) params |> Utils.improve_ids_params, 
    transform_typ env typ, 
    List.map (transform_clause env) clauses)
  | GramD (id, params, typ, prods) -> 
    GramD (id, 
    List.map (transform_param env) params |> Utils.improve_ids_params, 
    transform_typ env typ, 
    List.map (transform_prod env) prods)
  | RecD defs -> RecD (List.map (transform_def env) defs)
  | HintD hintdef -> HintD hintdef
  ) $ def.at

let create_env il = {
  atom_str_set = StringSet.empty;
  il_env = Env.env_of_script il
}

let transform (il : script): script =
  let env = create_env il in 
  List.map (transform_def env) il