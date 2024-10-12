open Util
open Source
open Ast
open Print


(* Errors *)

let error at msg = Error.error at "validation" msg


(* Environment *)

let local_env envr = ref !envr

let find_field fs atom at =
  match List.find_opt (fun (atom', _, _) -> Eq.eq_atom atom' atom) fs with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases op at =
  match List.find_opt (fun (op', _, _) -> Eq.eq_mixop op' op) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_mixop op ^ "`")


let typ_string env t =
  let t' = Eval.reduce_typ env t in
  if Eq.eq_typ t t' then
    "`" ^ string_of_typ t ^ "`"
  else
    "`" ^ string_of_typ t ^ "` = `" ^ string_of_typ t' ^ "`"


(* Type Accessors *)

let expand_typ (env : Env.t) t = (Eval.reduce_typ env t).it
let expand_typdef (env : Env.t) t = (Eval.reduce_typdef env t).it

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

let rec as_comp_typ phrase env dir t at =
  match expand_typdef env t with
  | AliasT {it = IterT _; _} -> ()
  | StructT tfs ->
    List.iter (fun (_, (_, t, _), _) -> as_comp_typ phrase env dir t at) tfs
  | _ ->
    error at (phrase ^ "'s type `" ^ string_of_typ t ^ "` is not composable")


(* Type Equivalence and Subtyping *)

let equiv_typ env t1 t2 at =
  if not (Eval.equiv_typ env t1 t2) then
    error at ("expression's type " ^ typ_string env t1 ^ " " ^
      "does not equal expected type " ^ typ_string env t2)

let sub_typ env t1 t2 at =
  if not (Eval.sub_typ env t1 t2) then
    error at ("expression's type " ^ typ_string env t1 ^ " " ^
      "does not match expected supertype " ^ typ_string env t2)


(* Operators *)

let infer_unop = function
  | NotOp -> BoolT, BoolT
  | PlusOp t | MinusOp t | PlusMinusOp t | MinusPlusOp t -> NumT t, NumT t

let infer_binop = function
  | AndOp | OrOp | ImplOp | EquivOp -> BoolT, BoolT, BoolT
  | AddOp t | SubOp t | MulOp t | DivOp t | ModOp t -> NumT t, NumT t, NumT t
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


let rec valid_iter ?(side = `Rhs) env iter : Env.t =
  match iter with
  | Opt | List | List1 -> env
  | ListN (e, id_opt) ->
    valid_exp ~side env e (NumT NatT $ e.at);
    Option.fold id_opt ~none:env ~some:(fun id ->
      Env.bind_var env id (NumT NatT $ e.at)
    )


(* Types *)

and valid_typ env t =
  Debug.(log_at "il.valid_typ" t.at
    (fun _ -> fmt "%s" (il_typ t)) (Fun.const "ok")
  ) @@ fun _ ->
  match t.it with
  | VarT (id, as_) ->
    let ps, _insts = Env.find_typ env id in
    ignore (valid_args env as_ ps Subst.empty t.at)
  | BoolT
  | NumT _
  | TextT ->
    ()
  | TupT ets ->
    List.iter (valid_typbind env) ets
  | IterT (t1, iter) ->
    match iter with
    | ListN (e, _) -> error e.at "definite iterator not allowed in type"
    | _ ->
      let env' = valid_iter env iter in
      valid_typ env' t1

and valid_typbind env (e, t) =
  valid_typ env t;
  valid_exp ~side:`Lhs env e t

and valid_deftyp envr dt =
  match dt.it with
  | AliasT t ->
    valid_typ !envr t
  | StructT tfs ->
    check_mixops "record" "field" (List.map (fun (atom, _, _) -> [[atom]]) tfs) dt.at;
    List.iter (valid_typfield envr) tfs
  | VariantT tcs ->
    check_mixops "variant" "case" (List.map (fun (op, _, _) -> op) tcs) dt.at;
    List.iter (valid_typcase envr) tcs

and valid_typfield envr (_atom, (bs, t, prems), _hints) =
  let envr' = local_env envr in
  List.iter (valid_bind envr') bs;
  valid_typ !envr' t;
  List.iter (valid_prem !envr') prems

and valid_typcase envr (mixop, (bs, t, prems), _hints) =
  Debug.(log_at "il.valid_typcase" t.at
    (fun _ -> fmt "%s %s" (il_binds bs) (il_typ t))
    (fun _ -> "ok")
  ) @@ fun _ ->
  let arity =
    match t.it with
    | TupT ts -> List.length ts
    | _ -> 1
  in
  if List.length mixop <> arity + 1 then
    error t.at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ typ_string !envr t);
  let envr' = local_env envr in
  List.iter (valid_bind envr') bs;
  valid_typ !envr' t;
  List.iter (valid_prem !envr') prems


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

and infer_exp (env : Env.t) e : typ =
  Debug.(log_at "il.infer_exp" e.at
    (fun _ -> fmt "%s : %s" (il_exp e) (il_typ e.note))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match e.it with
  | VarE id -> Env.find_var env id
  | BoolE _ -> BoolT $ e.at
  | NatE _ | LenE _ -> NumT NatT $ e.at
  | TextE _ -> TextT $ e.at
  | UnE (op, _) -> let _t1, t' = infer_unop op in t' $ e.at
  | BinE (op, _, _) -> let _t1, _t2, t' = infer_binop op in t' $ e.at
  | CmpE _ | MemE _ -> BoolT $ e.at
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
    let ps, t, _ = Env.find_def env id in
    let s = valid_args env as_ ps Subst.empty e.at in
    Subst.subst_typ s t
  | IterE (e1, iterexp) ->
    let iter, env' = valid_iterexp env iterexp e.at in
    IterT (infer_exp env' e1, iter) $ e.at
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let ets = as_tup_typ "expression" env Infer t1 e1.at in
    if i >= List.length ets then
      error e.at "invalid tuple projection";
    (match proj_tup_typ env Subst.empty e1 ets i with
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
  | ListE es ->
    (match List.map (infer_exp env) es with
    | [] -> error e.at "cannot infer type of list"
    | t :: ts ->
      if List.for_all (Eq.eq_typ t) ts then
        IterT (t, List) $ e.at
      else
        error e.at "cannot infer type of list"
    )
  | CatE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t2 = infer_exp env e2 in
    if Eq.eq_typ t1 t2 then
      t1
    else
      error e.at "cannot infer type of concatenation"
  | CaseE _ -> e.note (* error e.at "cannot infer type of case constructor" *)
  | SubE _ -> error e.at "cannot infer type of subsumption"


and valid_exp ?(side = `Rhs) env e t =
  Debug.(log_at "il.valid_exp" e.at
    (fun _ -> fmt "%s :%s %s == %s" (il_exp e) (il_side side) (il_typ e.note) (il_typ t))
    (Fun.const "ok")
  ) @@ fun _ ->
try
  match e.it with
  | VarE id when id.it = "_" && side = `Lhs -> ()
  | VarE id ->
    let t' = Env.find_var env id in
    equiv_typ env t' t e.at
  | BoolE _ | NatE _ | TextE _ ->
    let t' = infer_exp env e in
    equiv_typ env t' t e.at
  | UnE (op, e1) ->
    let t1, t' = infer_unop op in
    valid_exp ~side env e1 (t1 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | BinE ((AddOp _ | SubOp _) as op, e1, ({it = NatE _; _} as e2))
  | BinE ((AddOp _ | SubOp _) as op, ({it = NatE _; _} as e1), e2) when side = `Lhs ->
    let t1, t2, t' = infer_binop op in
    valid_exp ~side env e1 (t1 $ e.at);
    valid_exp ~side env e2 (t2 $ e.at);
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
      | None -> try infer_exp env e1 with _ -> infer_exp env e2
    in
    let side' = if op = EqOp then `Lhs else `Rhs in (* HACK *)
    valid_exp ~side:side' env e1 t';
    valid_exp ~side:side' env e2 t';
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
    valid_list (valid_expfield ~side) env efs tfs e.at
  | DotE (e1, atom) ->
    let t1 = infer_exp env e1 in
    valid_exp env e1 t1;
    let tfs = as_struct_typ "expression" env Check t1 e1.at in
    let _binds, t', _prems = find_field tfs atom e1.at in
    equiv_typ env t' t e.at
  | CompE (e1, e2) ->
    let _ = as_comp_typ "expression" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | MemE (e1, e2) ->
    let t1 = infer_exp env e1 in
    valid_exp env e1 t1;
    valid_exp env e2 (IterT (t1, List) $ e2.at);
    equiv_typ env (BoolT $ e.at) t e.at
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
    if not (valid_tup_exp ~side env Subst.empty es ets) then
      as_error e.at "tuple" Check t ""
  | CallE (id, as_) ->
    let ps, t', _ = Env.find_def env id in
    let s = valid_args env as_ ps Subst.empty e.at in
    equiv_typ env (Subst.subst_typ s t') t e.at
  | IterE (e1, iterexp) ->
    let iter, env' = valid_iterexp ~side env iterexp e.at in
    let t1 = as_iter_typ iter "iteration" env Check t e.at in
    valid_exp ~side env' e1 t1
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let ets = as_tup_typ "expression" env Infer t1 e1.at in
    if i >= List.length ets then
      error e.at "invalid tuple projection";
    let side' = if List.length ets > 1 then `Rhs else side in
    valid_exp ~side:side' env e1 t1;
    (match proj_tup_typ env Subst.empty e1 ets i with
    | Some tI -> equiv_typ env tI t e.at
    | None -> error e.at "invalid tuple projection, cannot match pattern"
    )
  | UncaseE (e1, op) ->
    let t1 = infer_exp env e1 in
    valid_exp ~side env e1 t1;
    (match as_variant_typ "expression" env Infer t1 e1.at with
    | [(op', (_, t', _), _)] when Eq.eq_mixop op op' -> equiv_typ env t' t e.at
    | _ -> error e.at "invalid case projection";
    )
  | OptE eo ->
    let t1 = as_iter_typ Opt "option" env Check t e.at in
    Option.iter (fun e1 -> valid_exp ~side env e1 t1) eo
  | TheE e1 ->
    valid_exp ~side env e1 (IterT (t, Opt) $ e1.at)
  | ListE es ->
    let t1 = as_iter_typ List "list" env Check t e.at in
    List.iter (fun eI -> valid_exp ~side env eI t1) es
  | CatE (e1, ({it = ListE _ | CatE ({it = ListE _; _}, _); _} as e2))
  | CatE (({it = ListE _ | CatE ({it = ListE _; _}, _); _} as e1), e2) when side = `Lhs ->
    let _typ1 = as_iter_typ List "list" env Check t e.at in
    valid_exp ~side env e1 t;
    valid_exp ~side env e2 t
  | CatE (e1, e2) ->
    let _typ1 = as_iter_typ List "list" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | CaseE (op, e1) ->
    let cases = as_variant_typ "case" env Check t e.at in
    let _binds, t1, _prems = find_case cases op e1.at in
    valid_exp ~side env e1 t1
  | SubE (e1, t1, t2) ->
    valid_typ env t1;
    valid_typ env t2;
    valid_exp ~side env e1 t1;
    equiv_typ env t2 t e.at;
    sub_typ env t1 t2 e.at
with exn ->
  let bt = Printexc.get_raw_backtrace () in
  Printf.eprintf "[valid_exp] %s\n%!" (Debug.il_exp e);
  Printexc.raise_with_backtrace exn bt


and valid_expmix ?(side = `Rhs) env mixop e (mixop', t) at =
  if not (Eq.eq_mixop mixop mixop') then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_exp ~side env e t

and valid_tup_exp ?(side = `Rhs) env s es ets =
  Debug.(log_in "il.valid_tup_exp"
    (fun _ -> fmt "(%s) :%s (%s)[%s]" (list il_exp es) (il_side side) (list il_typ (List.map snd ets)) (il_subst s))
  );
  match es, ets with
  | e1::es', (e2, t)::ets' ->
    valid_exp ~side env e1 (Subst.subst_typ s t);
    (match Eval.match_exp env s e1 e2 with
    | Some s' -> valid_tup_exp ~side env s' es' ets'
    | None -> false
    | exception Eval.Irred -> false
    )
  | _, _ -> true

and valid_expfield ~side env (atom1, e) (atom2, (_binds, t, _prems), _) =
  if not (Eq.eq_atom atom1 atom2) then error e.at "unexpected record field";
  valid_exp ~side env e t

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

and valid_iterexp ?(side = `Rhs) env (iter, xes) at : iter * Env.t =
  let env' = valid_iter ~side env iter in
  if xes = [] && iter <= List1 && side = `Rhs then error at "empty iteration";
  let iter' = match iter with Opt -> Opt | _ -> List in
  iter',
  List.fold_left (fun env' (id, e) ->
    let t = infer_exp env e in
    valid_exp ~side env e t;
    let t1 = as_iter_typ iter' "iterator" env Check t e.at in
    Env.bind_var env' id t1
  ) env' xes


(* Grammars *)

and valid_sym env g : typ =
  Debug.(log_at "il.valid_sym" g.at (fun _ -> il_sym g) (fun t -> il_typ t)) @@ fun _ ->
  match g.it with
  | VarG (id, as_) ->
    let ps, t, _ = Env.find_gram env id in
    let s = valid_args env as_ ps Subst.empty g.at in
    Subst.subst_typ s t
  | NatG n ->
    if n < 0x00 || n > 0xff then
      error g.at "byte value out of range";
    NumT NatT $ g.at
  | TextG _ -> TextT $ g.at
  | EpsG -> TupT [] $ g.at
  | SeqG gs ->
    let _ts = List.map (valid_sym env) gs in
    TupT [] $ g.at
  | AltG gs ->
    let _ts = List.map (valid_sym env) gs in
    TupT [] $ g.at
  | RangeG (g1, g2) ->
    let t1 = valid_sym env g1 in
    let t2 = valid_sym env g2 in
    equiv_typ env t1 (NumT NatT $ g1.at) g.at;
    equiv_typ env t2 (NumT NatT $ g2.at) g.at;
    TupT [] $ g.at
  | IterG (g1, iterexp) ->
    let iter, env' = valid_iterexp ~side:`Lhs env iterexp g.at in
    let t1 = valid_sym env' g1 in
    IterT (t1, iter) $ g.at
  | AttrG (e, g1) ->
    let t1 = valid_sym env g1 in
    valid_exp ~side:`Lhs env e t1;
    t1


(* Premises *)

and valid_prem env prem =
  Debug.(log_in_at "il.valid_prem" prem.at (fun _ -> il_prem prem));
  match prem.it with
  | RulePr (id, mixop, e) ->
    let mixop', t, _rules = Env.find_rel env id in
    assert (Mixop.eq mixop mixop');
    valid_expmix env mixop e (mixop, t) e.at
  | IfPr e ->
    valid_exp env e (BoolT $ e.at)
  | LetPr (e1, e2, ids) ->
    let t = infer_exp env e2 in
    valid_exp ~side:`Lhs env e1 t;
    valid_exp env e2 t;
    let target_ids = Free.{empty with varid = Set.of_list ids} in
    let free_ids = Free.(free_exp e1) in
    if not (Free.subset target_ids free_ids) then
      error prem.at ("target identifier(s) " ^
        ( Free.Set.elements (Free.diff target_ids free_ids).varid |>
          List.map (fun id -> "`" ^ id ^ "`") |>
          String.concat ", " ) ^
        " do not occur in left-hand side expression")
  | ElsePr ->
    ()
  | IterPr (prem', iterexp) ->
    let _iter, env' = valid_iterexp env iterexp prem.at in
    valid_prem env' prem'


(* Definitions *)

and valid_arg env a p s =
  Debug.(log_at "il.valid_arg" a.at
    (fun _ -> fmt "%s : %s" (il_arg a) (il_param p)) (Fun.const "ok")
  ) @@ fun _ ->
  match a.it, (Subst.subst_param s p).it with
  | ExpA e, ExpP (id, t) -> valid_exp ~side:`Lhs env e t; Subst.add_varid s id e
  | TypA t, TypP id -> valid_typ env t; Subst.add_typid s id t
  | DefA id', DefP (id, ps, t) ->
    let ps', t', _ = Env.find_def env id' in
    if not (Eval.equiv_functyp env (ps', t') (ps, t)) then
      error a.at "type mismatch in function argument";
    Subst.add_defid s id id'
  | GramA g, GramP (id, t) ->
    let t' = valid_sym env g in
    if not (Eval.equiv_typ env t' t) then
      error a.at "type mismatch in grammar argument";
    Subst.add_gramid s id g
  | _, _ ->
    error a.at ("sort mismatch for argument, expected `" ^
      Print.string_of_param p ^ "`, got `" ^ Print.string_of_arg a ^ "`")

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

and valid_bind envr b =
  match b.it with
  | ExpB (id, t) ->
    valid_typ !envr t;
    envr := Env.bind_var !envr id t
  | TypB id ->
    envr := Env.bind_typ !envr id ([], [])
  | DefB (id, ps, t) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    envr := Env.bind_def !envr id (ps, t, [])
  | GramB (id, ps, t) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    envr := Env.bind_gram !envr id (ps, t, [])

and valid_param envr p =
  match p.it with
  | ExpP (id, t) ->
    valid_typ !envr t;
    envr := Env.bind_var !envr id t
  | TypP id ->
    envr := Env.bind_typ !envr id ([], [])
  | DefP (id, ps, t) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    envr := Env.bind_def !envr id (ps, t, [])
  | GramP (id, t) ->
    valid_typ !envr t;
    envr := Env.bind_gram !envr id ([], t, [])

let valid_inst envr ps inst =
  Debug.(log_in "il.valid_inst" line);
  Debug.(log_in_at "il.valid_inst" inst.at
    (fun _ -> fmt "(%s) = ..." (il_params ps))
  );
  match inst.it with
  | InstD (bs, as_, dt) ->
    let envr' = local_env envr in
    List.iter (valid_bind envr') bs;
    let _s = valid_args !envr' as_ ps Subst.empty inst.at in
    valid_deftyp envr' dt

let valid_rule envr mixop t rule =
  Debug.(log_in "il.valid_rule" line);
  Debug.(log_in_at "il.valid_rule" rule.at
    (fun _ -> fmt "%s : %s = ..." (il_mixop mixop) (il_typ t))
  );
  match rule.it with
  | RuleD (_id, bs, mixop', e, prems) ->
    let envr' = local_env envr in
    List.iter (valid_bind envr') bs;
    valid_expmix ~side:`Lhs !envr' mixop' e (mixop, t) e.at;
    List.iter (valid_prem !envr') prems

let valid_clause envr ps t clause =
  Debug.(log_in "il.valid_clause" line);
  Debug.(log_in_at "il.valid_clause" clause.at
    (fun _ -> fmt ": (%s) -> %s" (il_params ps) (il_typ t))
  );
  match clause.it with
  | DefD (bs, as_, e, prems) ->
    let envr' = local_env envr in
    List.iter (valid_bind envr') bs;
    let s = valid_args !envr' as_ ps Subst.empty clause.at in
    valid_exp !envr' e (Subst.subst_typ s t);
    List.iter (valid_prem !envr') prems

let valid_prod envr ps t prod =
  Debug.(log_in "il.valid_prod" line);
  Debug.(log_in_at "il.valid_prod" prod.at
    (fun _ -> fmt ": (%s) -> %s" (il_params ps) (il_typ t))
  );
  match prod.it with
  | ProdD (bs, g, e, prems) ->
    let envr' = local_env envr in
    List.iter (valid_bind envr') bs;
    let _t' = valid_sym !envr' g in
    valid_exp !envr' e t;
    List.iter (valid_prem !envr') prems

let infer_def envr d =
  match d.it with
  | TypD (id, ps, _insts) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    envr := Env.bind_typ !envr id (ps, [])
  | RelD (id, mixop, t, rules) ->
    valid_typcase envr (mixop, ([], t, []), []);
    envr := Env.bind_rel !envr id (mixop, t, rules)
  | DecD (id, ps, t, clauses) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    envr := Env.bind_def !envr id (ps, t, clauses)
  | GramD (id, ps, t, prods) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    envr := Env.bind_gram !envr id (ps, t, prods)
  | _ -> ()


let rec valid_def envr d =
  Debug.(log_in "il.valid_def" line);
  Debug.(log_in_at "il.valid_def" d.at (fun _ -> il_def d));
  match d.it with
  | TypD (id, ps, insts) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    List.iter (valid_inst envr ps) insts;
    envr := Env.bind_typ !envr id (ps, insts);
  | RelD (id, mixop, t, rules) ->
    valid_typcase envr (mixop, ([], t, []), []);
    List.iter (valid_rule envr mixop t) rules;
    envr := Env.bind_rel !envr id (mixop, t, rules)
  | DecD (id, ps, t, clauses) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    List.iter (valid_clause envr ps t) clauses;
    envr := Env.bind_def !envr id (ps, t, clauses)
  | GramD (id, ps, t, prods) ->
    let envr' = local_env envr in
    List.iter (valid_param envr') ps;
    valid_typ !envr' t;
    List.iter (valid_prod envr' ps t) prods;
    envr := Env.bind_gram !envr id (ps, t, prods)
  | RecD ds ->
    List.iter (infer_def envr) ds;
    List.iter (valid_def envr) ds;
    List.iter (fun d ->
      match (List.hd ds).it, d.it with
      | HintD _, _ | _, HintD _
      | TypD _, TypD _
      | RelD _, RelD _
      | DecD _, DecD _
      | GramD _, GramD _ -> ()
      | _, _ ->
        error (List.hd ds).at (" " ^ string_of_region d.at ^
          ": invalid recursion between definitions of different sort")
    ) ds
  | HintD _ ->
    ()


(* Scripts *)

let valid ds =
  let envr = ref Env.empty in
  List.iter (valid_def envr) ds
