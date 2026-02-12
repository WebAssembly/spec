open Il.Ast
open Il
open Util.Source

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

let generate_var ids id =
  let start = 0 in
  let fresh_prefix = "var" in
  let max = 1000 in
  let rec go prefix c =
    if max <= c then assert false else
    let name = prefix ^ "_" ^ Int.to_string c in 
    if (List.mem name ids) 
      then go prefix (c + 1) 
      else name
  in
  match id with
  | "" | "_" -> go fresh_prefix start
  | s when List.mem s ids -> go s start
  | _ -> id

let improve_ids_quants ids generate_all_quants at exp_typ_pairs =
  let rec improve_ids_helper ids qs = 
    match qs with
    | [] -> ([], [])
    | (q_id, t) :: qs' -> 
      let new_name = generate_var ids q_id.it in 
      let (quants, pairs) = improve_ids_helper (new_name :: ids) qs' in
      let new_pairs = (new_name $ q_id.at, t) :: pairs in 
      if not generate_all_quants && new_name = q_id.it
        then (quants, new_pairs)
        else ((ExpP (new_name $ q_id.at, t) $ at) :: quants, new_pairs)
  in
  improve_ids_helper ids exp_typ_pairs

let get_param_id p = 
  match p.it with
  | ExpP (id, _) | TypP id | DefP (id, _, _) | GramP (id, _, _) -> id

let improve_ids_params params =
  let reconstruct_param id p = 
    (match p.it with
    | ExpP (_, t) -> ExpP (id, t)
    | TypP _ -> TypP id
    | DefP (_, params, r_typ) -> DefP (id, params, r_typ)
    | GramP (_, params, r_typ) -> GramP (id, params, r_typ)
    ) $ p.at
  in
  let rec improve_ids_helper ids ps = 
    match ps with
    | [] -> []
    | p :: ps' -> 
      let p_id = get_param_id p in
      let new_name = generate_var ids p_id.it $ p_id.at in 
      reconstruct_param new_name p :: improve_ids_helper (new_name.it :: ids) ps' 
  in
  improve_ids_helper [] params

