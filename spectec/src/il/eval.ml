open Util
open Source
open Ast
open Xl
open Env


(* Environment *)

type env = Env.t
type subst = Subst.t


(* Helpers *)

(* This exception indicates that a an application cannot be reduced because a pattern
 * match cannot be decided.
 * When assume_coherent_matches is set, that case is treated as a non-match.
 *)
exception Irred

let assume_coherent_matches = ref true

let (let*) = Option.bind

let ($>) it e = {e with it}

let fst3 (x, _, _) = x
let snd3 (_, x, _) = x

let unordered s1 s2 = not Set.(subset s1 s2 || subset s2 s1)


let of_bool_exp = function
  | BoolE b -> Some b
  | _ -> None

let of_num_exp = function
  | NumE n -> Some n
  | _ -> None

let to_bool_exp b = BoolE b
let to_num_exp n = NumE n

let as_opt_exp e =
  match e.it with
  | OptE eo -> eo
  | _ -> failwith "as_opt_exp"

let as_list_exp e =
  match e.it with
  | ListE es -> es
  | _ -> failwith "as_list_exp"


(* Matching Lists *)

let _match_opt match_x env s xo1 xo2 : subst option =
  match xo1, xo2 with
  | None, None -> Some s
  | Some x1, Some x2 -> match_x env s x1 x2
  | _, _ -> None

let rec match_list match_x env s xs1 xs2 : subst option =
  match xs1, xs2 with
  | [], [] -> Some s
  | x1::xs1', x2::xs2' ->
    let* s' = match_x env s x1 x2 in
    match_list match_x env (Subst.union s s') xs1' xs2'
  | _, _ -> None

let equiv_list equiv_x env xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 (equiv_x env) xs1 xs2


(* Type Reduction (weak-head) *)

let rec reduce_typ env t : typ =
  Debug.(log_if "il.reduce_typ" (t.it <> NumT NatT)
    (fun _ -> fmt "%s" (il_typ t))
    (fun r -> fmt "%s" (il_typ r))
  ) @@ fun _ ->
  match t.it with
  | VarT (id, args) ->
    let args' = List.map (reduce_arg env) args in
    (match reduce_typ_app' env id args' t.at (Env.find_opt_typ env id) with
    | Some {it = AliasT t'; _} -> reduce_typ env t'
    | _ -> VarT (id, args') $ t.at
    )
  | _ -> t

and reduce_typdef env t : deftyp =
  let t' = reduce_typ env t in
  match t'.it with
  | VarT (id, as_) ->
    (match reduce_typ_app env id as_ t'.at with
    | Some dt -> dt
    | None -> AliasT t $ t'.at
    )
  | _ -> AliasT t $ t'.at

and reduce_typ_app env id args at : deftyp option =
  Debug.(log "il.reduce_typ_app"
    (fun _ -> fmt "%s(%s)" id.it (il_args args))
    (fun r -> fmt "%s" (opt il_deftyp r))
  ) @@ fun _ ->
  reduce_typ_app' env id (List.map (reduce_arg env) args) at (Env.find_opt_typ env id)

and reduce_typ_app' env id args at = function
  | None -> None  (* id is a type parameter *)
  | Some (_ps, []) ->
    if !assume_coherent_matches then None else
    Error.error at "validation"
      ("undefined instance of partial type `" ^ id.it ^ "`")
  | Some (ps, {it = InstD (_binds, args', dt); _}::insts') ->
    Debug.(log "il.reduce_typ_app'"
      (fun _ -> fmt "%s(%s) =: %s(%s)" id.it (il_args args) id.it (il_args args'))
      (fun r -> fmt "%s" (opt (Fun.const "!") r))
    ) @@ fun _ ->
    match match_list match_arg env Subst.empty args args' with
    | exception Irred ->
      if not !assume_coherent_matches then None else
      reduce_typ_app' env id args at (Some (ps, insts'))
    | None -> reduce_typ_app' env id args at (Some (ps, insts'))
    | Some s -> Some (Subst.subst_deftyp s dt)


(* Expression Reduction *)

and is_head_normal_exp e =
  match e.it with
  | BoolE _ | NumE _ | TextE _
  | OptE _ | ListE _ | TupE _ | CaseE _ | StrE _ -> true
  | SubE (e, _, _) -> is_head_normal_exp e
  | _ -> false

and is_normal_exp e =
  match e.it with
  | BoolE _ | NumE _ | TextE _ -> true
  | ListE es | TupE es -> List.for_all is_normal_exp es
  | OptE None -> true
  | OptE (Some e) | CaseE (_, e) | SubE (e, _, _) -> is_normal_exp e
  | StrE efs -> List.for_all (fun (_, e) -> is_normal_exp e) efs
  | _ -> false

and reduce_exp env e : exp =
  Debug.(log "il.reduce_exp"
    (fun _ -> fmt "%s" (il_exp e))
    (fun e' -> fmt "%s" (il_exp e'))
  ) @@ fun _ ->
  match e.it with
  | VarE _ | BoolE _ | NumE _ | TextE _ -> e
  | UnE (op, e1) ->
    let e1' = reduce_exp env e1 in
    (match op, e1'.it with
    | BoolUnop op', BoolE b1 -> BoolE (Bool.un op' b1) $> e
    | NumUnop (op', _), NumE n1 ->
      (match Num.un op' n1 with
      | Some n -> NumE n
      | None -> UnE (op, e1')
      ) $> e
    | BoolUnop Bool.NotOp, UnE (BoolUnop Bool.NotOp, e11') -> e11'
    | NumUnop (Num.MinusOp, _), UnE (NumUnop (Num.MinusOp, _), e11') -> e11'
    | _ -> UnE (op, e1') $> e
    )
  | BinE (op, e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op with
    | BoolBinop op' ->
      (match Bool.bin_partial op' e1'.it e2'.it of_bool_exp to_bool_exp with
      | None -> BinE (op, e1', e2')
      | Some e' -> e'
      )
    | NumBinop (op', _) ->
      (match Num.bin_partial op' e1'.it e2'.it of_num_exp to_num_exp with
      | None -> BinE (op, e1', e2')
      | Some e' -> e'
      )
    ) $> e
  | CmpE (op, e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match op, e1'.it, e2'.it with
    | EqOp, _, _ when Eq.eq_exp e1' e2' -> BoolE true
    | NeOp, _, _ when Eq.eq_exp e1' e2' -> BoolE false
    | EqOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE false
    | NeOp, _, _ when is_normal_exp e1' && is_normal_exp e2' -> BoolE true
    | NumCmpop (op, _), NumE n1, NumE n2 -> BoolE (Num.cmp op n1 n2)
    | _ -> CmpE (op, e1', e2')
    ) $> e
  | IdxE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | ListE es, NumE (Num.Nat i) when i < Z.of_int (List.length es) -> List.nth es (Z.to_int i)
    | _ -> IdxE (e1', e2') $> e
    )
  | SliceE (e1, e2, e3) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let e3' = reduce_exp env e3 in
    (match e1'.it, e2'.it, e3'.it with
    | ListE es, NumE (Num.Nat i), NumE (Num.Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
      ListE (Lib.List.take (Z.to_int n) (Lib.List.drop (Z.to_int i) es))
    | _ -> SliceE (e1', e2', e3')
    ) $> e
  | UpdE (e1, p, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    reduce_path env e1' p
      (fun e' p' -> if p'.it = RootP then e2' else UpdE (e', p', e2') $> e')
  | ExtE (e1, p, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    reduce_path env e1' p
      (fun e' p' ->
        if p'.it = RootP
        then reduce_exp env (CatE (e', e2') $> e')
        else ExtE (e', p', e2') $> e'
      )
  | StrE efs -> StrE (List.map (reduce_expfield env) efs) $> e
  | DotE (e1, atom) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | StrE efs -> snd (List.find (fun (atomN, _) -> Atom.eq atomN atom) efs)
    | _ -> DotE (e1', atom) $> e
    )
  | CompE (e1, e2) ->
    (* TODO(4, rossberg): avoid overlap with CatE? *)
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> ListE (es1 @ es2)
    | OptE None, OptE _ -> e2'.it
    | OptE _, OptE None -> e1'.it
    | StrE efs1, StrE efs2 ->
      let merge (atom1, e1) (atom2, e2) =
        assert (Atom.eq atom1 atom2);
        (atom1, reduce_exp env (CompE (e1, e2) $> e1))
      in StrE (List.map2 merge efs1 efs2)
    | _ -> CompE (e1', e2')
    ) $> e
  | MemE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e2'.it with
    | OptE None -> BoolE false
    | OptE (Some e2') when Eq.eq_exp e1' e2' -> BoolE true
    | OptE (Some e2') when is_normal_exp e1' && is_normal_exp e2' -> BoolE false
    | ListE [] -> BoolE false
    | ListE es2' when List.exists (Eq.eq_exp e1') es2' -> BoolE true
    | ListE es2' when is_normal_exp e1' && List.for_all is_normal_exp es2' -> BoolE false
    | _ -> MemE (e1', e2')
    ) $> e
  | LenE e1 ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | ListE es -> NumE (Num.Nat (Z.of_int (List.length es)))
    | _ -> LenE e1'
    ) $> e
  | TupE es -> TupE (List.map (reduce_exp env) es) $> e
  | CallE (id, args) ->
    let args' = List.map (reduce_arg env) args in
    let _ps, _t, clauses = Env.find_def env id in
    (* Allow for uninterpreted functions *)
    if not !assume_coherent_matches && clauses = [] then CallE (id, args') $> e else
    (match reduce_exp_call env id args' e.at clauses with
    | None -> CallE (id, args') $> e
    | Some e -> e
    )
  | IterE (e1, iterexp) ->
    let e1' = reduce_exp env e1 in
    let (iter', xes') as iterexp' = reduce_iterexp env iterexp in
    let ids, es' = List.split xes' in
    if not (List.for_all is_head_normal_exp es') || iter' <= List1 && es' = [] then
      IterE (e1', iterexp') $> e
    else
      (match iter' with
      | Opt ->
        let eos' = List.map as_opt_exp es' in
        if List.for_all Option.is_none eos' then
          OptE None $> e
        else if List.for_all Option.is_some eos' then
          let es1' = List.map Option.get eos' in
          let s = List.fold_left2 Subst.add_varid Subst.empty ids es1' in
          reduce_exp env (Subst.subst_exp s e1')
        else
          IterE (e1', iterexp') $> e
      | List | List1 ->
        let n = List.length (as_list_exp (List.hd es')) in
        if iter' = List || n >= 1 then
          let en = NumE (Num.Nat (Z.of_int n)) $$ e.at % (NumT NatT $ e.at) in
          reduce_exp env (IterE (e1', (ListN (en, None), xes')) $> e)
        else
          IterE (e1', iterexp') $> e
      | ListN ({it = NumE (Num.Nat n'); _}, ido) ->
        let ess' = List.map as_list_exp es' in
        let ns = List.map List.length ess' in
        let n = Z.to_int n' in
        if List.for_all ((=) n) ns then
          (TupE (List.init n (fun i ->
            let esI' = List.map (fun es -> List.nth es i) ess' in
            let s = List.fold_left2 Subst.add_varid Subst.empty ids esI' in
            let s' =
              Option.fold ido ~none:s ~some:(fun id ->
                let en = NumE (Num.Nat (Z.of_int i)) $$ id.at % (NumT NatT $ id.at) in
                Subst.add_varid s id en
              )
            in Subst.subst_exp s' e1'
          )) $> e) |> reduce_exp env
        else
          IterE (e1', iterexp') $> e
      | ListN _ ->
        IterE (e1', iterexp') $> e
      )
  | ProjE (e1, i) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | TupE es -> List.nth es i
    | _ -> ProjE (e1', i) $> e
    )
  | UncaseE (e1, mixop) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | CaseE (_, e11') -> e11'
    | _ -> UncaseE (e1', mixop) $> e
    )
  | OptE eo -> OptE (Option.map (reduce_exp env) eo) $> e
  | TheE e1 ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | OptE (Some e11) -> e11
    | _ -> TheE e1' $> e
    )
  | ListE es -> ListE (List.map (reduce_exp env) es) $> e
  | CatE (e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> ListE (es1 @ es2)
    | OptE None, OptE _ -> e2'.it
    | OptE _, OptE None -> e1'.it
    | _ -> CatE (e1', e2')
    ) $> e
  | CaseE (op, e1) -> CaseE (op, reduce_exp env e1) $> e
  | CvtE (e1, _nt1, nt2) ->
    let e1' = reduce_exp env e1 in
    (match e1'.it with
    | NumE n ->
      (match Num.cvt nt2 n with
      | Some n' -> NumE n' $> e
      | None -> e1'
      )
    | _ -> e1'
    )
  | SubE (e1, t1, t2) when equiv_typ env t1 t2 ->
    reduce_exp env e1
  | SubE (e1, t1, t2) ->
    let e1' = reduce_exp env e1 in
    let t1' = reduce_typ env t1 in
    let t2' = reduce_typ env t2 in
    (match e1'.it with
    | SubE (e11', t11', _t12') ->
      reduce_exp env (SubE (e11', t11', t2') $> e)
    | TupE es' ->
      (match t1.it, t2.it with
      | TupT ets1, TupT ets2 ->
        (match
          List.fold_left2 (fun opt eI ((e1I, t1I), (e2I, t2I)) ->
            let* (s1, s2, res') = opt in
            let t1I' = Subst.subst_typ s1 t1I in
            let t2I' = Subst.subst_typ s2 t2I in
            let e1I' = reduce_exp env (Subst.subst_exp s1 e1I) in
            let e2I' = reduce_exp env (Subst.subst_exp s2 e2I) in
            let* s1' = try match_exp env s1 eI e1I' with Irred -> None in
            let* s2' = try match_exp env s2 eI e2I' with Irred -> None in
            let eI' = reduce_exp env (SubE (eI, t1I', t2I') $$ eI.at % t2I') in
            Some (s1', s2', eI'::res')
          ) (Some (Subst.empty, Subst.empty, [])) es' (List.combine ets1 ets2)
        with
        | Some (_, _, res') -> TupE (List.rev res') $> e
        | None -> SubE (e1', t1', t2') $> e
        )
      | _ -> SubE (e1', t1', t2') $> e
      )
    | _ when is_head_normal_exp e1' ->
      {e1' with note = e.note}
    | _ -> SubE (e1', t1', t2') $> e
    )

and reduce_iter env = function
  | ListN (e, ido) -> ListN (reduce_exp env e, ido)
  | iter -> iter

and reduce_iterexp env (iter, xes) =
  (reduce_iter env iter, List.map (fun (id, e) -> id, reduce_exp env e) xes)

and reduce_expfield env (atom, e) : expfield = (atom, reduce_exp env e)

and reduce_path env e p f =
  match p.it with
  | RootP -> f e p
  | IdxP (p1, e1) ->
    let e1' = reduce_exp env e1 in
    let f' e' p1' =
      match e'.it, e1'.it with
      | ListE es, NumE (Num.Nat i) when i < Z.of_int (List.length es) ->
        ListE (List.mapi (fun j eJ -> if Z.of_int j = i then f eJ p1' else eJ) es) $> e'
      | _ ->
        f e' (IdxP (p1', e1') $> p)
    in
    reduce_path env e p1 f'
  | SliceP (p1, e1, e2) ->
    let e1' = reduce_exp env e1 in
    let e2' = reduce_exp env e2 in
    let f' e' p1' =
      match e'.it, e1'.it, e2'.it with
      | ListE es, NumE (Num.Nat i), NumE (Num.Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
        let e1' = ListE Lib.List.(take (Z.to_int i) es) $> e' in
        let e2' = ListE Lib.List.(take (Z.to_int n) (drop (Z.to_int i) es)) $> e' in
        let e3' = ListE Lib.List.(drop Z.(to_int (i + n)) es) $> e' in
        reduce_exp env (CatE (e1', CatE (f e2' p1', e3') $> e') $> e')
      | _ ->
        f e' (SliceP (p1', e1', e2') $> p)
    in
    reduce_path env e p1 f'
  | DotP (p1, atom) ->
    let f' e' p1' =
      match e'.it with
      | StrE efs ->
        StrE (List.map (fun (atomI, eI) ->
          if Eq.eq_atom atomI atom then (atomI, f eI p1') else (atomI, eI)) efs) $> e'
      | _ ->
        f e' (DotP (p1', atom) $> p)
    in
    reduce_path env e p1 f'

and reduce_arg env a : arg =
  Debug.(log "il.reduce_arg"
    (fun _ -> fmt "%s" (il_arg a))
    (fun a' -> fmt "%s" (il_arg a'))
  ) @@ fun _ ->
  match a.it with
  | ExpA e -> ExpA (reduce_exp env e) $ a.at
  | TypA _t -> a  (* types are reduced on demand *)
  | DefA _id -> a
  | GramA _g -> a

and reduce_exp_call env id args at = function
  | [] ->
    if !assume_coherent_matches then None else
    Error.error at "validation"
      ("undefined call to partial function `$" ^ id.it ^ "`")
  | {it = DefD (_binds, args', e, prems); _}::clauses' ->
    Debug.(log "il.reduce_exp_call"
      (fun _ -> fmt "$%s(%s) =: $%s(%s)" id.it (il_args args) id.it (il_args args'))
      (function None -> "-" | Some e' -> fmt "%s" (il_exp e'))
    ) @@ fun _ ->
    assert (List.for_all (fun a -> Eq.eq_arg a (reduce_arg env a)) args);
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
  | RulePr _ -> None
  | IfPr e ->
    (match (reduce_exp env e).it with
    | BoolE b -> Some b
    | _ -> None
    )
  | ElsePr -> Some true
  | LetPr (e1, e2, _ids) ->
    (match match_exp env Subst.empty e2 e1 with
    | Some _ -> Some true  (* TODO(2, rossberg): need to keep substitution? *)
    | None -> None
    | exception Irred -> None
    )
  | IterPr (_prem, _iter) -> None  (* TODO(3, rossberg): reduce? *)


(* Matching *)

(* Iteration *)

and match_iter env s iter1 iter2 : subst option =
  match iter1, iter2 with
  | Opt, Opt -> Some s
  | List, List -> Some s
  | List1, List1 -> Some s
  | ListN (e1, _ido1), ListN (e2, _ido2) -> match_exp env s e1 e2
  | (Opt | List1 | ListN _), List -> Some s
  | _, _ -> None


(* Types *)

and match_typ env s t1 t2 : subst option =
  match t1.it, t2.it with
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
  | TupT ets1, TupT ets2 -> match_list match_typbind env s ets1 ets2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    let* s' = match_typ env s t11 t21 in match_iter env s' iter1 iter2
  | _, _ -> None

and match_typbind env s (e1, t1) (e2, t2) =
  let* s' = match_exp env s e1 (Subst.subst_exp s e2) in
  let* s'' = match_typ env s' t1 (Subst.subst_typ s t2) in
  Some s''


(* Expressions *)

and match_exp env s e1 e2 : subst option =
  match_exp' env s (reduce_exp env e1) e2

and match_exp' env s e1 e2 : subst option =
  Debug.(log "il.match_exp"
    (fun _ -> fmt "%s : %s =: %s" (il_exp e1) (il_typ e1.note) (il_exp (Subst.subst_exp s e2)))
    (fun r -> fmt "%s" (opt il_subst r))
  ) @@ fun _ ->
  assert (Eq.eq_exp e1 (reduce_exp env e1));
  if Eq.eq_exp e1 e2 then Some s else  (* HACK around subtype elim pass introducing calls on LHS's *)
  match e1.it, (reduce_exp env (Subst.subst_exp s e2)).it with
  | _, VarE id when Subst.mem_varid s id ->
    (* A pattern variable already in the substitution is non-linear *)
    if equiv_exp env e1 (Subst.subst_exp s e2) then
      Some s
    else
      None
  | _, VarE id ->
    (* Treat as a fresh pattern variable. *)
    let e1' = reduce_exp env (SubE (e1, e1.note, e2.note) $$ e1.at % e2.note) in
    Some (Subst.add_varid s id e1')
  | BoolE b1, BoolE b2 when b1 = b2 -> Some s
  | NumE n1, NumE n2 when n1 = n2 -> Some s
  | TextE s1, TextE s2 when s1 = s2 -> Some s
(*
  | UnE (op1, e11), UnE (op2, e21) when op1 = op2 -> match_exp' env s e11 e21
  | BinE (e11, op1, e12), BinE (e21, op2, e22) when op1 = op2 ->
    let* s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | CmpE (e11, op1, e12), CmpE (e21, op2, e22) when op1 = op2 ->
    let* s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | (EpsE | SeqE []), (EpsE | SeqE []) -> Some s
*)
  | ListE es1, ListE es2
  | TupE es1, TupE es2 -> match_list match_exp' env s es1 es2
  | _, TupE es2 ->
    let* es1 = eta_tup_exp env e1 in
    match_list match_exp' env s es1 es2
  | ListE es1, CatE ({it = ListE es21; _} as e21, e22)
    when List.length es21 <= List.length es1 ->
    let es11, es12 = Lib.List.split (List.length es21) es1 in
    let* s' = match_exp' env s (ListE es11 $> e1) e21 in
    match_exp' env s' (ListE es12 $> e1) e22
  | ListE es1, CatE (e21, ({it = ListE es22; _} as e22))
    when List.length es22 <= List.length es1 ->
    let es11, es12 = Lib.List.split (List.length es22) es1 in
    let* s' = match_exp' env s (ListE es11 $> e1) e21 in
    match_exp' env s' (ListE es12 $> e1) e22
(*
  | IdxE (e11, e12), IdxE (e21, e22)
  | CommaE (e11, e12), CommaE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22) ->
    let* s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    let* s' = match_exp' env s e11 e21 in
    let* s'' = match_exp' env s' e12 e22 in
    match_exp' env s'' e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    let* s' = match_exp' env s e11 e21 in
    let* s'' = match_path env s' p1 p2 in
    match_exp' env s'' e12 e22
*)
  | StrE efs1, StrE efs2 -> match_list match_expfield env s efs1 efs2
(*
  | DotE (e11, atom1), DotE (e21, atom2) when Eq.eq_atom atom1 atom2 ->
    match_exp' env s e11 e21
  | LenE e11, LenE e21 -> match_exp' env s e11 e21
*)
  | CaseE (op1, e11), CaseE (op2, e21) when Eq.eq_mixop op1 op2 ->
    match_exp' env s e11 e21
(*
  | CallE (id1, args1), CallE (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
*)
  | _, UncaseE (e21, mixop) ->
    match_exp' env s (CaseE (mixop, e1) $$ e1.at % e21.note) e21
  | _, ProjE (e21, 0) ->  (* only valid on unary tuples! *)
    match_exp' env s (TupE [e1] $$ e1.at % e21.note) e21
(*
  | IterE (e11, iter1), IterE (e21, iter2) ->
    let* s' = match_exp' env s e11 e21 in
    match_iterexp env s' iter1 iter2
  | _, IterE (e21, iter2) ->
    let e11, iter1 = eta_iter_exp env e1 in
    let* s' = match_exp' env s e11 e21 in
    match_iterexp env s' iter1 iter2
*)
  | OptE None, IterE (_e21, (Opt, xes)) ->
    List.fold_left (fun s_opt (_xI, eI) ->
      let* s = s_opt in
      match_exp' env s e1 eI
    ) (Some s) xes
  | OptE (Some e11), IterE (e21, (Opt, xes)) ->
    let* s' = match_exp' env s e11 e21 in
    let* s'' =
      List.fold_left (fun s_opt (xI, exI) ->
        let* s = s_opt in
        match_exp' env s (OptE (Some (Subst.subst_exp s' (VarE xI $> exI))) $> e2) exI
      ) (Some (List.fold_left Subst.remove_varid s (List.map fst xes))) xes
    in Some (Subst.union s'' s)  (* re-add possibly locally shadowed bindings *)
  | ListE _es1, IterE (e21, (List, xes)) ->
    let en = VarE ("_" $ e2.at) $$ e2.at % (NumT NatT $ e2.at) in
    match_exp' env s e1 (IterE (e21, (ListN (en, None), xes)) $> e2)
  | ListE es1, IterE (e21, (List1, xes)) ->
    if es1 = [] then None else
    let en = VarE ("_" $ e2.at) $$ e2.at % (NumT NatT $ e2.at) in
    match_exp' env s e1 (IterE (e21, (ListN (en, None), xes)) $> e2)
  | ListE es1, IterE (e21, (ListN (en, id_opt), xes)) ->
    let en' = NumE (Num.Nat (Z.of_int (List.length es1))) $$ e1.at % (NumT NatT $ e1.at) in
    let* s' = match_exp' env s en' en in
    let s'' = List.fold_left Subst.remove_varid s' (List.map fst xes) in  (* local subst *)
    (* match each list element against iteration body for corresponding subst *)
    let* ss =
      List.mapi (fun j e1J ->
        let s''' =
          match id_opt with
          | None -> s''
          | Some xJ ->
            Subst.add_varid s'' xJ
              (NumE (Num.Nat (Z.of_int j)) $$ e1.at % (NumT NatT $ e1.at))
        in match_exp' env s''' e1J (Subst.subst_exp s''' e21)
      ) es1 |> Lib.List.flatten_opt
    in
    (* now project list for each iteration variable and match against rhs's *)
    let xs, exs = List.split xes in
    let* s''' =
      match_list (fun env s xI exI ->
        let eI = ListE (List.map (fun sJ -> Subst.subst_exp sJ (VarE xI $> exI)) ss) $> e2 in
        match_exp' env s eI exI
      ) env s' xs exs
    in Some (Subst.union s''' s)  (* re-add possibly locally shadowed bindings *)
  | _, IterE (e21, iter2) ->
    let e11, iter1 = eta_iter_exp env e1 in
    let* s' = match_exp' env s e11 e21 in
    match_iterexp env s' iter1 iter2
  | SubE (e11, t11, _t12), SubE (e21, t21, _t22) when sub_typ env t11 t21 ->
    match_exp' env s (reduce_exp env (SubE (e11, t11, t21) $> e21)) e21
  | SubE (_e11, t11, _t12), SubE (_e21, t21, _t22) when disj_typ env t11 t21 ->
    None
  | _, SubE (e21, t21, _t22) ->
    if sub_typ env e1.note t21 then
      match_exp' env s (reduce_exp env (SubE (e1, e1.note, t21) $> e21)) e21
    else if is_head_normal_exp e1 then
      let t21' = reduce_typ env t21 in
      if
        match e1.it, t21'.it with
        | BoolE _, BoolT
        | NumE _, NumT _
        | TextE _, TextT -> true
        | CaseE (op, _), VarT _ ->
          (match (reduce_typdef env t21).it with
          | VariantT tcs ->
            (* Assumes that we only have shallow subtyping. *)
            List.exists (fun (opN, _, _) -> Eq.eq_mixop opN op) tcs
          | _ -> false
          )
        | VarE id1, _ ->
          let t1 = reduce_typ env (Env.find_var env id1) in
          sub_typ env t1 t21 || raise Irred
        | _, _ -> false
      then match_exp' env s {e1 with note = t21} e21
      else None
    else raise Irred
  | _, _ when is_head_normal_exp e1 -> None
  | _, _ ->
    raise Irred

and match_expfield env s (atom1, e1) (atom2, e2) =
  if not (Eq.eq_atom atom1 atom2) then None else
  match_exp' env s e1 e2

and match_iterexp env s (iter1, _ids1) (iter2, _ids2) =
  match_iter env s iter1 iter2


and eta_tup_exp env e : exp list option =
  let ets =
    match (reduce_typ env e.note).it with
    | TupT ets -> ets
    | _ -> assert false
  in
  let* es' =
    List.fold_left (fun opt (eI, tI) ->
      let* res', i, s = opt in
      let eI' = ProjE (e, i) $$ e.at % Subst.subst_typ s tI in
      let* s' = try match_exp env s eI' eI with Irred -> None in
      Some (eI'::res', i + 1, s')
    ) (Some ([], 0, Subst.empty)) ets |> Option.map fst3 |> Option.map List.rev
  in Some es'

and eta_iter_exp env e : exp * iterexp =
  match (reduce_typ env e.note).it with
  | IterT (t, Opt) -> reduce_exp env (TheE e $$ e.at % t), (Opt, [])
  | IterT (t, List) ->
    let id = "_i_" $ e.at in
    let len = reduce_exp env (LenE e $$ e.at % (NumT NatT $ e.at)) in
    IdxE (e, VarE id $$ e.at % (NumT NatT $ e.at)) $$ e.at % t,
    (ListN (len, Some id), [])
  | _ -> assert false


(* Grammars *)

and match_sym env s g1 g2 : subst option =
  Debug.(log_in "il.match_sym" (fun _ -> fmt "%s =: %s" (il_sym g1) (il_sym g2)));
  match g1.it, g2.it with
  | _, VarG (id, []) when Subst.mem_gramid s id ->
    match_sym env s g1 (Subst.subst_sym s g2)
  | _, VarG (id, []) when not (Map.mem id.it env.grams) ->
    (* An unbound grammar is treated as a pattern variable *)
    Some (Subst.add_gramid s id g1)
  | VarG (id1, args1), VarG (id2, args2) when id1.it = id2.it ->
    match_list match_arg env s args1 args2
  | IterG (g11, iter1), IterG (g21, iter2) ->
    let* s' = match_sym env s g11 g21 in match_iterexp env s' iter1 iter2
  | _, _ -> None


(* Parameters *)

and match_arg env s a1 a2 : subst option =
  Debug.(log_in "il.match_arg" (fun _ -> fmt "%s =: %s" (il_arg a1) (il_arg a2)));
  match a1.it, a2.it with
  | ExpA e1, ExpA e2 -> match_exp env s e1 e2
  | TypA t1, TypA t2 -> match_typ env s t1 t2
  | DefA id1, DefA id2 -> Some (Subst.add_defid s id1 id2)
  | GramA g1, GramA g2 -> match_sym env s g1 g2
  | _, _ -> assert false


(* Type Equivalence *)

and equiv_typ env t1 t2 =
  Debug.(log "il.equiv_typ"
    (fun _ -> fmt "%s == %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match t1.it, t2.it with
  | VarT (id1, as1), VarT (id2, as2) ->
    id1.it = id2.it && equiv_list equiv_arg env as1 as2 || (* optimization *)
    let t1' = reduce_typ env t1 in
    let t2' = reduce_typ env t2 in
    (t1 <> t1' || t2 <> t2') && equiv_typ env t1' t2' ||
    Eq.eq_deftyp (reduce_typdef env t1') (reduce_typdef env t2')  (* TODO(3, rossberg): be more expressive *)
  | VarT _, _ ->
    let t1' = reduce_typ env t1 in
    t1 <> t1' && equiv_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ env t2 in
    t2 <> t2' && equiv_typ env t1 t2'
  | TupT ets1, TupT ets2 -> equiv_tup env Subst.empty ets1 ets2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    equiv_typ env t11 t21 && equiv_iter env iter1 iter2
  | _, _ ->
    t1.it = t2.it

and equiv_tup env s ets1 ets2 =
  match ets1, ets2 with
  | (e1, t1)::ets1', (e2, t2)::ets2' ->
    equiv_typ env t1 (Subst.subst_typ s t2) &&
    (match match_exp env s e1 e2 with
    | None -> false
    | Some s' -> equiv_tup env s' ets1' ets2'
    | exception Irred -> false
    )
  | _, _ -> ets1 = ets2

and equiv_iter env iter1 iter2 =
  match iter1, iter2 with
  | ListN (e1, ido1), ListN (e2, ido2) ->
    equiv_exp env e1 e2 && Option.equal (fun id1 id2 -> id1.it = id2.it) ido1 ido2
  | _, _ -> iter1 = iter2

(*
and equiv_prem env pr1 pr2 =
  match pr1.it, pr2.it with
  | RulePr (id1, mixop1, e1), RulePr (id2, mixop2, e2) ->
    id1.it = id2.it && Eq.eq_mixop mixop1 mixop2 && equiv_exp env e1 e2
  | IfPr e1, IfPr e2 -> equiv_exp env e1 e2
  | LetPr (e11, e12, _ids1), LetPr (e21, e22, _id2) ->
    equiv_exp env e11 e21 && equiv_exp env e12 e22
  | IterPr (pr11, iter1), IterPr (pr21, iter2) ->
    equiv_prem env pr11 pr21 && equiv_iter env (fst iter1) (fst iter2)
  | pr1', pr2' -> pr1' = pr2'
*)

and equiv_exp env e1 e2 =
  Debug.(log "il.equiv_exp"
    (fun _ -> fmt "%s == %s" (il_exp e1) (il_exp e2)) Bool.to_string
  ) @@ fun _ ->
  (* TODO(3, rossberg): this does not reduce inner type arguments *)
  Eq.eq_exp (reduce_exp env e1) (reduce_exp env e2)

and equiv_sym _env g1 g2 =
  Debug.(log "il.equiv_sym"
    (fun _ -> fmt "%s == %s" (il_sym g1) (il_sym g2)) Bool.to_string
  ) @@ fun _ ->
  Eq.eq_sym g1 g2

and equiv_arg env a1 a2 =
  Debug.(log "il.equiv_arg"
    (fun _ -> fmt "%s == %s" (il_arg a1) (il_arg a2)) Bool.to_string
  ) @@ fun _ ->
  match a1.it, a2.it with
  | ExpA e1, ExpA e2 -> equiv_exp env e1 e2
  | TypA t1, TypA t2 -> equiv_typ env t1 t2
  | DefA id1, DefA id2 -> id1.it = id2.it
  | GramA g1, GramA g2 -> equiv_sym env g1 g2
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
      Some (Subst.add_varid s id2 (VarE id1 $$ p1.at % t1))
    | TypP _, TypP _ -> Some s
    | DefP (id1, ps1, t1), DefP (id2, ps2, t2) ->
      if not (equiv_functyp env (ps1, t1) (ps2, t2)) then None else
      Some (Subst.add_defid s id2 id1)
    | GramP (id1, t1), GramP (id2, t2) ->
      if not (equiv_typ env t1 t2) then None else
      Some (Subst.add_gramid s id2 (VarG (id1, []) $ p1.at))
    | _, _ -> assert false
  ) (Some Subst.empty) ps1 ps2


(* Subtyping *)

and sub_prems _env prems1 prems2 =
  List.for_all (fun prem2 -> List.exists (Eq.eq_prem prem2) prems1) prems2

and sub_typ env t1 t2 =
  Debug.(log "il.sub_typ"
    (fun _ -> fmt "%s <: %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  equiv_typ env t1 t2 ||
  let t1' = reduce_typ env t1 in
  let t2' = reduce_typ env t2 in
  match t1'.it, t2'.it with
(*| NumT t1', NumT t2' -> t1' <= t2'*)
  | TupT ets1, TupT ets2 -> sub_tup env Subst.empty ets1 ets2
  | VarT _, VarT _ ->
    (match (reduce_typdef env t1').it, (reduce_typdef env t2').it with
    | StructT tfs1, StructT tfs2 ->
      List.for_all (fun (atom, (_binds2, t2, prems2), _) ->
        match find_field tfs1 atom with
        | Some (_binds1, t1, prems1) ->
          sub_typ env t1 t2 && sub_prems env prems1 prems2
        | None -> false
      ) tfs2
    | VariantT tcs1, VariantT tcs2 ->
      List.for_all (fun (mixop, (_binds1, t1, prems1), _) ->
        match find_case tcs2 mixop with
        | Some (_binds2, t2, prems2) ->
          sub_typ env t1 t2 && sub_prems env prems1 prems2
        | None -> false
      ) tcs1
    | _, _ -> false
    )
  | _, _ ->
    false

and sub_tup env s ets1 ets2 =
  match ets1, ets2 with
  | (e1, t1)::ets1', (e2, t2)::ets2' ->
    sub_typ env t1 (Subst.subst_typ s t2) &&
    (match match_exp env s e1 e2 with
    | None -> false
    | Some s' -> sub_tup env s' ets1' ets2'
    | exception Irred -> false
    )
  | _, _ -> ets1 = ets2


and find_field tfs atom =
  List.find_opt (fun (atom', _, _) -> Eq.eq_atom atom' atom) tfs |> Option.map snd3

and find_case tcs op =
  List.find_opt (fun (op', _, _) -> Eq.eq_mixop op' op) tcs |> Option.map snd3


(* Type Disjointness *)

and disj_typ env t1 t2 =
  Debug.(log "il.disj_typ"
    (fun _ -> fmt "%s ## %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match t1.it, t2.it with
  | VarT _, VarT _ ->
    (match (reduce_typdef env t1).it, (reduce_typdef env t2).it with
    | StructT tfs1, StructT tfs2 ->
      unordered (atoms tfs1) (atoms tfs2) ||
      List.exists (fun (atom, (_binds2, t2, _prems2), _) ->
        match find_field tfs1 atom with
        | Some (_binds1, t1, _prems1) -> disj_typ env t1 t2
        | None -> true
      ) tfs2
    | VariantT tcs1, VariantT tcs2 ->
      Set.disjoint (mixops tcs1) (mixops tcs2) ||
      List.exists (fun (atom, (_binds1, t1, _prems1), _) ->
        match find_case tcs2 atom with
        | Some (_binds2, t2, _prems2) -> disj_typ env t1 t2
        | None -> false
      ) tcs1
    | _, _ -> true
    )
  | VarT _, _ ->
    let t1' = reduce_typ env t1 in
    t1 <> t1' && disj_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ env t2 in
    t2 <> t2' && disj_typ env t1 t2'
  | TupT ets1, TupT ets2 -> disj_tup env Subst.empty ets1 ets2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    disj_typ env t11 t21 || not (Eq.eq_iter iter1 iter2)
  | _, _ ->
    t1.it <> t2.it

and atoms xs = Set.of_list (List.map Print.string_of_atom (List.map fst3 xs))
and mixops xs = Set.of_list (List.map Print.string_of_mixop (List.map fst3 xs))

and disj_tup env s ets1 ets2 =
  match ets1, ets2 with
  | (e1, t1)::ets1', (e2, t2)::ets2' ->
    disj_typ env t1 (Subst.subst_typ s t2) ||
    (match match_exp env s e1 e2 with
    | None -> false
    | Some s' -> disj_tup env s' ets1' ets2'
    | exception Irred -> false
    )
  | _, _ -> ets1 = ets2
