open Util
open Source
open Ast
open Xl
open Env


(* Environment *)

type env = Env.t
type subst = Subst.t


(* Helpers *)

let assume_coherent_matches = ref true

type 'a result = ('a, 'a) Result.t

let static f env x =
  let (Ok y | Error y) = f true env x in Ok y

let static3 f env x1 x2 x3 =
  let (Ok y | Error y) = f true env x1 x2 x3 in Ok y

let (let*) = Option.bind

let (let**) xr f =
  match xr with
  | Ok x -> f x
  | Error x -> let Ok y | Error y = f x in Error y

let (let***) xor f =
  let** xo = xor in
  match xo with
  | None -> Ok None
  | Some x -> f x

let rec map_results f = function
  | [] -> Ok []
  | x::xs -> let** y = f x in let** ys = map_results f xs in Ok (y::ys)


let error_typ at t expect =
  Error.error at "validation"
    ("type `" ^ Print.string_of_typ t ^ "` is not " ^ expect)


let ($>) it e = {e with it}

let unordered s1 s2 = not Set.(subset s1 s2 || subset s2 s1)

let il_result f = function
  | Ok x -> f x
  | Error x -> "FAIL(" ^ f x ^ ")"

let il_opt_result f = function
  | Ok (Some x) -> f x
  | Ok None -> "?"
  | Error _ -> "FAIL"


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

let _match_opt match_x env s xo1 xo2 : subst option result =
  match xo1, xo2 with
  | None, None -> Ok (Some s)
  | Some x1, Some x2 -> match_x env s x1 x2
  | _, _ -> Error None

let rec match_list match_x env s xs1 xs2 : subst option result =
  match xs1, xs2 with
  | [], [] -> Ok (Some s)
  | x1::xs1', x2::xs2' ->
    let*** s' = match_x env s x1 x2 in
    match_list match_x env (Subst.union s s') xs1' xs2'
  | _, _ -> Error None

let equiv_list equiv_x env xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 (equiv_x env) xs1 xs2


(* Type Reduction (weak-head) *)

let rec reduce_typ env t : typ result =
  Debug.(log_if "il.reduce_typ" (t.it <> NumT `NatT)
    (fun _ -> fmt "%s" (il_typ t))
    (fun r -> fmt "%s" (il_result il_typ r))
  ) @@ fun _ ->
  match t.it with
  | VarT (id, as_) ->
    let** as' = map_results (static reduce_arg env) as_ in
    let** dto = reduce_typ_app env id as' (Env.find_opt_typ env id) t.at in
    (match dto with
    | Some {it = AliasT t'; _} -> reduce_typ env t'
    | _ -> Ok (VarT (id, as') $ t.at)
    )
  | _ -> Ok t

and reduce_typdef env t : deftyp result =
  let** t' = reduce_typ env t in
  match t'.it with
  | VarT (id, as_) ->
    let** dto = reduce_typ_app env id as_ (Env.find_opt_typ env id) t'.at in
    (match dto with
    | Some dt -> Ok dt
    | None -> Ok (AliasT t $ t'.at)
    )
  | _ -> Ok (AliasT t $ t'.at)

and reduce_typ_app env id as_ tdo at : deftyp option result =
  Debug.(log "il.reduce_typ_app"
    (fun _ -> fmt "%s(%s)" id.it (il_args as_))
    (fun r -> fmt "%s" (il_opt_result il_deftyp r))
  ) @@ fun _ ->
  match tdo with
  | None -> Ok None  (* id is a type parameter *)
  | Some (_ps, []) -> if !assume_coherent_matches then Ok None else Error None
  | Some (ps, {it = InstD (_ps, as', dt); _}::insts') ->
    match match_list (static3 match_arg) env Subst.empty as_ as' with
    | Ok (Some s) -> Ok (Some (Subst.subst_deftyp s dt))
    | Error _ -> reduce_typ_app env id as_ (Some (ps, insts')) at
    | Ok None ->
      if not !assume_coherent_matches then Ok None else
      match reduce_typ_app env id as_ (Some (ps, insts')) at with
      | Error _ -> Ok None
      | ok -> ok

and reduce_typ_ok env t =
  match reduce_typ env t with
  | Ok t -> t
  | Error _ -> error_typ t.at t "defined"

and reduce_typdef_ok env t =
  match reduce_typdef env t with
  | Ok dt -> dt
  | Error _ -> error_typ t.at t "defined"

and as_tup_typ env t at : (id * typ) list =
  match (reduce_typ_ok env t).it with
  | TupT xts -> xts
  | _ -> error_typ at t "a tuple"

and as_iter_typ env t at : typ * iter =
  match (reduce_typ_ok env t).it with
  | IterT (t1, it) -> t1, it
  | _ -> error_typ at t "an iteration"

and as_struct_typ env t at : typfield list =
  match (reduce_typdef_ok env t).it with
  | StructT tfs -> tfs
  | _ -> error_typ at t "a record"

and as_variant_typ env t at : typcase list =
  match (reduce_typdef_ok env t).it with
  | VariantT tcs -> tcs
  | _ -> error_typ at t "a variant"

and find_typfield t tfs atom at =
  match List.find_opt (fun (atom', _, _) -> Eq.eq_atom atom' atom) tfs with
  | Some (_, x, _) -> x
  | None ->
    error_typ at t ("a record with field `" ^ Print.string_of_atom atom ^ "`")

and find_typcase t tcs op at =
  match List.find_opt (fun (op', _, _) -> Eq.eq_mixop op' op) tcs with
  | Some (_, x, _) -> x
  | None ->
    error_typ at t ("a variant with case `" ^ Print.string_of_mixop op ^ "`")


(* Expression Reduction *)

and is_normal_arg static env a =  (* only for assertions *)
  match reduce_arg static env a with
  | Ok a' | Error a' -> Eq.eq_arg a a'

and is_normal_exp static env e =  (* only for assertions *)
  match reduce_exp static env e with
  | Ok e' | Error e' -> Eq.eq_exp e e'

and is_head_normal_exp e =
  match e.it with
  | BoolE _ | NumE _ | TextE _
  | OptE _ | ListE _ | TupE _ | CaseE _ | StrE _ -> true
  | SubE (e, _, _) -> is_head_normal_exp e
  | _ -> false

and is_value_exp e =
  match e.it with
  | BoolE _ | NumE _ | TextE _ -> true
  | ListE es | TupE es -> List.for_all is_value_exp es
  | OptE None -> true
  | OptE (Some e) | CaseE (_, e, Checked) | SubE (e, _, _) -> is_value_exp e
  | StrE (efs, Checked) -> List.for_all (fun (_, e) -> is_value_exp e) efs
  | _ -> false

and reduce_exp static env e : exp result =
  Debug.(log ("il.reduce_exp" ^ if static then " static" else "")
    (fun _ -> fmt "%s" (il_exp e))
    (fun e' -> fmt "%s" (il_result il_exp e'))
  ) @@ fun _ ->
  match e.it with
  | VarE _ | BoolE _ | NumE _ | TextE _ -> Ok e
  | UnE (op, ot, e1) ->
    let** e1' = reduce_exp static env e1 in
    (match op, e1'.it with
    | #Bool.unop as op', BoolE b1 -> Ok (BoolE (Bool.un op' b1) $> e)
    | #Num.unop as op', NumE n1 ->
      (match Num.un op' n1 with
      | Some n -> Ok (NumE n $> e)
      | None -> Error (UnE (op, ot, e1') $> e)
      )
    | `NotOp, UnE (`NotOp, _, e11') -> Ok e11'
    | `MinusOp, UnE (`MinusOp, _, e11') -> Ok e11'
    | _ -> Ok (UnE (op, ot, e1') $> e)
    )
  | BinE (op, ot, e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match op with
    | #Bool.binop as op' ->
      (match Bool.bin_partial op' e1'.it e2'.it of_bool_exp to_bool_exp with
      | None -> Ok (BinE (op, ot, e1', e2') $> e)
      | Some e' -> Ok (e' $> e)
      )
    | #Num.binop as op' ->
      (match Num.bin_partial op' e1'.it e2'.it of_num_exp to_num_exp with
      | None -> Ok (BinE (op, ot, e1', e2') $> e)
      | Some None -> Error (BinE (op, ot, e1', e2') $> e)
      | Some (Some e') -> Ok (e' $> e)
      )
    )
  | CmpE (op, ot, e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match op, e1'.it, e2'.it with
    | `EqOp, _, _ when static || is_value_exp e1' && is_value_exp e2' ->
      Ok (BoolE (Eq.eq_exp e1' e2') $> e)
    | `NeOp, _, _ when is_value_exp e1' && is_value_exp e2' ->
      Ok (BoolE (not (Eq.eq_exp e1' e2')) $> e)
    | #Num.cmpop as op', NumE n1, NumE n2 ->
      (match Num.cmp op' n1 n2 with
      | Some b -> Ok (BoolE b $> e)
      | None -> Ok (CmpE (op, ot, e1', e2') $> e)
      )
    | _ -> Ok (CmpE (op, ot, e1', e2') $> e)
    )
  | IdxE (e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match e1'.it, e2'.it with
    | ListE es, NumE (`Nat i) when i < Z.of_int (List.length es) ->
      Ok (List.nth es (Z.to_int i))
    | _ -> Error (IdxE (e1', e2') $> e)
    )
  | SliceE (e1, e2, e3) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    let** e3' = reduce_exp static env e3 in
    (match e1'.it, e2'.it, e3'.it with
    | ListE es, NumE (`Nat i), NumE (`Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
      Ok (ListE (Lib.List.take (Z.to_int n) (Lib.List.drop (Z.to_int i) es)) $> e)
    | _ -> Error (SliceE (e1', e2', e3') $> e)
    )
  | UpdE (e1, p, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    reduce_path static env e1' p
      (fun e' p' ->
        if p'.it = RootP
        then Ok e2'
        else Ok (UpdE (e', p', e2') $> e')
      )
  | ExtE (e1, p, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    reduce_path static env e1' p
      (fun e' p' ->
        if p'.it = RootP
        then reduce_exp static env (CatE (e', e2') $> e')
        else Ok (ExtE (e', p', e2') $> e')
      )
  | StrE (efs, ch) ->
    let tfs = as_struct_typ env e.note e.at in
    let** ef_chs' = map_results (reduce_expfield static env e.note tfs ch) efs in
    let efs', chs' = List.split ef_chs' in
    let ch' = if List.for_all ((=) Checked) chs' then Checked else Unchecked in
    Ok (StrE (efs', ch') $> e)
  | DotE (e1, atom) ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | StrE (efs, Checked) when static || is_value_exp e1' ->
      Ok (snd (List.find (fun (atomN, _) -> Atom.eq atomN atom) efs))
    | _ -> Ok (DotE (e1', atom) $> e)
    )
  | CompE (e1, e2) ->
    (* TODO(4, rossberg): avoid overlap with CatE? *)
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> Ok (ListE (es1 @ es2) $> e)
    | OptE None, OptE _ -> Ok e2'
    | OptE _, OptE None -> Ok e1'
    | StrE (efs1, Checked), StrE (efs2, Checked) ->
      let tfs = as_struct_typ env e.note e.at in
      let merge ((atom1, e1), (atom2, e2)) =
        assert (Atom.eq atom1 atom2);
        reduce_expfield static env e.note tfs Checked (atom1, CompE (e1, e2) $> e1)
      in
      assert (List.length efs1 = List.length efs2);
      let** ef_chs' = map_results merge (List.combine efs1 efs2) in
      let efs', _chs = List.split ef_chs' in
      Ok (StrE (efs', Checked) $> e)
    | _ -> Ok (CompE (e1', e2') $> e)
    )
  | MemE (e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match e2'.it with
    | OptE None -> Ok (BoolE false $> e)
    | OptE (Some e2') when static || is_value_exp e1' && is_value_exp e2' ->
      Ok (BoolE (Eq.eq_exp e1' e2') $> e)
    | ListE [] -> Ok (BoolE false $> e)
    | ListE es2' when static || is_value_exp e1' && List.for_all is_value_exp es2' ->
      Ok (BoolE (List.exists (Eq.eq_exp e1') es2') $> e)
    | _ -> Ok (MemE (e1', e2') $> e)
    )
  | LenE e1 ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | ListE es when static || is_value_exp e1' ->
      Ok (NumE (`Nat (Z.of_int (List.length es))) $> e)
    | _ -> Ok (LenE e1' $> e)
    )
  | TupE es ->
    let** es' = map_results (reduce_exp static env) es in
    Ok (TupE es' $> e)
  | CallE (id, as_) ->
    let _ps, _t, clauses = Env.find_def env id in
    let** as' = map_results (reduce_arg static env) as_ in
    (* Allow for parameters or uninterpreted functions *)
    if clauses = [] then
      Ok (CallE (id, as') $> e)
    else
      let** eo = reduce_exp_call static env id as' clauses e.at in
      (match eo with
      | None -> Ok (CallE (id, as') $> e)
      | Some e -> reduce_exp static env e
      )
  | IterE (e1, iterexp) ->
    let** e1' = reduce_exp static env e1 in
    let** (iter', xes') as iterexp' = reduce_iterexp static env iterexp in
    let ids, es' = List.split xes' in
    if iter' <= List1 && es' = [] then
      (* Lists with no iteration vars are invalid except as patterns *)
      Ok (IterE (e1', iterexp') $> e)
    else if not (List.for_all is_head_normal_exp es') then
      Ok (IterE (e1', iterexp') $> e)
    else
      (match iter' with
      | Opt ->
        let eos' = List.map as_opt_exp es' in
        if List.for_all Option.is_none eos' then
          Ok (OptE None $> e)
        else if List.for_all Option.is_some eos' then
          let es1' = List.map Option.get eos' in
          let s = List.fold_left2 Subst.add_varid Subst.empty ids es1' in
          reduce_exp static env (Subst.subst_exp s e1')
        else
          Ok (IterE (e1', iterexp') $> e)
      | List | List1 ->
        let n = List.length (as_list_exp (List.hd es')) in
        if iter' = List || n >= 1 then
          let en = NumE (`Nat (Z.of_int n)) $$ e.at % (NumT `NatT $ e.at) in
          reduce_exp static env (IterE (e1', (ListN (en, None), xes')) $> e)
        else
          Error (IterE (e1', iterexp') $> e)
      | ListN ({it = NumE (`Nat n'); _}, ido) ->
        let ess' = List.map as_list_exp es' in
        let ns = List.map List.length ess' in
        let n = Z.to_int n' in
        if List.for_all ((=) n) ns then
          (ListE (List.init n (fun i ->
            let esI' = List.map (fun es -> List.nth es i) ess' in
            let s = List.fold_left2 Subst.add_varid Subst.empty ids esI' in
            let s' =
              Option.fold ido ~none:s ~some:(fun id ->
                let en = NumE (`Nat (Z.of_int i)) $$ id.at % (NumT `NatT $ id.at) in
                Subst.add_varid s id en
              )
            in Subst.subst_exp s' e1'
          )) $> e) |> reduce_exp static env
        else
          Error (IterE (e1', iterexp') $> e)
      | ListN _ ->
        Ok (IterE (e1', iterexp') $> e)
      )
  | ProjE (e1, i) ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | TupE es when static || is_value_exp e1' -> Ok (List.nth es i)
    | _ -> Ok (ProjE (e1', i) $> e)
    )
  | UncaseE (e1, mixop) ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | CaseE (mixop', e11', Checked) when Mixop.eq mixop mixop' -> Ok e11'
    | CaseE (mixop', _, _) when not (Mixop.eq mixop mixop') ->
      Error (UncaseE (e1', mixop) $> e)
    | _ -> Ok (UncaseE (e1', mixop) $> e)
    )
  | OptE eo ->
    (match eo with
    | None -> Ok e
    | Some e1 ->
      let** e1' = reduce_exp static env e1 in
      Ok (OptE (Some e1') $> e)
    )
  | TheE e1 ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | OptE (Some e11) -> Ok e11
    | OptE None -> Error (TheE e1' $> e)
    | _ -> Ok (TheE e1' $> e)
    )
  | ListE es ->
    let** es' = map_results (reduce_exp static env) es in
    Ok (ListE es' $> e)
  | LiftE e1 ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | OptE None -> Ok (ListE [] $> e)
    | OptE (Some e11') -> Ok (ListE [e11'] $> e)
    | _ -> Ok (LiftE e1' $> e)
    )
  | CatE (e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    (match e1'.it, e2'.it with
    | ListE es1, ListE es2 -> Ok (ListE (es1 @ es2) $> e)
    | OptE None, OptE _ -> Ok e2'
    | OptE _, OptE None -> Ok e1'
    | OptE _, OptE _ -> Error (CatE (e1', e2') $> e)
    | _ -> Ok (CatE (e1', e2') $> e)
    )
  | CaseE (op, e1, Unchecked) when not static ->
    let tcs = as_variant_typ env e.note e.at in
    let t, _qs, prems = find_typcase e.note tcs op e.at in
    let** e1' = reduce_exp static env e1 in
    let** so = match_exp_typ static env Subst.empty e1' t in
    (match so with
    | Some s ->
      let** so' = reduce_prems env s prems in
      Ok (CaseE (op, e1', if so' <> None then Checked else Unchecked) $> e)
    | None ->
      Ok (CaseE (op, e1', Unchecked) $> e)
    )
  | CaseE (op, e1, _ch) ->
    let** e1' = reduce_exp static env e1 in
    Ok (CaseE (op, e1', Checked) $> e)
  | CvtE (e1, nt1, nt2) ->
    let** e1' = reduce_exp static env e1 in
    (match e1'.it with
    | NumE n ->
      (match Num.cvt nt2 n with
      | Some n' -> Ok (NumE n' $> e)
      | None -> Error (CvtE (e1', nt1, nt2) $> e)
      )
    | _ -> Ok (CvtE (e1', nt1, nt2) $> e)
    )
  | SubE (e1, t1, t2) ->
    let** e1' = reduce_exp static env e1 in
    let** t1' = reduce_typ env t1 in
    let** t2' = reduce_typ env t2 in
    if equiv_typ env t1' t2' then Ok e1' else
    (match e1'.it with
    | SubE (e11', t11', _t12') ->
      reduce_exp static env (SubE (e11', t11', t2') $> e)
    | TupE es' ->
      let xts1 = as_tup_typ env t1' t1.at in
      let xts2 = as_tup_typ env t2' t2.at in
      let** _, _, res' =
        List.fold_left2 (fun opt eI ((x1I, t1I), (x2I, t2I)) ->
          let** s1, s2, res' = opt in
          let t1I' = Subst.subst_typ s1 t1I in
          let t2I' = Subst.subst_typ s2 t2I in
          let s1' = Subst.add_varid s1 x1I eI in
          let s2' = Subst.add_varid s2 x2I eI in
          let** eI' =
            reduce_exp static env (SubE (eI, t1I', t2I') $$ eI.at % t2I') in
          Ok (s1', s2', eI'::res')
        ) (Ok (Subst.empty, Subst.empty, [])) es' (List.combine xts1 xts2)
      in Ok (TupE (List.rev res') $> e)
    | StrE (efs', _ch) ->
      let tfs1 = as_struct_typ env t1' t1.at in
      let tfs2 = as_struct_typ env t2' t2.at in
      let efs'' =
        List.map2 (fun (atomI, eI) ((atom1I, (t1I, _, _), _), (atom2I, (t2I, _, _), _)) ->
          assert (Atom.eq atomI atom1I);
          assert (Atom.eq atomI atom2I);
          (atomI, SubE (eI, t1I, t2I) $$ eI.at % t2I)
        ) efs' (List.combine tfs1 tfs2)
      in reduce_exp static env (StrE (efs'', Unchecked) $> e)
    | CaseE (op, e11', _ch) ->
      let tcs1 = as_variant_typ env t1' t1.at in
      let tcs2 = as_variant_typ env t2' t2.at in
      let t1', _qs, _prems = find_typcase t1' tcs1 op t1.at in
      let t2', _qs, _prems = find_typcase t2' tcs2 op t2.at in
      reduce_exp static env
        (CaseE (op, SubE (e11', t1', t2') $$ e11'.at % t2', Unchecked) $> e)
    | _ when is_head_normal_exp e1' ->
      Ok {e1' with note = e.note}
    | _ -> Ok (SubE (e1', t1', t2') $> e)
    )

and reduce_iter static env iter : iter result =
  match iter with
  | ListN (e, ido) ->
    let** e' = reduce_exp static env e in
    Ok (ListN (e', ido))
  | iter -> Ok iter

and reduce_iterexp static env (iter, xes) : iterexp result =
  let** iter' = reduce_iter static env iter in
  let** es' = map_results (reduce_exp static env) (List.map snd xes) in
  Ok (iter', List.map2 (fun (xI, _) eI' -> xI, eI') xes es')

and reduce_expfield static env t tfs ch (atom, e) : (expfield * check) result =
  match ch with
  | Unchecked when not static ->
    let _t, _qs, prems = find_typfield t tfs atom atom.at in
    let** e' = reduce_exp static env e in
    let** so = match_exp_typ static env Subst.empty e' t in
    (match so with
    | Some s ->
      let** so' = reduce_prems env s prems in
      Ok ((atom, e'), if so' <> None then Checked else Unchecked)
    | None ->
      Ok ((atom, e'), Unchecked)
    )
  | _ch ->
    let** e' = reduce_exp static env e in
    Ok ((atom, e'), Checked)

and reduce_path static env e p k : exp result =
  match p.it with
  | RootP -> k e p
  | IdxP (p1, e1) ->
    let** e1' = reduce_exp static env e1 in
    let k' e' p1' =
      match e'.it, e1'.it with
      | ListE es, NumE (`Nat i)
        when (static || is_value_exp e') && i < Z.of_int (List.length es) ->
        let** es' =
          map_results (fun (j, eJ) ->
            if Z.of_int j = i then k eJ p1' else Ok eJ
          ) (List.mapi Pair.make es)
        in
        Ok (ListE es' $> e')
      | ListE _es, NumE (`Nat _) ->
        let** e'' = k e' (IdxP (p1', e1') $> p) in
        Error e''
      | _ ->
        k e' (IdxP (p1', e1') $> p)
    in
    reduce_path static env e p1 k'
  | SliceP (p1, e1, e2) ->
    let** e1' = reduce_exp static env e1 in
    let** e2' = reduce_exp static env e2 in
    let k' e' p1' =
      match e'.it, e1'.it, e2'.it with
      | ListE es, NumE (`Nat i), NumE (`Nat n) when Z.(i + n) < Z.of_int (List.length es) ->
        let e1' = ListE Lib.List.(take (Z.to_int i) es) $> e' in
        let e2' = ListE Lib.List.(take (Z.to_int n) (drop (Z.to_int i) es)) $> e' in
        let e3' = ListE Lib.List.(drop Z.(to_int (i + n)) es) $> e' in
        let** e2'' = k e2' p1' in
        reduce_exp static env (CatE (e1', CatE (e2'', e3') $> e') $> e')
      | ListE _es, NumE (`Nat _), NumE (`Nat _) ->
        let** e'' = k e' (SliceP (p1', e1', e2') $> p) in
        Error e''
      | _ ->
        k e' (SliceP (p1', e1', e2') $> p)
    in
    reduce_path static env e p1 k'
  | DotP (p1, atom) ->
    let k' e' p1' =
      match e'.it with
      | StrE (efs, Checked) ->
        let tfs = as_struct_typ env e'.note e'.at in
        let** ef_chs' =
          map_results (fun (atomI, eI) ->
            if Eq.eq_atom atomI atom then
              let** eI' = k eI p1' in
              reduce_expfield static env e'.note tfs Unchecked (atomI, eI')
            else Ok ((atomI, eI), Checked)
          ) efs
        in
        let efs', chs' = List.split ef_chs' in
        let ch' = if List.for_all ((=) Checked) chs' then Checked else Unchecked in
        Ok (StrE (efs', ch') $> e')
      | _ ->
        k e' (DotP (p1', atom) $> p)
    in
    reduce_path static env e p1 k'

and reduce_arg static env a : arg result =
  Debug.(log "il.reduce_arg"
    (fun _ -> fmt "%s" (il_arg a))
    (fun a' -> fmt "%s" (il_result il_arg a'))
  ) @@ fun _ ->
  match a.it with
  | ExpA e -> let** e' = reduce_exp static env e in Ok (ExpA e' $ a.at)
  | TypA _t -> Ok a  (* types are reduced on demand *)
  | DefA _id -> Ok a
  | GramA _g -> Ok a

and reduce_exp_call static env id args clauses at : exp option result =
  match clauses with
  | [] ->
    Debug.(log "il.reduce_exp_call"
      (fun _ -> fmt "$%s%s / -" id.it (il_args args))
      (fun r -> fmt "%s" (il_opt_result il_exp r))
    ) @@ fun _ ->
    Error None
  | {it = DefD (_ps, args', e, prems); _}::clauses' ->
    Debug.(log "il.reduce_exp_call"
      (fun _ -> fmt "$%s%s / $%s%s" id.it (il_args args) id.it (il_args args'))
      (fun r -> fmt "%s" (il_opt_result il_exp r))
    ) @@ fun _ ->
    assert (List.for_all (is_normal_arg static env) args);
    match match_list (match_arg static) env Subst.empty args args' with
    | Error _ -> reduce_exp_call static env id args clauses' at
    | Ok None ->
      if not !assume_coherent_matches then Ok None else
      (match reduce_exp_call static env id args clauses' at with
      | Error _ -> Ok None
      | ok -> ok
      )
    | Ok (Some s) ->
      match reduce_prems env s prems with
      | Ok (Some _s') -> Ok (Some (Subst.subst_exp s e))
      | Error _ -> reduce_exp_call static env id args clauses' at
      | Ok None ->
        if not !assume_coherent_matches then Ok None else
        match reduce_exp_call static env id args clauses' at with
        | Error _ -> Ok None
        | ok -> ok

and reduce_prems env s prems : subst option result =
  Debug.(log "il.reduce_prems"
    (fun _ -> fmt "%s [%s]" (list il_prem prems) (il_subst s))
    (fun r -> fmt "%s" (il_opt_result il_subst r))
  ) @@ fun _ ->
  match prems with
  | [] -> Ok (Some s)
  | prem::prems ->
    let** so = reduce_prem env (Subst.subst_prem s prem) in
    match so with
    | Some s' -> reduce_prems env (Subst.union s s') prems
    | None -> Ok None

and reduce_prem env prem : subst option result =
  match prem.it with
  | RulePr _ -> Ok None
  | IfPr e ->
    let** e' = reduce_exp false env e in
    (match e'.it with
    | BoolE b -> if b then Ok (Some Subst.empty) else Error None
    | _ -> Ok None
    )
  | ElsePr -> Ok (Some Subst.empty)
  | LetPr (_qs, e1, e2) ->
    let** e1' = reduce_exp false env e1 in
    let** e2' = reduce_exp false env e2 in
    match_exp false env Subst.empty e2' e1'
  | IterPr (prem1, iterexp) ->
    let** iter', xes' = reduce_iterexp false env iterexp in
    (* Distinguish between let-defined variables, which flow outwards,
     * and others, which are assumed to flow inwards. *)
    let rec is_let_bound prem (x, _) =
      match prem.it with
      | LetPr (qs, _, _) -> Free.(Set.mem x.it (bound_quants qs).varid)
      | IterPr (premI, (_iter1', xes1')) ->
        let xes1_out, _ = List.partition (is_let_bound premI) xes1' in
        List.exists (fun (_, e1) -> Free.(Set.mem x.it (free_exp e1).varid)) xes1_out
      | _ -> false
    in
    let xes_out, xes_in = List.partition (is_let_bound prem) xes' in
    let xs_out, es_out = List.split xes_out in
    let xs_in, es_in = List.split xes_in in
    if not (List.for_all is_head_normal_exp es_in) || iter' <= List1 && es_in = [] then
      (* We don't know the number of iterations (yet): can't do anything. *)
      Ok None
    else
      (match iter' with
      | Opt ->
        (* Iterationen values es_in are in hnf, so got to be options. *)
        let eos_in = List.map as_opt_exp es_in in
        if List.for_all Option.is_none eos_in then
          (* Iterating over empty options: nothing to do. *)
          Ok (Some Subst.empty)
        else if List.for_all Option.is_some eos_in then
          (* All iteration variables are non-empty: reduce body. *)
          let es1_in = List.map Option.get eos_in in
          (* s substitutes in-bound iteration variables with corresponding
           * values. *)
          let s = List.fold_left2 Subst.add_varid Subst.empty xs_in es1_in in
          let*** s' = reduce_prem env (Subst.subst_prem s prem1) in
          (* Body is true: now reverse-match out-bound iteration values
           * against iteration sources. *)
          List.fold_left (fun r (xI, eI) ->
            let*** s = r in
            let tI = match eI.note.it with IterT (tI, _) -> tI | _ -> assert false in
            match_exp' false env s (OptE (Some (Subst.subst_exp s' (VarE xI $$ xI.at % tI))) $> eI) eI
          ) (Ok (Some Subst.empty)) xes_out
        else
          (* Inconsistent arity of iteration values. *)
          Error None
      | List | List1 ->
        (* Unspecified iteration count: get length from (first) iteration value
         * and start over; es_in are in hnf, so got to be lists. *)
        let n = List.length (as_list_exp (List.hd es_in)) in
        if iter' = List || n >= 1 then
          let en = NumE (`Nat (Z.of_int n)) $$ prem.at % (NumT `NatT $ prem.at) in
          reduce_prem env (IterPr (prem1, (ListN (en, None), xes')) $> prem)
        else
          (* List is empty although it is List1: inconsistency. *)
          Error None
      | ListN ({it = NumE (`Nat n'); _}, xo) ->
        (* Iterationen values es_in are in hnf, so got to be lists. *)
        let ess_in = List.map as_list_exp es_in in
        let ns = List.map List.length ess_in in
        let n = Z.to_int n' in
        if List.for_all ((=) n) ns then
          (* All in-bound lists have the expected length: reduce body,
           * once for each tuple of values from the iterated lists. *)
          let** rs = List.init n (fun i ->
              let esI_in = List.map (fun es -> List.nth es i) ess_in in
              (* s substitutes in-bound iteration variables with corresponding
               * values for this respective iteration. *)
              let s = List.fold_left2 Subst.add_varid Subst.empty xs_in esI_in in
              (* Add iteration counter variable if used. *)
              let s' =
                Option.fold xo ~none:s ~some:(fun x ->
                  let en = NumE (`Nat (Z.of_int i)) $$ x.at % (NumT `NatT $ x.at) in
                  Subst.add_varid s x en
                )
              in
              reduce_prem env (Subst.subst_prem s' prem1)
            ) |> map_results Fun.id
          in
          if List.mem None rs then Ok None else
          (* Body was true in every iteration: now reverse-match out-bound
           * iteration variables against iteration sources. *)
          let ss = List.map Option.get rs in
          (* Aggregate the out-lists for each out-bound variable. *)
          let es_out' =
            List.map2 (fun xI eI ->
              let tI = match eI.note.it with IterT (tI, _) -> tI | _ -> assert false in
              let esI = List.map (fun sJ ->
                  Subst.subst_exp sJ (VarE xI $$ xI.at % tI)
                ) ss
              in ListE esI $> eI
            ) xs_out es_out
          in
          (* Reverse-match out-bound list values against iteration sources. *)
          match_list (match_exp false) env Subst.empty es_out' es_out
        else
          (* Inconsistent list lengths: can't perform mapping.
           * (This is a stuck computation, i.e., undefined.) *)
          Error None
      | ListN _ -> Ok None
      )


(* Matching *)

(* Iteration *)

and match_iter static env s iter1 iter2 : subst option result =
  match iter1, iter2 with
  | Opt, Opt -> Ok (Some s)
  | List, List -> Ok (Some s)
  | List1, List1 -> Ok (Some s)
  | ListN (e1, _ido1), ListN (e2, _ido2) -> match_exp static env s e1 e2
  | (Opt | List1 | ListN _), List -> Ok (Some s)
  | _, _ -> Error None


(* Types *)

and match_typ env s t1 t2 : subst option result =
  Debug.(log "il.match_typ"
    (fun _ -> fmt "%s / %s" (il_typ t1) (il_typ (Subst.subst_typ s t2)))
    (fun r -> fmt "%s" (il_result (opt il_subst) r))
  ) @@ fun _ ->
  match t1.it, t2.it with
  | _, VarT (id, []) when Subst.mem_typid s id ->
    match_typ env s t1 (Subst.subst_typ s t2)
  | _, VarT (id, []) when not (Map.mem id.it env.typs) ->
    (* An unbound type is treated as a pattern variable *)
    Ok (Some (Subst.add_typid s id t1))
  | VarT (id1, args1), VarT (id2, args2) when id1.it = id2.it ->
    (* Optimization for the common case where args are absent or equivalent. *)
    (match match_list (static3 match_arg) env s args1 args2 with
    | Ok so -> Ok so
    | Error _ ->
      (* If that fails, fall back to reduction. *)
      let** t1' = reduce_typ env t1 in
      let** t2' = reduce_typ env t2 in
      if Eq.(eq_typ t1 t1' && eq_typ t2 t2') then Ok None else
      match_typ env s t1' t2'
    )
  | VarT _, _ ->
    let** t1' = reduce_typ env t1 in
    if Eq.eq_typ t1 t1' then Ok None else
    match_typ env s t1' t2
  | _, VarT _ ->
    let** t2' = reduce_typ env t2 in
    if Eq.eq_typ t2 t2' then Ok None else
    match_typ env s t1 t2'
  | TupT xts1, TupT xts2 ->
    match_list match_typbind env s xts1 xts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    let*** s' = match_typ env s t11 t21 in
    static3 match_iter env s' iter1 iter2
  | _, _ -> Ok None

and match_typbind env s (x1, t1) (x2, t2) =
  let s' = Subst.add_varid s x2 (VarE x1 $$ x1.at % t1) in
  match_typ env s' t1 (Subst.subst_typ s t2)


(* Expressions *)

and match_exp_typ static env s e t : subst option result =
  Debug.(log "il.match_exp_typ"
    (fun _ -> fmt "%s / %s [%s]" (il_exp e) (il_typ t) (il_subst s))
    (fun r -> fmt "%s" (il_result (opt il_subst) r))
  ) @@ fun _ ->
  let** e' = reduce_exp static env e in
  let** t' = reduce_typ env t in
  match e'.it, t'.it with
  | TupE es, TupT xts when List.length es = List.length xts ->
    Ok (Some (List.fold_left (fun s (e, (x, _)) ->
      Subst.add_varid s x (Subst.subst_exp s e)
    ) s (List.combine es xts)))
  | _, _ -> Error None

and match_exp static env s e1 e2 : subst option result =
  let** e1' = reduce_exp static env e1 in
  match_exp' static env s e1' e2

and match_exp' static env s e1 e2 : subst option result =
  Debug.(log "il.match_exp"
    (fun _ -> fmt "%s : %s / %s" (il_exp e1) (il_typ e1.note) (il_exp (Subst.subst_exp s e2)))
    (fun r -> fmt "%s" (il_result (opt il_subst) r))
  ) @@ fun _ ->
  assert (is_normal_exp static env e1);
  let** e2' = reduce_exp static env (Subst.subst_exp s e2) in
  (* HACK around subtype elim pass introducing calls on LHS's *)
  if Eq.eq_exp e1 e2 && (static || is_value_exp e1 && is_value_exp e2) then Ok (Some s) else
  match e1.it, e2'.it with
  | _, VarE id when Subst.mem_varid s id ->
    (* A pattern variable already in the substitution is non-linear *)
    if equiv_exp static env e1 (Subst.subst_exp s e2) then
      Ok (Some s)
    else
      Error None
  | _, VarE id ->
    (* Treat as a fresh pattern variable. *)
    let** e1' = reduce_exp static env (SubE (e1, e1.note, e2.note) $$ e1.at % e2.note) in
    Ok (Some (Subst.add_varid s id e1'))
  | BoolE b1, BoolE b2 when b1 = b2 -> Ok (Some s)
  | NumE n1, NumE n2 when n1 = n2 -> Ok (Some s)
  | TextE s1, TextE s2 when s1 = s2 -> Ok (Some s)
  | NumE n1, UnE (`PlusOp, _, e21) when not (Num.is_neg n1) ->
    match_exp static env s e1 e21
  | NumE n1, UnE (`MinusOp, _, e21) when Num.is_neg n1 ->
    let** e1' = reduce_exp static env (NumE (Num.abs n1) $> e1) in
    match_exp static env s e1' e21
  | NumE n1, CvtE (e21, nt1, _nt2) ->
    (match Num.cvt nt1 n1 with
    | Some n1' -> match_exp static env s (NumE n1' $> e1) e21
    | None -> Error None
    )
(*
  | UnE (op1, _, e11), UnE (op2, _, e21) when op1 = op2 -> match_exp' env s e11 e21
  | BinE (e11, op1, e12), BinE (e21, op2, e22) when op1 = op2 ->
    let** s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | CmpE (e11, op1, e12), CmpE (e21, op2, e22) when op1 = op2 ->
    let** s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | (EpsE | SeqE []), (EpsE | SeqE []) -> Some s
*)
  | ListE es1, ListE es2
  | TupE es1, TupE es2 -> match_list (match_exp' static) env s es1 es2
  | _, TupE es2 ->
    let es1 = eta_tup_exp env e1 in
    match_list (match_exp' static) env s es1 es2
  | ListE es1, CatE ({it = ListE es21; _} as e21, e22)
    when List.length es21 <= List.length es1 ->
    let es11, es12 = Lib.List.split (List.length es21) es1 in
    let*** s' = match_exp' static env s (ListE es11 $> e1) e21 in
    match_exp' static env s' (ListE es12 $> e1) e22
  | ListE es1, CatE (e21, ({it = ListE es22; _} as e22))
    when List.length es22 <= List.length es1 ->
    let es11, es12 = Lib.List.split (List.length es22) es1 in
    let*** s' = match_exp' static env s (ListE es11 $> e1) e21 in
    match_exp' static env s' (ListE es12 $> e1) e22
(*
  | IdxE (e11, e12), IdxE (e21, e22)
  | CommaE (e11, e12), CommaE (e21, e22)
  | CompE (e11, e12), CompE (e21, e22) ->
    let** s' = match_exp' env s e11 e21 in match_exp' env s' e12 e22
  | SliceE (e11, e12, e13), SliceE (e21, e22, e23) ->
    let** s' = match_exp' env s e11 e21 in
    let** s'' = match_exp' env s' e12 e22 in
    match_exp' env s'' e13 e23
  | UpdE (e11, p1, e12), UpdE (e21, p2, e22)
  | ExtE (e11, p1, e12), ExtE (e21, p2, e22) ->
    let** s' = match_exp' env s e11 e21 in
    let** s'' = match_path env s' p1 p2 in
    match_exp' env s'' e12 e22
*)
  | StrE (efs1, Checked), StrE (efs2, _) ->
    match_list (match_expfield static) env s efs1 efs2
(*
  | DotE (e11, atom1), DotE (e21, atom2) when Eq.eq_atom atom1 atom2 ->
    match_exp' env s e11 e21
  | LenE e11, LenE e21 -> match_exp' env s e11 e21
*)
  | CaseE (op1, _, _), CaseE (op2, e21, _) when Eq.eq_mixop op1 op2 ->
    (* Beta-expand to allow unchecked e1 without losing checks *)
    let** e11' = reduce_exp static env (UncaseE (e1, op2) $> e21) in
    match_exp' static env s e11' e21
  | _, CaseE (op2, e21, _)
    when List.length (as_variant_typ env e2.note e2.at) = 1 ->
    (* Beta-expand irrefutable case pattern *)
    let** e11' = reduce_exp static env (UncaseE (e1, op2) $> e21) in
    match_exp' static env s e11' e21
(*
  | CallE (id1, args1), CallE (id2, args2) when id1.it = id2.it ->
    match_list (match_arg static) env s args1 args2
*)
  | _, UncaseE (e21, mixop) ->
    let** e1' =
      reduce_exp static env (CaseE (mixop, e1, Unchecked) $$ e1.at % e21.note) in
    match_exp' static env s e1' e21
  | _, ProjE (e21, 0) ->  (* only valid on unary tuples! *)
    match_exp' static env s (TupE [e1] $$ e1.at % e21.note) e21
(*
  | IterE (e11, iter1), IterE (e21, iter2) ->
    let** s' = match_exp' env s e11 e21 in
    match_iterexp env s' iter1 iter2
  | _, IterE (e21, iter2) ->
    let e11, iter1 = eta_iter_exp env e1 in
    let** s' = match_exp' env s e11 e21 in
    match_iterexp env s' iter1 iter2
*)
  | OptE None, IterE (_e21, (Opt, xes)) ->
    List.fold_left (fun r (_xI, eI) ->
      let*** s = r in match_exp' static env s e1 eI
    ) (Ok (Some s)) xes
  | OptE (Some e11), IterE (e21, (Opt, xes)) ->
    let*** s' = match_exp' static env s e11 e21 in
    let*** s'' =
      List.fold_left (fun r (xI, exI) ->
        let*** s = r in
        let tI = match exI.note.it with IterT (tI, _) -> tI | _ -> assert false in
        match_exp' static env s (OptE (Some (Subst.subst_exp s' (VarE xI $$ exI.at % tI))) $> e2) exI
      ) (Ok (Some (List.fold_left Subst.remove_varid s (List.map fst xes)))) xes
    in Ok (Some (Subst.union s'' s))  (* re-add possibly locally shadowed bindings *)
  | ListE _es1, IterE (e21, (List, xes)) ->
    let en = VarE ("_" $ e2.at) $$ e2.at % (NumT `NatT $ e2.at) in
    match_exp' static env s e1 (IterE (e21, (ListN (en, None), xes)) $> e2)
  | ListE es1, IterE (e21, (List1, xes)) ->
    if es1 = [] then Error None else
    let en = VarE ("_" $ e2.at) $$ e2.at % (NumT `NatT $ e2.at) in
    match_exp' static env s e1 (IterE (e21, (ListN (en, None), xes)) $> e2)
  | ListE es1, IterE (e21, (ListN (en, id_opt), xes)) ->
    let en' = NumE (`Nat (Z.of_int (List.length es1))) $$ e1.at % (NumT `NatT $ e1.at) in
    let*** s' = match_exp' static env s en' en in
    let s'' = List.fold_left Subst.remove_varid s' (List.map fst xes) in  (* local subst *)
    (* match each list element against iteration body for corresponding subst *)
    let** sos =
      map_results (fun (j, e1J) ->
        let s''' =
          match id_opt with
          | None -> s''
          | Some xJ ->
            Subst.add_varid s'' xJ
              (NumE (`Nat (Z.of_int j)) $$ e1.at % (NumT `NatT $ e1.at))
        in match_exp' static env s''' e1J (Subst.subst_exp s''' e21)
      ) (List.mapi Pair.make es1)
    in
    let*** ss = Ok (Lib.List.flatten_opt sos) in
    (* now project list for each iteration variable and match against rhs's *)
    let xs, exs = List.split xes in
    let*** s''' =
      match_list (fun env s xI exI ->
        let tI = match exI.note.it with IterT (tI, _) -> tI | _ -> assert false in
        let eI = ListE (List.map (fun sJ -> Subst.subst_exp sJ (VarE xI $$ exI.at % tI)) ss) $> e2 in
        match_exp' static env s eI exI
      ) env s' xs exs
    in Ok (Some (Subst.union s''' s))  (* re-add possibly locally shadowed bindings *)
  | _, IterE (e21, iter2) ->
    let e11, iter1 = eta_iter_exp env e1 in
    let** e11' = reduce_exp static env e11 in
    let** iter1' = reduce_iterexp static env iter1 in
    let*** s' = match_exp' static env s e11' e21 in
    match_iterexp static env s' iter1' iter2
  | SubE (e11, t11, _t12), SubE (e21, t21, _t22) when sub_typ env t11 t21 ->
    let** e11' = reduce_exp static env (SubE (e11, t11, t21) $> e21) in
    match_exp' static env s e11' e21
  | SubE (_e11, t11, _t12), SubE (_e21, t21, _t22) when disj_typ env t11 t21 ->
    Error None
  | _, SubE (e21, t21, _t22) ->
    if sub_typ env e1.note t21 then
      let** e1' = reduce_exp static env (SubE (e1, e1.note, t21) $> e21) in
      match_exp' static env s e1' e21
    else if is_head_normal_exp e1 then
      let** t21' = reduce_typ env t21 in
      let** b =
        match e1.it, t21'.it with
        | BoolE _, BoolT
        | NumE _, NumT _
        | TextE _, TextT -> Ok true
        | CaseE (op, _, _), VarT _ ->
          let** dt = reduce_typdef env t21 in
          (match dt.it with
          | VariantT tcs ->
            (* Assumes that we only have shallow subtyping. *)
            Ok (List.exists (fun (opN, _, _) -> Eq.eq_mixop opN op) tcs)
          | _ -> Error false
          )
        | VarE id1, _ ->
          let t1 = Env.find_var env id1 in
          let** t1' = reduce_typ env t1 in
          Ok (sub_typ env t1' t21)
        | _, _ -> Error false
      in
      if b
      then match_exp' static env s {e1 with note = t21} e21
      else Ok None
    else Ok None
  | _, _ when is_head_normal_exp e1 -> Error None
  | _, _ -> Ok None

and match_expfield static env s (atom1, e1) (atom2, e2) =
  assert (Eq.eq_atom atom1 atom2);
  match_exp' static env s e1 (Subst.subst_exp s e2)

and match_iterexp static env s (iter1, _ids1) (iter2, _ids2) =
  match_iter static env s iter1 iter2


and eta_tup_exp env e : exp list =
  let xts = as_tup_typ env e.note e.at in
  List.fold_left (fun (res', i, s) (xI, tI) ->
    let eI' = ProjE (e, i) $$ e.at % Subst.subst_typ s tI in
    let s' = Subst.add_varid s xI eI' in
    (eI'::res', i + 1, s')
  ) ([], 0, Subst.empty) xts |> Lib.fst3 |> List.rev

and eta_iter_exp env e : exp * iterexp =
  let t, it = as_iter_typ env e.note e.at in
  match it with
  | Opt -> TheE e $$ e.at % t, (Opt, [])
  | List ->
    let id = "_i_" $ e.at in
    let len = LenE e $$ e.at % (NumT `NatT $ e.at) in
    IdxE (e, VarE id $$ e.at % (NumT `NatT $ e.at)) $$ e.at % t,
    (ListN (len, Some id), [])
  | _ -> assert false


(* Grammars *)

and match_sym env s g1 g2 : subst option result =
  Debug.(log "il.match_sym"
    (fun _ -> fmt "%s / %s" (il_sym g1) (il_sym g2))
    (fun r -> fmt "%s" (il_result (opt il_subst) r))
  ) @@ fun _ ->
  match g1.it, g2.it with
  | _, VarG (id, []) when Subst.mem_gramid s id ->
    match_sym env s g1 (Subst.subst_sym s g2)
  | _, VarG (id, []) when not (Map.mem id.it env.grams) ->
    (* An unbound grammar is treated as a pattern variable *)
    Ok (Some (Subst.add_gramid s id g1))
  | VarG (id1, args1), VarG (id2, args2) when id1.it = id2.it ->
    match_list (static3 match_arg) env s args1 args2
  | IterG (g11, iter1), IterG (g21, iter2) ->
    let*** s' = match_sym env s g11 g21 in
    static3 match_iterexp env s' iter1 iter2
  | _, _ -> Ok None


(* Parameters *)

and match_arg static env s a1 a2 : subst option result =
  Debug.(log "il.match_arg"
    (fun _ -> fmt "%s / %s" (il_arg a1) (il_arg a2))
    (fun r -> fmt "%s" (il_result (opt il_subst) r))
  ) @@ fun _ ->
  match a1.it, a2.it with
  | ExpA e1, ExpA e2 -> match_exp static env s e1 e2
  | TypA t1, TypA t2 -> match_typ env s t1 t2
  | DefA id1, DefA id2 -> Ok (Some (Subst.add_defid s id1 id2))
  | GramA g1, GramA g2 -> match_sym env s g1 g2
  | _, _ -> assert false


(* Type Equivalence *)

and equiv_typ env t1 t2 =
  Debug.(log "il.equiv_typ"
    (fun _ -> fmt "%s == %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match t1.it, t2.it with
  | VarT (id1, as1), VarT (id2, as2) ->
    id1.it = id2.it && equiv_list equiv_arg env as1 as2 ||
    (* optimization *)
    let t1' = reduce_typ_ok env t1 in
    let t2' = reduce_typ_ok env t2 in
    (* TODO(3, rossberg): be more expressive *)
    (t1 <> t1' || t2 <> t2') && equiv_typ env t1' t2' ||
    Eq.eq_deftyp (reduce_typdef_ok env t1') (reduce_typdef_ok env t2')
  | VarT _, _ ->
    let t1' = reduce_typ_ok env t1 in
    t1 <> t1' && equiv_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ_ok env t2 in
    t2 <> t2' && equiv_typ env t1 t2'
  | TupT ets1, TupT ets2 -> equiv_tup env Subst.empty ets1 ets2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    equiv_typ env t11 t21 && equiv_iter env iter1 iter2
  | _, _ ->
    t1.it = t2.it

and equiv_tup env s xts1 xts2 =
  match xts1, xts2 with
  | (x1, t1)::xts1', (x2, t2)::xts2' ->
    equiv_typ env t1 (Subst.subst_typ s t2) &&
    equiv_tup env (Subst.add_varid s x2 (VarE x1 $$ x1.at % t1)) xts1' xts2'
  | _, _ -> xts1 = xts2

and equiv_iter env iter1 iter2 =
  match iter1, iter2 with
  | ListN (e1, ido1), ListN (e2, ido2) ->
    equiv_exp true env e1 e2 && Option.equal (fun id1 id2 -> id1.it = id2.it) ido1 ido2
  | _, _ -> iter1 = iter2

(*
and equiv_prem env pr1 pr2 =
  match pr1.it, pr2.it with
  | RulePr (id1, mixop1, e1), RulePr (id2, mixop2, e2) ->
    id1.it = id2.it && Eq.eq_mixop mixop1 mixop2 && equiv_exp env e1 e2
  | IfPr e1, IfPr e2 -> equiv_exp env e1 e2
  | LetPr (_qs1, e11, e12), LetPr (_qs2, e21, e22) ->
    equiv_exp env e11 e21 && equiv_exp env e12 e22
  | IterPr (pr11, iter1), IterPr (pr21, iter2) ->
    equiv_prem env pr11 pr21 && equiv_iter env (fst iter1) (fst iter2)
  | pr1', pr2' -> pr1' = pr2'
*)

and equiv_exp static env e1 e2 =
  Debug.(log "il.equiv_exp"
    (fun _ -> fmt "%s == %s" (il_exp e1) (il_exp e2)) Bool.to_string
  ) @@ fun _ ->
  (* TODO(3, rossberg): this does not reduce inner type arguments *)
  let e1', e2' =
    match reduce_exp static env e1, reduce_exp static env e2 with
    | Ok e1', Ok e2' -> e1', e2'
    | (Ok e1' | Error e1'), (Ok e2' | Error e2') when static -> e1', e2'
    | Error _, _ ->
      Error.error e1.at "validation"
        "expression failed to evaluate during pattern-matching"
    | _, Error _ ->
      Error.error e2.at "validation"
        "expression failed to evaluate during pattern-matching"
  in
  Eq.eq_exp e1' e2' || Eq.eq_exp (recall_exp env e1') (recall_exp env e2')

and recall_exp env e =
  match Env.recall_eq_simp env e with
  | None -> e
  | Some e' -> recall_exp env e'

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
  | ExpA e1, ExpA e2 -> equiv_exp true env e1 e2
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
    | GramP (id1, ps1, t1), GramP (id2, ps2, t2) ->
      if not (equiv_functyp env (ps1, t1) (ps2, t2)) then None else
      Some (Subst.add_gramid s id2 (VarG (id1, []) $ p1.at))
    | _, _ -> assert false
  ) (Some Subst.empty) ps1 ps2


(* Subtyping *)

and sub_prems _env prems1 prems2 =
  prems2 = [] ||
  List.length prems1 = List.length prems2 &&
  List.for_all2 Eq.eq_prem prems1 prems2

and sub_typ env t1 t2 = sub_typ' env [] t1 t2

and sub_typ' env assum t1 t2 =
  Debug.(log "il.sub_typ"
    (fun _ -> fmt "%s <: %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  equiv_typ env t1 t2 ||
  List.exists (fun (t1', t2') -> Eq.eq_typ t1 t1' && Eq.eq_typ t2 t2') assum ||
  let t1' = reduce_typ_ok env t1 in
  let t2' = reduce_typ_ok env t2 in
  let assum' = (t1, t2)::assum in
  match t1'.it, t2'.it with
(*| NumT nt1, NumT nt2 -> Num.sub nt1 nt2*)
  | TupT ets1, TupT ets2 -> sub_tup env assum' Subst.empty ets1 ets2
  | VarT _, VarT _ ->
    (match (reduce_typdef_ok env t1').it, (reduce_typdef_ok env t2').it with
    | StructT tfs1, StructT tfs2 ->
      List.for_all (fun (atom, (t21, _qs2, prems2), _) ->
        match find_field tfs1 atom with
        | Some (t11, _qs1, prems1) ->
          sub_typ' env assum' t11 t21 && sub_prems env prems1 prems2
        | None -> false
      ) tfs2
    | VariantT tcs1, VariantT tcs2 ->
      List.for_all (fun (mixop, (t11, _qs1, prems1), _) ->
        match find_case tcs2 mixop with
        | Some (t21, _qs2, prems2) ->
          sub_typ' env assum' t11 t21 && sub_prems env prems1 prems2
        | None -> false
      ) tcs1
    | _, _ -> false
    )
  | IterT (t11, it1), IterT (t21, it2) ->
    sub_typ' env assum' t11 t21 && Eq.eq_iter it1 it2
  | _, _ ->
    false

and sub_tup env assum s xts1 xts2 =
  match xts1, xts2 with
  | (x1, t1)::xts1', (x2, t2)::xts2' ->
    sub_typ' env assum t1 (Subst.subst_typ s t2) &&
    sub_tup env assum (Subst.add_varid s x2 (VarE x1 $$ x1.at % t1)) xts1' xts2'
  | _, _ -> xts1 = xts2


and find_field tfs atom =
  List.find_opt (fun (atom', _, _) -> Eq.eq_atom atom' atom) tfs |> Option.map Lib.snd3

and find_case tcs op =
  List.find_opt (fun (op', _, _) -> Eq.eq_mixop op' op) tcs |> Option.map Lib.snd3


(* Type Disjointness *)

and disj_typ env t1 t2 =
  Debug.(log "il.disj_typ"
    (fun _ -> fmt "%s >< %s" (il_typ t1) (il_typ t2)) Bool.to_string
  ) @@ fun _ ->
  match t1.it, t2.it with
  | VarT _, VarT _ ->
    (match (reduce_typdef_ok env t1).it, (reduce_typdef_ok env t2).it with
    | StructT tfs1, StructT tfs2 ->
      unordered (atoms tfs1) (atoms tfs2) ||
      List.exists (fun (atom, (t2, _qs2, _prems2), _) ->
        match find_field tfs1 atom with
        | Some (t1, _qs1, _prems1) -> disj_typ env t1 t2
        | None -> true
      ) tfs2
    | VariantT tcs1, VariantT tcs2 ->
      List.for_all (fun (mixop, (t1, _qs1, _prems1), _) ->
        match find_case tcs2 mixop with
        | Some (t2, _qs2, _prems2) -> disj_typ env t1 t2
        | None -> true
      ) tcs1
    | _, _ -> true
    )
  | VarT _, _ ->
    let t1' = reduce_typ_ok env t1 in
    t1 <> t1' && disj_typ env t1' t2
  | _, VarT _ ->
    let t2' = reduce_typ_ok env t2 in
    t2 <> t2' && disj_typ env t1 t2'
  | TupT ets1, TupT ets2 -> disj_tup env Subst.empty ets1 ets2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    disj_typ env t11 t21 || not (Eq.eq_iter iter1 iter2)
  | _, _ ->
    not (equiv_typ env t1 t2)

and atoms xs = Set.of_list (List.map Print.string_of_atom (List.map Lib.fst3 xs))

and disj_tup env s xts1 xts2 =
  match xts1, xts2 with
  | (x1, t1)::xts1', (x2, t2)::xts2' ->
    disj_typ env t1 (Subst.subst_typ s t2) ||
    disj_tup env (Subst.add_varid s x2 (VarE x1 $$ x1.at % t1)) xts1' xts2'
  | _, _ -> xts1 <> xts2



(* Export (since OCaml's signature match can't instantiate opt args) *)

let reduce_exp = reduce_exp false
let reduce_arg = reduce_arg false

let match_iter = match_iter false
let match_exp = match_exp false
let match_arg = match_arg false
