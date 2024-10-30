open Util
open Source
open El
open Xl
open Ast
open Convert


(* Errors *)

let error at msg = Error.error at "dimension" msg


(* Environment *)

module Env = Map.Make(String)

type ctx = iter list
type env = ctx Env.t
type renv = ((region * ctx * [`Impl | `Expl]) list) Env.t


(* Solving constraints *)

let string_of_ctx id ctx =
  id ^ String.concat "" (List.map Print.string_of_iter ctx)

let rec is_prefix ctx1 ctx2 =
  match ctx1, ctx2 with
  | [], _ -> true
  | _, [] -> false
  | iter1::ctx1', iter2::ctx2' ->
    Eq.eq_iter iter1 iter2 && is_prefix ctx1' ctx2'


let rec check_ctx id (at0, ctx0, mode0) = function
  | [] -> ()
  | (at, ctx, mode)::ctxs ->
    if not (is_prefix ctx0 ctx) && (mode0 = `Expl || mode = `Expl) then
      error at ("inconsistent variable context, " ^
        string_of_ctx id ctx0 ^ " vs " ^ string_of_ctx id ctx ^
        " (" ^ string_of_region at0 ^ ")");
    check_ctx id (at0, ctx0, mode0) ctxs


let check_ctxs id ctxs : ctx =
  let sorted =
    if List.for_all (fun (_, _, mode) -> mode = `Impl) ctxs then
      (* Take first occurrence *)
      List.stable_sort
        (fun (at1, _, _) (at2, _, _) -> compare at1 at2)
        ctxs
    else
      let sorted = List.stable_sort
        (fun (_, ctx1, _) (_, ctx2, _) ->
          compare (List.length ctx1) (List.length ctx2))
        ctxs
      in
      check_ctx id (List.hd sorted) (List.tl sorted);
      sorted
  in
  let _, ctx, _ = List.hd sorted in
  ctx

let check_env (env : renv ref) : env =
  Env.mapi check_ctxs !env


(* Collecting constraints *)

let strip_index = function
  | ListN (e, Some _) -> ListN (e, None)
  | iter -> iter

let check_typid _env _ctx _id = ()   (* Types are always global *)
let check_gramid _env _ctx _id = ()  (* Grammars are always global *)

let check_varid env ctx mode id =
  let ctxs = Option.value (Env.find_opt id.it !env) ~default:[] in
  env := Env.add id.it ((id.at, ctx, mode)::ctxs) !env

let rec check_iter env ctx iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN (e, id_opt) ->
    check_exp env ctx e;
    Option.iter (fun id -> check_varid env [strip_index iter] `Expl id) id_opt

and check_typ env ctx t =
  match t.it with
  | VarT (id, args) ->
    check_typid env ctx (Convert.strip_var_suffix id);
    check_varid env ctx `Impl id;
    List.iter (check_arg env ctx) args
  | BoolT
  | NumT _
  | TextT ->
    check_varid env ctx `Impl (Convert.varid_of_typ t)
  | AtomT _ -> ()
  | ParenT t1
  | BrackT (_, t1, _) -> check_typ env ctx t1
  | TupT ts
  | SeqT ts -> List.iter (check_typ env ctx) ts
  | IterT (t1, iter) ->
    check_iter env ctx iter;
    check_typ env (strip_index iter::ctx) t1
  | StrT tfs ->
    iter_nl_list (fun (_, (tI, prems), _) ->
      let env' = ref Env.empty in
      check_typ env' ctx tI;
      iter_nl_list (check_prem env' ctx) prems
    ) tfs
  | CaseT (_, ts, tcs, _) ->
    iter_nl_list (check_typ env ctx) ts;
    iter_nl_list (fun (_, (tI, prems), _) ->
      let env' = ref Env.empty in
      check_typ env' ctx tI;
      iter_nl_list (check_prem env' ctx) prems
    ) tcs
  | ConT ((t1, prems), _) ->
    let env' = ref Env.empty in
    check_typ env' ctx t1;
    iter_nl_list (check_prem env' ctx) prems
  | RangeT tes ->
    iter_nl_list (fun (eI1, eoI2) ->
      let env' = ref Env.empty in
      check_exp env' ctx eI1;
      Option.iter (check_exp env' ctx) eoI2;
    ) tes
  | InfixT (t1, _, t2) ->
    check_typ env ctx t1;
    check_typ env ctx t2

and check_exp env ctx e =
  match e.it with
  | VarE (id, args) ->
    check_varid env ctx `Expl id;
    List.iter (check_arg env ctx) args
  | AtomE _
  | BoolE _
  | NumE _
  | TextE _
  | SizeE _
  | EpsE -> ()
  | CvtE (e1, _)
  | UnE (_, e1)
  | DotE (e1, _)
  | LenE e1
  | ParenE (e1, _)
  | BrackE (_, e1, _)
  | TypE (e1, _)
  | ArithE e1 -> check_exp env ctx e1
  | BinE (e1, _, e2)
  | CmpE (e1, _, e2)
  | IdxE (e1, e2)
  | CommaE (e1, e2)
  | CatE (e1, e2)
  | MemE (e1, e2)
  | InfixE (e1, _, e2) ->
    check_exp env ctx e1;
    check_exp env ctx e2
  | SliceE (e1, e2, e3) ->
    check_exp env ctx e1;
    check_exp env ctx e2;
    check_exp env ctx e3
  | UpdE (e1, p, e2)
  | ExtE (e1, p, e2) ->
    check_exp env ctx e1;
    check_path env ctx p;
    check_exp env ctx e2
  | SeqE es
  | TupE es -> List.iter (check_exp env ctx) es
  | StrE efs -> iter_nl_list (fun (_, eI) -> check_exp env ctx eI) efs
  | CallE (_, args) -> List.iter (check_arg env ctx) args
  | IterE (e1, iter) ->
    check_iter env ctx iter;
    check_exp env (strip_index iter::ctx) e1
  | HoleE _
  | FuseE _
  | UnparenE _
  | LatexE _ -> assert false

and check_path env ctx p =
  match p.it with
  | RootP -> ()
  | IdxP (p1, e) ->
    check_path env ctx p1;
    check_exp env ctx e
  | SliceP (p1, e1, e2) ->
    check_path env ctx p1;
    check_exp env ctx e1;
    check_exp env ctx e2
  | DotP (p1, _) ->
    check_path env ctx p1

and check_sym env ctx g =
  match g.it with
  | VarG (id, args) ->
    check_gramid env ctx id;
    List.iter (check_arg env ctx) args
  | NumG _
  | TextG _
  | EpsG -> ()
  | SeqG gs
  | AltG gs -> iter_nl_list (check_sym env ctx) gs
  | RangeG (g1, g2) ->
    check_sym env ctx g1;
    check_sym env ctx g2
  | ParenG g1 ->
    check_sym env ctx g1
  | TupG gs -> List.iter (check_sym env ctx) gs
  | ArithG e -> check_exp env ctx e
  | AttrG (e, g1) ->
    check_exp env ctx e;
    check_sym env ctx g1
  | IterG (g1, iter) ->
    check_iter env ctx iter;
    check_sym env (strip_index iter::ctx) g1
  | FuseG _
  | UnparenG _ -> assert false

and check_prod env ctx prod =
  let (g, e, prems) = prod.it in
  check_sym env ctx g;
  check_exp env ctx e;
  iter_nl_list (check_prem env ctx) prems

and check_gram env ctx gram =
  let (_dots1, prods, _dots2) = gram.it in
  iter_nl_list (check_prod env ctx) prods

and check_prem env ctx prem =
  match prem.it with
  | VarPr _ -> ()  (* skip, since var decls need not be under iterations *)
  | RulePr (_id, e) -> check_exp env ctx e
  | IfPr e -> check_exp env ctx e
  | ElsePr -> ()
  | IterPr (prem', iter) ->
    check_iter env ctx iter;
    check_prem env (strip_index iter::ctx) prem'

and check_arg env ctx a =
  match !(a.it) with
  | ExpA e -> check_exp env ctx e
  | TypA t -> check_typ env ctx t
  | GramA g -> check_sym env ctx g
  | DefA _id -> ()

and check_param env ctx p =
  match p.it with
  | ExpP (id, t) ->
    check_varid env ctx `Expl id;
    check_typ env ctx t
  | TypP id ->
    check_typid env ctx id;
    check_varid env ctx `Impl id
  | GramP (id, t) ->
    check_gramid env ctx id;
    check_typ env ctx t
  | DefP (_id, ps, t) ->
    List.iter (check_param env ctx) ps;
    check_typ env ctx t

let check_def d : env =
  let env = ref Env.empty in
  match d.it with
  | FamD (_id, ps, _hints) ->
    List.iter (check_param env []) ps;
    check_env env
  | TypD (_id1, _id2, args, t, _hints) ->
    List.iter (check_arg env []) args;
    check_typ env [] t;
    check_env env
  | GramD (_id1, _id2, ps, t, gram, _hints) ->
    List.iter (check_param env []) ps;
    check_typ env [] t;
    check_gram env [] gram;
    check_env env
  | RelD (_id, t, _hints) ->
    check_typ env [] t;
    check_env env
  | RuleD (_id1, _id2, e, prems) ->
    check_exp env [] e;
    iter_nl_list (check_prem env []) prems;
    check_env env
  | VarD (_id, t, _hints) ->
    check_typ env [] t;
    check_env env
  | DecD (_id, ps, t, _hints) ->
    List.iter (check_param env []) ps;
    check_typ env [] t;
    check_env env
  | DefD (_id, args, e, prems) ->
    List.iter (check_arg env []) args;
    check_exp env [] e;
    iter_nl_list (check_prem env []) prems;
    check_env env
  | SepD | HintD _ -> Env.empty


let check_prod prod : env =
  let env = ref Env.empty in
  check_prod env [] prod;
  check_env env

let check_typdef t prems : env =
  let env = ref Env.empty in
  check_typ env [] t;
  iter_nl_list (check_prem env []) prems;
  check_env env


(* Annotating iterations *)

open Il.Ast

type env' = iter list Env.t
type occur = (typ * iter list) Env.t

let union = Env.union (fun _ (_, ctx1 as occ1) (_, ctx2 as occ2) ->
  (* For well-typed scripts, t1 == t2. *)
  Some (if List.length ctx1 < List.length ctx2 then occ1 else occ2))

let strip_index = function
  | ListN (e, Some _) -> ListN (e, None)
  | iter -> iter

let annot_varid' id' = function
  | Opt -> id' ^ Il.Print.string_of_iter Opt
  | _ -> id' ^ Il.Print.string_of_iter List

let rec annot_varid id = function
  | [] -> id
  | iter::iters -> annot_varid (annot_varid' id.it iter $ id.at) iters

let rec annot_iter env iter : Il.Ast.iter * (occur * occur) =
  match iter with
  | Opt | List | List1 -> iter, Env.(empty, empty)
  | ListN (e, id_opt) ->
    let e', occur1 = annot_exp env e in
    let occur2 =
      match id_opt with
      | None -> Env.empty
      | Some id ->
        let iterexps', occurs =
          List.split
            (List.map (fun iter' -> annot_iterexp env occur1 (iter', []) e.at)
              (Env.find id.it env))
        in
        List.fold_left union
          (Env.singleton id.it (NumT Num.NatT $ id.at, List.map fst iterexps'))
          occurs
    in
    ListN (e', id_opt), (occur1, occur2)

and annot_exp env e : Il.Ast.exp * occur =
  Il.Debug.(log_in "el.annot_exp" (fun _ -> il_exp e));
  let it, occur =
    match e.it with
    | VarE id when id.it <> "_" && Env.mem id.it env ->
      VarE id, Env.singleton id.it (e.note, Env.find id.it env)
    | VarE _ | BoolE _ | NumE _ | TextE _ ->
      e.it, Env.empty
    | UnE (op, nt, e1) ->
      let e1', occur1 = annot_exp env e1 in
      UnE (op, nt, e1'), occur1
    | BinE (op, nt, e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      BinE (op, nt, e1', e2'), union occur1 occur2
    | CmpE (op, nt, e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      CmpE (op, nt, e1', e2'), union occur1 occur2
    | IdxE (e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      IdxE (e1', e2'), union occur1 occur2
    | SliceE (e1, e2, e3) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      let e3', occur3 = annot_exp env e3 in
      SliceE (e1', e2', e3'), union (union occur1 occur2) occur3
    | UpdE (e1, p, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let p', occur2 = annot_path env p in
      let e2', occur3 = annot_exp env e2 in
      UpdE (e1', p', e2'), union (union occur1 occur2) occur3
    | ExtE (e1, p, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let p', occur2 = annot_path env p in
      let e2', occur3 = annot_exp env e2 in
      ExtE (e1', p', e2'), union (union occur1 occur2) occur3
    | StrE efs ->
      let efs', occurs = List.split (List.map (annot_expfield env) efs) in
      StrE efs', List.fold_left union Env.empty occurs
    | DotE (e1, atom) ->
      let e1', occur1 = annot_exp env e1 in
      DotE (e1', atom), occur1
    | CompE (e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      CompE (e1', e2'), union occur1 occur2
    | LenE e1 ->
      let e1', occur1 = annot_exp env e1 in
      LenE e1', occur1
    | TupE es ->
      let es', occurs = List.split (List.map (annot_exp env) es) in
      TupE es', List.fold_left union Env.empty occurs
    | CallE (id, as1) ->
      let as1', occurs = List.split (List.map (annot_arg env) as1) in
      CallE (id, as1'), List.fold_left union Env.empty occurs
    | IterE (e1, iter) ->
      let e1', occur1 = annot_exp env e1 in
      let iter', occur' = annot_iterexp env occur1 iter e.at in
      IterE (e1', iter'), occur'
    | ProjE (e1, i) ->
      let e1', occur1 = annot_exp env e1 in
      ProjE (e1', i), occur1
    | UncaseE (e1, op) ->
      let e1', occur1 = annot_exp env e1 in
      UncaseE (e1', op), occur1
    | OptE None ->
      OptE None, Env.empty
    | OptE (Some e1) ->
      let e1', occur1 = annot_exp env e1 in
      OptE (Some e1'), occur1
    | TheE e1 ->
      let e1', occur1 = annot_exp env e1 in
      TheE e1', occur1
    | ListE es ->
      let es', occurs = List.split (List.map (annot_exp env) es) in
      ListE es', List.fold_left union Env.empty occurs
    | MemE (e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      MemE (e1', e2'), union occur1 occur2
    | CatE (e1, e2) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      CatE (e1', e2'), union occur1 occur2
    | CaseE (atom, e1) ->
      let e1', occur1 = annot_exp env e1 in
      CaseE (atom, e1'), occur1
    | CvtE (e1, nt1, nt2) ->
      let e1', occur1 = annot_exp env e1 in
      CvtE (e1', nt1, nt2), occur1
    | SubE (e1, t1, t2) ->
      let e1', occur1 = annot_exp env e1 in
      SubE (e1', t1, t2), occur1
  in {e with it}, occur

and annot_expfield env (atom, e) : Il.Ast.expfield * occur =
  let e', occur = annot_exp env e in
  (atom, e'), occur

and annot_path env p : Il.Ast.path * occur =
  let it, occur =
    match p.it with
    | RootP -> RootP, Env.empty
    | IdxP (p1, e) ->
      let p1', occur1 = annot_path env p1 in
      let e', occur2 = annot_exp env e in
      IdxP (p1', e'), union occur1 occur2
    | SliceP (p1, e1, e2) ->
      let p1', occur1 = annot_path env p1 in
      let e1', occur2 = annot_exp env e1 in
      let e2', occur3 = annot_exp env e2 in
      SliceP (p1', e1', e2'), union occur1 (union occur2 occur3)
    | DotP (p1, atom) ->
      let p1', occur1 = annot_path env p1 in
      DotP (p1', atom), occur1
  in {p with it}, occur

and annot_iterexp env occur1 (iter, xes) at : Il.Ast.iterexp * occur =
  assert (xes = []);
  let iter', (occur2, occur3) = annot_iter env iter in
  let occur1'_l =
    List.filter_map (fun (x, (t, iters)) ->
      match iters with
      | [] -> None
      | iter::iters' ->
        assert (Il.Eq.eq_iter (strip_index iter') iter);
        Some (x, (annot_varid' x iter, (IterT (t, iter) $ at, iters')))
    ) (Env.bindings (union occur1 occur3))
  in
(* TODO(2, rossberg): this should be active
  if occur1'_l = [] then
    error at "iteration does not contain iterable variable";
*)
  let xes' =
    List.map (fun (x, (x', (t, _))) -> x $ at, VarE (x' $ at) $$ at % t) occur1'_l in
  (iter', xes'), union (Env.of_seq (List.to_seq (List.map snd occur1'_l))) occur2

and annot_sym env g : Il.Ast.sym * occur =
  Il.Debug.(log_in "el.annot_sym" (fun _ -> il_sym g));
  let it, occur =
    match g.it with
    | VarG (id, as1) ->
      let as1', occurs = List.split (List.map (annot_arg env) as1) in
      VarG (id, as1'), List.fold_left union Env.empty occurs
    | NumG _ | TextG _ | EpsG ->
      g.it, Env.empty
    | SeqG gs ->
      let gs', occurs = List.split (List.map (annot_sym env) gs) in
      SeqG gs', List.fold_left union Env.empty occurs
    | AltG gs ->
      let gs', occurs = List.split (List.map (annot_sym env) gs) in
      AltG gs', List.fold_left union Env.empty occurs
    | RangeG (g1, g2) ->
      let g1', occur1 = annot_sym env g1 in
      let g2', occur2 = annot_sym env g2 in
      RangeG (g1', g2'), union occur1 occur2
    | IterG (g1, iter) ->
      let g1', occur1 = annot_sym env g1 in
      let iter', occur' = annot_iterexp env occur1 iter g.at in
      IterG (g1', iter'), occur'
    | AttrG (e1, g2) ->
      let e1', occur1 = annot_exp env e1 in
      let g2', occur2 = annot_sym env g2 in
      AttrG (e1', g2'), union occur1 occur2
  in {g with it}, occur

and annot_arg env a : Il.Ast.arg * occur =
  let it, occur =
    match a.it with
    | ExpA e ->
      let e', occur1 = annot_exp env e in
      ExpA e', occur1
    | TypA t -> TypA t, Env.empty
    | DefA id -> DefA id, Env.empty
    | GramA g ->
      let g', occur1 = annot_sym env g in
      GramA g', occur1
  in {a with it}, occur

and annot_prem env prem : Il.Ast.prem * occur =
  let it, occur =
    match prem.it with
    | RulePr (id, op, e) ->
      let e', occur = annot_exp env e in
      RulePr (id, op, e'), occur
    | IfPr e ->
      let e', occur = annot_exp env e in
      IfPr e', occur
    | LetPr (e1, e2, ids) ->
      let e1', occur1 = annot_exp env e1 in
      let e2', occur2 = annot_exp env e2 in
      LetPr (e1', e2', ids), union occur1 occur2
    | ElsePr ->
      ElsePr, Env.empty
    | IterPr (prem1, iter) ->
      let prem1', occur1 = annot_prem env prem1 in
      let iter', occur' = annot_iterexp env occur1 iter prem.at in
      IterPr (prem1', iter'), occur'
  in {prem with it}, occur


let annot_top annot_x env x =
  let x', occurs = annot_x env x in
  assert (Env.for_all (fun _ (_t, ctx) -> ctx = []) occurs);
  x'

let annot_iter = annot_top (fun env x -> let x', (y, _) = annot_iter env x in x', y)
let annot_exp = annot_top annot_exp
let annot_sym = annot_top annot_sym
let annot_arg = annot_top annot_arg
let annot_prem = annot_top annot_prem
