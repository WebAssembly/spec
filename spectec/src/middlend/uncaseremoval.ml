(*
This transformation focuses on transforming uncase expressions into explicit projection functions.

This is achieved through the following steps:
  * The uncase expressions are collected and placed in a map (as a first pass). This is a map from id
  to a list of mixops.
  * When encountering a user defined type definition, we lookup in the map and generate
  the projection functions accordingly for each mixop in the list. If there is more than one case,
  the projection function returns the case tuple wrapped in an optional type.
  * When encountering an uncase expression, we just simply make the appropriate transformation
  to a function call.

This pass works with/without dependent types. It will simply add the dependent type parameters
to the projection function whenver necessary.

As an example,
given the following type:

syntax foo =
  | A v
  | B c v

where A and B are case constructors, and v c are types.

Assume we have uncase expressions somewhere in our script (with x being a variable of type foo):
(x!A).0 and (x!B).1

This is transformed into: 

syntax foo =
  | A v
  | B c v

def $proj_foo_0(x : foo) : (v)?
  def $proj_foo_0{var : v}(A(var)) = ?(var)
  def $proj_foo_0{var : foo}(var) = ?()

def $proj_foo_1(x : foo) : (c, v)?
  def $proj_foo_0{v_c : c, v_v : v}(B(v_c, v_v)) = ?((v_c, v_v))
  def $proj_foo_0{var : foo}(var) = ?()

with uncase expressions being transformed into:
(the($proj_foo_0(x))).0 and (the($proj_foo_1(x))).1

Names were specifically chosen here for simplicity.
*)

open Il.Ast
open Il
open Il.Walk
open Util.Source

module StringMap = Map.Make(String)
type uncase_map = (mixop list) StringMap.t

type env = {
  mutable uncase_map : uncase_map;
  mutable env : Il.Env.t;
}

let empty_env = {
  uncase_map = StringMap.empty;
  env = Il.Env.empty
}

let error at msg = Util.Error.error at "uncase-removal" msg

let var_prefix = "v_"
let proj_prefix = "proj_"

let get_case_typs t = 
  match t.it with
  | TupT typs -> typs
  | _ -> [(VarE ("_" $ t.at) $$ t.at % t, t)]

let iter_name i = 
  match i with
  | Opt -> "opt"
  | List | List1 | ListN _ -> "list"

let rec typ_name t =
  match t.it with
  | VarT (id, _) -> id.it
  | BoolT -> "bool"
  | NumT _ -> "num"
  | TextT -> "str"
  | TupT pairs -> String.concat "__" (List.map (fun (_, t) -> typ_name t) pairs) ^ "_pair"
  | IterT (typ, iter) -> typ_name typ ^ "_" ^ iter_name iter 

let make_arg p = 
  (match p.it with
  | ExpP (id, typ) -> ExpA (VarE id $$ id.at % typ) 
  | TypP id -> TypA (VarT (id, []) $ id.at) (* TODO unsure this makes sense*)
  | DefP (id, _, _) -> DefA id 
  | GramP (_, _) -> assert false (* Avoid this *)
  ) $ p.at

let make_bind p = 
  (match p.it with 
  | ExpP (id, typ) -> ExpB (id, typ)
  | TypP id -> TypB id
  | DefP (id, params, typ) -> DefB (id, params, typ)
  | GramP _ -> assert false (* Avoid this *)
  ) $ p.at

let create_projection_functions id params mixops inst =
  let get_deftyp inst' = (match inst'.it with
    | InstD (_binds, _args, deftyp) -> deftyp.it
  ) in 
  let at = inst.at in 
  let user_typ = VarT (id, List.map make_arg params) $ at in 
  let param_ids = List.map (fun p -> (Utils.get_param_id p).it) params in 
  let fresh_name = Utils.generate_var param_ids "x" in
  let new_param = ExpP (fresh_name $ at, user_typ) $ at in
  let make_func m case_typs has_one_case idx = 
    let new_var_exps = List.mapi (fun idx (_, t) -> VarE (var_prefix ^ typ_name t ^ "_" ^ Int.to_string idx $ at) $$ at % t) case_typs in 
    let tupt = TupT case_typs $ at in
    let no_name_tupt = TupT (List.map (fun (e, t) -> ({e with it = VarE ("_" $ e.at)}, t)) case_typs) $ at in
    let new_tup = TupE (new_var_exps) $$ at % tupt in
    let new_case_exp = CaseE(m, new_tup) $$ at % user_typ in

    let new_params = params @ [new_param] in 
    let new_binds = List.mapi (fun idx (_, t) -> ExpB (var_prefix ^ typ_name t ^ "_" ^ Int.to_string idx $ at, t) $ at) case_typs in
    let new_arg = ExpA new_case_exp $ at in 
    if has_one_case then 
      let clause = DefD (List.map make_bind params @ new_binds, List.map make_arg params @ [new_arg], new_tup, []) $ at in 
      DecD ((proj_prefix ^ id.it ^ "_" ^ Int.to_string idx) $ id.at, new_params, no_name_tupt, [clause])
    else
      (* extra handling in case that it has more than one case *)
      let extra_arg = ExpA (VarE (fresh_name $ at) $$ at % user_typ) $ at in
      let new_bind = ExpB (fresh_name $ at, user_typ) $ at in 
      let opt_type = IterT (no_name_tupt, Opt) $ at in
      let none_exp = OptE (None) $$ at % no_name_tupt in
      let opt_tup = OptE (Some new_tup) $$ at % opt_type in 
      let clause' = DefD (List.map make_bind params @ new_binds, List.map make_arg params @ [new_arg], opt_tup, []) $ at in
      let extra_clause = DefD (List.map make_bind params @ new_binds @ [new_bind], List.map make_arg params @ [extra_arg], none_exp, []) $ at in
      DecD ((proj_prefix ^ id.it ^ "_" ^ Int.to_string idx) $ id.at, new_params, opt_type, [clause'; extra_clause])
  in

  List.map (fun m -> 
    (match (get_deftyp inst) with
    (* Should not happen due to reduction while collecting uncase expressions *)
    | AliasT _typ -> error inst.at "Found type alias while constructing projection functions, should not happen"
    (* Should not be allowed since struct does not have cases *)
    | StructT _ -> error inst.at "Found struct construction while constructing projection functions, should not happen" 
    | VariantT typcases -> 
      let mixop_opt = List.find_map (fun (i, (m', (_, t, _), _)) -> 
        if not (Eq.eq_mixop m m') then None else 
        Some (i, m, t)
      ) (List.mapi (fun i t -> (i, t)) typcases) in
      begin match mixop_opt with
      | Some (i, m, t) -> make_func m (get_case_typs t) (List.length typcases = 1) i
      | None -> 
        error inst.at ("Could not find mixop " ^ Il.Print.string_of_mixop m ^ 
        " while constructing projection functions") 
      end 
    )
  ) mixops

let get_proj_info p_env m id = 
  let opt = Env.find_opt_typ p_env.env (id $ no_region) in
  match opt with
  | Some (_, [{it = InstD(_, _, {it = VariantT typcases; _}); _}]) -> 
    List.find_map (fun (i, (m', (_, t, _), _)) -> 
      if Eq.eq_mixop m m' then Some (i, t) else None
    ) (List.mapi (fun i t -> (i, t)) typcases) |>
    Option.map (fun (i, t) -> (i, t, List.length typcases = 1))
  | _ -> None

let transform_tuple_type t = 
  match t.it with
  | TupT ts -> TupT (List.map (fun (e, t) -> (VarE ("_" $ e.at) $$ e.at % t, t)) ts) $ t.at
  | _ -> t

let t_exp p_env e = 
  match e.it with
  | UncaseE (exp, m) -> 
    (* Supplying the projection function for UncaseE removal *)
    let typ = Eval.reduce_typ p_env.env exp.note in 
    let typ_name = Print.string_of_typ_name typ in
    let proj_info_opt = get_proj_info p_env m typ_name in
    let args = (match typ.it with 
      | VarT (_, args) -> args
      | _ -> error e.at ("Found non-variable type in uncase expression: " ^ Il.Print.string_of_typ typ)
    ) in 
    let args' = args @ [ExpA exp $ e.at] in
    let fun_id idx = proj_prefix ^ typ_name ^ "_" ^ Int.to_string idx $ e.at in
    begin match proj_info_opt with 
    | Some (idx, _, true) -> { e with it = CallE (fun_id idx, args') }
    | Some (idx, t, false) -> 
      let call_typ = IterT (transform_tuple_type t, Opt) $ e.at in
      { e with it = TheE (CallE (fun_id idx, args') $$ e.at % call_typ) }
    | None -> error e.at ("Could not find mixop: " ^ Il.Print.string_of_mixop m)
    end
  | _ -> e

let t_def p_env def = 
  let t = { base_transformer with transform_exp = t_exp p_env} in 
  (match def.it with
  | TypD (id, params, [inst]) -> 
    let d = TypD (id, List.map (transform_param t) params, [transform_inst t inst]) in 
    (match (StringMap.find_opt id.it p_env.uncase_map) with 
      | None -> [d]
      | Some ms -> d :: create_projection_functions id params ms inst
    )
  | _ -> [ (transform_def t def).it ]
  ) |> List.map (fun d -> d $ def.at)

let collect_uncase_iter env: uncase_map ref * (module Iter.Arg) =
  let module Arg = 
    struct
      include Iter.Skip 
      let acc = ref StringMap.empty
      let visit_exp (exp : exp) = 
        match exp.it with
        | UncaseE(e, m) -> 
          let typ_name = Print.string_of_typ_name (Il.Eval.reduce_typ env e.note) in
          acc := StringMap.update typ_name (fun int_set_opt -> match int_set_opt with 
            | None -> Some [m]
            | Some ms -> 
              Some (if List.mem m ms then ms else m :: ms) 
          ) !acc
        | _ -> ()
    end
  in Arg.acc, (module Arg)

let transform (il : script): script =
  let p_env = empty_env in 
  p_env.env <- Il.Env.env_of_script il;

  (* Building up uncase_map *)
  let acc, (module Arg : Iter.Arg) = collect_uncase_iter p_env.env in
  let module Acc = Iter.Make(Arg) in
  List.iter Acc.def il;
  p_env.uncase_map <- !acc;

  (* Main transformation *)
  List.concat_map (t_def p_env) il 