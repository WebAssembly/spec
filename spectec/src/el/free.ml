open Util.Source
open Ast


(* Data Structure *)

module Set = Set.Make(String)

type sets = {synid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

let empty =
  {synid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}

let union sets1 sets2 =
  { synid = Set.union sets1.synid sets2.synid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
  }

let free_list free_x xs = List.(fold_left union empty (map free_x xs))

let free_nl_elem free_x = function Nl -> empty | Elem x -> free_x x
let free_nl_list free_x xs = List.(fold_left union empty (map (free_nl_elem free_x) xs))


(* Identifiers *)

let free_synid id = {empty with synid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, None) -> free_exp e
  | ListN (e, Some (id)) ->
      union (free_exp e) (free_varid id)


(* Types *)

and free_typ t =
  match t.it with
  | VarT id -> free_synid id
  | BoolT | NatT | TextT -> empty
  | ParenT t1 -> free_typ t1
  | TupT ts -> free_list free_typ ts
  | IterT (t1, iter) -> union (free_typ t1) (free_iter iter)
  | StrT tfs -> free_nl_list free_typfield tfs
  | CaseT (_, ids, tcases, _) ->
    union (free_nl_list free_synid ids) (free_nl_list free_typcase tcases)
  | AtomT _ -> empty
  | SeqT ts -> free_list free_typ ts
  | InfixT (t1, _, t2) -> free_list free_typ [t1; t2]
  | BrackT (_, t1) -> free_typ t1

and free_typfield (_, t, _) = free_typ t
and free_typcase (_, ts, _) = free_list free_typ ts


(* Expressions *)

and free_exp e =
  match e.it with
  | VarE id -> free_varid id
  | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE | HoleE _ -> empty
  | UnE (_, e1) | DotE (e1, _) | LenE e1
  | ParenE (e1, _) | BrackE (_, e1) -> free_exp e1
  | BinE (e1, _, e2) | CmpE (e1, _, e2)
  | IdxE (e1, e2) | CommaE (e1, e2) | CompE (e1, e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) ->
    free_list free_exp [e1; e2]
  | SliceE (e1, e2, e3) -> free_list free_exp [e1; e2; e3]
  | SeqE es | TupE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (free_list free_exp [e1; e2]) (free_path p)
  | StrE efs -> free_nl_list free_expfield efs
  | CallE (id, e1) -> union (free_defid id) (free_exp e1)
  | IterE (e1, iter) -> union (free_exp e1) (free_iter iter)

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (free_path p1) (free_exp e)
  | SliceP (p1, e1, e2) ->
    union (free_path p1) (union (free_exp e1) (free_exp e2))
  | DotP (p1, _) -> free_path p1


(* Definitions *)

let rec free_prem prem =
  match prem.it with
  | RulePr (id, e) -> union (free_relid id) (free_exp e)
  | IfPr e -> free_exp e
  | ElsePr -> empty
  | IterPr (prem', iter) -> union (free_prem prem') (free_iter iter)

let free_def d =
  match d.it with
  | SynD (_id1, _id2, t, _hints) -> free_typ t
  | VarD _ | SepD -> empty
  | RelD (_id, t, _hints) -> free_typ t
  | RuleD (id1, _id2, e, prems) ->
    union (free_relid id1) (union (free_exp e) (free_nl_list free_prem prems))
  | DecD (_id, e, t, _hints) -> union (free_exp e) (free_typ t)
  | DefD (id, e1, e2, prems) ->
    union
      (union (free_defid id) (free_exp e1))
      (union (free_exp e2) (free_nl_list free_prem prems))
  | HintD _ -> empty
