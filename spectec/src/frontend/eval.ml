open Util
open Source
open El
open Ast


(* Environment *)

module Map = Map.Make(String)

type typ_def = (arg list * typ) list
type def_def = (arg list * exp * premise list) list
type gram_def = unit
type env = {vars : typ Map.t; typs : typ_def Map.t; defs : def_def Map.t; syms : gram_def Map.t}
type subst = Subst.t


(* Helpers *)

exception Irred

let (let*) = Option.bind


(* Matching Lists *)

let rec match_list match_x env s xs1 xs2 : subst option =
  match xs1, xs2 with
  | [], [] -> Some s
  | x1::xs1', x2::xs2' ->
    let* s' = match_x env s x1 x2 in
    match_list match_x env s' xs1' xs2'
  | _, _ -> None

let match_nl_list match_x env s xs1 xs2 =
  match_list match_x env s (Convert.filter_nl xs1) (Convert.filter_nl xs2)


let equiv_list equiv_x env xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 (equiv_x env) xs1 xs2
let equiv_nl_list equiv_x env xs1 xs2 =
  equiv_list equiv_x env (El.Convert.filter_nl xs1) (El.Convert.filter_nl xs2)
let equiv_opt equiv_x env xo1 xo2 =
  match xo1, xo2 with
  | None, None -> true
  | Some x1, Some x2 -> equiv_x env x1 x2
  | _, _ -> false


(* Type Reduction (weak-head) *)

let rec reduce_typ env t : typ =
  (*
  if t.it <> NumT NatT then
  Printf.eprintf "[el.reduce_typ] %s\n%!" (El.Print.string_of_typ t);
  let t' =
  *)
  match t.it with
  | VarT (id, args) ->
    let args' = List.map (reduce_arg env) args in
    (match reduce_typ_app env id args' (Map.find id.it env.typs) with
    | Some t' -> t'
    | None -> VarT (id, args') $ t.at
    )
  | ParenT t1 -> reduce_typ env t1
  | CaseT (dots1, ts, tcs, dots2) ->
    assert (dots1 = NoDots && dots2 = NoDots);
    let tcs' = Convert.concat_map_nl_list (reduce_casetyp env) ts in
    CaseT (NoDots, [], tcs' @ tcs, NoDots) $ t.at
  | _ -> t
  (*
  in
  if t.it <> NumT NatT then
  Printf.eprintf "[el.reduce_typ] %s => %s\n%!" (El.Print.string_of_typ t) (El.Print.string_of_typ t');
  t'
  *)

and reduce_casetyp env t : typcase nl_list =
  match (reduce_typ env t).it with
  | CaseT (NoDots, [], tcs, NoDots) -> tcs
  | _ -> assert false

and reduce_typ_app env id args = function
  | [] -> None
  | (args', t)::defs' ->
    (* HACK: check for forward reference to yet undefined type (should throw?) *)
    if Eq.eq_typ t (VarT (id, args') $ id.at) then None else
    match match_list match_arg env Subst.empty args args' with
    | exception Irred -> None
    | None -> reduce_typ_app env id args defs'
    | Some s -> Some (reduce_typ env (Subst.subst_typ s t))


(* Expression Reduction *)

and is_normal_exp e =
  match e.it with
  | AtomE _ | BoolE _ | NatE _ | TextE _ | SeqE _
  | UnE (MinusOp, {it = NatE _; _})
  | StrE _ | TupE _ | InfixE _ | BrackE _ -> true
  | _ -> false

and reduce_exp env e : exp =
  (*
  (match e.it with VarE ({it = "nat"; _}, []) -> () | _ ->
  Printf.eprintf "[el.reduce_exp] %s\n%!" (El.Print.string_of_exp e));
  let e' =
  *)
  match e.it with
  | VarE _ | AtomE _ | BoolE _ | NatE _ | TextE _ | SizeE _ -> e
  | UnE (op, e1) ->
    let e1' = reduce_exp env e1 in
    (match op, e1'.it with
    | NotOp, BoolE b -> BoolE (not b) $ e.at
    | NotOp, UnE (NotOp, e11) -> e11
    | PlusOp, _ -> e1'
    | MinusOp, UnE (PlusOp, e11) -> UnE (MinusOp, e11) $ e.at
    | MinusOp, UnE (MinusOp, e11) -> UnE (PlusOp, e11) $ e.at
    | _ -> UnE (op, e1') $ e.at
    )
  | BinE (e1, op, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op, e1'.it, e2'.it with
    | AndOp, BoolE true, _ -> e2'
    | AndOp, BoolE false, _ -> e1'
    | AndOp, _, BoolE true -> e1'
    | AndOp, _, BoolE false -> e2'
    | OrOp, BoolE true, _ -> e1'
    | OrOp, BoolE false, _ -> e2'
    | OrOp, _, BoolE true -> e2'
    | OrOp, _, BoolE false -> e1'
    | ImplOp, BoolE b1, BoolE b2 -> BoolE (not b1 || b2) $ e.at
    | ImplOp, BoolE true, _ -> e2'
    | ImplOp, BoolE false, _ -> BoolE true $ e.at
    | ImplOp, _, BoolE true -> e2'
    | ImplOp, _, BoolE false -> UnE (NotOp, e1') $ e.at
    | EquivOp, BoolE b1, BoolE b2 -> BoolE (b1 = b2) $ e.at
    | EquivOp, BoolE true, _ -> e2'
    | EquivOp, BoolE false, _ -> UnE (NotOp, e2') $ e.at
    | EquivOp, _, BoolE true -> e1'
    | EquivOp, _, BoolE false -> UnE (NotOp, e1') $ e.at
    | AddOp, NatE (op, n1), NatE (_, n2) -> NatE (op, n1 + n2) $ e.at
    | AddOp, NatE (_, 0), _ -> e2'
    | AddOp, _, NatE (_, 0) -> e1'
    | SubOp, NatE (op, n1), NatE (_, n2) -> NatE (op, n1 - n2) $ e.at
    | SubOp, NatE (_, 0), _ -> UnE (MinusOp, e2') $ e.at
    | SubOp, _, NatE (_, 0) -> e1'
    | MulOp, NatE (op, n1), NatE (_, n2) -> NatE (op, n1 * n2) $ e.at
    | MulOp, NatE (_, 1), _ -> e2'
    | MulOp, _, NatE (_, 1) -> e1'
    | DivOp, NatE (op, n1), NatE (_, n2) -> NatE (op, n1 / n2) $ e.at
    | DivOp, NatE (_, 0), _ -> e1'
    | DivOp, _, NatE (_, 1) -> e1'
    | ExpOp, NatE (op, n1), NatE (_, n2) -> NatE (op, int_of_float (float n1 ** float n2)) $ e.at
    | ExpOp, NatE (_, (0 | 1)), _ -> e1'
    | ExpOp, _, NatE (op, 0) -> NatE (op, 1) $ e.at
    | ExpOp, _, NatE (_, 1) -> e1'
    | _ -> BinE (e1', op, e2') $ e.at
    )
  | CmpE (e1, op, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op, e1'.it, e2'.it with
    | EqOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE (Eq.eq_exp e1' e2')
    | NeOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE (not (Eq.eq_exp e1' e2'))
    | LtOp, NatE (_, n1), NatE (_, n2) -> BoolE (n1 < n2)
    | LtOp, UnE (MinusOp, {it = NatE (_, n1); _}), UnE (MinusOp, {it = NatE (_, n2); _}) -> BoolE (n2 < n1)
    | LtOp, UnE (MinusOp, {it = NatE _; _}), NatE _ -> BoolE true
    | LtOp, NatE _, UnE (MinusOp, {it = NatE _; _}) -> BoolE false
    | GtOp, NatE (_, n1), NatE (_, n2) -> BoolE (n1 > n2)
    | GtOp, UnE (MinusOp, {it = NatE (_, n1); _}), UnE (MinusOp, {it = NatE (_, n2); _}) -> BoolE (n2 > n1)
    | GtOp, UnE (MinusOp, {it = NatE _; _}), NatE _ -> BoolE false
    | GtOp, NatE _, UnE (MinusOp, {it = NatE _; _}) -> BoolE true
    | LeOp, NatE (_, n1), NatE (_, n2) -> BoolE (n1 <= n2)
    | LeOp, UnE (MinusOp, {it = NatE (_, n1); _}), UnE (MinusOp, {it = NatE (_, n2); _}) -> BoolE (n2 <= n1)
    | LeOp, UnE (MinusOp, {it = NatE _; _}), NatE _ -> BoolE true
    | LeOp, NatE _, UnE (MinusOp, {it = NatE _; _}) -> BoolE false
    | GeOp, NatE (_, n1), NatE (_, n2) -> BoolE (n1 >= n2)
    | GeOp, UnE (MinusOp, {it = NatE (_, n1); _}), UnE (MinusOp, {it = NatE (_, n2); _}) -> BoolE (n2 >= n1)
    | GeOp, UnE (MinusOp, {it = NatE _; _}), NatE _ -> BoolE false
    | GeOp, NatE _, UnE (MinusOp, {it = NatE _; _}) -> BoolE true
    | _ -> CmpE (e1', op, e2')
    ) $ e.at
  | EpsE -> SeqE [] $ e.at
  | SeqE es -> SeqE (List.map (reduce_exp env) es) $ e.at
  | IdxE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | SeqE es, NatE (_, i) when i < List.length es -> List.nth es i
    | _ -> IdxE (e1', e2') $ e.at
    )
  | SliceE (e1, e2, e3) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let e3' = reduce_exp env e3 in
    (match e1'.it, e2'.it, e3'.it with
    | SeqE es, NatE (_, i), NatE (_, n) when i + n < List.length es ->
      SeqE (Lib.List.take n (Lib.List.drop i es))
    | _ -> SliceE (e1', e2', e3')
    ) $ e.at
  | UpdE (e1, p, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    reduce_path env e1' p
      (fun e' p' -> if p'.it = RootP then e2' else UpdE (e', p', e2') $ e.at)
  | ExtE (e1, p, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    reduce_path env e1' p
      (fun e' p' ->
        if p'.it = RootP
        then reduce_exp env (SeqE [e'; e2'] $ e.at)
        else ExtE (e', p', e2') $ e.at
      )
  | StrE efs -> StrE (Convert.map_nl_list (reduce_expfield env) efs) $ e.at
  | DotE (e1, atom) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | StrE efs ->
      snd (Option.get (El.Convert.find_nl_list (fun (atomN, _) -> atomN = atom) efs))
    | _ -> DotE (e1', atom) $ e.at
    )
  | CommaE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (* TODO *)
    (match e1'.it, e2'.it with
    | _ -> CommaE (e1', e2') $ e.at
    )
  | CompE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (* TODO *)
    (match e1'.it, e2'.it with
    | _ -> CompE (e1', e2') $ e.at
    )
  | LenE e1 ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | SeqE es -> NatE (DecOp, List.length es)
    | _ -> LenE e1'
    ) $ e.at
  | ParenE (e1, _) | TypE (e1, _) -> reduce_exp env e1
  | TupE es -> TupE (List.map (reduce_exp env) es) $ e.at
  | InfixE (e1, atom, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    InfixE (e1', atom, e2') $ e.at
  | BrackE (atom1, e1, atom2) ->
    let e1' = reduce_exp env e1 in
    BrackE (atom1, e1', atom2) $ e.at
  | CallE (id, args) ->
    let args' = List.map (reduce_arg env) args in
    (match reduce_exp_call env id args' (Map.find id.it env.defs) with
    | None -> CallE (id, args') $ e.at
    | Some e -> e
    )
  | IterE (e1, iter) ->
    let e1' = reduce_exp env e1 in
    IterE (e1', iter) $ e.at  (* TODO *)
  | HoleE _ | FuseE _ -> assert false
  (*
  in
  (match e.it with VarE ({it = "nat"; _}, []) -> () | _ ->
  Printf.eprintf "[el.reduce_exp] %s => %s\n%!" (El.Print.string_of_exp e) (El.Print.string_of_exp e'));
  e'
  *)

and reduce_expfield env (atom, e) : expfield = (atom, reduce_exp env e)

and reduce_path env e p f =
  match p.it with
  | RootP -> f e p
  | IdxP (p1, e1) ->
    let e1' = reduce_exp env e1 in
    let f' e' p1' =
      match e'.it, e1'.it with
      | SeqE es, NatE (_, i) when i < List.length es ->
        SeqE (List.mapi (fun j eJ -> if j = i then f eJ p1' else eJ) es) $ e'.at
      | _ ->
        f e' (IdxP (p1', e1') $ p.at)
    in
    reduce_path env e p1 f'
  | SliceP (p1, e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let f' e' p1' =
      match e'.it, e1'.it, e2'.it with
      | SeqE es, NatE (_, i), NatE (_, n) when i + n < List.length es ->
        let e1' = SeqE Lib.List.(take i es) $ e'.at in
        let e2' = SeqE Lib.List.(take n (drop i es)) $ e'.at in
        let e3' = SeqE Lib.List.(drop (i + n) es) $ e'.at in
        reduce_exp env (SeqE [e1'; f e2' p1'; e3'] $ e'.at)
      | _ ->
        f e' (SliceP (p1', e1', e2') $ p.at)
    in
    reduce_path env e p1 f'
  | DotP (p1, atom) ->
    let f' e' p1' =
      match e'.it with
      | StrE efs ->
        StrE (Convert.map_nl_list (fun (atomI, eI) ->
          if atomI = atom then (atomI, f eI p1') else (atomI, eI)) efs) $ e'.at
      | _ ->
        f e' (DotP (p1', atom) $ p.at)
    in
    reduce_path env e p1 f'

and reduce_arg env a : arg =
  match !(a.it) with
  | ExpA e -> ref (ExpA (reduce_exp env e)) $ a.at
  | TypA _t -> a  (* types are reduced on demand *)
  | GramA _g -> a

and reduce_exp_call env id args = function
  | [] -> None
  | (args', e, prems)::clauses' ->
    match match_list match_arg env Subst.empty args args' with
    | exception Irred -> None
    | None -> reduce_exp_call env id args clauses'
    | Some s ->
      match reduce_prems env Subst.(subst_list subst_prem s prems) with
      | None -> None
      | Some false -> reduce_exp_call env id args clauses'
      | Some true -> Some (reduce_exp env e)

and reduce_prems env = function
  | [] -> Some true
  | prem::prems ->
    match reduce_prem env prem with
    | Some true -> reduce_prems env prems
    | other -> other

and reduce_prem env prem : bool option =
  match prem.it with
  | RulePr _ -> None
  | IfPr e ->
    (match (reduce_exp env e).it with
    | BoolE b -> Some b
    | _ -> None
    )
  | ElsePr -> Some true
  | IterPr (_prem, _iter) -> None  (* TODO *)


(* Matching *)

(* Iteration *)

and match_iter env s iter1 iter2 : subst option =
  match iter1, iter2 with
  | Opt, Opt -> Some s
  | List, List -> Some s
  | List1, List1 -> Some s
  | ListN (e1, _ido1), ListN (e2, _ido2) -> match_exp env s e1 e2
  | _, _ -> None


(* Types *)

and match_typ env s t1 t2 : subst option =
  match t1.it, t2.it with
  | ParenT t11, _ -> match_typ env s t11 t2
  | _, ParenT t21 -> match_typ env s t1 t21
  | _, VarT (id, []) when Subst.mem_typid s id ->
    match_typ env s t1 (Subst.subst_typ s t2)
  | _, VarT (id, []) when not (Map.mem id.it env.typs) ->
    (* An unbound type is treated as a pattern variable *)
    Some (Subst.add_typid s id t1)
  | VarT (id1, args1), VarT (id2, args2) when id1.it = id2.it ->
    (* Optimization for the common case where args are absent or equivalent. *)
    (match match_list match_arg env s args1 args2 with
    | Some s -> Some s
    | None ->
      (* If that fails, fall back to reduction. *)
      match_typ env s (reduce_typ env t1) (reduce_typ env t2)
    )
  | VarT _, _ -> match_typ env s (reduce_typ env t1) t2
  | _, VarT _ -> match_typ env s t1 (reduce_typ env t2)
  | TupT ts1, TupT ts2 -> match_list match_typ env s ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    let* s' = match_typ env s t11 t21 in match_iter env s' iter1 iter2
  | _, _ -> None


(* Expressions *)

and match_exp env s e1 e2 : subst option =
  (*
  Printf.eprintf "[el.match_exp] %s =: %s[%s] = %s\n%!"
    (Print.string_of_exp e1)
    (Print.string_of_exp e2)
    (String.concat " " (List.map (fun (x, e) -> x^"="^Print.string_of_exp e) (Subst.Map.bindings s.varid)))
    (Print.string_of_exp (reduce_exp env (Subst.subst_exp s e2)));
  let so =
  *)
  match e1.it, (reduce_exp env (Subst.subst_exp s e2)).it with
(*
  | (ParenE (e11, _) | TypE (e11, _)), _ -> match_exp env s e11 e2
  | _, (ParenE (e21, _) | TypE (e21, _)) -> match_exp env s e1 e21
  | _, VarE (id, []) when Subst.mem_varid s id ->
    match_exp env s e1 (Subst.subst_exp s e2)
  | VarE (id1, args1), VarE (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
*)
  | _, VarE (id, []) when Subst.mem_varid s id ->
    (* A pattern variable already in the substitution is non-linear *)
    if equiv_exp env e1 (Subst.subst_exp s e2) then
      Some s
    else
      None
  | _, VarE (id, []) ->
    (* Treat as a fresh pattern variable. Need to check domain. *)
Printf.eprintf "[1] %s\n%!" id.it;
    let find_var id =
      try Map.find id.it env.vars with Not_found ->
        (* Implicitly bound *)
        Map.find (El.Convert.strip_var_suffix id).it env.vars
    in
    let t' = reduce_typ env (find_var id) in
    if
      match e1.it, t'.it with
      | BoolE _, BoolT
      | NatE _, NumT _
      | TextE _, TextT -> true
      | UnE ((MinusOp | PlusOp), _), NumT t1 -> t1 >= IntT
      | NatE (_, n), RangeT tes ->
        List.exists (function
          | ({it = NatE (_, n1); _}, None) -> n1 = n
          | ({it = NatE (_, n1); _}, Some {it = NatE (_, n2); _}) -> n1 <= n && n <= n2
          | _ -> false
        ) (Convert.filter_nl tes)
      | (AtomE atom | SeqE ({it = AtomE atom; _}::_)), CaseT (_, _, tcs, _) ->
        (match El.Convert.find_nl_list (fun (atomN, _, _) -> atomN.it = atom.it) tcs with
        | Some (_, (tN, _), _) -> match_exp env s e1 (Convert.exp_of_typ tN) <> None
        | None -> false
        )
      | VarE (id1, []), _ ->
Printf.eprintf "[2] %s\n%!" id1.it;
        let t1 = reduce_typ env (find_var id1) in
        sub_typ env t1 t'
      | _, _ -> false
    then
      if id.it = "_" then Some s else
      Some (Subst.add_varid s id e1)
    else None
  | AtomE atom1, AtomE atom2 when atom1.it = atom2.it -> Some s
  | BoolE b1, BoolE b2 when b1 = b2 -> Some s
  | NatE (_, n1), NatE (_, n2) when n1 = n2 -> Some s
  | TextE s1, TextE s2 when s1 = s2 -> Some s
  | UnE (MinusOp, e11), UnE (MinusOp, e21) -> match_exp env s e11 e21
(*
  | UnE (op1, e11), UnE (op2, e21) when op1 = op2 -> match_exp env s e11 e21
  | BinE (e11, op1, e12), BinE (e21, op2, e22) when op1 = op2 ->
    let* s' = match_exp env s e11 e21 in match_exp env s' e12 e22
  | CmpE (e11, op1, e12), CmpE (e21, op2, e22) when op1 = op2 ->
    let* s' = match_exp env s e11 e21 in match_exp env s' e12 e22
  | (EpsE | SeqE []), (EpsE | SeqE []) -> Some s
*)
  | SeqE es1, SeqE es2
  | TupE es1, TupE es2 -> match_list match_exp env s es1 es2
(*
  | IdxE (e11, e12), IdxE (e21, e22)
  | CommaE (e11, e12), CommaE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22) ->
    let* s' = match_exp env s e11 e21 in match_exp env s' e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    let* s' = match_exp env s e11 e21 in
    let* s'' = match_exp env s' e12 e22 in
    match_exp env s'' e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    let* s' = match_exp env s e11 e21 in
    let* s'' = match_path env s' p1 p2 in
    match_exp env s'' e12 e22
*)
  | StrE efs1, StrE efs2 -> match_nl_list match_expfield env s efs1 efs2
(*
  | DotE (e11, atom1), DotE (e21, atom2) when atom1 = atom2 ->
    match_exp env s e11 e21
  | LenE e11, LenE e21 -> match_exp env s e11 e21
  | SizeE id1, SizeE id2 when id1.it = id2.it -> Some s
*)
  | InfixE (e11, atom1, e12), InfixE (e21, atom2, e22) when atom1 = atom2 ->
    let* s' = match_exp env s e11 e21 in match_exp env s' e12 e22
  | BrackE (atom11, e11, atom12), BrackE (atom21, e21, atom22)
    when atom11 = atom21 && atom12 = atom22 ->
    match_exp env s e11 e21
(*
  | CallE (id1, args1), CallE (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
*)
  | IterE (e11, iter1), IterE (e21, iter2) ->
    let* s' = match_exp env s e11 e21 in match_iter env s' iter1 iter2
  | (HoleE _ | FuseE _), _
  | _, (HoleE _ | FuseE _) -> assert false
  | _, _ when is_normal_exp e1 -> None
  | _, _ -> raise Irred
  (*
  in
  Printf.eprintf "[el.match_exp] %s =: %s => %s\n%!"
    (Print.string_of_exp e1)
    (Print.string_of_exp (reduce_exp env (Subst.subst_exp s e2)))
    (match so with
    | None -> "-"
    | Some s ->
    (String.concat " " (List.map (fun (x, e) -> x^"="^Print.string_of_exp e) (Subst.Map.bindings s.varid)))
    );
  so
  *)

and match_expfield env s (atom1, e1) (atom2, e2) =
  if atom1 <> atom2 then None else
  match_exp env s e1 e2

(*
and match_path env s p1 p2 =
  match p1.it, p2.it with
  | RootP, RootP -> Some s
  | IdxP (p11, e1), IdxP (p21, e2) ->
    let* s' = match_path env s p11 p21 in
    match_exp env s' e1 e2
  | SliceP (p11, e11, e12), SliceP (p21, e21, e22) ->
    let* s' = match_path env s p11 p21 in
    let* s'' = match_exp env s' e11 e21 in
    match_exp env s'' e12 e22
  | DotP (p11, atom1), DotP (p21, atom2) when atom1 = atom2 ->
    match_path env s p11 p21
  | _, _ -> None
*)


(* Grammars *)

and match_sym env s g1 g2 : subst option =
  (*
  Printf.eprintf "[el.match_sym] %s =: %s\n%!"
    (Print.string_of_sym g1)
    (Print.string_of_sym g2);
  *)
  match g1.it, g2.it with
  | ParenG g11, _ -> match_sym env s g11 g2
  | _, ParenG g21 -> match_sym env s g1 g21
  | _, VarG (id, []) when Subst.mem_gramid s id ->
    match_sym env s g1 (Subst.subst_sym s g2)
  | _, VarG (id, []) when not (Map.mem id.it env.syms) ->
    (* An unbound type is treated as a pattern variable *)
    Some (Subst.add_gramid s id g1)
  | VarG (id1, args1), VarG (id2, args2) when id1.it = id2.it ->
    (* Optimization for the common case where args are absent or equivalent. *)
    match_list match_arg env s args1 args2
  | TupG gs1, TupG gs2 -> match_list match_sym env s gs1 gs2
  | IterG (g11, iter1), IterG (g21, iter2) ->
    let* s' = match_sym env s g11 g21 in match_iter env s' iter1 iter2
  | _, _ -> None


(* Parameters *)

and match_arg env s a1 a2 : subst option =
  (* *)
  Printf.eprintf "[el.match_arg] %s =: %s\n%!"
    (Print.string_of_arg a1)
    (Print.string_of_arg a2);
  (* *)
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> match_exp env s e1 e2
  | TypA t1, TypA t2 -> match_typ env s t1 t2
  | GramA g1, GramA g2 -> match_sym env s g1 g2
  | _, _ -> assert false


(* Type Equivalence *)

and equiv_typ env t1 t2 =
  (*
  Printf.eprintf "[el.equiv_typ] %s == %s\n%!"
    (Print.string_of_typ t1)
    (Print.string_of_typ t2);
  let b =
  *)
  match t1.it, t2.it with
  | VarT (id1, args1), VarT (id2, args2) ->
    (El.Convert.strip_var_suffix id1).it = (El.Convert.strip_var_suffix id2).it &&
    equiv_list equiv_arg env args1 args2 || (* optimization *)
    let t1' = reduce_typ env t1 in
    let t2' = reduce_typ env t2 in
    (t1' <> t1 || t2' <> t2) && equiv_typ env t1' t2'
  | VarT _, _ ->
    let t1' = reduce_typ env t1 in
    t1' <> t1 && equiv_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ env t2 in
    t2' <> t2 && equiv_typ env t1 t2'
  | ParenT t11, _ -> equiv_typ env t11 t2
  | _, ParenT t21 -> equiv_typ env t1 t21
  | TupT ts1, TupT ts2 | SeqT ts1, SeqT ts2 -> equiv_list equiv_typ env ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    equiv_typ env t11 t21 && Eq.eq_iter iter1 iter2
  | InfixT (t11, atom1, t12), InfixT (t21, atom2, t22) ->
    equiv_typ env t11 t21 && atom1 = atom2 && equiv_typ env t12 t22
  | BrackT (atom11, t11, atom12), BrackT (atom21, t21, atom22) ->
    atom11 = atom21 && equiv_typ env t11 t21 && atom12 = atom22
  | StrT tfs1, StrT tfs2 -> equiv_nl_list equiv_typfield env tfs1 tfs2
  | CaseT (NoDots, [], tcs1, NoDots), CaseT (NoDots, [], tcs2, NoDots) ->
    equiv_nl_list equiv_typcase env tcs1 tcs2
  | RangeT tes1, RangeT tes2 -> equiv_nl_list equiv_typenum env tes1 tes2
  | _, _ -> t1.it = t2.it
  (*
  in
  Printf.eprintf "[el.equiv_typ] (%s) == (%s) => %b\n%!"
    (Print.string_of_typ t1)
    (Print.string_of_typ t2)
    b;
  b
  *)

and equiv_typfield env (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1 = atom2 && equiv_typ env t1 t2 && Eq.(eq_nl_list eq_prem prems1 prems2)
and equiv_typcase env (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1 = atom2 && equiv_typ env t1 t2 && Eq.(eq_nl_list eq_prem prems1 prems2)
and equiv_typenum env (e11, e12o) (e21, e22o) =
  equiv_exp env e11 e21 && equiv_opt equiv_exp env e12o e22o

and equiv_exp env e1 e2 =
  (* TODO: this does not reduce inner type arguments *)
  Eq.eq_exp (reduce_exp env e1) (reduce_exp env e2)

and equiv_arg env a1 a2 =
  (*
  Printf.eprintf "[el.equiv_arg] (%s) == (%s)\n%!"
    (Print.string_of_arg a1)
    (Print.string_of_arg a2);
  *)
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> equiv_exp env e1 e2
  | TypA t1, TypA t2 -> equiv_typ env t1 t2
  | GramA g1, GramA g2 -> Eq.eq_sym g1 g2
  | _, _ -> false


(* Subtyping *)

and sub_typ env t1 t2 =
  (* *)
  if not (Eq.eq_typ t1 t2) then
  Printf.eprintf "[el.sub_typ] %s <: %s\n%!" (Print.string_of_typ t1) (Print.string_of_typ t2);
  (* *)
  match (reduce_typ env t1).it, (reduce_typ env t2).it with
  | NumT t1', NumT t2' -> t1' <= t2'
  | RangeT (Elem (e1, _)::_), NumT t2' ->
    (match (reduce_exp env e1).it with
    | NatE _ -> true
    | UnE (MinusOp, _) -> t2' <= IntT
    | _ -> assert false
    )
  | _, _ -> equiv_typ env t1 t2
