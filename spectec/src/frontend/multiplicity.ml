open Util
open Source
open El
open Ast


(* Errors *)

let error at msg = Source.error at "multiplicity" msg


(* Environment *)

module Env = Map.Make(String)

type ctx = iter list
type env = ctx Env.t
type renv = ((region * ctx) list) Env.t


(* Solving constraints *)

let string_of_ctx id ctx =
  id ^ String.concat "" (List.map Print.string_of_iter ctx)

let rec is_prefix ctx1 ctx2 =
  match ctx1, ctx2 with
  | [], _ -> true
  | _, [] -> false
  | iter1::ctx1', iter2::ctx2' ->
    Eq.eq_iter iter1 iter2 && is_prefix ctx1' ctx2'


let rec check_ctx id (at0, ctx0) = function
  | [] -> ()
  | (at, ctx)::ctxs ->
    if not (is_prefix ctx0 ctx) then
      error at ("inconsistent variable context, " ^
        string_of_ctx id ctx0 ^ " vs " ^ string_of_ctx id ctx ^
        " (" ^ string_of_region at0 ^ ")");
    check_ctx id (at0, ctx0) ctxs


let check_ctxs id ctxs : ctx =
  let sorted = List.stable_sort
    (fun (_, ctx1) (_, ctx2) -> compare (List.length ctx1) (List.length ctx2))
    ctxs
  in
  check_ctx id (List.hd sorted) (List.tl sorted);
  snd (List.hd sorted)

let check_env (env : renv ref) : env =
  Env.mapi check_ctxs !env


(* Collecting constraints *)

let check_id env ctx id =
  let ctxs =
    match Env.find_opt id.it !env with
    | None -> [id.at, ctx]
    | Some ctxs -> (id.at, ctx)::ctxs
  in env := Env.add id.it ctxs !env


let iter_nl_list f xs = List.iter (function Nl -> () | Elem x -> f x) xs

let rec check_iter env ctx iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN e -> check_exp env ctx e

and check_exp env ctx e =
  match e.it with
  | VarE id -> check_id env ctx id
  | AtomE _
  | BoolE _
  | NatE _
  | TextE _
  | EpsE
  | HoleE _
  | FuseE _ -> ()
  | UnE (_, e1)
  | DotE (e1, _)
  | LenE e1
  | ParenE (e1, _)
  | BrackE (_, e1)
  | CallE (_, e1) -> check_exp env ctx e1
  | BinE (e1, _, e2)
  | CmpE (e1, _, e2)
  | IdxE (e1, e2)
  | CommaE (e1, e2)
  | CompE (e1, e2)
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
  | StrE efs -> iter_nl_list (fun ef -> check_exp env ctx (snd ef)) efs
  | IterE (e1, iter) ->
    check_iter env ctx iter;
    check_exp env (iter::ctx) e1

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

let rec check_prem env ctx prem =
  match prem.it with
  | RulePr (_id, e) -> check_exp env ctx e
  | IfPr e -> check_exp env ctx e
  | ElsePr -> ()
  | IterPr (prem', iter) ->
    check_iter env ctx iter;
    check_prem env (iter::ctx) prem'

let check_def d : env =
  match d.it with
  | SynD _ | RelD _ | VarD _ | DecD _ | SepD | HintD _ -> Env.empty
  | RuleD (_id1, _id2, e, prems) ->
    let env = ref Env.empty in
    check_exp env [] e;
    iter_nl_list (check_prem env []) prems;
    check_env env
  | DefD (_id, e1, e2, prems) ->
    let env = ref Env.empty in
    check_exp env [] e1;
    check_exp env [] e2;
    iter_nl_list (check_prem env []) prems;
    check_env env


(* Annotating iterations *)

open Il.Ast

type env' = iter list Env.t
type occur = Il.Ast.iter list Env.t

let union = Env.union (fun _ ctx1 ctx2 -> assert (ctx1 = ctx2); Some ctx1)


let rec annot_iter env iter : Il.Ast.iter * occur =
  match iter with
  | Opt | List | List1 -> iter, Env.empty
  | ListN e ->
    let e', occur = annot_exp env e in
    ListN e', occur

and annot_exp env e : Il.Ast.exp * occur =
  match e.it with
  | VarE id ->
    VarE id $ e.at, Env.singleton id.it (Env.find id.it env)
  | BoolE _ | NatE _ | TextE _ ->
    e, Env.empty
  | UnE (op, e1) ->
    let e1', occur1 = annot_exp env e1 in
    UnE (op, e1') $ e.at, occur1
  | BinE (op, e1, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    BinE (op, e1', e2') $ e.at, union occur1 occur2
  | CmpE (op, e1, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    CmpE (op, e1', e2') $ e.at, union occur1 occur2
  | IdxE (e1, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    IdxE (e1', e2') $ e.at, union occur1 occur2
  | SliceE (e1, e2, e3) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    let e3', occur3 = annot_exp env e3 in
    SliceE (e1', e2', e3') $ e.at, union (union occur1 occur2) occur3
  | UpdE (e1, p, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let p', occur2 = annot_path env p in
    let e2', occur3 = annot_exp env e2 in
    UpdE (e1', p', e2') $ e.at, union (union occur1 occur2) occur3
  | ExtE (e1, p, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let p', occur2 = annot_path env p in
    let e2', occur3 = annot_exp env e2 in
    ExtE (e1', p', e2') $ e.at, union (union occur1 occur2) occur3
  | StrE efs ->
    let efs', occurs = List.split (List.map (annot_expfield env) efs) in
    StrE efs' $ e.at, List.fold_left union Env.empty occurs
  | DotE (t, e1, atom) ->
    let e1', occur1 = annot_exp env e1 in
    DotE (t, e1', atom) $ e.at, occur1
  | CompE (e1, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    CompE (e1', e2') $ e.at, union occur1 occur2
  | LenE e1 ->
    let e1', occur1 = annot_exp env e1 in
    LenE e1' $ e.at, occur1
  | TupE es ->
    let es', occurs = List.split (List.map (annot_exp env) es) in
    TupE es' $ e.at, List.fold_left union Env.empty occurs
  | MixE (op, e1) ->
    let e1', occur1 = annot_exp env e1 in
    MixE (op, e1') $ e.at, occur1
  | CallE (id, e1) ->
    let e1', occur1 = annot_exp env e1 in
    CallE (id, e1') $ e.at, occur1
  | IterE (e1, iter) ->
    let e1', occur1 = annot_exp env e1 in
    let iter', occur' = annot_iterexp env occur1 iter e.at in
    IterE (e1', iter') $ e.at, occur'
  | OptE None ->
    OptE None $ e.at, Env.empty
  | OptE (Some e1) ->
    let e1', occur1 = annot_exp env e1 in
    OptE (Some e1') $ e.at, occur1
  | TheE e1 ->
    let e1', occur1 = annot_exp env e1 in
    TheE e1' $ e.at, occur1
  | ListE es ->
    let es', occurs = List.split (List.map (annot_exp env) es) in
    ListE es' $ e.at, List.fold_left union Env.empty occurs
  | CatE (e1, e2) ->
    let e1', occur1 = annot_exp env e1 in
    let e2', occur2 = annot_exp env e2 in
    CatE (e1', e2') $ e.at, union occur1 occur2
  | CaseE (atom, e1, t) ->
    let e1', occur1 = annot_exp env e1 in
    CaseE (atom, e1', t) $ e.at, occur1
  | SubE (e1, t1, t2) ->
    let e1', occur1 = annot_exp env e1 in
    SubE (e1', t1, t2) $ e.at, occur1

and annot_expfield env (atom, e) : Il.Ast.expfield * occur =
  let e', occur = annot_exp env e in
  (atom, e'), occur

and annot_path env p : Il.Ast.path * occur =
  match p.it with
  | RootP -> p, Env.empty
  | IdxP (p1, e) ->
    let p1', occur1 = annot_path env p1 in
    let e', occur2 = annot_exp env e in
    IdxP (p1', e') $ p.at, union occur1 occur2
  | SliceP (p1, e1, e2) ->
    let p1', occur1 = annot_path env p1 in
    let e1', occur2 = annot_exp env e1 in
    let e2', occur3 = annot_exp env e2 in
    SliceP (p1', e1', e2') $ p.at, union occur1 (union occur2 occur3)
  | DotP (p1, atom) ->
    let p1', occur1 = annot_path env p1 in
    DotP (p1', atom) $ p.at, occur1

and annot_iterexp env occur1 (iter, ids) at : Il.Ast.iterexp * occur =
  assert (ids = []);
  let iter', occur2 = annot_iter env iter in
  let occur1' =
    Env.filter_map (fun _ iters ->
      match iters with
      | [] -> None
      | iter1::iters' -> assert (Il.Eq.eq_iter iter iter1); Some iters'
    ) occur1
  in
  let ids' = List.map (fun (x, _) -> x $ at) (Env.bindings occur1') in
  (iter', ids'), union occur1' occur2


and annot_prem env prem : Il.Ast.premise * occur =
  match prem.it with
  | RulePr (id, op, e) ->
    let e', occur = annot_exp env e in
    RulePr (id, op, e') $ prem.at, occur
  | IfPr e ->
    let e', occur = annot_exp env e in
    IfPr e' $ prem.at, occur
  | ElsePr ->
    prem, Env.empty
  | IterPr (prem1, iter) ->
    let prem1', occur1 = annot_prem env prem1 in
    let iter', occur' = annot_iterexp env occur1 iter prem.at in
    IterPr (prem1', iter') $ prem.at, occur'


let annot_exp env e =
  let e', occurs = annot_exp env e in
  assert (Env.for_all (fun _ ctx -> ctx = []) occurs);
  e'

let annot_prem env prem =
  let prem', occurs = annot_prem env prem in
  assert (Env.for_all (fun _ ctx -> ctx = []) occurs);
  prem'
