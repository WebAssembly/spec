open Util
open Source
open El
open Xl
open Ast


(* Environment *)

module Set = Set.Make(String)
module Map = Map.Make(String)

type typ_def = (arg list * typ) list
type def_def = (arg list * exp * prem list) list
type gram_def = unit
type env = {vars : typ Map.t; typs : typ_def Map.t; defs : def_def Map.t; grams : gram_def Map.t}
type subst = Subst.t


(* Helpers *)

(* This exception indicates that a an application cannot be reduced because a pattern
 * match cannot be decided.
 * When assume_coherent_matches is set, that case is treated as a non-match.
 *)
exception Irred

let assume_coherent_matches = ref true

let (let*) = Option.bind


let of_bool_exp = function
  | BoolE b -> Some b
  | _ -> None

let of_num_exp = function
  | NumE (_, n) -> Some n
  | _ -> None

let to_bool_exp b = BoolE b
let to_num_exp n = NumE (`DecOp, n)


(* Matching Lists *)

let rec match_list match_x env s xs1 xs2 : subst option =
  match xs1, xs2 with
  | [], [] -> Some s
  | x1::xs1', x2::xs2' ->
    let* s' = match_x env s x1 x2 in
    match_list match_x env (Subst.union s s') xs1' xs2'
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

let disj_list disj_x env xs1 xs2 =
  List.length xs1 <> List.length xs2 || List.exists2 (disj_x env) xs1 xs2


(* Type Reduction (weak-head) *)

let rec reduce_typ env t : typ =
  Debug.(log_if "el.reduce_typ" (t.it <> NumT `NatT)
    (fun _ -> fmt "%s" (el_typ t))
    (fun r -> fmt "%s" (el_typ r))
  ) @@ fun _ ->
  match t.it with
  | VarT (id, args) ->
    let args' = List.map (reduce_arg env) args in
    let id' = El.Convert.strip_var_suffix id in
    if id'.it <> id.it && args = [] then reduce_typ env (El.Convert.typ_of_varid id') else
    (match reduce_typ_app env id args' t.at (Map.find id'.it env.typs) with
    | Some t' ->
(* TODO(2, rossberg): reenable?
      if id'.it <> id.it then
        Error.error id.at "syntax" "identifer suffix encountered during reduction";
*)
      t'
    | None -> VarT (id, args') $ t.at
    )
  | ParenT t1 -> reduce_typ env t1
  | CaseT (dots1, ts, tcs, _dots2) ->
    assert (dots1 = NoDots);
(* TODO(3, rossberg): unclosed case types are not checked early enough for this
    assert (dots2 = NoDots);
*)
    let tcs' = Convert.concat_map_nl_list (reduce_casetyp env) ts in
    CaseT (NoDots, [], tcs' @ tcs, NoDots) $ t.at
  | _ -> t

and reduce_casetyp env t : typcase nl_list =
  match (reduce_typ env t).it with
  | CaseT (NoDots, [], tcs, NoDots) -> tcs
  | _ -> assert false

and reduce_typ_app env id args at = function
  | [] ->
    if !assume_coherent_matches then None else
    let args = if args = [] then "" else
      "(" ^ String.concat ", " (List.map Print.string_of_arg args) ^ ")" in
    Error.error at "type"
      ("undefined instance of partial syntax type definition: `" ^ id.it ^ args ^ "`")
  | (args', t)::insts' ->
    Debug.(log "el.reduce_typ_app"
      (fun _ -> fmt "%s(%s) =: %s(%s)" id.it (el_args args) id.it (el_args args'))
      (fun r -> fmt "%s" (opt (Fun.const "!") r))
    ) @@ fun _ ->
    (* HACK: check for forward reference to yet undefined type (should throw?) *)
    if Eq.eq_typ t (VarT (id, args') $ id.at) then None else
    match match_list match_arg env Subst.empty args args' with
    | exception Irred ->
      if not !assume_coherent_matches then None else
      reduce_typ_app env id args at insts'
    | None -> reduce_typ_app env id args at insts'
    | Some s -> Some (reduce_typ env (Subst.subst_typ s t))


(* Expression Reduction *)

and is_head_normal_exp e =
  match e.it with
  | AtomE _ | BoolE _ | NumE _ | TextE _
  | SeqE _ | TupE _ | InfixE _ | BrackE _ | StrE _ -> true
  | _ -> false

and is_normal_exp e =
  match e.it with
  | AtomE _ | BoolE _ | NumE _ | TextE _ -> true
  | SeqE es | TupE es -> List.for_all is_normal_exp es
  | BrackE (_, e, _) -> is_normal_exp e
  | InfixE (e1, _, e2) -> is_normal_exp e1 && is_normal_exp e2
  | StrE efs -> Convert.forall_nl_list (fun (_, e) -> is_normal_exp e) efs
  | _ -> false

and reduce_exp env e : exp =
  Debug.(log "el.reduce_exp"
    (fun _ -> fmt "%s" (el_exp e))
    (fun r -> fmt "%s" (el_exp r))
  ) @@ fun _ ->
  match e.it with
  | VarE _ | AtomE _ | BoolE _ | TextE _ | SizeE _ -> e
  | NumE (numop, n) -> NumE (numop, Num.narrow n) $ e.at
  | CvtE (e1, nt) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | NumE (numop, n) ->
      (match Num.cvt nt n with
      | Some n' -> NumE (numop, n') $ e.at
      | None -> e1'
      )
    | _ -> e1'
    )
  | UnE (op, e1) ->
    let e1' = reduce_exp env e1 in
    (match op, e1'.it with
    | #Bool.unop as op', BoolE b1 -> BoolE (Bool.un op' b1) $ e.at
    | #Num.unop as op', NumE (numop, n1) ->
      (match Num.un op' n1 with
      | Some n -> NumE (numop, n)
      | None -> UnE (op, e1')
      ) $ e.at
    | `NotOp, UnE (`NotOp, e11') -> e11'
    | `MinusOp, UnE (`MinusOp, e11') -> e11'
    | `PlusOp, _ -> e1'
    | _ -> UnE (op, e1') $ e.at
    )
  | BinE (e1, op, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op with
    | #Bool.binop as op' ->
      (match Bool.bin_partial op' e1'.it e2'.it of_bool_exp to_bool_exp with
      | None -> BinE (e1', op, e2')
      | Some e' -> e'
      )
    | #Num.binop as op' ->
      let e1'', e2'' =
        match e1'.it, e2'.it with
        | NumE (numop1, n1), NumE (numop2, n2) ->
          let n1', n2' = Num.widen n1 n2 in
          NumE (numop1, n1'), NumE (numop2, n2')
        | _, _ -> e1'.it, e2'.it
      in
      (match Num.bin_partial op' e1'' e2'' of_num_exp to_num_exp with
      | None -> BinE (e1', op, e2')
      | Some e' -> e'
      )
    ) $ e.at
  | CmpE (e1, op, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op, e1'.it, e2'.it with
    | `EqOp, _, _ when Eq.eq_exp e1' e2' -> BoolE true
    | `NeOp, _, _ when Eq.eq_exp e1' e2' -> BoolE false
    | `EqOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE false
    | `NeOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE true
    | #Num.cmpop as op', NumE (_, n1), NumE (_, n2) ->
      (match Num.cmp op' n1 n2 with
      | Some b -> BoolE b
      | None -> CmpE (e1', op, e2')
      )
    | _ -> CmpE (e1', op, e2')
    ) $ e.at
  | EpsE -> SeqE [] $ e.at
  | SeqE es -> SeqE (List.map (reduce_exp env) es) $ e.at
  | ListE es -> SeqE (List.map (reduce_exp env) es) $ e.at
  | IdxE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | SeqE es, NumE (_, `Nat i) when i < Z.of_int (List.length es) -> List.nth es (Z.to_int i)
    | _ -> IdxE (e1', e2') $ e.at
    )
  | SliceE (e1, e2, e3) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let e3' = reduce_exp env e3 in
    (match e1'.it, e2'.it, e3'.it with
    | SeqE es, NumE (_, `Nat i), NumE (_, `Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
      SeqE (Lib.List.take (Z.to_int n) (Lib.List.drop (Z.to_int i) es))
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
      snd (Option.get (El.Convert.find_nl_list (fun (atomN, _) -> Atom.eq atomN atom) efs))
    | _ -> DotE (e1', atom) $ e.at
    )
  | CommaE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e2'.it with
    | SeqE ({it = AtomE atom; _} :: es2') ->
      let e21' = match es2' with [e21'] -> e21' | _ -> SeqE es2' $ e2.at in
      reduce_exp env (CatE (e1', StrE [Elem (atom, e21')] $ e2.at) $ e.at)
    | _ -> CommaE (e1', e2') $ e.at
    )
  | CatE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | SeqE es1, SeqE es2 -> SeqE (es1 @ es2)
    | SeqE [], _ -> e2'.it
    | _, SeqE [] -> e1'.it
    | StrE efs1, StrE efs2 ->
      let rec merge efs1 efs2 =
        match efs1, efs2 with
        | [], _ -> efs2
        | _, [] -> efs1
        | Nl::efs1', _ -> merge efs1' efs2
        | _, Nl::efs2' -> merge efs1 efs2'
        | Elem (atom1, e1) :: efs1', Elem (atom2, e2) :: efs2' ->
          (* Assume that both lists are sorted in same order *)
          if Atom.eq atom1 atom2 then
            let e' = reduce_exp env (CatE (e1, e2) $ e.at) in
            Elem (atom1, e') :: merge efs1' efs2'
          else if El.Convert.exists_nl_list (fun (atom, _) -> Atom.eq atom atom2) efs1 then
            Elem (atom1, e1) :: merge efs1' efs2
          else
            Elem (atom2, e2) :: merge efs1 efs2'
      in StrE (merge efs1 efs2)
    | _ -> CatE (e1', e2')
    ) $ e.at
  | MemE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e2'.it with
    | SeqE [] -> BoolE false
    | SeqE es2' when List.exists (Eq.eq_exp e1') es2' -> BoolE true
    | SeqE es2' when is_normal_exp e1' && List.for_all is_normal_exp es2' -> BoolE false
    | _ -> MemE (e1', e2')
    ) $ e.at
  | LenE e1 ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | SeqE es -> NumE (`DecOp, `Nat (Z.of_int (List.length es)))
    | _ -> LenE e1'
    ) $ e.at
  | ParenE e1 | ArithE e1 | TypE (e1, _) -> reduce_exp env e1
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
    let clauses = Map.find id.it env.defs in
    (* Allow for uninterpreted functions *)
    if not !assume_coherent_matches && clauses = [] then CallE (id, args') $ e.at else
    (match reduce_exp_call env id args' e.at clauses with
    | None -> CallE (id, args') $ e.at
    | Some e -> e
    )
  | IterE (e1, iter) ->
    let e1' = reduce_exp env e1 in
    IterE (e1', iter) $ e.at  (* TODO(2, rossberg): simplify? *)
  | HoleE _ | FuseE _ | UnparenE _ | LatexE _ -> assert false

and reduce_expfield env (atom, e) : expfield = (atom, reduce_exp env e)

and reduce_path env e p f =
  match p.it with
  | RootP -> f e p
  | IdxP (p1, e1) ->
    let e1' = reduce_exp env e1 in
    let f' e' p1' =
      match e'.it, e1'.it with
      | SeqE es, NumE (_, `Nat i) when i < Z.of_int (List.length es) ->
        SeqE (List.mapi (fun j eJ -> if Z.of_int j = i then f eJ p1' else eJ) es) $ e'.at
      | _ ->
        f e' (IdxP (p1', e1') $ p.at)
    in
    reduce_path env e p1 f'
  | SliceP (p1, e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let f' e' p1' =
      match e'.it, e1'.it, e2'.it with
      | SeqE es, NumE (_, `Nat i), NumE (_, `Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
        let e1' = SeqE Lib.List.(take (Z.to_int i) es) $ e'.at in
        let e2' = SeqE Lib.List.(take (Z.to_int n) (drop (Z.to_int i) es)) $ e'.at in
        let e3' = SeqE Lib.List.(drop Z.(to_int (i + n)) es) $ e'.at in
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
  | DefA _id -> a

and reduce_exp_call env id args at = function
  | [] ->
    if !assume_coherent_matches then None else
    let args = if args = [] then "" else
      "(" ^ String.concat ", " (List.map Print.string_of_arg args) ^ ")" in
    Error.error at "type"
      ("undefined call to partial function: `$" ^ id.it ^ args ^ "`")
  | (args', e, prems)::clauses' ->
    match match_list match_arg env Subst.empty args args' with
    | exception Irred ->
      if not !assume_coherent_matches then None else
      reduce_exp_call env id args at clauses'
    | None -> reduce_exp_call env id args at clauses'
    | Some s ->
      match reduce_prems env Subst.(subst_list subst_prem s prems) with
      | None -> None
      | Some false -> reduce_exp_call env id args at clauses'
      | Some true -> Some (reduce_exp env (Subst.subst_exp s e))

and reduce_prems env = function
  | [] -> Some true
  | prem::prems ->
    match reduce_prem env prem with
    | Some true -> reduce_prems env prems
    | other -> other

and reduce_prem env prem : bool option =
  match prem.it with
  | VarPr _
  | ElsePr -> Some true
  | RulePr _ -> None
  | IfPr e ->
    (match (reduce_exp env e).it with
    | BoolE b -> Some b
    | _ -> None
    )
  | IterPr (_prem, _iter) -> None  (* TODO(2, rossberg): implement *)


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
      let t1' = reduce_typ env t1 in
      let t2' = reduce_typ env t2 in
      if Eq.(eq_typ t1 t1' && eq_typ t2 t2') then None else
      match_typ env s t1' t2'
    )
  | VarT _, _ ->
    let t1' = reduce_typ env t1 in
    if Eq.eq_typ t1 t1' then None else
    match_typ env s t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ env t2 in
    if Eq.eq_typ t2 t2' then None else
    match_typ env s t1 t2'
  | TupT ts1, TupT ts2 -> match_list match_typ env s ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    let* s' = match_typ env s t11 t21 in match_iter env s' iter1 iter2
  | _, _ -> None


(* Expressions *)

(* Matching can produce one of several results:
   - Some s: matches producing substitutions
   - None: does not match
   - exception Irred: lacking normal form, can't decide between Some or None
   - exception Error: some inner application was undefined, i.e., non-exhaustive
*)

and match_exp env s e1 e2 : subst option =
  Debug.(log "el.match_exp"
    (fun _ -> fmt "%s =: %s" (el_exp e1) (el_exp e2))
    (fun r -> fmt "%s" (opt el_subst r))
  ) @@ fun _ ->
  match e1.it, (reduce_exp env (Subst.subst_exp s e2)).it with
(*
  | (ParenE e11 | TypE (e11, _)), _ -> match_exp env s e11 e2
  | _, (ParenE e21 | TypE (e21, _)) -> match_exp env s e1 e21
  | _, VarE (id, []) when Subst.mem_varid s id ->
    match_exp env s e1 (Subst.subst_exp s e2)
  | VarE (id1, args1), VarE (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
*)
  | _, VarE (id2, []) when Subst.mem_varid s id2 ->
    (* A pattern variable already in the substitution is non-linear *)
    let e2' = Subst.subst_exp s e2 in
    if equiv_exp env e1 e2' then
      Some s
    else if is_head_normal_exp e1 && is_head_normal_exp e2' then
      None
    else
      raise Irred
  | _, VarE (id2, []) ->
    (* Treat as a fresh pattern variable. If declared, need to check domain. *)
    let find_var id =
      match Map.find_opt id.it env.vars with
      | None ->
        (* Implicitly bound *)
        Map.find_opt (El.Convert.strip_var_suffix id).it env.vars  (* TODO(2, rossberg): should be gvars *)
      | some -> some
    in
    if
      match Map.find_opt (El.Convert.strip_var_suffix id2).it env.vars (* gvars *) with
      | None -> true  (* undeclared pattern variable always matches *)
      | Some t2 ->
        let t2' = reduce_typ env t2 in
        match e1.it, t2'.it with
        | BoolE _, BoolT
        | TextE _, TextT -> true
        | NumE (_, n), NumT t -> t >= Num.to_typ (Num.narrow n)
        | UnE ((`MinusOp | `PlusOp), _), NumT t1 -> t1 >= `IntT
        | NumE (_, `Nat n), RangeT tes ->
          List.exists (function
            | ({it = NumE (_, `Nat n1); _}, None) -> n1 = n
            | ({it = NumE (_, `Nat n1); _}, Some {it = NumE (_, `Nat n2); _}) -> n1 <= n && n <= n2
            | _ -> false
          ) (Convert.filter_nl tes)
        | (AtomE atom | SeqE ({it = AtomE atom; _}::_)), CaseT (_, _, tcs, _) ->
          (match El.Convert.find_nl_list (fun (atomN, _, _) -> atomN.it = atom.it) tcs with
          | Some (_, (tN, _), _) ->
            match_exp env s e1 (Convert.exp_of_typ tN) <> None
          | None -> false
          )
        | VarE (id1, []), _ ->
          (match find_var id1 with
          | None -> raise Irred
          | Some t1 -> sub_typ env t1 t2' ||
            if disj_typ env t1 t2' then false else raise Irred
          )
        | _, (StrT _ | CaseT _ | ConT _ | RangeT _) -> raise Irred
        | _, _ -> true
    then
      if id2.it = "_" then Some s else
      Some (Subst.add_varid s id2 e1)
    else None
  | AtomE atom1, AtomE atom2 when atom1.it = atom2.it -> Some s
  | BoolE b1, BoolE b2 when b1 = b2 -> Some s
  | NumE (_, n1), NumE (_, n2) when n1 = n2 -> Some s
  | TextE s1, TextE s2 when s1 = s2 -> Some s
  | NumE (_, n1), UnE (`PlusOp, e21) when not (Num.is_neg n1) ->
    match_exp env s e1 e21
  | NumE (numop, n1), UnE (`MinusOp, e21) when Num.is_neg n1 ->
    match_exp env s (reduce_exp env {e1 with it = NumE (numop, Num.abs n1)}) e21
  | NumE (_, n1), UnE (#signop as op, _) ->
    let pm, mp =
      if Num.is_neg n1 = (op = `MinusPlusOp)
      then `PlusOp, `MinusOp else `MinusOp, `PlusOp
    in
    match_exp env
      (Subst.add_unop (Subst.add_unop s `PlusMinusOp pm) `MinusPlusOp mp) e1 e2
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
  | CatE (e11, e12), CatE (e21, e22) ->
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
  | (HoleE _ | FuseE _ | UnparenE _), _
  | _, (HoleE _ | FuseE _ | UnparenE _) -> assert false
  | _, _ when is_head_normal_exp e1 -> None
  | _, _ -> raise Irred

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
  Debug.(log "el.match_sym"
    (fun _ -> fmt "%s =: %s" (el_sym g1) (el_sym g2))
    (fun r -> fmt "%s" (opt el_subst r))
  ) @@ fun _ ->
  match g1.it, g2.it with
  | ParenG g11, _ -> match_sym env s g11 g2
  | _, ParenG g21 -> match_sym env s g1 g21
  | _, VarG (id, []) when Subst.mem_gramid s id ->
    match_sym env s g1 (Subst.subst_sym s g2)
  | _, VarG (id, []) when not (Map.mem id.it env.grams) ->
    (* An unbound id is treated as a pattern variable *)
    Some (Subst.add_gramid s id g1)
  | VarG (id1, args1), VarG (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
  | TupG gs1, TupG gs2 -> match_list match_sym env s gs1 gs2
  | IterG (g11, iter1), IterG (g21, iter2) ->
    let* s' = match_sym env s g11 g21 in match_iter env s' iter1 iter2
  | _, _ -> None


(* Parameters *)

and match_arg env s a1 a2 : subst option =
  Debug.(log "el.match_arg"
    (fun _ -> fmt "%s =: %s" (el_arg a1) (el_arg a2))
    (fun r -> fmt "%s" (opt el_subst r))
  ) @@ fun _ ->
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> match_exp env s e1 e2
  | TypA t1, TypA t2 -> match_typ env s t1 t2
  | GramA g1, GramA g2 -> match_sym env s g1 g2
  | DefA id1, DefA id2 ->
    if id2.it = "_" then Some s else
    Some (Subst.add_defid s id2 id1)
  | _, _ -> assert false


(* Type Equivalence *)

and equiv_typ env t1 t2 =
  Debug.(log "el.equiv_typ"
    (fun _ -> fmt "%s == %s" (el_typ t1) (el_typ t2)) Bool.to_string
  ) @@ fun _ ->
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
  | AtomT atom1, AtomT atom2 -> atom1.it = atom2.it
  | InfixT (t11, atom1, t12), InfixT (t21, atom2, t22) ->
    equiv_typ env t11 t21 && atom1.it = atom2.it && equiv_typ env t12 t22
  | BrackT (atom11, t11, atom12), BrackT (atom21, t21, atom22) ->
    atom11.it = atom21.it && equiv_typ env t11 t21 && atom12 = atom22
  | StrT tfs1, StrT tfs2 -> equiv_nl_list equiv_typfield env tfs1 tfs2
  | CaseT (NoDots, [], tcs1, NoDots), CaseT (NoDots, [], tcs2, NoDots) ->
    equiv_nl_list equiv_typcase env tcs1 tcs2
  | ConT tc1, ConT tc2 -> equiv_typcon env tc1 tc2
  | RangeT tes1, RangeT tes2 -> equiv_nl_list equiv_typenum env tes1 tes2
  | _, _ -> t1.it = t2.it

and equiv_typfield env (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1.it = atom2.it && equiv_typ env t1 t2 && Eq.(eq_nl_list eq_prem prems1 prems2)
and equiv_typcase env (atom1, (t1, prems1), _) (atom2, (t2, prems2), _) =
  atom1.it = atom2.it && equiv_typ env t1 t2 && Eq.(eq_nl_list eq_prem prems1 prems2)
and equiv_typcon env ((t1, prems1), _) ((t2, prems2), _) =
  equiv_typ env t1 t2 && Eq.(eq_nl_list eq_prem prems1 prems2)
and equiv_typenum env (e11, e12o) (e21, e22o) =
  equiv_exp env e11 e21 && equiv_opt equiv_exp env e12o e22o

and equiv_exp env e1 e2 =
  Debug.(log "el.equiv_exp"
    (fun _ -> fmt "%s == %s" (el_exp e1) (el_exp e2)) Bool.to_string
  ) @@ fun _ ->
  (* TODO(3, rossberg): this does not reduce inner type arguments *)
  Eq.eq_exp (reduce_exp env e1) (reduce_exp env e2)

and equiv_arg env a1 a2 =
  Debug.(log "el.equiv_arg"
    (fun _ -> fmt "%s == %s" (el_arg a1) (el_arg a2)) Bool.to_string
  ) @@ fun _ ->
  (*
  Printf.eprintf "[el.equiv_arg] %s == %s\n%!"
    (Print.string_of_arg a1)
    (Print.string_of_arg a2);
  *)
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> equiv_exp env e1 e2
  | TypA t1, TypA t2 -> equiv_typ env t1 t2
  | GramA g1, GramA g2 -> Eq.eq_sym g1 g2
  | DefA id1, DefA id2 -> id1.it = id2.it
  | _, _ -> false


and equiv_functyp env (ps1, t1) (ps2, t2) =
  List.length ps1 = List.length ps2 &&
  match equiv_params env ps1 ps2 with
  | None -> false
  | Some s -> equiv_typ env t1 (Subst.subst_typ s t2)

and equiv_params env ps1 ps2 =
  List.fold_left2 (fun s_opt p1 p2 ->
    let* s = s_opt in
    match p1.it, (Subst.subst_param s p2).it with
    | ExpP (id1, t1), ExpP (id2, t2) ->
      if not (equiv_typ env t1 t2) then None else
      Some (Subst.add_varid s id2 (VarE (id1, []) $ p1.at))
    | TypP _, TypP _ -> Some s
    | GramP (id1, t1), GramP (id2, t2) ->
      if not (equiv_typ env t1 t2) then None else
      Some (Subst.add_gramid s id2 (VarG (id1, []) $ p1.at))
    | DefP (id1, ps1, t1), DefP (id2, ps2, t2) ->
      if not (equiv_functyp env (ps1, t1) (ps2, t2)) then None else
      Some (Subst.add_defid s id2 id1)
    | _, _ -> None
  ) (Some Subst.empty) ps1 ps2


(* Subtyping *)

and sub_prems _env prems1 prems2 =
  Debug.(log "el.sub_prems"
    (fun _ -> fmt "%s <: %s" (nl_list el_prem prems1) (nl_list el_prem prems2))
    Bool.to_string
  ) @@ fun _ ->
  let open Convert in
  forall_nl_list (fun prem2 -> exists_nl_list (Eq.eq_prem prem2) prems1) prems2

and sub_typ env t1 t2 =
  Debug.(log "el.sub_typ"
    (fun _ -> fmt "%s <: %s" (el_typ t1) (el_typ t2)) Bool.to_string
  ) @@ fun _ ->
  let t1 = reduce_typ env t1 in
  let t2 = reduce_typ env t2 in
  match t1.it, t2.it with
(*| NumT nt1, NumT nt2 -> Num.sub nt1 nt2*)
  | StrT tfs1, StrT tfs2 ->
    El.Convert.forall_nl_list (fun (atom, (t2, prems2), _) ->
      match find_field tfs1 atom with
      | Some (t1, prems1) ->
        equiv_typ env t1 t2 && sub_prems env prems1 prems2
      | None -> false
    ) tfs2
  | CaseT (NoDots, [], tcs1, NoDots), CaseT (NoDots, [], tcs2, NoDots) ->
    El.Convert.forall_nl_list (fun (atom, (t1, prems1), _) ->
      match find_case tcs2 atom with
      | Some (t2, prems2) ->
        equiv_typ env t1 t2 && sub_prems env prems1 prems2
      | None -> false
    ) tcs1
  | ConT ((t11, prems1), _), ConT ((t21, prems2), _) ->
    sub_typ env t11 t21 && sub_prems env prems1 prems2 ||
    equiv_typ env t1 t2
(*
  | ConT ((t11, _), _), _ -> sub_typ env t11 t2
  | _, ConT ((t21, _), _) -> sub_typ env t1 t21
  | RangeT [], NumT _ -> true
  | RangeT (Elem (e1, _)::tes1), NumT t2' ->
    (match (reduce_exp env e1).it with
    | NumE _ -> true
    | UnE (`MinusOp, _) -> t2' <= `IntT
    | _ -> assert false
    ) && sub_typ env (RangeT tes1 $ t1.at) t2
  | NumT _, RangeT [] -> true
  | NumT t1', RangeT (Elem (e2, _)::tes2) ->
    (match (reduce_exp env e2).it with
    | NumE (_, `Nat _) -> t1' = `NatT
    | UnE (`MinusOp, _) -> true
    | _ -> assert false
    ) && sub_typ env t1 (RangeT tes2 $ t2.at)
*)
  | TupT ts1, TupT ts2
  | SeqT ts1, SeqT ts2 ->
    List.length ts1 = List.length ts2 && List.for_all2 (sub_typ env) ts1 ts2
  | _, _ -> equiv_typ env t1 t2

and find_field tfs atom =
  El.Convert.find_nl_list (fun (atom', _, _) -> atom'.it = atom.it) tfs
  |> Option.map snd3

and find_case tcs atom =
  El.Convert.find_nl_list (fun (atom', _, _) -> atom'.it = atom.it) tcs
  |> Option.map snd3

and fst3 (x, _, _) = x
and snd3 (_, x, _) = x


(* Type Disjointness *)

and disj_typ env t1 t2 =
  Debug.(log "el.disj_typ"
    (fun _ -> fmt "%s ## %s" (el_typ t1) (el_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match t1.it, t2.it with
  | VarT (id1, args1), VarT (id2, args2) ->
    let t1' = reduce_typ env t1 in
    let t2' = reduce_typ env t2 in
    if t1' <> t1 || t2' <> t2 then
      disj_typ env t1' t2'
    else
      (El.Convert.strip_var_suffix id1).it <> (El.Convert.strip_var_suffix id2).it ||
      disj_list disj_arg env args1 args2
  | VarT _, _ ->
    let t1' = reduce_typ env t1 in
    t1' <> t1 && disj_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ env t2 in
    t2' <> t2 && disj_typ env t1 t2'
  | ParenT t11, _ -> disj_typ env t11 t2
  | _, ParenT t21 -> disj_typ env t1 t21
  | TupT ts1, TupT ts2 | SeqT ts1, SeqT ts2 -> disj_list disj_typ env ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    disj_typ env t11 t21 || not (Eq.eq_iter iter1 iter2)
  | AtomT atom1, AtomT atom2 -> atom1.it <> atom2.it
  | InfixT (t11, atom1, t12), InfixT (t21, atom2, t22) ->
    disj_typ env t11 t21 || atom1.it <> atom2.it || disj_typ env t12 t22
  | BrackT (atom11, t11, atom12), BrackT (atom21, t21, atom22) ->
    atom11.it <> atom21.it || disj_typ env t11 t21 || atom12 = atom22
  | StrT tfs1, StrT tfs2 ->
    unordered (atoms tfs1) (atoms tfs2) ||
    El.Convert.exists_nl_list (fun (atom, (t2, _prems2), _) ->
      match find_field tfs1 atom with
      | Some (t1, _prems1) -> disj_typ env t1 t2
      | None -> true
    ) tfs2
  | CaseT (NoDots, [], tcs1, NoDots), CaseT (NoDots, [], tcs2, NoDots) ->
    Set.disjoint (atoms tcs1) (atoms tcs2) ||
    El.Convert.exists_nl_list (fun (atom, (t1, _prems1), _) ->
      match find_case tcs2 atom with
      | Some (t2, _prems2) -> disj_typ env t1 t2
      | None -> false
    ) tcs1
  | ConT ((t11, _), _), ConT ((t21, _), _) -> disj_typ env t11 t21
  | RangeT _, RangeT _ -> false  (* approximation *)
  | _, _ -> t1.it <> t2.it

and narrow_typ env t1 t2 =
  Debug.(log "el.narrow_typ"
    (fun _ -> fmt "%s <: %s" (el_typ t1) (el_typ t2)) Bool.to_string
  ) @@ fun _ ->
  let t1 = reduce_typ env t1 in
  let t2 = reduce_typ env t2 in
  match t1.it, t2.it with
  | NumT nt1, NumT nt2 -> Num.sub nt1 nt2
  | _, _ -> equiv_typ env t1 t2

and atoms xs =
  Set.of_list (List.map Print.string_of_atom
    (El.Convert.map_filter_nl_list fst3 xs))

and unordered s1 s2 = not Set.(subset s1 s2 || subset s2 s1)

and disj_exp env e1 e2 =
  (* TODO(3, rossberg): this does not reduce inner type arguments *)
  let e1' = reduce_exp env e1 in
  let e2' = reduce_exp env e2 in
  is_normal_exp e1' && is_normal_exp e2' && not (Eq.eq_exp e1' e2')

and disj_arg env a1 a2 =
  match !(a1.it), !(a2.it) with
  | ExpA e1, ExpA e2 -> disj_exp env e1 e2
  | TypA t1, TypA t2 -> disj_typ env t1 t2
  | GramA _, GramA _ -> false
  | DefA _, DefA _ -> false
  | _, _ -> false
