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

let diff sets1 sets2 =
  { synid = Set.diff sets1.synid sets2.synid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
  }

let subset sets1 sets2 =
  Set.subset sets1.synid sets2.synid &&
  Set.subset sets1.relid sets2.relid &&
  Set.subset sets1.varid sets2.varid &&
  Set.subset sets1.defid sets2.defid

let disjoint sets1 sets2 =
  Set.disjoint sets1.synid sets2.synid &&
  Set.disjoint sets1.relid sets2.relid &&
  Set.disjoint sets1.varid sets2.varid &&
  Set.disjoint sets1.defid sets2.defid


let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left union empty (map free_x xs))


(* Identifiers *)

let free_synid id = {empty with synid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN e -> free_exp e


(* Types *)

and free_typ t =
  match t.it with
  | VarT id -> free_synid id
  | BoolT | NatT | TextT -> empty
  | TupT ts -> free_list free_typ ts
  | IterT (t1, iter) -> union (free_typ t1) (free_iter iter)

and free_deftyp dt =
  match dt.it with
  | AliasT t | NotationT (_, t) -> free_typ t
  | StructT tfs -> free_list free_typfield tfs
  | VariantT tcs -> free_list free_typcase tcs

and free_typfield (_, t, _) = free_typ t
and free_typcase (_, t, _) = free_typ t


(* Expressions *)

and free_exp e =
  match e.it with
  | VarE id -> free_varid id
  | BoolE _ | NatE _ | TextE _ -> empty
  | UnE (_, e1) | LenE e1 | TheE e1 | MixE (_, e1) | SubE (e1, _, _) ->
    free_exp e1
  | BinE (_, e1, e2) | CmpE (_, e1, e2)
  | IdxE (e1, e2) | CompE (e1, e2) | CatE (e1, e2) ->
    free_list free_exp [e1; e2]
  | SliceE (e1, e2, e3) -> free_list free_exp [e1; e2; e3]
  | OptE eo -> free_opt free_exp eo
  | TupE es | ListE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (free_list free_exp [e1; e2]) (free_path p)
  | StrE efs -> free_list free_expfield efs
  | CallE (id, e1) -> union (free_defid id) (free_exp e1)
  | IterE (e1, iter) -> union (free_exp e1) (free_iterexp iter)
  | DotE (t, e1, _) | CaseE (_, e1, t) -> union (free_exp e1) (free_typ t)

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (free_path p1) (free_exp e)
  | SliceP (p1, e1, e2) ->
    union (free_path p1) (union (free_exp e1) (free_exp e2))
  | DotP (p1, t, _atom) -> union (free_path p1) (free_typ t)

and free_iterexp (iter, ids) =
    union (free_iter iter) (free_list free_varid ids)


(* Definitions *)

let bound_bind (id, _typ, _dim) = free_varid id
let bound_binds binds = free_list bound_bind binds

let free_bind (_id, t, _dim) = free_typ t
let free_binds binds = free_list free_bind binds

let rec free_prem prem =
  match prem.it with
  | RulePr (id, _op, e) -> union (free_relid id) (free_exp e)
  | IfPr e -> free_exp e
  | ElsePr -> empty
  | IterPr (prem', iter) -> union (free_prem prem') (free_iterexp iter)

let free_rule rule =
  match rule.it with
  | RuleD (_id, binds, _op, e, prems) ->
    union (free_binds binds)
      (diff
        (union (free_exp e) (free_list free_prem prems))
        (bound_binds binds)
      )

let free_clause clause =
  match clause.it with
  | DefD (binds, e1, e2, prems) ->
    union (free_binds binds)
      (diff
        (union (free_list free_exp [e1; e2]) (free_list free_prem prems))
        (bound_binds binds)
      )

let free_hintdef hd =
  match hd.it with
  | SynH (id, _) -> free_synid id
  | RelH (id, _) -> free_relid id
  | DecH (id, _) -> free_defid id

let rec free_def d =
  match d.it with
  | SynD (_id, dt) -> free_deftyp dt
  | RelD (_id, _mixop, t, rules) ->
    union (free_typ t) (free_list free_rule rules)
  | DecD (_id, t1, t2, clauses) ->
    union (union (free_typ t1) (free_typ t2)) (free_list free_clause clauses)
  | RecD ds -> free_list free_def ds
  | HintD hd -> free_hintdef hd


let rec bound_def d =
  match d.it with
  | SynD (id, _) -> free_synid id
  | RelD (id, _, _, _) -> free_relid id
  | DecD (id, _, _, _) -> free_defid id
  | RecD ds -> free_list bound_def ds
  | HintD _ -> empty
