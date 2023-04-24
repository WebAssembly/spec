(*
This transformation make explicit the following implicit side conditions
of terms in premises and conclusions:

 * Array access          a[i]         i < |a|
 * Joint iteration       e*{v1,v2}    |v1*| = |v2*|
 * Option projection     !(e)         e =!= null

(The option projection would probably be nicer by rewriting !(e) to a fresh
variable x and require e=?x. Maybe later.)
*)

open Util
open Source
open Il.Ast

(* Errors *)

let _error at msg = Source.error at "sideconditions" msg

let is_null e = CmpE (EqOp, e, OptE None $ no_region) $ no_region
let iffE e1 e2 = IfPr (BinE (EquivOp, e1, e2) $ no_region) $ no_region
let same_len e1 e2 = IfPr (CmpE (EqOp, LenE e1 $ no_region, LenE e2 $ no_region) $ no_region) $ no_region
let has_len ne e = IfPr (CmpE (EqOp, LenE e $ no_region, ne) $ no_region) $ no_region

let iter_side_conditions ((iter, vs) : iterexp) : premise list =
  let ves = List.map (fun v -> IterE (VarE v $ no_region, (iter, [v])) $ no_region) vs in
 match iter, ves with
  | _, [] -> []
  | Opt, (e::es) -> List.map (fun e' -> iffE (is_null e) (is_null e')) es
  | (List|List1), (e::es) -> List.map (same_len e) es
  | ListN ne, es -> List.map (has_len ne) es

(* Expr traversal *)
let rec t_exp e : premise list =
  (* First the conditions to be generated here *)
  begin match e.it with
  | IdxE (exp1, exp2) ->
    [IfPr (CmpE (LtOp, exp2, LenE exp1 $ no_region) $ no_region) $ no_region]
  | TheE exp ->
    [IfPr (CmpE (NeOp, exp, OptE None $ no_region) $ no_region) $ no_region]
  | IterE (_exp, iterexp) -> iter_side_conditions iterexp
  | _ -> []
  end @
  (* And now descend *)
  match e.it with
  | VarE _ | BoolE _ | NatE _ | TextE _ | OptE None
  -> []
  | UnE (_, exp)
  | DotE (_, exp, _)
  | LenE exp
  | MixE (_, exp)
  | CallE (_, exp)
  | OptE (Some exp)
  | TheE exp
  | CaseE (_, exp, _)
  | SubE (exp, _, _)
  -> t_exp exp
  | BinE (_, exp1, exp2)
  | CmpE (_, exp1, exp2)
  | IdxE (exp1, exp2)
  | CompE (exp1, exp2)
  | CatE (exp1, exp2)
  -> t_exp exp1 @ t_exp exp2
  | SliceE (exp1, exp2, exp3)
  -> t_exp exp1 @ t_exp exp2 @ t_exp exp3
  | UpdE (exp1, path, exp2)
  | ExtE (exp1, path, exp2)
  -> t_exp exp1 @ t_path path @ t_exp exp2
  | StrE fields
  -> List.concat_map (fun (_, e) -> t_exp e) fields
  | TupE es | ListE es
  -> List.concat_map t_exp es
  | IterE (e, iterexp)
  -> List.map (fun pr -> IterPr (pr, iterexp) $ no_region) (t_exp e) @ t_iterexp iterexp

and t_iterexp (iter, _) = t_iter iter

and t_iter = function
  | ListN e -> t_exp e
  | _ -> []

and t_path path = match path.it with
  | RootP -> []
  | IdxP (path, e) -> t_path path @ t_exp e
  | SliceP (path, e1, e2) -> t_path path @ t_exp e1 @ t_exp e2
  | DotP (path, _) -> t_path path


let rec t_prem prem = match prem.it with
  | RulePr (_, _, exp) -> t_exp exp
  | IfPr e -> t_exp e
  | ElsePr -> []
  | IterPr (prem, iterexp)
  -> iter_side_conditions iterexp @
     List.map (fun pr -> IterPr (pr, iterexp) $ no_region) (t_prem prem) @ t_iterexp iterexp

let t_prems = List.concat_map t_prem

(* Does prem1 obviously imply prem2? *)
let rec implies prem1 prem2 = Il.Eq.eq_prem prem1 prem2 ||
  match prem2.it with
  | IterPr (prem2', _) -> implies prem1 prem2'
  | _ -> false


let t_rule' = function
  | RuleD (id, binds, mixop, exp, prems) ->
    let extra_prems = t_prems prems @ t_exp exp in
    let prems' = Util.Lib.List.nub implies (extra_prems @ prems) in
    RuleD (id, binds, mixop, exp, prems')

let t_rule x = { x with it = t_rule' x.it }

let t_rules = List.map t_rule

let rec t_def' = function
  | RecD defs -> RecD (List.map t_def defs)
  | RelD (id, mixop, typ, rules) ->
    RelD (id, mixop, typ, t_rules rules)
  | def -> def

and t_def x = { x with it = t_def' x.it }

let transform (defs : script) =
  List.map t_def defs

