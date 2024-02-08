open Util
open Source
open Ast
open Print


(* Errors *)

let error at msg = Source.error at "validation" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ * iter list
type typ_typ = param list * instance list
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

let to_eval_env env =
  let vars = Env.map (fun (t, _iters) -> t) env.vars in
  let typs = Env.map (fun (_ps, insts) -> insts) env.typs in
  let defs = Env.map (fun (_ps, _t, clauses) -> clauses) env.defs in
  Eval.{vars; typs; defs}

(* TODO
let fwd_deftyp id = NotationT ([[]; []], VarT (id $ no_region, []) $ no_region)
let fwd_deftyp_bad = fwd_deftyp "(undefined)" $ no_region
let fwd_deftyp_ok = fwd_deftyp "(forward)" $ no_region
*)

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
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fs with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_atom atom ^ "`")


let typ_string env t =
  let t' = Eval.reduce_typ (to_eval_env env) t in
  if Eq.eq_typ t t' then
    "`" ^ string_of_typ t ^ "`"
  else
    "`" ^ string_of_typ t ^ "` = `" ^ string_of_typ t' ^ "`"


(* Type Accessors *)

(* Returns None when args cannot be reduced enough to decide family instance. *)
let expand_app env id as_ : deftyp' option =
  (*
  Printf.eprintf "[il.expand_app] %s(%s)\n%!" id.it
    (String.concat "< " (List.map Print.string_of_arg as_));
  let dto' =
  *)
  let env' = to_eval_env env in
  let as_ = List.map (Eval.reduce_arg env') as_ in
  let _ps, insts = find "syntax type" env.typs id in
  let rec lookup = function
    | [] -> None  (* no match, cannot reduce *)
    | inst::insts' ->
      let InstD (_binds, as', dt) = inst.it in
      if as' = [] && as_ = [] then Some dt.it else   (* optimisation *)
      match Eval.(match_list match_arg env' Subst.empty as_ as') with
      | exception Eval.Irred -> None  (* cannot reduce *)
      | None -> lookup insts'
      | Some s -> Some (Subst.subst_deftyp s dt).it
  in lookup insts
  (*
  in
  Printf.eprintf "[il.expand_app] %s(%s) => %s\n%!" id.it
    (String.concat "< " (List.map Print.string_of_arg as_))
    (match dto' with None -> "-" | Some dt' -> string_of_deftyp (dt' $ id.at));
  dto'
  *)

let rec expand env t : typ' =
  match t.it with
  | VarT (id, as_) ->
    (match expand_app env id as_ with
    | Some (AliasT t1) -> expand env t1
    | _ -> t.it
    )
  | _ -> t.it

let expand_def env t : deftyp' =
  match expand env t with
  | VarT (id, as_) ->
    (match expand_app env id as_ with
    | Some dt' -> dt'
    | None -> AliasT t
    )
  | _ -> AliasT t


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
  match expand env t with
  | IterT (t1, iter2) when match_iter iter iter2 -> t1
  | _ -> as_error at phrase dir t ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir t at : typ =
  match expand env t with
  | IterT (t1, (List | List1 | ListN _)) -> t1
  | _ -> as_error at phrase dir t "(_)*"

let as_tup_typ phrase env dir t at : (id * typ) list =
  match expand env t with
  | TupT xts -> xts
  | _ -> as_error at phrase dir t "(_,...,_)"


let as_mix_typ phrase env dir t at : mixop * typ =
  match expand_def env t with
  | NotationT (mixop, t) -> mixop, t
  | _ -> as_error at phrase dir t ("`mixin-op`(...)")

let as_struct_typ phrase env dir t at : typfield list =
  match expand_def env t with
  | StructT tfs -> tfs
  | _ -> as_error at phrase dir t "{...}"

let as_variant_typ phrase env dir t at : typcase list =
  match expand_def env t with
  | VariantT tcs -> tcs
  | _ -> as_error at phrase dir t "| ..."


(* Type Equivalence and Subtyping *)

let equiv_typ env t1 t2 at =
  if not (Eval.equiv_typ (to_eval_env env) t1 t2) then
    error at ("expression's type `" ^ typ_string env t1 ^ "` " ^
      "does not match expected type `" ^ typ_string env t2 ^ "`")

and selfify_typ env e t =
  match expand env t with
  | TupT xts ->
    let s, _ =
      List.fold_left (fun (s, i) (xI, tI) ->
        Subst.add_varid s xI (ProjE (e, i) $$ e.at % Subst.subst_typ s tI), i + 1
      ) (Subst.empty, 0) xts
    in TupT (List.map (fun (xI, tI) -> xI, Subst.subst_typ s tI) xts) $ t.at
  | _ -> t

let sub_typ env t1 t2 at =
  if not (Eval.sub_typ (to_eval_env env) t1 t2) then
    error at ("expression's type `" ^ typ_string env t1 ^ "` " ^
      "does not match expected supertype `" ^ typ_string env t2 ^ "`")


(* Operators *)

let infer_unop = function
  | NotOp -> BoolT, BoolT
  | PlusOp t | MinusOp t -> NumT t, NumT t

let infer_binop = function
  | AndOp | OrOp | ImplOp | EquivOp -> BoolT, BoolT, BoolT
  | AddOp t | SubOp t | MulOp t | DivOp t -> NumT t, NumT t, NumT t
  | ExpOp t -> NumT t, NumT NatT, NumT t

let infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp t | GtOp t | LeOp t | GeOp t -> Some (NumT t)


(* Atom Bindings *)

let check_atoms phrase item list at =
  let _, dups =
    List.fold_right (fun (atom, _, _) (set, dups) ->
      let s = Print.string_of_atom atom in
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

and valid_typ env dim t =
  match t.it with
  | VarT (id, as_) ->
    let ps, _insts = find "syntax type" env.typs id in
(* TODO
    if dt = fwd_deftyp_bad then
      error t.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
*)
    ignore (valid_args env as_ ps Subst.empty t.at)
  | BoolT
  | NumT _
  | TextT ->
    ()
  | TupT xts ->
    let env' = local_env env in
    List.iter (valid_typbind env' dim) xts
  | IterT (t1, iter) ->
    match iter with
    | ListN (e, _) -> error e.at "definite iterator not allowed in type"
    | _ -> valid_iter env iter; valid_typ env (iter::dim) t1

and valid_typbind env dim (id, t) =
  valid_typ env dim t;
  env.vars <- bind "variable" env.vars id (t, dim)

and valid_deftyp env dt =
  (*
  Printf.eprintf "[il.valid_deftyp %s]\n%!" (string_of_region dt.at);
  *)
  match dt.it with
  | AliasT t ->
    valid_typ env [] t
  | NotationT (mixop, t) ->
    valid_typ_mix env mixop t dt.at
  | StructT tfs ->
    check_atoms "record" "field" tfs dt.at;
    List.iter (valid_typfield env) tfs
  | VariantT tcs ->
    check_atoms "variant" "case" tcs dt.at;
    List.iter (valid_typcase env) tcs

and valid_typ_mix env mixop t at =
  let arity =
    match t.it with
    | TupT ts -> List.length ts
    | _ -> 1
  in
  if List.length mixop <> arity + 1 then
    error at ("inconsistent arity in mixin notation, `" ^ string_of_mixop mixop ^
      "` applied to " ^ typ_string env t);
  valid_typ env [] t

and valid_typfield env (_atom, (binds, t, prems), _hints) =
  let env' = local_env env in
  valid_binds env' binds;
  valid_typ env' [] t;
  List.iter (valid_prem env') prems

and valid_typcase env (_atom, (binds, t, prems), _hints) =
  let env' = local_env env in
  valid_binds env' binds;
  valid_typ env' [] t;
  List.iter (valid_prem env') prems


(* Expressions *)

and infer_exp env e : typ =
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
  | TupE es -> TupT (List.map (fun e -> "_" $ e.at, infer_exp env e) es) $ e.at
  | CallE (id, as_) ->
    let ps, t, _ = find "function" env.defs id in
    let s = valid_args env as_ ps Subst.empty e.at in
    Subst.subst_typ s t
  | MixE _ -> error e.at "cannot infer type of mixin notation"
  | IterE (e1, iter) ->
    let iter' = match fst iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env e1, iter') $ e.at
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let xts = as_tup_typ "expression" env Infer (selfify_typ env e1 t1) e1.at in
    if i >= List.length xts then
      error e.at "invalid tuple projection";
    snd (List.nth xts i)
  | OptE _ -> error e.at "cannot infer type of option"
  | TheE e1 -> as_iter_typ Opt "option" env Check (infer_exp env e1) e1.at
  | ListE _ -> error e.at "cannot infer type of list"
  | CatE _ -> error e.at "cannot infer type of concatenation"
  | CaseE _ -> error e.at "cannot infer type of case constructor"
  | SubE _ -> error e.at "cannot infer type of subsumption"


and valid_exp env e t =
  (*
  Printf.eprintf "[il.valid_exp %s] %s  :  %s  ==  %s  {%s}\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ e.note) (string_of_typ t)
    (String.concat ", " (List.map (fun (x, (t, iters)) ->
      x ^ " : " ^ string_of_typ t ^ (String.concat "" (List.map string_of_iter iters))
    ) (Env.bindings env.vars)));
  (
  *)
  equiv_typ env e.note (selfify_typ env e t) e.at;
  match e.it with
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
    let xts = as_tup_typ "tuple" env Check t e.at in
    if List.length es <> List.length xts then
      error e.at ("arity mismatch for tuple, expected " ^
        string_of_int (List.length xts) ^ ", got " ^ string_of_int (List.length es));
    ignore (List.fold_left2 (valid_exptup env) Subst.empty es xts)
  | CallE (id, as_) ->
    let ps, t', _ = find "function" env.defs id in
    let s = valid_args env as_ ps Subst.empty e.at in
    equiv_typ env (Subst.subst_typ s t') t e.at
  | MixE (op, e) ->
    let tmix = as_mix_typ "mixin notation" env Check t e.at in
    valid_expmix env op e tmix e.at
  | IterE (e1, iter) ->
    let env' = valid_iterexp env iter in
    let t1 = as_iter_typ (fst iter) "iteration" env Check t e.at in
    valid_exp env' e1 t1
  | ProjE (e1, i) ->
    let t1 = infer_exp env e1 in
    let xts = as_tup_typ "expression" env Infer (selfify_typ env e1 t1) e1.at in
    if i >= List.length xts then
      error e.at "invalid tuple projection";
    equiv_typ env (snd (List.nth xts i)) t e.at
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
  | CaseE (atom, e1) ->
    let cases = as_variant_typ "case" env Check t e.at in
    let _binds, t1, _prems = find_case cases atom e1.at in
    valid_exp env e1 t1
  | SubE (e1, t1, t2) ->
    valid_typ env [] t1;
    valid_typ env [] t2;
    valid_exp env e1 t1;
    equiv_typ env t2 t e.at;
    sub_typ env t1 t2 e.at
  (*
  );
  Printf.eprintf "[il.valid_exp %s] done\n%!" (string_of_region e.at);
  *)


and valid_expmix env mixop e (mixop', t) at =
  if mixop <> mixop' then
    error at (
      "mixin notation `" ^ string_of_mixop mixop ^
      "` does not match expected notation `" ^ string_of_mixop mixop' ^ "`"
    );
  valid_exp env e t

and valid_exptup env s e (id, t) : Subst.t =
  valid_exp env e (Subst.subst_typ s t);
  Subst.add_varid s id e

and valid_expfield env (atom1, e) (atom2, (_binds, t, _prems), _) =
  if atom1 <> atom2 then error e.at "unexpected record field";
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
      let _binds, t, _prems = find_field tfs atom p1.at in
      t
  in
  equiv_typ env p.note t' p.at;
  t'

and valid_iterexp env (iter, ids) : env =
  valid_iter env iter;
  let iter' =
    match iter with
    | ListN (e, Some _) -> ListN (e, None)
    | iter -> iter
  in
  List.fold_left (fun env id ->
    match find "variable" env.vars id with
    | t, iter1::iters
      when Eq.eq_iter (snd (Lib.List.split_last (iter1::iters))) iter' ->
      {env with vars =
        Env.add id.it (t, fst (Lib.List.split_last (iter1::iters))) env.vars}
    | _, iters ->
      error id.at ("iteration variable `" ^ id.it ^
        "` has incompatible dimension `" ^ id.it ^
        String.concat "" (List.map string_of_iter iters) ^
        "` in iteration `_" ^ string_of_iter iter' ^ "`")
  ) env ids


(* Premises *)

and valid_prem env prem =
  match prem.it with
  | RulePr (id, mixop, e) ->
    valid_expmix env mixop e (find "relation" env.rels id) e.at
  | IfPr e ->
    valid_exp env e (BoolT $ e.at)
  | LetPr (e1, e2, ids) ->
    valid_exp env (CmpE (EqOp, e1, e2) $$ prem.at % (BoolT $ prem.at))  (BoolT $ prem.at);
    let target_ids = Free.Set.of_list (List.map it ids) in
    let free_ids = (Free.free_exp e1).varid in
    let diff_ids = Free.Set.diff target_ids free_ids in
    if diff_ids <> Free.Set.empty then
      error prem.at ("target identifier(s) " ^
        ( Free.Set.elements diff_ids |>
          List.map (fun id -> "`" ^ id ^ "`") |>
          String.concat ", " ) ^
        " not contained in left-hand side expression")
  | ElsePr ->
    ()
  | IterPr (prem', iter) ->
    let env' = valid_iterexp env iter in
    valid_prem env' prem'


(* Definitions *)

and valid_binds env binds =
  List.iter (fun (id, t, dim) ->
(*TODO
    valid_typ env dim t;
*)
    env.vars <- bind "variable" env.vars id (t, dim)
  ) binds

and valid_arg env a p s =
  (*
  Printf.eprintf "[il.valid_arg %s]\n%!" (string_of_region a.at);
  *)
  match a.it, p.it with
  | ExpA e, ExpP (id, t) -> valid_exp env e (Subst.subst_typ s t); Subst.add_varid s id e
  | TypA t, TypP id -> valid_typ env [] t; Subst.add_typid s id t
  | _, _ -> error a.at "sort mismatch for argument"

and valid_args env as_ ps s at : Subst.t =
  (*
  if as_ <> [] || ps <> [] then
  Printf.eprintf "[il.valid_args] (%s)  :  (%s)\n%!"
    (String.concat ", " (List.map Print.string_of_arg as_))
    (String.concat ", " (List.map Print.string_of_param ps));
  *)
  match as_, ps with
  | [], [] -> s
  | a::_, [] -> error a.at "too many arguments"
  | [], _::_ -> error at "too few arguments"
  | a::as', p::ps' ->
    let s' = valid_arg env a p s in
    valid_args env as' ps' s' at

let valid_param env p =
  match p.it with
  | ExpP (id, t) ->
    valid_typ env [] t;
    env.vars <- bind "variable" env.vars id (t, [])
  | TypP id ->
    env.typs <- bind "syntax" env.typs id ([], [])

let valid_instance env ps inst =
  (*
  Printf.eprintf "[il.valid_inst %s]\n%!" (string_of_region inst.at);
  *)
  match inst.it with
  | InstD (binds, as_, dt) ->
    let env' = local_env env in
    valid_binds env' binds;
    let _s = valid_args env' as_ ps Subst.empty inst.at in
    valid_deftyp env' dt

let valid_rule env mixop t rule =
  (*
  Printf.eprintf "[il.valid_rule %s] %s  :  %s%s\n%!"
    (string_of_region rule.at) (string_of_rule rule)
    (string_of_mixop mixop) (string_of_typ t);
  *)
  match rule.it with
  | RuleD (_id, binds, mixop', e, prems) ->
    let env' = local_env env in
    valid_binds env' binds;
    valid_expmix env' mixop' e (mixop, t) e.at;
    List.iter (valid_prem env') prems

let valid_clause env ps t clause =
  (*
  Printf.eprintf "[il.valid_clause %s] %s  :  (%s) -> %s\n%!"
    (string_of_region clause.at) (string_of_clause ("" $ no_region) clause)
    (String.concat ", " (List.map string_of_param ps))
    (string_of_typ t);
  *)
  match clause.it with
  | DefD (binds, as_, e, prems) ->
    let env' = local_env env in
    valid_binds env' binds;
    let s = valid_args env' as_ ps Subst.empty clause.at in
    valid_exp env' e (Subst.subst_typ s t);
    List.iter (valid_prem env') prems
(*
    let free_rh =
      Free.(Set.diff (Set.diff (free_exp e2).varid
        (free_exp e1).varid) (free_list free_prem prems).varid)
    in
    if free_rh <> Free.Set.empty then
      error clause.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free_rh) ^ "`")
*)

let infer_def env d =
  match d.it with
  | TypD (id, ps, _insts) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
(* TODO
    let fwd_deftyp =
      match dt.it with NotationT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax type" env.typs id (ps, fwd_deftyp)
*)
    env.typs <- bind "syntax type" env.typs id (ps, [])
  | RelD (id, mixop, t, _rules) ->
    valid_typ_mix env mixop t d.at;
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, ps, t, clauses) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    valid_typ env' [] t;
    env.defs <- bind "function" env.defs id (ps, t, clauses)
  | _ -> ()


type bind = {bind : 'a. string -> 'a Env.t -> id -> 'a -> 'a Env.t}

let rec valid_def {bind} env d =
  (*
  Printf.eprintf "[il.valid_def %s] %s\n%!" (string_of_region d.at) (Print.string_of_def d);
  *)
  match d.it with
  | TypD (id, ps, insts) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    List.iter (valid_instance env ps) insts;
    env.typs <- bind "syntax type" env.typs id (ps, insts);
  | RelD (id, mixop, t, rules) ->
    valid_typ_mix env mixop t d.at;
    List.iter (valid_rule env mixop t) rules;
    env.rels <- bind "relation" env.rels id (mixop, t)
  | DecD (id, ps, t, clauses) ->
    let env' = local_env env in
    List.iter (valid_param env') ps;
    valid_typ env' [] t;
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
