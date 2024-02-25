(*
free_??? are equivalent to those in Il.Free module, except
1. i in e^(i<n) is not considered free.
2. n in e^n can be not considered free, depending on flag.
*)
open Util
open Source
open Il.Ast
include Il.Free

let empty =
  {typid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}
let free_varid id = {empty with varid = Set.singleton id.it}

let rec free_exp ignore_listN e =
  let f = free_exp ignore_listN in
  let fp = free_path ignore_listN in
  let fef = free_expfield ignore_listN in
  let fi = free_iterexp ignore_listN in
  let fa = free_arg ignore_listN in
  match e.it with
  | VarE id -> free_varid id
  | BoolE _ | NatE _ | TextE _ -> empty
  | UnE (_, e1) | LenE e1 | TheE e1 | MixE (_, e1) | SubE (e1, _, _)
  | DotE (e1, _) | CaseE (_, e1) | ProjE (e1, _) | UnmixE (e1, _) ->
    f e1
  | BinE (_, e1, e2) | CmpE (_, e1, e2) | IdxE (e1, e2) | CompE (e1, e2) | CatE (e1, e2) ->
    free_list f [e1; e2]
  | SliceE (e1, e2, e3) -> free_list f [e1; e2; e3]
  | OptE eo -> free_opt f eo
  | TupE es | ListE es -> free_list f es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (free_list f [e1; e2]) (fp p)
  | StrE efs -> free_list fef efs
  | CallE (_, args) -> free_list fa args
  | IterE (e1, iter) ->
    let free1 = f e1 in
    let bound, free2 = fi iter in
    diff (union free1 free2) bound

and free_expfield ignore_listN (_, e) = free_exp ignore_listN e

and free_arg ignore_listN arg =
  let f = free_exp ignore_listN in
  match arg.it with
  | ExpA e -> f e
  | TypA _ -> empty

and free_path ignore_listN p =
  let f = free_exp ignore_listN in
  let fp = free_path ignore_listN in
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (fp p1) (f e)
  | SliceP (p1, e1, e2) ->
    union (fp p1) (union (f e1) (f e2))
  | DotP (p1, _) -> fp p1

and free_iterexp ignore_listN (iter, _) =
  let f = free_exp ignore_listN in
  match iter with
  | ListN (e, None) -> empty, if ignore_listN then empty else f e
  | ListN (e, Some id) -> free_varid id, if ignore_listN then empty else f e
  | _ -> empty, empty

let rec free_prem ignore_listN prem =
  let f = free_exp ignore_listN in
  let fp = free_prem ignore_listN in
  let fi = free_iterexp ignore_listN in
  match prem.it with
  | RulePr (_id, _op, e) -> f e
  | IfPr e -> f e
  | LetPr (e1, e2, _ids) -> union (f e1) (f e2)
  | ElsePr -> empty
  | IterPr (prem', iter) ->
    let free1 = fp prem' in
    let bound, free2 = fi iter in
    diff (union free1 free2) bound
