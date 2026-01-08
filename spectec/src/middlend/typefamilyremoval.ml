(*
This transformation transforms type families into a single variant user-defined
type. 

This is achieved through the following steps:
  * Transform variant and struct instances of the type family into their own
    user-defined type, using the binds as their respective dependent type arguments.
  * Transform the type family itself as a variant type with many as many cases as there
    were instances before, encoding the pattern matching as equality premises. 
  * Projection functions are made for each instance that go from type family to the
    sub type.
  * Implicit conversions going from type family to sub type and vice-versa are made
    explicit through the use of the constructor and projections made before. This is achieved
    by inspecting the expression and generating its "real type", and match that to the type
    given by elaboration.

As an example,
given the following type family:

syntax foo(p)
syntax foo{v : t}(a) = t_alias(a)
syntax foo{v : t}(b) = | case_1 | case_2 | ... | case_n
syntax foo{v : t}(c) = { field_1, field_2, ... , field_n }

where p is a parameter type, a, b and c are arguments that match their respective parameter type,
v is a bind that appears in a, b, and c with type t.

This is transformed into: 

syntax foo_case_2(v : t) = | case_1 | case_2 | ... | case_n
syntax foo_case_3(v : t) = { field_1, field_2, ... , field_n }

syntax foo(p) =
  | foo_make_case_1{v : t, x : t_alias(a)}(v : t, x : t_alias(a))
    -- if a == p
  | foo_make_case_2{v : t, x : foo_case_2(b)}(v : t, x : foo_case_2(b))
    -- if b == p
  | foo_make_case_3{v : t, x : foo_case_3(c)}(v : t, x : foo_case_2(c))
    -- if c == p

an example of the projection function is as follows:

def $proj_foo_case_1(v : t, x : foo(a)) : t_alias(a)?
def $proj_foo_case_1{v : t, x : t_alias(a)}(v, foo_make_case_1(v, x)) = ?(x)
def $proj_foo_case_1{v : t, x : foo(a)}(v, x) = ?()

Names were specifically chosen here for simplicity.
*)

open Il.Ast
open Util.Source
open Util
open Il
open Xl

module StringMap = Map.Make(String)

type family_data = (id * bind list * Subst.t * int * typ * typ)

let error at msg = Error.error at "Type families removal" msg

let projection_hint_id = "tf_projection_func"
let projection_hint = { hintid = projection_hint_id $ no_region; hintexp = El.Ast.SeqE [] $ no_region}

let bind_to_string bind = 
  match bind.it with
  | ExpB (id, _) -> id.it
  | TypB id -> id.it
  | DefB (id, _, _) -> id.it
  | GramB (id, _, _) -> id.it

let make_prefix = "mk_"
let proj_prefix = "proj_"
let var_typ_fam = "var_x"
let iter_var_name = "iter_"
let name_prefix id = id.it ^ "_"

let empty_info: region * Xl.Atom.info = (no_region, {def = ""; case = ""})
let sub_type_name_binds binds = (String.concat "_" (List.map bind_to_string binds))
let constructor_name' id case_num = make_prefix ^ name_prefix id ^ Int.to_string case_num
let _constructor_name id binds = constructor_name' id binds $ id.at 
let constructor_name_mixop id binds case_num: mixop = [[ Xl.Atom.Atom (constructor_name' id case_num) $$ empty_info ]] @ List.init (List.length binds + 1) (fun _ -> [])
let proj_name' id case_num = proj_prefix ^ name_prefix id ^ Int.to_string case_num
let proj_name id case_num = proj_name' id case_num $ id.at

let construct_tuple_typ typ args at = 
  let name = var_typ_fam $ typ.at in  
  let varE = VarE (name) $$ typ.at % typ in
  let extra_case_args = List.map (fun a -> match a.it with 
    | ExpA exp -> (exp, exp.note)
    | _ -> error at "Removal of other arguments is not supported yet"
  ) args in
  TupT (extra_case_args @ [(varE, typ)]) $ typ.at 

let construct_tuple_exp at e t args =
  let tupt = construct_tuple_typ t args at in 
  let extra_tup_exps = List.map (fun a -> match a.it with 
    | ExpA exp -> exp
    | _ -> error at "Removal of other arguments is not supported yet"
  ) args in
  TupE (extra_tup_exps @ [{e with note = t}]) $$ e.at % tupt

(* HACK This is used to distinguish between normal types and type families *)
let check_normal_type_creation (inst : inst) : bool = 
  match inst.it with
  | InstD (_, args, _) -> List.for_all (fun arg -> 
    match arg.it with 
    (* Args in normal types can really only be variable expressions or type params *)
    | ExpA {it = VarE _; _} | TypA _ -> true
    | _ -> false  
    ) args 

let rec reduce_type_aliasing env t =
  match t.it with
  | VarT(id, args) -> 
    (match Env.find_opt_typ env id with 
    | Some (_, [inst]) when check_normal_type_creation inst -> reduce_inst_alias env args inst t
    | _ -> t
    )
  | _ -> t

and reduce_inst_alias env args inst base_typ = 
  match inst.it with
  | InstD (_, args', {it = AliasT typ; _}) ->
    let subst_opt = Eval.match_list Eval.match_arg env Subst.empty args args' in
    (match subst_opt with
    | Some subst -> reduce_type_aliasing env (Subst.subst_typ subst typ)
    | None -> reduce_type_aliasing env typ
    ) 
  | _ -> base_typ

let make_arg_from_param p = 
  (match p.it with
  | ExpP (id, typ) -> ExpA (VarE id $$ id.at % typ)
  | TypP id -> TypA (VarT (id, []) $ id.at)
  | DefP (id, _, _) -> DefA id
  | GramP _ -> assert false
  ) $ p.at

let make_bind_from_param p = 
  (match p.it with
  | ExpP (id, typ) -> ExpB (id, typ)
  | TypP id -> TypB id
  | DefP (id, params, typ) -> DefB (id, params, typ)
  | GramP _ -> assert false
  ) $ p.at

let make_param_from_bind b = 
  (match b.it with
  | ExpB (id, typ) -> ExpP (id, typ)
  | TypB id -> TypP id
  | DefB (id, params, typ) -> DefP (id, params, typ)
  | GramB _ -> assert false
  ) $ b.at

let make_arg_from_bind b = 
  (match b.it with
  | ExpB (id, typ) -> ExpA (VarE id $$ id.at % typ)
  | TypB id -> TypA (VarT (id, []) $ id.at)
  | DefB (id, _, _) -> DefA id
  | GramB (id, _, _) -> GramA (VarG (id, []) $ id.at)
  ) $ b.at

let create_arg_param_subst args params =
  List.fold_left2 (fun s a p -> 
    match a.it, p.it with
    | ExpA e, ExpP (id, _) -> Subst.add_varid s id e
    | TypA t, TypP id -> Subst.add_typid s id t
    | DefA id, DefP (id', _, _) -> Subst.add_defid s id' id
    | GramA sym, GramP (id, _) -> Subst.add_gramid s id sym
    | _ -> s   
  ) Subst.empty args params 

let remove_iter_from_type t = 
  match t.it with
  | IterT (t, _) -> t
  | _ -> t

let make_arg b = 
  (match b.it with
  | ExpB (id, typ) -> ExpA (VarE id $$ id.at % typ) 
  | TypB id -> TypA (VarT (id, []) $ id.at)
  | DefB (id, _, _) -> DefA id 
  | GramB (id, _, _) -> GramA (VarG (id, []) $ id.at)
  ) $ b.at

let check_type_family insts = 
  match insts with
  | [] -> false
  | [inst] when check_normal_type_creation inst -> false
  | _ -> true

let has_one_inst env family_typ =
  match family_typ.it with
  | VarT (id, _) -> (match (Env.find_opt_typ env id) with 
    | Some (_, [_]) -> true  
    | _ -> false 
    )
  | _ -> false

let make_bind_set binds = 
  List.fold_left (fun acc b -> 
    match b.it with 
    | ExpB (id, typ) -> StringMap.add id.it typ acc
    | DefB (id, _, typ) -> StringMap.add id.it typ acc
    | _ -> acc  
  ) StringMap.empty binds

let rec check_type_equality env t t' = 
  let r_t = reduce_type_aliasing env t in 
  let r_t' = reduce_type_aliasing env t' in 
  match r_t.it, r_t'.it with
  | VarT (id, args), VarT (id', args') ->
    let r_args = List.map (Eval.reduce_arg env) args in
    let r_args' = List.map (Eval.reduce_arg env) args' in
    id.it = id'.it && Eq.eq_list Eq.eq_arg r_args r_args' 
  | IterT (typ, iter), IterT (typ', iter') -> 
    Eq.eq_iter iter iter' && check_type_equality env typ typ'
  | TupT ets, TupT ets' -> (List.length ets = List.length ets') && 
    List.for_all2 (fun (e, typ) (e', typ') -> Eq.eq_exp e e' && check_type_equality env typ typ') ets ets'
  | _ -> Eq.eq_typ t t'

let rec get_real_typ_from_exp bind_map env e =  
  match e.it with
  | VarE id -> (match StringMap.find_opt id.it bind_map with
    | Some typ -> typ 
    | None -> e.note
  )
  | CallE (id, args) -> 
    (match (Env.find_opt_def env id) with
    | Some (params, typ, _) -> 
      let subst = create_arg_param_subst args params in 
      let s_typ = Subst.subst_typ subst typ in
      s_typ
    | None -> 
      (match StringMap.find_opt id.it bind_map with
      | Some typ -> typ
      | None -> e.note
      )
    )
  | CaseE (m, _) -> 
    let r_typ = Eval.reduce_typ env e.note in
    let id = (match r_typ.it with
      | VarT (id, _) -> id
      | _ -> 
        (* Will make the lookup fail*)
        "" $ no_region 
      ) in
    (match (Env.find_opt_typ env id) with
      | Some (_, [{it = InstD(_, _, {it = VariantT typcases; _}); _}]) when 
        Option.is_some (List.find_opt (fun (m', _, _) -> Eq.eq_mixop m m') typcases) ->
        r_typ
      | _ -> e.note
    )
  | NumE (`Nat _) -> NumT `NatT $ e.at
  | NumE (`Int _) -> NumT `IntT $ e.at
  | NumE (`Rat _) -> NumT `RatT $ e.at
  | NumE (`Real _) -> NumT `RealT $ e.at
  | UnE (_, `BoolT, _) -> BoolT $ e.at
  | UnE (_, (#Num.typ as t), _) -> NumT t $ e.at
  | BinE (_, `BoolT, _, _) -> BoolT $ e.at 
  | BinE (_, (#Num.typ as t), _, _) -> NumT t $ e.at
  | BoolE _ -> BoolT $ e.at
  | TextE _ -> TextT $ e.at
  | TupE es -> let typs = List.map (get_real_typ_from_exp bind_map env) es in
    let get_tuple_exps t =
      match t.it with
        | TupT typs -> List.map fst typs
        | _ -> assert false
    in
    let expected_exps = get_tuple_exps (reduce_type_aliasing env e.note) in 
    TupT (List.map2 (fun t e -> ({e with note = t}, t)) typs expected_exps) $ e.at
  | ListE (e' :: _) -> 
    let iter = (match e.note.it with 
      | IterT (_, i) -> i
      | _ -> List
    ) in
    let t = get_real_typ_from_exp bind_map env e' in
    IterT (t, iter) $ e.at
  | OptE (Some e) -> let t = get_real_typ_from_exp bind_map env e in
    IterT (t, Opt) $ e.at
  | IterE (e', (iter, _)) ->
    let t = get_real_typ_from_exp bind_map env e' in
    IterT (t, iter) $ e.at  
  | IdxE (e', _) -> 
    let t = get_real_typ_from_exp bind_map env e' in
    remove_iter_from_type t
  | LenE _ -> NumT `NatT $ e.at
  | MemE _ -> BoolT $ e.at
  | SubE (_, _, t) -> t
  | LiftE e1 ->
    let t = get_real_typ_from_exp bind_map env e1 in
    IterT (remove_iter_from_type t, List) $ e.at
  | SliceE (e1, _e2, _e3) -> get_real_typ_from_exp bind_map env e1
  | UpdE (e1, _, _) | ExtE (e1, _, _) -> get_real_typ_from_exp bind_map env e1 
  | CvtE (_, _, nt1) -> NumT nt1 $ e.at
  | TheE e1 -> 
    let t = get_real_typ_from_exp bind_map env e1 in
    remove_iter_from_type t 
  | CatE (e1, _) -> get_real_typ_from_exp bind_map env e1
  | CompE (e1, _) -> get_real_typ_from_exp bind_map env e1
  | StrE _ -> Eval.reduce_typ env e.note
  (* TODO ProjE and UncaseE *)
  | _ -> e.note

let is_family_typ env typ = 
  match typ.it with
  | VarT (id, _) -> 
    (match (Env.find_opt_typ env id) with
      | Some (_, insts) -> check_type_family insts 
      | _ -> false
    )
  | _ -> false
      
let rec get_chain_from_inst id env family_typ args insts = 
  let rec helper insts num = 
    match insts with
    | [] -> []
    | {it = InstD (binds, args', {it = AliasT sub_typ; _}); _}::insts' ->
      (match (Eval.match_list Eval.match_arg env Subst.empty args args') with 
        | exception Eval.Irred -> helper insts' (num + 1)
        | Some subst -> 
          let subst_typ = reduce_type_aliasing env (Il.Subst.subst_typ subst sub_typ) in
          (id, binds, subst, num, family_typ, subst_typ) :: get_type_family_conversion_chain env subst_typ 
        | _ -> helper insts' (num + 1)
      )
    | _ -> [] in
  helper insts 0

and get_type_family_conversion_chain env family_typ = 
  match family_typ.it with
  | VarT (id, args) -> 
    (match (Env.find_opt_typ env id) with
      | Some (_, insts) when check_type_family insts ->
        get_chain_from_inst id env family_typ args insts
      | _ -> []
  )
  | IterT (typ, _) -> get_type_family_conversion_chain env typ
  | _ -> []

let make_projection_family_data env (lst : family_data list) (base_exp : exp) = 
  List.fold_right (fun (id, binds, subst, case_num, family_typ, sub_typ) exp ->
    let proj_id = proj_name id case_num in 
    let new_args = List.map make_arg_from_bind binds |> Subst.subst_list Subst.subst_arg subst in
    let sub_typ' = Subst.subst_typ subst sub_typ in 
    let opt_typ = IterT (sub_typ', Opt) $ sub_typ'.at in
    let calle = CallE (proj_id, new_args @ [(ExpA exp) $ exp.at]) in
    (if has_one_inst env family_typ then calle else TheE (calle $$ exp.at % opt_typ)) $$ exp.at % sub_typ'
  ) lst base_exp  

let make_constructor_family_data (lst : family_data list) (base_exp : exp) = 
  List.fold_left (fun exp (id, binds, subst, case_num, family_typ, sub_typ) ->
    let new_args = List.map make_arg_from_bind binds |> Subst.subst_list Subst.subst_arg subst in
    let tupe = construct_tuple_exp base_exp.at exp sub_typ new_args in
    CaseE (constructor_name_mixop id binds case_num, tupe) $$ id.at % family_typ 
  ) base_exp lst 

let handle_iter_typ base_exp real_typ expected_typ = 
  let rec go real_typ expected_typ num = 
    match real_typ.it, expected_typ.it, num with
    | IterT (t, iter), IterT (t', iter'), _ when Eq.eq_iter iter iter' -> 
      let (iters, e, t1, t2) = go t t' (num + 1) in 
      (iter :: iters, e, t1, t2)
    | _, _, 0 -> 
      ([], base_exp, real_typ, expected_typ)
    | _, _, _ -> 
      let id = iter_var_name ^ Int.to_string 0 $ base_exp.at in 
      ([], VarE id $$ id.at % real_typ, real_typ, expected_typ)
  in
  go real_typ expected_typ 0

let apply_iteration iters (base_exp : exp) converted_exp real_typ =
  let length = List.length iters in
  let rec go iters num = 
    match iters with
    | [] -> (real_typ, converted_exp)
    | iter :: iters' -> 
      let (r_typ, iter_e) = go iters' (num - 1) in
      let old_id = iter_var_name ^ Int.to_string num $ converted_exp.at in
      let new_id = iter_var_name ^ Int.to_string (num - 1) $ converted_exp.at in
      let iter_typ = IterT (r_typ, iter) $ converted_exp.at in 
      let new_exp = if num = length then base_exp else VarE old_id $$ converted_exp.at % iter_typ in
      iter_typ, IterE (iter_e, (iter, [new_id, new_exp])) $$ converted_exp.at % iter_typ 
  in
  snd (go iters length)

let rec simplify_conversions proj_list constructor_list = 
  match proj_list, constructor_list with
  | [], cs -> ([], cs)
  | ps, [] -> (ps, [])
  | (id, _, _, n1, family_typ, sub_typ) :: ps, (id', _, _, n2, family_typ', sub_typ'):: cs when
    Eq.eq_id id id' && 
    Eq.eq_typ family_typ family_typ' &&
    Eq.eq_typ sub_typ sub_typ' && 
    n1 = n2 ->
    simplify_conversions ps cs
  | p :: ps, c :: cs -> 
    let ps', cs' = simplify_conversions ps cs in
    (p :: ps', c :: cs')
  
let apply_conversion env exp real_typ expected_typ = 
  let reduced_r_typ = reduce_type_aliasing env real_typ in
  let reduced_e_typ = reduce_type_aliasing env expected_typ in 
  let (iters, iter_exp, r_typ, e_typ) = handle_iter_typ exp reduced_r_typ reduced_e_typ in 
  if (is_family_typ env r_typ || is_family_typ env e_typ) 
    then (
      let proj_list = get_type_family_conversion_chain env r_typ in
      let constructor_list = get_type_family_conversion_chain env e_typ in
      let p_list, c_list = simplify_conversions (List.rev proj_list) (List.rev constructor_list) in
      let real_exp = { iter_exp with note = r_typ } in
      let real_base_exp = { exp with note = reduced_r_typ } in
      let converted_exp = make_constructor_family_data c_list (make_projection_family_data env p_list real_exp) in
      if iters = [] then converted_exp else
      apply_iteration iters real_base_exp converted_exp r_typ
    )
    else exp

let add_iter_ids_to_map env id_exp_pairs bind_map = 
  List.fold_left (fun acc (id, e') -> 
    let r_typ = 
      get_real_typ_from_exp bind_map env e' |>
      reduce_type_aliasing env |>
      remove_iter_from_type
    in 
    StringMap.add id.it r_typ acc
  ) bind_map id_exp_pairs

let rec transform_iter bind_map env i =
  match i with 
  | ListN (exp, id_opt) -> ListN (transform_exp bind_map env exp, id_opt)
  | _ -> i

and transform_typ bind_map env t = 
  (match t.it with
  | VarT (id, args) -> VarT (id, List.map (transform_arg bind_map env) args)
  | TupT exp_typ_pairs -> TupT (List.map (fun (e, t) -> (transform_exp bind_map env e, transform_typ bind_map env t)) exp_typ_pairs)
  | IterT (typ, iter) -> IterT (transform_typ bind_map env typ, transform_iter bind_map env iter)
  | typ -> typ
  ) $ t.at

and transform_exp bind_map env e =  
  let t_func = transform_exp bind_map env in
  let typ = transform_typ bind_map env e.note in
  let t_e = (match e.it with
  | CaseE (m, e1) -> CaseE (m, t_func e1)
  | CallE (fun_id, fun_args) -> CallE (fun_id, List.map (transform_arg bind_map env) fun_args)
  | UnE (unop, optyp, e1) -> 
    UnE (unop, optyp, t_func e1) 
  | BinE (binop, optyp, e1, e2) ->
    BinE (binop, optyp, t_func e1, t_func e2) 
  | CmpE (cmpop, optyp, e1, e2) -> 
    CmpE (cmpop, optyp, t_func e1, t_func e2) 
  | IterE (e1, (iter, id_exp_pairs)) -> 
    let new_bind_map = add_iter_ids_to_map env id_exp_pairs bind_map in
    let t_e1 = transform_exp new_bind_map env e1 in
    IterE (t_e1, (transform_iter new_bind_map env iter, List.map (fun (id, exp) -> (id, {exp with note = get_real_typ_from_exp bind_map env exp})) id_exp_pairs))
  | TupE (exps) -> TupE (List.map t_func exps)
  | ListE exps -> ListE (List.map t_func exps)
  | ProjE (e1, n) -> ProjE (t_func e1, n) 
  | UncaseE (e1, m) -> UncaseE (t_func { e1 with note = Eval.reduce_typ env e1.note }, m) 
  | OptE e1 -> OptE (Option.map t_func e1) 
  | TheE e1 -> TheE (t_func e1) 
  | StrE fields -> StrE (List.map (fun (a, e1) -> (a, t_func e1)) fields) 
  | DotE (e1, a) -> DotE (t_func e1, a) 
  | CompE (e1, e2) -> CompE (t_func e1, t_func e2) 
  | LiftE e1 -> LiftE (t_func e1) 
  | MemE (e1, e2) -> MemE (t_func e1, t_func e2) 
  | LenE e1 -> LenE e1 
  | CatE (e1, e2) -> CatE (t_func e1, t_func e2) 
  | IdxE (e1, e2) -> IdxE (t_func e1, t_func e2)
  | SliceE (e1, e2, e3) -> SliceE (t_func e1, t_func e2, t_func e3) 
  | IfE (e1, e2, e3) -> IfE (t_func e1, t_func e2, t_func e3) 
  | UpdE (e1, p, e2) -> UpdE (t_func e1, transform_path bind_map env p, t_func e2) 
  | ExtE (e1, p, e2) -> ExtE (t_func e1, transform_path bind_map env p, t_func e2)  
  | CvtE (e1, nt1, nt2) -> CvtE (t_func e1, nt1, nt2) 
  | SubE (e1, t1, t2) -> SubE (t_func e1, transform_typ bind_map env t1, transform_typ bind_map env t2) 
  | exp -> exp 
  ) $$ e.at % typ in
  let real_type = get_real_typ_from_exp bind_map env t_e in
  let expected_type = typ in 
  if (check_type_equality env real_type expected_type) then t_e else apply_conversion env t_e real_type expected_type

and transform_path bind_map env p = 
  (match p.it with
  | RootP -> RootP
  | IdxP (p, e) -> IdxP (transform_path bind_map env p, transform_exp bind_map env e)
  | SliceP (p, e1, e2) -> SliceP (transform_path bind_map env p, transform_exp bind_map env e1, transform_exp bind_map env e2)
  | DotP (p, a) -> DotP (transform_path bind_map env p, a)
  ) $$ p.at % (transform_typ bind_map env p.note)

and transform_sym bind_map env s = 
  (match s.it with
  | VarG (id, args) -> VarG (id, List.map (transform_arg bind_map env) args)
  | SeqG syms | AltG syms -> SeqG (List.map (transform_sym bind_map env) syms)
  | RangeG (syml, symu) -> RangeG (transform_sym bind_map env syml, transform_sym bind_map env symu)
  | IterG (sym, (iter, id_exp_pairs)) -> IterG (transform_sym bind_map env sym, (transform_iter bind_map env iter, 
      List.map (fun (id, exp) -> (id, transform_exp bind_map env exp)) id_exp_pairs)
    )
  | AttrG (e, sym) -> AttrG (transform_exp bind_map env e, transform_sym bind_map env sym)
  | sym -> sym 
  ) $ s.at 

and transform_arg bind_map env a =
  (match a.it with
  | ExpA exp -> ExpA (transform_exp bind_map env exp)
  | TypA typ -> TypA (transform_typ bind_map env typ)
  | DefA id -> DefA id
  | GramA sym -> GramA (transform_sym bind_map env sym)
  ) $ a.at

and transform_bind env b =
  (match b.it with
  | ExpB (id, typ) -> ExpB (id, transform_typ StringMap.empty env typ)
  | TypB id -> TypB id
  | DefB (id, params, typ) -> DefB (id, List.map (transform_param env) params, transform_typ StringMap.empty env typ)
  | GramB (id, params, typ) -> GramB (id, List.map (transform_param env) params, transform_typ StringMap.empty env typ)
  ) $ b.at 
  
and transform_param env p =
  (match p.it with
  | ExpP (id, typ) -> ExpP (id, transform_typ StringMap.empty env typ)
  | TypP id -> TypP id
  | DefP (id, params, typ) -> DefP (id, List.map (transform_param env) params, transform_typ StringMap.empty env typ)
  | GramP (id, typ) -> GramP (id, transform_typ StringMap.empty env typ)
  ) $ p.at 

let rec transform_prem bind_map env prem = 
  (match prem.it with
  | RulePr (id, m, e) -> RulePr (id, m, transform_exp bind_map env e)
  | IfPr e -> IfPr (transform_exp bind_map env e)
  | LetPr (e1, e2, ids) -> LetPr (transform_exp bind_map env e1, transform_exp bind_map env e2, ids)
  | ElsePr -> ElsePr
  | IterPr (prem1, (iter, id_exp_pairs)) -> 
    let new_bind_map = add_iter_ids_to_map env id_exp_pairs bind_map in
    IterPr (transform_prem new_bind_map env prem1, 
      (transform_iter new_bind_map env iter, List.map (fun (id, exp) -> (id, transform_exp new_bind_map env exp)) id_exp_pairs)
    )
  | NegPr prem1 -> NegPr (transform_prem bind_map env prem1)
  ) $ prem.at

let transform_rule env rule = 
  match rule.it with
  | RuleD (id, binds, m, exp, prems) -> 
    let bind_map = make_bind_set binds in 
    RuleD (id, 
    List.map (transform_bind env) binds, 
    m, 
    transform_exp bind_map env exp, 
    List.map (transform_prem bind_map env) prems) $ rule.at

(* Reducing binds as conversion functions actively change the type of variables when matching *)
let reduce_bind env b = 
  match b.it with
  | ExpB (id, typ) -> ExpB (id, Il.Eval.reduce_typ env typ) $ b.at
  | _ -> b

let transform_clause _id params env rt clause =
  match clause.it with 
  | DefD (binds, args, exp, prems) -> 
    let subst = create_arg_param_subst args params in
    let reduced_binds = List.map (reduce_bind env) binds in 
    let bind_map = make_bind_set reduced_binds in
    let t_exp = transform_exp bind_map env exp in
    let real_typ = get_real_typ_from_exp bind_map env t_exp in
    let s_rt = Subst.subst_typ subst rt in 
    let new_exp = if check_type_equality env real_typ s_rt then t_exp else apply_conversion env t_exp real_typ s_rt in 
    DefD ((List.map (transform_bind env) reduced_binds), 
    List.map (transform_arg bind_map env) args, 
    new_exp, 
    List.map (transform_prem bind_map env) prems) $ clause.at

let transform_prod env prod = 
  (match prod.it with 
  | ProdD (binds, sym, exp, prems) -> 
    let bind_map = make_bind_set binds in
    ProdD (List.map (transform_bind env) binds,
    transform_sym bind_map env sym,
    transform_exp bind_map env exp,
    List.map (transform_prem bind_map env) prems
  )
  ) $ prod.at

let transform_deftyp env deftyp = 
  (match deftyp.it with
  | AliasT typ -> AliasT (transform_typ StringMap.empty env typ)
  | StructT typfields -> StructT (List.map (fun (a, (bs, t, prems), hints) -> 
    let bind_map = make_bind_set bs in
    (a, (List.map (transform_bind env) bs, transform_typ bind_map env t, List.map (transform_prem bind_map env) prems), hints)) typfields)
  | VariantT typcases -> VariantT (List.map (fun (m, (bs, t, prems), hints) -> 
    let bind_map = make_bind_set bs in
    (m, (List.map (transform_bind env) bs, transform_typ bind_map env t, List.map (transform_prem bind_map env) prems), hints)) typcases)
  ) $ deftyp.at

let transform_inst env inst =
  match inst.it with 
  | (InstD (binds, args, deftyp)) -> 
    [InstD (List.map (transform_bind env) binds, List.map (transform_arg StringMap.empty env) args, transform_deftyp env deftyp) $ inst.at]
 
(* Creates new TypD's for each StructT and VariantT *)
let create_types id inst = 
  let make_param_from_bind b = 
  (match b.it with 
  | ExpB (id, typ) -> ExpP (id, typ)
  | TypB id -> TypP id
  | DefB (id, params, typ) -> DefP (id, params, typ)
  | GramB (id, _, typ) -> GramP (id, typ)
  ) $ b.at in
  match inst.it with
  | InstD (binds, _, deftyp) -> 
    (match deftyp.it with 
    | AliasT _ -> []
    | StructT _ | VariantT _ ->
      let inst = InstD(binds, List.map make_arg binds, deftyp) $ inst.at in 
      [TypD (id.it ^ sub_type_name_binds binds $ id.at, List.map make_param_from_bind binds, [inst])]
    )

let rec transform_def env def = 
  (match def.it with
  | TypD (id, params, insts) -> 
    let new_insts = List.concat_map (transform_inst env) insts in
    TypD (id, List.map (transform_param env) params, new_insts)
  | RecD defs -> RecD (List.map (transform_def env) defs)
  | RelD (id, m, typ, rules) ->
    RelD (id, m, transform_typ StringMap.empty env typ, List.map (transform_rule env) rules)
  | DecD (id, params, typ, clauses) -> 
    DecD (id, List.map (transform_param env) params, transform_typ StringMap.empty env typ, List.map (transform_clause id params env typ) clauses)
  | GramD (id, params, typ, prods) -> 
    GramD (id, List.map (transform_param env) params, transform_typ StringMap.empty env typ, List.map (transform_prod env) prods)
  | d -> d
  ) $ def.at

let gen_family_projections id has_one_inst case_num inst =
  match inst.it with
  | InstD (binds, args, deftyp) -> 
    match deftyp.it with
    | AliasT typ ->
      let family_typ = VarT(id, args) $ id.at in
      let return_type = if has_one_inst then typ else IterT (typ, Opt) $ id.at in
      let new_param = ExpP (var_typ_fam $ id.at, family_typ) $ id.at in
      let new_bind = ExpB (var_typ_fam $ id.at, typ) $ id.at in
      let var_exp = VarE (var_typ_fam $ id.at) $$ id.at % typ in
      let opt_exp = OptE (Some (var_exp)) $$ id.at % return_type in
      let new_args = List.map make_arg_from_bind binds in
      let new_case = CaseE(constructor_name_mixop id binds case_num, construct_tuple_exp deftyp.at var_exp typ new_args) $$ id.at % family_typ in

      let return_exp = if has_one_inst then var_exp else opt_exp in
      let new_clause = DefD(binds @ [new_bind], new_args @ [ExpA new_case $ id.at], return_exp, []) $ id.at in

      let extra_bind = ExpB (var_typ_fam $ id.at, family_typ) $ id.at in
      let extra_arg = ExpA (VarE (var_typ_fam $ id.at) $$ id.at % family_typ) $ id.at in
      let none_exp = OptE (None) $$ id.at % return_type in  
      let extra_clause = DefD(binds @ [extra_bind], new_args @ [extra_arg], none_exp, []) $ id.at in 
      let clauses = new_clause :: if has_one_inst then [] else [extra_clause] in
      let fun_id = proj_name id case_num in
      fun_id, DecD (fun_id, List.map make_param_from_bind binds @ [new_param], return_type, clauses)
    | _ -> error inst.at "Type Family of variant or records should not exist" (* This should never occur *)

let rec create_types_from_instances def =
  (match def.it with
  | TypD (id, params, [inst]) when check_normal_type_creation inst -> [TypD (id, params, [inst])]
  | TypD (id, params, insts) -> let types = List.concat_map (create_types id) insts in
    let transformed_instances = List.map (fun inst -> match inst.it with 
      | InstD (binds, args, {it = StructT _; at; _}) | InstD(binds, args, {it = VariantT _; at; _}) -> 
        InstD (binds, args, AliasT (VarT (id.it ^ sub_type_name_binds binds $ id.at, List.map make_arg binds) $ id.at) $ at) $ inst.at
      | _ -> inst 
    ) insts in
    types @ [TypD(id, params, transformed_instances)]
  | RecD defs -> [RecD (List.concat_map create_types_from_instances defs)]
  | d -> [d]
  ) |> List.map (fun d -> d $ def.at)

let rec transform_type_family def =
  (match def.it with
  | TypD (id, params, [inst]) when check_normal_type_creation inst -> [TypD (id, params, [inst])]
  | TypD (id, params, insts) -> 
    let deftyp = VariantT (List.mapi (fun case_num inst -> match inst.it with 
      | InstD (binds, args, {it = AliasT typ; _}) ->
        let name = var_typ_fam $ typ.at in
        let new_args = List.map make_arg_from_bind binds in
        let tupt = construct_tuple_typ typ new_args id.at in
        let new_bind = ExpB (name, typ) $ typ.at in

        let prems = List.map2 (fun a p ->
          let var_param = (match p.it with
            | ExpP (id', typ') -> VarE id' $$ id'.at % typ'
            | _ -> error id.at "Removal of other arguments is not supported yet"
          ) in
          let exp_arg = (match a.it with
            | ExpA exp -> exp
            | _ -> error id.at "Removal of other arguments is not supported yet"
          ) in 
          let cmp_exp = CmpE (`EqOp, `BoolT, var_param, exp_arg) $$ id.at % (BoolT $ id.at) in
          IfPr cmp_exp $ id.at
        ) args params in 
        (constructor_name_mixop id binds case_num, (binds @ [new_bind], tupt, prems), [])
      | _ -> error def.at "Should be type alias"
    ) insts) $ def.at in
    let inst = InstD (List.map make_bind_from_param params, List.map make_arg_from_param params, deftyp) $ def.at in 
    let one_inst = match insts with 
      | [_] -> true
      | _ -> false
    in
    let proj_ids, projections = List.split (List.mapi (gen_family_projections id one_inst) insts) in

    let hintdefs = List.map (fun id -> HintD (DecH (id, [projection_hint]) $ def.at)) proj_ids in
    TypD (id, params, [inst]) :: projections @ hintdefs
  | RecD defs -> [RecD (List.concat_map transform_type_family defs)]
  | d -> [d]
  ) |> List.map (fun d -> d $ def.at)

let transform (il : script): script = 
  let il_transformed = List.concat_map create_types_from_instances il in
  let env = Env.env_of_script il_transformed in 
  List.map (transform_def env) il_transformed |>
  List.concat_map transform_type_family