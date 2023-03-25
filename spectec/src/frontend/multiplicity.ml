open Util
open Source
open El
open Ast


(* Errors *)

let error at msg = Source.error at "multiplicity" msg


(* Environment *)

module Env = Map.Make(String)

type _ctx = iter list


(* Checking *)

let string_of_ctx id ctx =
  id.it ^ String.concat "" (List.map Print.string_of_iter ctx)

exception Meet
let rec meet ctx1 ctx2 =
  match ctx1, ctx2 with
  | _, []
  | [], _ -> []
  | iter1::ctx1', iter2::ctx2' ->
    if not (Eq.eq_iter iter1 iter2) then raise Meet else
    iter1 :: meet ctx1' ctx2'

let check_id env ctx id at =
  let ctx' =
    match Env.find_opt id.it !env with
    | None -> ctx
    | Some ctx' ->
      try meet ctx ctx' with Meet ->
        error at ("inconsistent variable context, " ^
          string_of_ctx id ctx ^ " vs " ^ string_of_ctx id ctx')
  in env := Env.add id.it ctx' !env


let iter_nl_list f xs = List.iter (function Nl -> () | Elem x -> f x) xs

let rec check_iter env ctx iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN exp ->
    check_exp env ctx exp

and check_exp env ctx exp =
  match exp.it with
  | VarE id ->
    check_id env ctx id exp.at
  | AtomE _
  | BoolE _
  | NatE _
  | TextE _
  | EpsE
  | HoleE
  | FuseE _ ->
    ()
  | UnE (_, exp1)
  | DotE (exp1, _)
  | LenE exp1
  | ParenE exp1
  | BrackE (_, exp1)
  | CallE (_, exp1) ->
    check_exp env ctx exp1
  | BinE (exp1, _, exp2)
  | CmpE (exp1, _, exp2)
  | IdxE (exp1, exp2)
  | CommaE (exp1, exp2)
  | CompE (exp1, exp2)
  | InfixE (exp1, _, exp2) ->
    check_exp env ctx exp1;
    check_exp env ctx exp2
  | SliceE (exp1, exp2, exp3) ->
    check_exp env ctx exp1;
    check_exp env ctx exp2;
    check_exp env ctx exp3
  | UpdE (exp1, path, exp2)
  | ExtE (exp1, path, exp2) ->
    check_exp env ctx exp1;
    check_path env ctx path;
    check_exp env ctx exp2
  | SeqE exps
  | TupE exps ->
    List.iter (check_exp env ctx) exps
  | StrE fields ->
    iter_nl_list (fun field -> check_exp env ctx (snd field)) fields
  | IterE (exp1, iter) ->
    check_iter env ctx iter;
    check_exp env (iter::ctx) exp1

and check_path env ctx path =
  match path.it with
  | RootP -> ()
  | IdxP (path1, exp) ->
    check_path env ctx path1;
    check_exp env ctx exp
  | DotP (path1, _) ->
    check_path env ctx path1

let check_prem env prem =
  match prem.it with
  | RulePr (_id, exp, None) ->
    check_exp env [] exp
  | RulePr (_id, exp, Some iter) ->
    check_iter env [] iter;
    check_exp env [iter] exp
  | IffPr (exp, None) ->
    check_exp env [] exp
  | IffPr (exp, Some iter) ->
    check_iter env [] iter;
    check_exp env [iter] exp
  | ElsePr -> ()

let check_def def =
  match def.it with
  | SynD _
  | RelD _
  | VarD _
  | DecD _ -> ()
  | RuleD (_id1, _id2, exp, prems) ->
    let env = ref Env.empty in
    check_exp env [] exp;
    List.iter (check_prem env) prems
  | DefD (_id, exp1, exp2, premo) ->
    let env = ref Env.empty in
    check_exp env [] exp1;
    check_exp env [] exp2;
    Option.iter (check_prem env) premo

let check script = List.iter check_def script
