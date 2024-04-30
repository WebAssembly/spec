open Util
open Source
open Ast
open Print


(* Errors *)

let error at msg = Error.error at "validation" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ * iter list
type typ_typ = param list * inst list
type rel_typ = mixop * typ
type def_typ = param list * typ * clause list

type env =
  { mutable vars : var_typ Env.t;
    mutable typs : typ_typ Env.t;
    mutable rels : rel_typ Env.t;
    mutable defs : def_typ Env.t;
  }

let new_env () =
  { vars = Env.empty;
    typs = Env.empty;
    rels = Env.empty;
    defs = Env.empty;
  }

let local_env env = {env with vars = env.vars; typs = env.typs}

(* TODO: avoid repeated copying of environment *)
let to_eval_env env =
  let vars = Env.map (fun (t, _iters) -> t) env.vars in
  let typs = Env.map (fun (_ps, insts) -> insts) env.typs in
  let defs = Env.map (fun (_ps, _t, clauses) -> clauses) env.defs in
  Eval.{vars; typs; defs}

let find space env' id =
  match Env.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind _space env' id t =
(* TODO
  if Env.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
*)
  if id.it = "_" then env' else
    Env.add id.it t env'

let rebind _space env' id t =
  assert (Env.mem id.it env');
  Env.add id.it t env'

let find_field fs atom at =
  match List.find_opt (fun (atom', _, _) -> Eq.eq_atom atom' atom) fs with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases op at =
  match List.find_opt (fun (op', _, _) -> Eq.eq_mixop op' op) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_mixop op ^ "`")


let typ_string env t =
  let t' = Eval.reduce_typ (to_eval_env env) t in
  if Eq.eq_typ t t' then
    "`" ^ string_of_typ t ^ "`"
  else
    "`" ^ string_of_typ t ^ "` = `" ^ string_of_typ t' ^ "`"


(* Type Accessors *)

let expand_typ env t = (Eval.reduce_typ (to_eval_env env) t).it
let expand_typdef env t = (Eval.reduce_typdef (to_eval_env env) t).it

type direction = Infer | Check

let as_error at phrase dir t expected =
  match dir with
  | Infer ->
    error at (
      phrase ^ "'s type `" ^ string_of_typ t ^
      "` does not match expected type `" ^ expected ^ "`"
    )
  | Check ->
    error at (
      phrase ^ "'s type does not match expected type `" ^
      string_of_typ t ^ "`"
    )

let match_iter iter1 iter2 =
  iter2 = List || Eq.eq_iter iter1 iter2

let as_iter_typ iter phrase env dir t at : typ =
  match expand_typ env t with
  | IterT (t1, iter2) when match_iter iter iter2 -> t1
  | _ -> as_error at phrase dir t ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir t at : typ =
  match expand_typ env t with
  | IterT (t1, (List | List1 | ListN _)) -> t1
  | _ -> as_error at phrase dir t "(_)*"

let as_tup_typ phrase env dir t at : (exp * typ) list =
  match expand_typ env t with
  | TupT ets -> ets
  | _ -> as_error at phrase dir t "(_,...,_)"


let as_struct_typ phrase env dir t at : typfield list =
  match expand_typdef env t with
  | StructT tfs -> tfs
  | _ -> as_error at phrase dir t "{...}"

let as_variant_typ phrase env dir t at : typcase list =
  match expand_typdef env t with
  | VariantT tcs -> tcs
  | _ -> as_error at phrase dir t "| ..."


(* Type Equivalence and Subtyping *)

let equiv_typ env t1 t2 at =
  if not (Eval.equiv_typ (to_eval_env env) t1 t2) then
    error at ("expression's type " ^ typ_string env t1 ^ " " ^
      "does not equal expected type " ^ typ_string env t2)

let sub_typ env t1 t2 at =
  if not (Eval.sub_typ (to_eval_env env) t1 t2) then
    error at ("expression's type " ^ typ_string env t1 ^ " " ^
      "does not match expected supertype " ^ typ_string env t2)


(* Operators *)

let infer_unop = function
  | NotOp -> BoolT, BoolT
  | PlusOp t | MinusOp t | PlusMinusOp t | MinusPlusOp t -> NumT t, NumT t

let infer_binop = function
  | AndOp | OrOp | ImplOp | EquivOp -> BoolT, BoolT, BoolT
  | AddOp t | SubOp t | MulOp t | DivOp t -> NumT t, NumT t, NumT t
  | ExpOp t -> NumT t, NumT NatT, NumT t

let infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp t | GtOp t | LeOp t | GeOp t -> Some (NumT t)


(* Atom Bindings *)

let check_mixops phrase item list at =
  let _, dups =
    List.fold_right (fun op (set, dups) ->
      let s = Print.string_of_mixop op in
      Free.Set.(if mem s set then (set, s::dups) else (add s set, dups))
    ) list (Free.Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let valid_list valid_x_y env xs ys at =
  if List.length xs <> List.length ys then
    error at ("arity mismatch for expression list, expected " ^
      string_of_int (List.length ys) ^ ", got " ^ string_of_int (List.length xs));
  List.iter2 (valid_x_y env) xs ys


let rec valid_iter env iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN (e, None) -> valid_exp env e (NumT NatT $ e.at)
  | ListN (e, Some id) ->
    valid_exp env e (NumT NatT $ e.at);
    let t', dim = find "variable" env.vars id in
    equiv_typ env t' (NumT NatT $ e.at) e.at;
    if not Eq.(eq_list eq_iter dim [ListN (e, None)]) then
      error e.at ("use of iterated variable `" ^
        id.it ^ String.concat "" (List.map string_of_iter dim) ^
        "` outside suitable iteraton context")


(* Types *)

and valid_typ env t =
  Debug.(log_at "il.valid_typ" t.at
    (fun _ -> fmt "%s" (il_typ t)) (Fun.const "ok")
  ) @@ fun _ ->
  match t.it with
  | VarT (id, as_) ->
    let ps, _insts = find "syntax type" env.typs id in
    ignore (valid_args env as_ ps Subst.empty t.at)
  | BoolT
  | NumT _
  | TextT ->
    ()
  | TupT ets ->
    let env' = local_env env in
    List.iter (valid_typbind env') ets
  | IterT (t1, iter) ->
    match iter with
    | ListN (e, _) -> error e.at "definite iterator not allowed in type"
    | _ -> valid_iter env iter; valid_typ env t1

and valid_typbind env (e, t) =
  valid_typ env t;
  valid_exp env e t

and valid_deftyp env dt =
  match dt.it with
  | AliasT t ->
    valid_typ env t
  | StructT tfs ->
    check_mixops "record" "field" (List.map (fun (atom, _, _) -> [[atom]]) tfs) dt.at;
    List.iter (valid_typfield env) tfs
  | VariantT tcs ->
    check_mixops "variant" "case" (List.map (fun (op, _, _) -> op) tcs) dt.at;
    List.iter (valid_typcase env) tcs

and valid_typfield env (_atom, (bs, t, prems), _hints) =
  let env' = local_env env in
  List.iter (valid_bind env') bs;
  valid_typ env' t;
  List.iter (valid_prem env') prems

and valid_typcase env (mixop, (bs, t, prems), _hints) =
  let arity =
    match t.it with
    | TupT ts -> List.length ts
    | _ -> 1
  in
  if List.length mixop <> arity + 1 then
    error t.at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ typ_string env t);
  let env' = local_env env in
  List.iter (valid_bind env') bs;
  valid_typ env' t;
  List.iter (valid_prem env') prems


and proj_tup_typ env s e ets i : typ option =
  match ets, i with
  | (_eI, tI)::_, 0 -> Some tI
  | (eI, tI)::ets', i ->
    (match Eval.match_exp env s (ProjE (e, i) $$ e.at % tI) eI with
    | None -> None
    | Some s' -> proj_tup_typ env s' e ets' (i - 1)
    | exception Eval.Irred -> None
    )
  | [], _ -> assert false


(* Expressions *)

and infer_exp env e : typ =
  Debug.(log_at "il.infer_exp" e.at
    (fun _ -> fmt "%s : %s" (il_exp e) (il_typ e.note))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match e.it with
  | VarE id -> fst (find "variable" env.vars id)
  | BoolE _ -> BoolT $ e.at
  | NatE _ | LenE _ -> NumT NatT $ e.at
  | TextE _ -> TextT $ e.at
  | UnE (op, _) -> let _t1, t' = infer_unop op in t' $ e.at
  | BinE (op, _, _) -> let _t1, _t2, t' = infer_binop op in t' $ e.at
  | CmpE _ -> BoolT $ e.at
  | IdxE (e1, _) -> as_list_typ "expression" env Infer (infer_exp env e1) e1.at
  | SliceE (e1, _, _)
  | UpdE (e1, _, _)
  | ExtE (e1, _, _)
  | CompE (e1, _) -> infer_exp env e1
  | StrE _ -> error e.at "cannot infer type of record"
  | DotE (e1, atom) ->
    let tfs = as_struct_typ "expression" env Infer (infer_exp env e1) e1.at in
    let _binds, t, _prems = find_field tfs atom e1.at in
    t
  | TupE es ->
    TupT (List.map (fun eI -> eI, infer_exp env eI) es) $ e.at
  | CallE (id, as_) ->
    let ps, t, _ = find "function" env.defs id in
    let s = valid_args env as_ ps Subst.empty e.at in
    Subst.subst_typ s t
  | IterE (e1, iter) ->
    let iter' = match fst iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env e1, iter') $ e.at
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let ets = as_tup_typ "expression" env Infer t1 e1.at in
    if i >= List.length ets then
      error e.at "invalid tuple projection";
    (match proj_tup_typ (to_eval_env env) Subst.empty e1 ets i with
    | Some tI -> tI
    | None -> error e.at "cannot infer type of tuple projection"
    )
  | UncaseE (e1, op) ->
    let t1 = infer_exp env e1 in
    (match as_variant_typ "expression" env Infer t1 e1.at with
    | [(op', (_, t, _), _)] when Eq.eq_mixop op op' -> t
    | _ -> error e.at "invalid case projection";
    )
  | OptE _ -> error e.at "cannot infer type of option"
  | TheE e1 -> as_iter_typ Opt "option" env Check (infer_exp env e1) e1.at
  | ListE _ -> error e.at "cannot infer type of list"
  | CatE _ -> error e.at "cannot infer type of concatenation"
  | CaseE _ -> error e.at "cannot infer type of case constructor"
  | SubE _ -> error e.at "cannot infer type of subsumption"


and valid_exp env e t =
  Debug.(log_at "il.valid_exp" e.at
    (fun _ -> fmt "%s : %s == %s" (il_exp e) (il_typ e.note) (il_typ t))
    (Fun.const "ok")
  ) @@ fun _ ->
try
  match e.it with
  | VarE id when id.it = "_" -> ()
  | VarE id ->
    let t', dim = find "variable" env.vars id in
    equiv_typ env t' t e.at;
    if dim <> [] then
      error e.at ("use of iterated variable `" ^
        id.it ^ String.concat "" (List.map string_of_iter dim) ^
        "` outside suitable iteraton context")
  | BoolE _ | NatE _ | TextE _ ->
    let t' = infer_exp env e in
    equiv_typ env t' t e.at
  | UnE (op, e1) ->
    let t1, t' = infer_unop op in
    valid_exp env e1 (t1 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | BinE (op, e1, e2) ->
    let t1, t2, t' = infer_binop op in
    valid_exp env e1 (t1 $ e.at);
    valid_exp env e2 (t2 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | CmpE (op, e1, e2) ->
    let t' =
      match infer_cmpop op with
      | Some t' -> t' $ e.at
      | None -> try infer_exp env e1 with
        | _ -> infer_exp env e2
    in
    valid_exp env e1 t';
    valid_exp env e2 t';
    equiv_typ env (BoolT $ e.at) t e.at
  | IdxE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t' = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    valid_exp env e2 (NumT NatT $ e2.at);
    equiv_typ env t' t e.at
  | SliceE (e1, e2, e3) ->
    let _typ' = as_list_typ "expression" env Check t e1.at in
    valid_exp env e1 t;
    valid_exp env e2 (NumT NatT $ e2.at);
    valid_exp env e3 (NumT NatT $ e3.at)
  | UpdE (e1, p, e2) ->
    valid_exp env e1 t;
    let t2 = valid_path env p t in
    valid_exp env e2 t2
  | ExtE (e1, p, e2) ->
    valid_exp env e1 t;
    let t2 = valid_path env p t in
    let _typ21 = as_list_typ "path" env Check t2 p.at in
    valid_exp env e2 t2
  | StrE efs ->
    let tfs = as_struct_typ "record" env Check t e.at in
    valid_list valid_expfield env efs tfs e.at
  | DotE (e1, atom) ->
    let t1 = infer_exp env e1 in
    valid_exp env e1 t1;
    let tfs = as_struct_typ "expression" env Check t1 e1.at in
    let _binds, t', _prems = find_field tfs atom e1.at in
    equiv_typ env t' t e.at
  | CompE (e1, e2) ->
    let _ = as_struct_typ "record" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | LenE e1 ->
    let t1 = infer_exp env e1 in
    let _typ11 = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    equiv_typ env (NumT NatT $ e.at) t e.at
  | TupE es ->
    let ets = as_tup_typ "tuple" env Check t e.at in
    if List.length es <> List.length ets then
      error e.at ("arity mismatch for tuple, expected " ^
        string_of_int (List.length ets) ^ ", got " ^ string_of_int (List.length es));
    if not (valid_tup_exp env Subst.empty es ets) then
      as_error e.at "tuple" Check t ""
  | CallE (id, as_) ->
    let ps, t', _ = find "function" env.defs id in
    let s = valid_args env as_ ps Subst.empty e.at in
    equiv_typ env (Subst.subst_typ s t') t e.at
  | IterE (e1, iter) ->
    let env' = valid_iterexp env iter in
    let t1 = as_iter_typ (fst iter) "iteration" env Check t e.at in
    valid_exp env' e1 t1
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let ets = as_tup_typ "expression" env Infer t1 e1.at in
    if i >= List.length ets then
      error e.at "invalid tuple projection";
    (match proj_tup_typ (to_eval_env env) Subst.empty e1 ets i with
    | Some tI -> equiv_typ env tI t e.at
    | None -> error e.at "invalid tuple projection, cannot match pattern"
    )
  | UncaseE (e1, op) ->
    let t1 = infer_exp env e1 in
    (match as_variant_typ "expression" env Infer t1 e1.at with
    | [(op', (_, t', _), _)] when Eq.eq_mixop op op' -> equiv_typ env t' t e.at
    | _ -> error e.at "invalid case projection";
    )
  | OptE eo ->
    let t1 = as_iter_typ Opt "option" env Check t e.at in
    Option.iter (fun e1 -> valid_exp env e1 t1) eo
  | TheE e1 ->
    valid_exp env e1 (IterT (t, Opt) $ e1.at)
  | ListE es ->
    let t1 = as_iter_typ List "list" env Check t e.at in
    List.iter (fun eI -> valid_exp env eI t1) es
  | CatE (e1, e2) ->
    let _typ1 = as_iter_typ List "list" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | CaseE (op, e1) ->
    let cases = as_variant_typ "case" env Check t e.at in
    let _binds, t1, _prems = find_case cases op e1.at in
    valid_exp env e1 t1
  | SubE (e1, t1, t2) ->
    valid_typ env t1;
    valid_typ env t2;
    valid_exp env e1 t1;
    equiv_typ env t2 t e.at;
    sub_typ env t1 t2 e.at
with exn ->
  let bt = Printexc.get_raw_backtrace () in
  Printf.eprintf "[valid_exp] %s\n%!" (Debug.il_exp e);
  Printexc.raise_with_backtrace exn bt


and valid_expmix env mixop e (mixop', t) at =
  if not (Eq.eq_mixop mixop mixop') then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_exp env e t

and valid_tup_exp env s es ets =
  match es, ets with
  | e1::es', (e2, t)::ets' ->
    valid_exp env e1 (Subst.subst_typ s t);
    (match Eval.match_exp (to_eval_env env) s e1 e2 with
    | Some s' -> valid_tup_exp env s' es' ets'
    | None -> false
    | exception Eval.Irred -> false
    )
  | _, _ -> true

and valid_expfield env (atom1, e) (atom2, (_binds, t, _prems), _) =
  if not (Eq.eq_atom atom1 atom2) then error e.at "unexpected record field";
  valid_exp env e t

and valid_path env p t : typ =
  let t' =
    match p.it with
    | RootP -> t
    | IdxP (p1, e1) ->
      let t1 = valid_path env p1 t in
      valid_exp env e1 (NumT NatT $ e1.at);
      as_list_typ "path" env Check t1 p1.at
    | SliceP (p1, e1, e2) ->
      let t1 = valid_path env p1 t in
      valid_exp env e1 (NumT NatT $ e1.at);
      valid_exp env e2 (NumT NatT $ e2.at);
      let _ = as_list_typ "path" env Check t1 p1.at in
      t1
    | DotP (p1, atom) ->
      let t1 = valid_path env p1 t in
      let tfs = as_struct_typ "path" env Check t1 p1.at in
      let _bs, t, _prems = find_field tfs atom p1.at in
      t
  in
  equiv_typ env p.note t' p.at;
  t'

and valid_iterexp env (iter, bs) : env =
  valid_iter env iter;
  let iter' =
    match iter with
    | ListN (e, _) -> ListN (e, None)
    | iter -> iter
  in
  List.fold_left (fun env' (id, t) ->
    let t', iters = find "variable" env.vars id in
    valid_typ env t;
    equiv_typ env t' t id.at;
    match Lib.List.split_last_opt iters with
    | Some (iters', iterN) when Eq.eq_iter iterN iter' ->
      {env' with vars = Env.add id.it (t, iters') env'.vars}
    | _ ->
      error id.at ("iteration variable `" ^ id.it ^
        "` has incompatible dimension `" ^ id.it ^
        String.concat "" (List.map string_of_iter iters) ^
        "` in iteration `_" ^ string_of_iter iter' ^ "`")
  ) env bs


(* Premises *)

and valid_prem env prem =
  match prem.it with
  | RulePr (id, mixop, e) ->
    valid_expmix env mixop e (find "relation" env.rels id) e.at
  | IfPr e ->
    valid_exp env e (BoolT $ e.at)
  | LetPr (e1, e2, ids) ->
    valid_exp env (CmpE (EqOp, e1, e2) $$ prem.at % (BoolT $ prem.at))  (BoolT $ prem.at);
    let target_ids = Free.(free_list free_varid ids) in
    let free_ids = Free.(free_exp e1) in
    if not (Free.subset target_ids free_ids) then
      error prem.at ("target identifier(s) " ^
        ( Free.Set.elements (Free.diff target_ids free_ids).varid |>
          List.map (fun id -> "`" ^ id ^ "`") |>
          String.concat ", " ) ^
        " do not occur in left-hand side expression")
  | ElsePr ->
    ()
  | IterPr (prem', iter) ->
    let env' = valid_iterexp env iter in
    valid_prem env' prem'


(* Definitions *)

and valid_arg env a p s =
  Debug.(log_at "il.valid_arg" a.at
    (fun _ -> fmt "%s : %s" (il_arg a) (il_param p)) (Fun.const "ok")
  ) @@ fun _ ->
  match a.it, p.it with
  | ExpA e, ExpP (id, t) -> valid_exp env e (Subst.subst_typ s t); Subst.add_varid s id e
  | TypA t, TypP id -> valid_typ env t; Subst.add_typid s id t
  | _, _ -> error a.at "sort mismatch for argument"

and valid_args env as_ ps s at : Subst.t =
  Debug.(log_if "il.valid_args" (as_ <> [] || ps <> [])
    (fun _ -> fmt "(%s) : (%s)" (il_args as_) (il_params ps)) (Fun.const "ok")
  ) @@ fun _ ->
  match as_, ps with
  | [], [] -> s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as', p::ps' ->
    let s' = valid_arg env a p s in
    valid_args env as' ps' s' at

and valid_bind env b =
  match b.it with
  | ExpB (id, t, dim) ->
    valid_typ env t;
    env.vars <- bind "variable" env.vars id (t, dim)
  | TypB id ->
    env.typs <- bind "syntax" env.typs id ([], [])

let valid_param env p =
  match p.it with
  | ExpP (id, t) ->
    valid_typ env t;
    env.vars <- bind "variable" env.vars id (t, [])
  | TypP id ->
    env.typs <- bind "syntax" env.typs id ([], [])

let valid_inst env ps inst =
  Debug.(log_in "il.valid_inst" line);
  Debug.(log_in_at "il.valid_inst" inst.at
    (fun _ -> fmt "(%s) = ..." (il_params ps))
  );
  match inst.it with
  | InstD (bs, as_, dt) ->
    let env' = local_env env in
    List.iter (valid_bind env') bs;
    let _s = valid_args env' as_ ps Subst.empty inst.at in
    valid_deftyp env' dt

let valid_rule env mixop t rule =
  Debug.(log_in "il.valid_rule" line);
  Debug.(log_in_at "il.valid_rule" rule.at
    (fun _ -> fmt "%s : %s = ..." (il_mixop mixop) (il_typ t))
  );
  match rule.it with
  | RuleD (_id, bs, mixop', e, prems) ->
    let env' = local_env env in
    List.iter (valid_bind env') bs;
    valid_expmix env' mixop' e (mixop, t) e.at;
    List.iter (valid_prem env') prems

let valid_clause env ps t clause =
  Debug.(log_in "il.valid_clause" line);
  Debug.(log_in_at "il.valid_clause" clause.at
    (fun _ -> fmt ": (%s) -> %s" (il_params ps) (il_typ t))
  );
  match clause.it with
  | DefD (bs, as_, e, prems) ->
    let env' = local_env env in
    List.iter (valid_bind env') bs;
    let s = valid_args env' as_ ps Subst.empty clause.at in
    valid_exp env' e (Subst.subst_typ s t);
    List.iter (valid_prem env') prems

let infer_def env d =
  match d.it with
  | TypD (id, ps, _insts) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    env.typs <- bind "syntax type" env.typs id (ps, [])
  | RelD (id, mixop, t, _rules) ->
    valid_typcase env (mixop, ([], t, []), []);
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, ps, t, clauses) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    valid_typ env' t;
    env.defs <- bind "function" env.defs id (ps, t, clauses)
  | _ -> ()


type bind = {bind : 'a. string -> 'a Env.t -> id -> 'a -> 'a Env.t}

let rec valid_def {bind} env d =
  Debug.(log_in "il.valid_def" line);
  Debug.(log_in_at "il.valid_def" d.at (fun _ -> il_def d));
  match d.it with
  | TypD (id, ps, insts) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    List.iter (valid_inst env ps) insts;
    env.typs <- bind "syntax type" env.typs id (ps, insts);
  | RelD (id, mixop, t, rules) ->
    valid_typcase env (mixop, ([], t, []), []);
    List.iter (valid_rule env mixop t) rules;
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, ps, t, clauses) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    valid_typ env' t;
    List.iter (valid_clause env ps t) clauses;
    env.defs <- bind "function" env.defs id (ps, t, clauses)
  | RecD ds ->
    List.iter (infer_def env) ds;
    List.iter (valid_def {bind = rebind} env) ds;
    List.iter (fun d ->
      match (List.hd ds).it, d.it with
      | HintD _, _ | _, HintD _
      | TypD _, TypD _
      | RelD _, RelD _
      | DecD _, DecD _ -> ()
      | _, _ ->
        error (List.hd ds).at (" " ^ string_of_region d.at ^
          ": invalid recursion between definitions of different sort")
    ) ds
  | HintD _ ->
    ()


(* Scripts *)

let valid ds =
  let env = new_env () in
  List.iter (valid_def {bind} env) ds
