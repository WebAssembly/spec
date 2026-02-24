open Util
open Source
open Ast
open Xl
open Print


(* Errors *)

let error at msg = Error.error at "validation" msg


(* Environment *)

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

let as_iter_typ iter phrase env dir t at : typ =
  match expand_typ env t with
  | IterT (t1, iter2) when iter = iter2 -> t1
  | _ -> as_error at phrase dir t ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir t at : typ =
  match expand_typ env t with
  | IterT (t1, (List | List1 | ListN _)) -> t1
  | _ -> as_error at phrase dir t "(_)*"

let as_tup_typ phrase env dir t at : (id * typ) list =
  match expand_typ env t with
  | TupT xts -> xts
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
    List.iter (fun (_, (t, _, _), _) -> as_comp_typ phrase env dir t at) tfs
  | _ ->
    error at (phrase ^ "'s type `" ^ string_of_typ t ^ "` is not composable")

let proj_tup_typ i xts e at =
  let rec loop i xts s =
    match i, xts with
    | _, [] -> error at "invalid tuple projection"
    | 0, (_, tI)::_ -> Subst.subst_typ s tI
    | i, (xI, tI)::xts' ->
      let eI = ProjE (e, i) $$ at % Subst.subst_typ s tI in
      loop (i - 1) xts' (Subst.add_varid s xI eI)
 in loop i xts Subst.empty


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

let infer_unop at op ot =
  match op, ot with
  | #Bool.unop, #Bool.typ -> BoolT, BoolT
  | #Num.unop as op, (#Num.typ as nt) ->
    if not (Num.typ_unop op nt nt) then
      error at ("illegal type " ^ string_of_numtyp nt ^ " for unary operator");
    NumT nt, NumT nt
  | _, _ ->
    error at ("malformed unary operator annotation")

let infer_binop at op ot =
  match op, ot with
  | #Bool.binop, #Bool.typ -> BoolT, BoolT, BoolT
  | #Num.binop as op, (#Num.typ as nt) ->
    let nt1, nt2, nt3 =
      match op with
      | `AddOp | `SubOp | `MulOp | `DivOp | `ModOp -> nt, nt, nt
      | `PowOp -> nt, (if nt = `NatT then `NatT else `IntT), nt
    in
    if not (Num.typ_binop op nt1 nt2 nt3) then
      error at ("illegal type " ^ string_of_numtyp nt ^ " for unary operator");
    NumT nt1, NumT nt2, NumT nt3
  | _, _ ->
    error at ("malformed binary operator annotation")

let infer_cmpop at op ot =
  match op, ot with
  | #Bool.cmpop, #Bool.typ -> None
  | #Num.cmpop, (#Num.typ as nt) -> Some (NumT nt)
  | _, _ -> error at ("malformed comparison operator annotation")


(* Atoms and Mixops *)

let valid_atom _env atom =
  if atom.note.Atom.def = "" then
    error atom.at ("missing definition name for atom " ^ Atom.to_string atom)

let valid_mixop env mixop =
  Mixop.iter_atoms (valid_atom env) mixop


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

let rec valid_binders valid_x env xs : Env.t =
  match xs with
  | [] -> env
  | x::xs -> valid_binders valid_x (valid_x env x) xs

let rec valid_iter ?(side = `Rhs) env iter : Env.t =
  match iter with
  | Opt | List | List1 -> env
  | ListN (e, id_opt) ->
    valid_exp ~side env e (NumT `NatT $ e.at);
    Option.fold id_opt ~none:env ~some:(fun id ->
      Env.bind_var env id (NumT `NatT $ e.at)
    )

and valid_iterexp ?(side = `Rhs) env (it, xes) at : iter * Env.t =
  Debug.(log_at "il.valid_iterexp" at
    (fun _ -> il_iter it)
    (fun (it', _) -> il_iter it')
  ) @@ fun _ ->
  let env' = valid_iter ~side env it in
  if xes = [] && it <= List1 && side = `Rhs then error at "empty iteration";
  let it' = match it with Opt -> Opt | _ -> List in
  it',
  List.fold_left (fun env' (x, e) ->
    let t = infer_exp env e in
    valid_exp ~side env e t;
    let t1 = as_iter_typ it' "iterator" env Check t e.at in
    Env.bind_var env' x t1
  ) env' xes


(* Types *)

and valid_typ env t = ignore (valid_typ_bind env t)

and valid_typ_bind env t : Env.t =
  Debug.(log_at "il.valid_typ" t.at
    (fun _ -> fmt "%s" (il_typ t)) (Fun.const "ok")
  ) @@ fun _ ->
  match t.it with
  | VarT (id, as_) ->
    let ps, _insts = Env.find_typ env id in
    ignore (valid_args env as_ ps Subst.empty t.at);
    env
  | BoolT
  | NumT _
  | TextT ->
    env
  | TupT [] ->
    env
  | TupT ((x1, t1)::xts) ->
    valid_typ env t1;
    valid_typ_bind (Env.bind_var env x1 t1) (TupT xts $ t.at)
  | IterT (t1, iter) ->
    match iter with
    | ListN (e, _) -> error e.at "definite iterator not allowed in type"
    | _ ->
      let env' = valid_iter env iter in
      valid_typ env' t1;
      env

and valid_deftyp env dt =
  match dt.it with
  | AliasT t ->
    valid_typ env t
  | StructT tfs ->
    check_mixops "record" "field" (List.map (fun (atom, _, _) -> Mixop.Atom atom) tfs) dt.at;
    List.iter (valid_typfield env) tfs
  | VariantT tcs ->
    check_mixops "variant" "case" (List.map (fun (op, _, _) -> op) tcs) dt.at;
    List.iter (valid_typcase env) tcs

and valid_typfield env (atom, (t, qs, prems), _hints) =
  valid_atom env atom;
  let env' = valid_typ_bind env t in
  let env'' = valid_quants env' qs in
  List.iter (valid_prem env'') prems

and valid_typcase env (mixop, (t, qs, prems), _hints) =
  Debug.(log_at "il.valid_typcase" t.at
    (fun _ -> fmt "%s" (il_typ t))
    (fun _ -> "ok")
  ) @@ fun _ ->
  let arity =
    match t.it with
    | TupT ts -> List.length ts
    | _ -> 1
  in
  if Mixop.arity mixop <> arity then
    error t.at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ typ_string env t);
  valid_mixop env mixop;
  let env' = valid_typ_bind env t in
  let env'' = valid_quants env' qs in
  List.iter (valid_prem env'') prems


(* Expressions *)

and infer_exp (env : Env.t) e : typ =
  Debug.(log_at "il.infer_exp" e.at
    (fun _ -> fmt "%s : %s" (il_exp e) (il_typ e.note))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match e.it with
  | VarE x -> Env.find_var env x
  | BoolE _ -> BoolT $ e.at
  | NumE n -> NumT (Num.to_typ n) $ e.at
  | TextE _ -> TextT $ e.at
  | UnE (op, ot, _) -> let _t1, t' = infer_unop e.at op ot in t' $ e.at
  | BinE (op, ot, _, _) -> let _t1, _t2, t' = infer_binop e.at op ot in t' $ e.at
  | CmpE _ | MemE _ -> BoolT $ e.at
  | IdxE (e1, _) -> as_list_typ "expression" env Infer (infer_exp env e1) e1.at
  | SliceE (e1, _, _)
  | UpdE (e1, _, _)
  | ExtE (e1, _, _)
  | CompE (e1, _) -> infer_exp env e1
  | StrE _ -> error e.at "cannot infer type of record"
  | DotE (e1, atom) ->
    let tfs = as_struct_typ "expression" env Infer (infer_exp env e1) e1.at in
    let t, _qs, _prems = find_field tfs atom e1.at in
    t
  | TupE es ->
    TupT (List.map (fun eI -> "_" $ eI.at, infer_exp env eI) es) $ e.at
  | CallE (x, as_) ->
    let ps, t, _ = Env.find_def env x in
    let s = valid_args env as_ ps Subst.empty e.at in
    Subst.subst_typ s t
  | IterE (e1, ite) ->
    let it, env' = valid_iterexp env ite e.at in
    IterT (infer_exp env' e1, it) $ e.at
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let xts = as_tup_typ "expression" env Infer t1 e1.at in
    proj_tup_typ i xts e1 e.at
  | UncaseE (e1, op) ->
    let t1 = infer_exp env e1 in
    (match as_variant_typ "expression" env Infer t1 e1.at with
    | [(op', (t, _, _), _)] when Eq.eq_mixop op op' -> t
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
  | LiftE e1 ->
    let t1 = as_iter_typ Opt "lifting" env Check (infer_exp env e1) e1.at in
    IterT (t1, List) $ e.at
  | LenE _ -> NumT `NatT $ e.at
  | CatE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t2 = infer_exp env e2 in
    if Eq.eq_typ t1 t2 then
      t1
    else
      error e.at "cannot infer type of concatenation"
  | CaseE _ -> e.note (* error e.at "cannot infer type of case constructor" *)
  | CvtE (_, _, t2) -> NumT t2 $ e.at
  | SubE (_, _, t2) -> t2


and valid_exp ?(side = `Rhs) env e t =
  Debug.(log_at "il.valid_exp" e.at
    (fun _ -> fmt "%s :%s %s == %s" (il_exp e) (il_side side) (il_typ e.note) (il_typ t))
    (Fun.const "ok")
  ) @@ fun _ ->
  valid_typ env t;
  match e.it with
  | VarE x when x.it = "_" && side = `Lhs -> ()
  | VarE x ->
    let t' = Env.find_var env x in
    equiv_typ env t' t e.at
  | BoolE _ | NumE _ | TextE _ ->
    let t' = infer_exp env e in
    equiv_typ env t' t e.at
  | UnE (op, nt, e1) ->
    let t1, t' = infer_unop e.at op nt in
    valid_exp ~side env e1 (t1 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | BinE ((`AddOp | `SubOp) as op, nt, e1, ({it = NumE (`Nat _); _} as e2))
  | BinE ((`AddOp | `SubOp) as op, nt, ({it = NumE (`Nat _); _} as e1), e2) when side = `Lhs ->
    let t1, t2, t' = infer_binop e.at op nt in
    valid_exp ~side env e1 (t1 $ e.at);
    valid_exp ~side env e2 (t2 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | BinE (op, nt, e1, e2) ->
    let t1, t2, t' = infer_binop e.at op nt in
    valid_exp env e1 (t1 $ e.at);
    valid_exp env e2 (t2 $ e.at);
    equiv_typ env (t' $ e.at) t e.at
  | CmpE (op, nt, e1, e2) ->
    let t' =
      match infer_cmpop e.at op nt with
      | Some t' -> t' $ e.at
      | None -> try infer_exp env e1 with _ -> infer_exp env e2
    in
    let side' = if op = `EqOp then `Lhs else `Rhs in (* HACK *)
    valid_exp ~side:side' env e1 t';
    valid_exp ~side:side' env e2 t';
    equiv_typ env (BoolT $ e.at) t e.at
  | IdxE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t' = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    valid_exp env e2 (NumT `NatT $ e2.at);
    equiv_typ env t' t e.at
  | SliceE (e1, e2, e3) ->
    let _typ' = as_list_typ "expression" env Check t e1.at in
    valid_exp env e1 t;
    valid_exp env e2 (NumT `NatT $ e2.at);
    valid_exp env e3 (NumT `NatT $ e3.at)
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
    valid_atom env atom;
    let tfs = as_struct_typ "expression" env Check t1 e1.at in
    let t', _qs, _prems = find_field tfs atom e1.at in
    equiv_typ env t' t e.at
  | CompE (e1, e2) ->
    let _ = as_comp_typ "expression" env Check t e.at in
    valid_exp env e1 t;
    valid_exp env e2 t
  | MemE (e1, e2) ->
    let t2 = infer_exp env e2 in
    let t1 = as_list_typ "expression" env Check t2 e2.at in
    valid_exp env e1 t1;
    valid_exp env e2 t2;
    equiv_typ env (BoolT $ e.at) t e.at
  | LenE e1 ->
    let t1 = infer_exp env e1 in
    let _typ11 = as_list_typ "expression" env Infer t1 e1.at in
    valid_exp env e1 t1;
    equiv_typ env (NumT `NatT $ e.at) t e.at
  | TupE es ->
    let xts = as_tup_typ "tuple" env Check t e.at in
    let rec loop i es xts s =
      match es, xts with
      | [], [] -> ()
      | eI::es', (xI, tI)::xts' ->
        valid_exp ~side env eI (Subst.subst_typ s tI);
        let s' = Subst.add_varid s xI eI in
        loop (i + 1) es' xts' s'
      | _, _ ->
        error e.at ("arity mismatch for tuple, expected " ^
          string_of_int (i + List.length xts) ^ ", got " ^
          string_of_int (i + List.length es));
    in loop 0 es xts Subst.empty
  | CallE (x, as_) ->
    let ps, t', _ = Env.find_def env x in
    let s = valid_args env as_ ps Subst.empty e.at in
    equiv_typ env (Subst.subst_typ s t') t e.at
  | IterE (e1, ite) ->
    let it, env' = valid_iterexp ~side env ite e.at in
    let t1 = as_iter_typ it "iteration" env Check t e.at in
    valid_exp ~side env' e1 t1
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let xts = as_tup_typ "expression" env Infer t1 e1.at in
    let side' = if List.length xts > 1 then `Rhs else side in
    valid_exp ~side:side' env e1 (TupT xts $ t1.at);
    equiv_typ env (proj_tup_typ i xts e1 e.at) t e.at
  | UncaseE (e1, op) ->
    let t1 = infer_exp env e1 in
    valid_exp ~side env e1 t1;
    valid_mixop env op;
    (match as_variant_typ "expression" env Infer t1 e1.at with
    | [(op', (t', _, _), _)] when Eq.eq_mixop op op' ->
      equiv_typ env t' t e.at
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
  | LiftE e1 ->
    let t1 = as_iter_typ List "lifting" env Check t e.at in
    valid_exp ~side env e1 (IterT (t1, Opt) $ e1.at)
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
    let t1, _qs, _prems = find_case cases op e1.at in
    valid_mixop env op;
    valid_exp ~side env e1 t1
  | CvtE (e1, nt1, nt2) ->
    valid_exp ~side env e1 (NumT nt1 $ e1.at);
    equiv_typ env (NumT nt2 $e.at) t e.at;
  | SubE (e1, t1, t2) ->
    valid_typ env t1;
    valid_typ env t2;
    valid_exp ~side env e1 t1;
    equiv_typ env t2 t e.at;
    sub_typ env t1 t2 e.at


and valid_expmix ?(side = `Rhs) env mixop e (mixop', t) at =
  if not (Eq.eq_mixop mixop mixop') then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_mixop env mixop;
  valid_exp ~side env e t

and valid_expfield ~side env (atom1, e) (atom2, (t, _qs, _prems), _) =
  Debug.(log_in_at "il.valid_expfield" e.at
    (fun _ -> fmt "%s %s :%s %s %s"
      (il_atom atom1) (il_exp e) (il_side side)
      (il_atom atom2) (il_typ t)
    )
  );
  if not (Eq.eq_atom atom1 atom2) then error e.at "unexpected record field";
  valid_atom env atom1;
  valid_exp ~side env e t

and valid_path env p t : typ =
  valid_typ env t;
  let t' =
    match p.it with
    | RootP -> t
    | IdxP (p1, e1) ->
      let t1 = valid_path env p1 t in
      valid_exp env e1 (NumT `NatT $ e1.at);
      as_list_typ "path" env Check t1 p1.at
    | SliceP (p1, e1, e2) ->
      let t1 = valid_path env p1 t in
      valid_exp env e1 (NumT `NatT $ e1.at);
      valid_exp env e2 (NumT `NatT $ e2.at);
      let _ = as_list_typ "path" env Check t1 p1.at in
      t1
    | DotP (p1, atom) ->
      let t1 = valid_path env p1 t in
      valid_atom env atom;
      let tfs = as_struct_typ "path" env Check t1 p1.at in
      let t, _qs, _prems = find_field tfs atom p1.at in
      t
  in
  equiv_typ env p.note t' p.at;
  t'


(* Grammars *)

and valid_sym env g : typ =
  Debug.(log_at "il.valid_sym" g.at (fun _ -> il_sym g) (fun t -> il_typ t)) @@ fun _ ->
  match g.it with
  | VarG (x, as_) ->
    let ps, t, _ = Env.find_gram env x in
    let s = valid_args env as_ ps Subst.empty g.at in
    Subst.subst_typ s t
  | NumG _ ->
(*
    if n < 0x00 || n > 0xff then
      error g.at "byte value out of range";
*)
    NumT `NatT $ g.at
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
    equiv_typ env t1 (NumT `NatT $ g1.at) g.at;
    equiv_typ env t2 (NumT `NatT $ g2.at) g.at;
    NumT `NatT $ g.at
  | IterG (g1, ite) ->
    let it, env' = valid_iterexp ~side:`Lhs env ite g.at in
    let t1 = valid_sym env' g1 in
    IterT (t1, it) $ g.at
  | AttrG (e, g1) ->
    let t1 = valid_sym env g1 in
    valid_exp ~side:`Lhs env e t1;
    t1


(* Premises *)

and valid_prem env prem =
  Debug.(log_in_at "il.valid_prem" prem.at (fun _ -> il_prem prem));
  match prem.it with
  | RulePr (x, as_, mixop, e) ->
    let ps, mixop', t, _rules = Env.find_rel env x in
    assert (Mixop.eq mixop mixop');
    let s = valid_args env as_ ps Subst.empty prem.at in
    valid_expmix env mixop e (mixop, Subst.subst_typ s t) e.at
  | IfPr e ->
    valid_exp env e (BoolT $ e.at)
  | LetPr (e1, e2, xs) ->
    let t = infer_exp env e2 in
    valid_exp ~side:`Lhs env e1 t;
    valid_exp env e2 t;
    let target_ids = Free.{empty with varid = Set.of_list xs} in
    let free_ids = Free.(free_exp e1) in
    if not (Free.subset target_ids free_ids) then
      error prem.at ("target identifier(s) " ^
        ( Free.Set.elements (Free.diff target_ids free_ids).varid |>
          List.map (fun x -> "`" ^ x ^ "`") |>
          String.concat ", " ) ^
        " do not occur in left-hand side expression")
  | ElsePr ->
    ()
  | IterPr (prem', ite) ->
    let _it, env' = valid_iterexp env ite prem.at in
    valid_prem env' prem'


(* Definitions *)

and valid_arg env a p s =
  Debug.(log_at "il.valid_arg" a.at
    (fun _ -> fmt "%s : %s" (il_arg a) (il_param p)) (Fun.const "ok")
  ) @@ fun _ ->
  match a.it, (Subst.subst_param s p).it with
  | ExpA e, ExpP (x, t) ->
    valid_exp ~side:`Lhs env e t; Subst.add_varid s x e
  | TypA t, TypP x -> valid_typ env t; Subst.add_typid s x t
  | DefA x', DefP (x, ps, t) ->
    let ps', t', _ = Env.find_def env x' in
    if not (Eval.equiv_functyp env (ps', t') (ps, t)) then
      error a.at "type mismatch in function argument";
    Subst.add_defid s x x'
  | GramA g, GramP (x, [], t) ->
    let t' = valid_sym env g in
    equiv_typ env t' t a.at;
    Subst.add_gramid s x g
  | GramA ({it = VarG (x', as'); _} as g), GramP (x, ps, t) ->
    let ps', t', _ = Env.find_gram env x' in
    if as' <> [] || not (Eval.equiv_functyp env (ps', t') (ps, t)) then
      error a.at "type mismatch in grammar argument";
    Subst.add_gramid s x g
  | _, _ ->
    error a.at ("sort mismatch for argument, expected `" ^
      Print.string_of_param p ^ "`, got `" ^ Print.string_of_arg a ^ "`")

and valid_args env as_ ps s at : Subst.t =
  Debug.(log_if "il.valid_args" (as_ <> [] || ps <> [])
    (fun _ -> fmt "{%s} : {%s}" (il_args as_) (il_params ps)) (Fun.const "ok")
  ) @@ fun _ ->
  match as_, ps with
  | [], [] -> s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as', p::ps' ->
    let s' = valid_arg env a p s in
    valid_args env as' ps' s' at

and valid_param env p : Env.t =
  match p.it with
  | ExpP (x, t) ->
    valid_typ env t;
    Env.bind_var env x t
  | TypP x ->
    Env.bind_typ env x ([], [])
  | DefP (x, ps, t) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    Env.bind_def env x (ps, t, [])
  | GramP (x, ps, t) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    Env.bind_gram env x (ps, t, [])

and valid_quant env q = valid_param env q

and valid_params env ps = valid_binders valid_param env ps
and valid_quants env qs = valid_binders valid_quant env qs

let valid_inst env ps inst =
  Debug.(log_in "il.valid_inst" line);
  Debug.(log_in_at "il.valid_inst" inst.at
    (fun _ -> fmt "(%s) = ..." (il_params ps))
  );
  match inst.it with
  | InstD (qs, as_, dt) ->
    let env' = valid_quants env qs in
    let _s = valid_args env' as_ ps Subst.empty inst.at in
    valid_deftyp env' dt

let valid_rule env mixop t rule =
  Debug.(log_in "il.valid_rule" line);
  Debug.(log_in_at "il.valid_rule" rule.at
    (fun _ -> fmt "%s : %s = ..." (il_mixop mixop) (il_typ t))
  );
  match rule.it with
  | RuleD (_x, qs, mixop', e, prems) ->
    let env' = valid_quants env qs in
    valid_expmix ~side:`Lhs env' mixop' e (mixop, t) e.at;
    List.iter (valid_prem env') prems

let valid_clause env x ps t clause =
  Debug.(log_in "il.valid_clause" line);
  Debug.(log_in_at "il.valid_clause" clause.at
    (fun _ -> fmt "%s : (%s) -> %s" (il_id x) (il_params ps) (il_typ t))
  );
  match clause.it with
  | DefD (qs, as_, e, prems) ->
    let env' = valid_quants env qs in
    let s = valid_args env' as_ ps Subst.empty clause.at in
    valid_exp env' e (Subst.subst_typ s t);
    List.iter (valid_prem env') prems

let valid_prod env ps t prod =
  Debug.(log_in "il.valid_prod" line);
  Debug.(log_in_at "il.valid_prod" prod.at
    (fun _ -> fmt ": (%s) -> %s" (il_params ps) (il_typ t))
  );
  match prod.it with
  | ProdD (qs, g, e, prems) ->
    let env' = valid_quants env qs in
    let _t' = valid_sym env' g in
    valid_exp env' e t;
    List.iter (valid_prem env') prems

let infer_def env d : Env.t =
  match d.it with
  | TypD (x, ps, _insts) ->
    let _env' = valid_params env ps in
    Env.bind_typ env x (ps, [])
  | RelD (x, ps, mixop, t, rules) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    Env.bind_rel env x (ps, mixop, t, rules)
  | DecD (x, ps, t, clauses) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    Env.bind_def env x (ps, t, clauses)
  | GramD (x, ps, t, prods) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    Env.bind_gram env x (ps, t, prods)
  | _ -> env


let rec valid_def env d : Env.t =
  Debug.(log_in "il.valid_def" line);
  Debug.(log_in_at "il.valid_def" d.at (fun _ -> il_def d));
  match d.it with
  | TypD (x, ps, insts) ->
    let env' = valid_params env ps in
    List.iter (valid_inst env' ps) insts;
    Env.bind_typ env x (ps, insts);
  | RelD (x, ps, mixop, t, rules) ->
    let env' = valid_params env ps in
    valid_typcase env' (mixop, (t, [], []), []);
    List.iter (valid_rule env' mixop t) rules;
    Env.bind_rel env x (ps, mixop, t, rules)
  | DecD (x, ps, t, clauses) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    List.iter (valid_clause env' x ps t) clauses;
    Env.bind_def env x (ps, t, clauses)
  | GramD (x, ps, t, prods) ->
    let env' = valid_params env ps in
    valid_typ env' t;
    List.iter (valid_prod env' ps t) prods;
    Env.bind_gram env x (ps, t, prods)
  | RecD ds ->
    let env' = valid_binders infer_def env ds in
    let env' = valid_binders valid_def env' ds in
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
    ) ds;
    env'
  | HintD _ ->
    env


(* Scripts *)

let valid ds =
  ignore (valid_binders valid_def Env.empty ds)
