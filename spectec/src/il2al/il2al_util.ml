open Il.Ast
open Xl
open Def
open Util
open Source

let error at msg = Error.error at "prose translation" msg

(* Helpers *)
let apply_if c f x = if c then f x else x
let compose g f x = g (f x)
let compose_list g f x = f x |> List.map g |> List.flatten
let lift f x = [f x]

let (-->) = apply_if
let (<<) = compose
let (>>) f g = g << f
let (<<@) = compose_list
let (>>@) f g = g <<@ f

(* TODO: combine this with Env *)
let hintdefs : hintdef list ref = ref []

let name_of_rule rule =
  match rule.it with
  | RuleD (id, _, _, _, _) ->
    String.split_on_char '-' id.it |> List.hd
let full_name_of_rule rule =
  match rule.it with
  | RuleD (id, _, _, _, _) -> id.it
let prems_of_rule rule =
  match rule.it with
  | RuleD (_, _, _, _, prems) -> prems

let lhs_of_prem pr =
  match pr.it with
  | LetPr (lhs, _, _) -> lhs
  | _ -> error pr.at "expected a LetPr"
let rhs_of_prem pr =
  match pr.it with
  | LetPr (_, rhs, _) -> rhs
  | _ -> error pr.at "expected a LetPr"
let replace_lhs lhs pr =
  let open Il.Free in
  match pr.it with
  | LetPr (lhs', rhs, _) ->
    if Il.Eq.eq_exp lhs lhs' then
      pr
    else
      { pr with it = LetPr (lhs, rhs, (free_exp lhs).varid |> Set.elements) }
  | _ -> error pr.at "expected a LetPr"

let case_of_case e =
  match e.it with
  | CaseE (mixop, _) -> mixop
  | _ -> error e.at
    (Printf.sprintf "expected a CaseE, but got `%s`" (Il.Print.string_of_exp e))

let is_let_prem_with_rhs_type t prem =
  match prem.it with
  | LetPr (_, e, _) ->
    (match e.note.it with
    | VarT (id, []) -> id.it = t
    | _ -> false
    )
  | _ -> false
let is_pop : prem -> bool = is_let_prem_with_rhs_type "stackT"
let is_ctxt_prem : prem -> bool = is_let_prem_with_rhs_type "contextT"

let extract_context r =
  let _, _, _, prems = r in
  prems
  |> List.find_opt is_ctxt_prem
  |> Option.map lhs_of_prem (* TODO: Collect helper functions into one place *)

let extract_pops rgroup =
  (* Helpers *)
  let rec extract_pops' acc prems premss =
    match prems with
    | hd :: tl when is_pop hd ->
      let partitions = List.map (List.partition (Il.Eq.eq_prem hd)) premss in
      let fsts = List.map fst partitions in
      let snds = List.map snd partitions in

      if List.for_all (fun l -> List.length l = 1) fsts then
        extract_pops' (hd :: acc) tl snds
      else
        List.rev acc, prems :: premss
    | _ -> List.rev acc, prems :: premss
  in

  let get_prems r = let _, _, _, prems = r in prems in
  let set_prems r prems =
    let id, lhs, rhs, _ = r in
    id, lhs, rhs, prems
  in
  (* End of helpers *)

  let hd = List.hd rgroup in
  let tl = List.tl rgroup in

  let extracted, new_premss = extract_pops' [] (get_prems hd) (List.map get_prems tl) in
  extracted, List.map2 set_prems rgroup new_premss

let rec add eq k v = function (* add a (k,v) to an assoc list *)
  | [] -> [(k, [v])]
  | (k', vs) :: tl ->
    if eq k k' then
      (k', vs @ [v]) :: tl
    else
      (k', vs) :: add eq k v tl

let group_by_context (rs: rule_clause list): ('a option * rule_clause list) list =
  let eq_context = Option.equal (fun c1 c2 -> Mixop.eq (case_of_case c1) (case_of_case c2)) in
  List.fold_left (fun acc r -> add eq_context (extract_context r) r acc) [] rs

let find_hint id hintdefs =
  List.find_map (fun hintdef ->
    match hintdef.it with
    | TypH (id', hints) when id.it = id'.it ->
      List.find_opt (fun hint -> hint.hintid.it = "show") hints
    | _ -> None
  ) hintdefs

let rec subst_hint hintexp args =
  match hintexp.it with
  | El.Ast.HoleE `Next ->
    (match args with
    | h :: args' -> args', Il.Print.string_of_arg (Il.Eval.reduce_arg !Al.Valid.il_env h)
    | _ -> failwith "not sufficient args")
  | El.Ast.FuseE (e1, e2) ->
    let args', t = subst_hint e1 args in
    let args'', t' = subst_hint e2 args' in
    args'', t ^ t'
  | El.Ast.IterE (e, Opt) ->
    let args', t = subst_hint e args in
    args', t ^ "_opt"
  | _ ->
    args, El.Print.string_of_exp hintexp |> String.map (fun c -> if c = ' ' then '_' else c)

let rec typ_to_var_name ty =
  match ty.it with
  (* TODO: guess this for "var" in el? *)
  | Il.Ast.VarT (id, args) ->
    (match find_hint id !hintdefs with
    | None -> id.it
    | Some hint -> let _, t = subst_hint hint.hintexp args in t
    )
  | Il.Ast.BoolT -> "b"
  | Il.Ast.NumT `NatT -> "n"
  | Il.Ast.NumT `IntT -> "i"
  | Il.Ast.NumT `RatT -> "q"
  | Il.Ast.NumT `RealT -> "r"
  | Il.Ast.TextT -> "s"
  | Il.Ast.TupT tys -> List.map typ_to_var_name (List.map snd tys) |> String.concat "_"
  | Il.Ast.IterT _ -> failwith (Il.Print.string_of_typ ty)

let rec typ_to_var_exp' ty suffix =
  match ty.it with
  | Il.Ast.IterT (ty', iter) ->
    let id, e = typ_to_var_exp' ty' suffix in
    let iter_id = { id with it = id.it ^ Il.Print.string_of_iter iter} in
    let iter_e = VarE iter_id $$ (no_region, ty) in
    iter_id, IterE (e, (iter, [(id, iter_e)])) $$ (no_region, ty)
  | _ ->
    let prefix = typ_to_var_name ty in
    let id' =
      if prefix.[String.length prefix - 1] = '_' && suffix.[0] = '_' then
        (* x__0 --> x_0 *)
        prefix ^ String.sub suffix 1 (String.length suffix - 1)
      else
        prefix ^ suffix
    in
    let id = id' $ no_region in
    id, VarE id $$ (no_region, ty)

let typ_to_var_exp ?(suffix="") ty =
  let _, e = typ_to_var_exp' ty suffix in
  e

let get_var_set_in_algo (algo: Al.Ast.algorithm) : Al.Free.IdSet.t =
  let open Al.Al_util in
  let open Al.Ast in
  let open Al.Free in

  (* NOTE: Eta-expansion *)
  let get_vars_in_list : 'a. ('a -> IdSet.t) -> 'a list -> IdSet.t =
    fun f -> List.fold_left (fun acc x -> IdSet.union (f x) acc) IdSet.empty in

  let get_vars_in_expr (expr: expr) : IdSet.t = free_expr expr in

  let get_vars_in_arg (arg: arg) : IdSet.t =
    match arg.it with
    | ExpA expr -> get_vars_in_expr expr
    | _ -> IdSet.empty
  in

  let rec get_vars_in_instr (instr: instr) : IdSet.t =
    match instr.it with
    | IfI (_, il1, il2) | EitherI (il1, il2) ->
      get_vars_in_list get_vars_in_instr (il1 @ il2)
    | EnterI (_, _, il) ->
      get_vars_in_list get_vars_in_instr il
    | LetI (binding_expr, _) | PopI binding_expr | PopAllI binding_expr ->
      get_vars_in_expr binding_expr
    | _ -> IdSet.empty
  in

  IdSet.union
    (get_vars_in_list get_vars_in_arg (params_of_algo algo))
    (get_vars_in_list get_vars_in_instr (body_of_algo algo))

let get_dimension (var: string) : string =
  let length = String.length var in

  let list = String.index_opt var '*' in
  let list1 = String.index_opt var '+' in
  let listn = String.index_opt var '^' in
  let opt = String.index_opt var '?' in

  let min_idx idx =
    function
    | Some idx' -> if idx < idx' then idx else idx'
    | _ -> idx in

  let dim_idx = List.fold_left min_idx length [ list; list1; listn; opt ] in
  String.sub var dim_idx (length - dim_idx)

let rec remove_dimension (var: string) : string =
  if
    String.ends_with ~suffix:"*" var ||
    String.ends_with ~suffix:"+" var ||
    String.ends_with ~suffix:"?" var
  then
    String.length var - 1
    |> String.sub var 0
    |> remove_dimension
  else if String.contains var '^' then
    String.rindex var '^'
    |> String.sub var 0
    |> remove_dimension
  else var

let introduce_fresh_variable
    ?(prefix: string option)
    (idset: Al.Free.IdSet.t)
    (typ: Al.Ast.typ)
  : string =

  let open Al.Free in

  let var = Option.value ~default:(Al.Al_util.typ_to_var_name typ) prefix in
  let prefix, suffix = remove_dimension var, get_dimension var in

  let idset =
    idset
    |> IdSet.filter (String.starts_with ~prefix)
    |> IdSet.map remove_dimension in

  let rec get_fresh_variable (var: string) : string =
    if IdSet.mem var idset then get_fresh_variable (var^"'"^suffix) else var^suffix in

  get_fresh_variable prefix

let val_mixops = ref []


let is_val exp =
  if (!val_mixops = []) then (
    let id = "val" $ no_region in
    match Il.Env.find_opt_typ !Al.Valid.il_env id with
    | Some(_, [inst]) -> (
      match inst.it with
      | InstD ([], [], { it = VariantT typcases; _ }) -> (
        val_mixops := List.map (fun (mixop, _, _) -> mixop) typcases
      )
      | _ -> ()
    )
    | _ -> ()
  );
  match exp.it with
  | CaseE (mixop, _) -> (
    match List.find_opt (Il.Eq.eq_mixop mixop) !val_mixops with
    | Some _ -> true
    | None -> false
    )
  | VarE _ -> Il.Eval.sub_typ !Al.Valid.il_env exp.note Al.Al_util.valT
  | SubE (_, t, _) -> Il.Eval.sub_typ !Al.Valid.il_env t Al.Al_util.valT
  | _ -> false

let replace_name_walker x1 x2 =
  let replace_name' walker e =
    match e.it with
    | Al.Ast.VarE x when x = x1 -> {e with it = Al.Ast.VarE x2}
    | _ -> Al.Walk.base_walker.walk_expr walker e
  in
  {Al.Walk.base_walker with walk_expr = replace_name'}

let replace_name_expr x1 x2 =
  let walker = replace_name_walker x1 x2 in
  walker.walk_expr walker

let replace_name x1 x2 =
  let walker = replace_name_walker x1 x2 in
  walker.walk_instr walker
