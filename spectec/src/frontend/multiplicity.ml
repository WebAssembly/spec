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
type env' = ((region * ctx) list) Env.t


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

let check_env (env : env' ref) : env =
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
  | DotP (p1, _) ->
    check_path env ctx p1

let check_prem env prem =
  match prem.it with
  | RulePr (_id, e, None) ->
    check_exp env [] e
  | RulePr (_id, e, Some iter) ->
    check_iter env [] iter;
    check_exp env [iter] e
  | IfPr (e, None) ->
    check_exp env [] e
  | IfPr (e, Some iter) ->
    check_iter env [] iter;
    check_exp env [iter] e
  | ElsePr -> ()

let check_def d : env =
  match d.it with
  | SynD _ | RelD _ | VarD _ | DecD _ | SepD -> Env.empty
  | RuleD (_id1, _id2, e, prems) ->
    let env = ref Env.empty in
    check_exp env [] e;
    iter_nl_list (check_prem env) prems;
    check_env env
  | DefD (_id, e1, e2, prems) ->
    let env = ref Env.empty in
    check_exp env [] e1;
    check_exp env [] e2;
    iter_nl_list (check_prem env) prems;
    check_env env
