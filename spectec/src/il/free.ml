open Util.Source
open Ast


(* Data Structure *)

module Set = Set.Make(String)

type sets = {typid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

let empty =
  {typid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}

let union sets1 sets2 =
  { typid = Set.union sets1.typid sets2.typid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
  }

let diff sets1 sets2 =
  { typid = Set.diff sets1.typid sets2.typid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
  }

let (+) = union
let (-) = diff

let subset sets1 sets2 =
  Set.subset sets1.typid sets2.typid &&
  Set.subset sets1.relid sets2.relid &&
  Set.subset sets1.varid sets2.varid &&
  Set.subset sets1.defid sets2.defid

let disjoint sets1 sets2 =
  Set.disjoint sets1.typid sets2.typid &&
  Set.disjoint sets1.relid sets2.relid &&
  Set.disjoint sets1.varid sets2.varid &&
  Set.disjoint sets1.defid sets2.defid

let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left (+) empty (map free_x xs))
let free_pair free_x free_y (x, y) = free_x x + free_y y
let bound_list = free_list

let rec free_list_dep free_x bound_x = function
  | [] -> empty
  | x::xs -> free_x x + (free_list_dep free_x bound_x xs - bound_x x)


(* Identifiers *)

let free_typid id = {empty with typid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}

let bound_typid id = if id.it = "_" then empty else free_typid id
let bound_varid id = if id.it = "_" then empty else free_varid id
let bound_defid id = if id.it = "_" then empty else free_defid id


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> free_exp e + free_opt free_varid id_opt


(* Types *)

and free_typ t =
  match t.it with
  | VarT (id, as_) -> free_typid id + free_args as_
  | BoolT | NumT _ | TextT -> empty
  | TupT ets -> free_typbinds ets
  | IterT (t1, iter) -> free_typ t1 + free_iter iter

and bound_typ t =
  match t.it with
  | VarT _ | BoolT | NumT _ | TextT -> empty
  | TupT ets -> bound_list bound_typbind ets
  | IterT (t1, _iter) -> bound_typ t1
  
and free_typbind (_e, t) = free_typ t
and bound_typbind (e, _t) = free_exp e
and free_typbinds xts = free_list_dep free_typbind bound_typbind xts

and free_deftyp dt =
  match dt.it with
  | AliasT t -> free_typ t
  | StructT tfs -> free_list free_typfield tfs
  | VariantT tcs -> free_list free_typcase tcs

and free_typfield (_, (bs, t, prems), _) =
  free_binds bs + (free_typ t + (free_prems prems - bound_typ t) - bound_binds bs)
and free_typcase (_, (bs, t, prems), _) =
  free_binds bs + (free_typ t + (free_prems prems - bound_typ t) - bound_binds bs)


(* Expressions *)

and free_exp e =
  match e.it with
  | VarE id -> free_varid id
  | BoolE _ | NatE _ | TextE _ -> empty
  | UnE (_, e1) | LenE e1 | ProjE (e1, _) | TheE e1 | DotE (e1, _) -> free_exp e1
  | BinE (_, e1, e2) | CmpE (_, e1, e2)
  | IdxE (e1, e2) | CompE (e1, e2) | CatE (e1, e2) -> free_exp e1 + free_exp e2
  | SliceE (e1, e2, e3) -> free_list free_exp [e1; e2; e3]
  | OptE eo -> free_opt free_exp eo
  | TupE es | ListE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> free_exp e1 + free_path p + free_exp e2
  | StrE efs -> free_list free_expfield efs
  | CaseE (_, e1) | UncaseE (e1, _) -> free_exp e1
  | CallE (id, as1) -> free_defid id + free_args as1
  | IterE (e1, iter) -> free_exp e1 + free_iterexp iter
  | SubE (e1, t1, t2) -> free_exp e1 + free_typ t1 + free_typ t2

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> free_path p1 + free_exp e
  | SliceP (p1, e1, e2) -> free_path p1 + free_exp e1 + free_exp e2
  | DotP (p1, _atom) -> free_path p1

and free_iterexp (iter, bs) =
    free_iter iter + free_list (free_pair free_varid free_typ) bs


(* Premises *)

and free_prem prem =
  match prem.it with
  | RulePr (id, _op, e) -> free_relid id + free_exp e
  | IfPr e -> free_exp e
  | LetPr (e1, e2, ids) -> free_exp e1 + free_exp e2 + free_list free_varid ids
  | ElsePr -> empty
  | IterPr (prem1, iter) -> free_prem prem1 + free_iterexp iter

and free_prems prems = free_list free_prem prems


(* Definitions *)

and free_arg a =
  match a.it with
  | ExpA e -> free_exp e
  | TypA t -> free_typ t
  | DefA id -> free_defid id

and free_bind b =
  match b.it with
  | ExpB (_, t, _) -> free_typ t
  | TypB _ -> empty
  | DefB (_, ps, t) -> free_params ps + free_typ t - bound_params ps

and free_param p =
  match p.it with
  | ExpP (_, t) -> free_typ t
  | TypP _ -> empty
  | DefP (_, ps, t) -> free_params ps + free_typ t - bound_params ps

and bound_bind b =
  match b.it with
  | ExpB (id, _, _) -> bound_varid id
  | TypB id -> bound_typid id
  | DefB (id, _, _) -> bound_defid id

and bound_param p =
  match p.it with
  | ExpP (id, _) -> bound_varid id
  | TypP id -> bound_typid id
  | DefP (id, _, _) -> bound_defid id

and free_args as_ = free_list free_arg as_
and free_binds bs = free_list_dep free_bind bound_bind bs
and free_params ps = free_list_dep free_param bound_param ps

and bound_binds bs = free_list bound_bind bs
and bound_params ps = free_list bound_param ps

let free_inst inst =
  match inst.it with
  | InstD (bs, as_, dt) ->
    free_binds bs + (free_args as_ + free_deftyp dt - bound_binds bs)

let free_rule rule =
  match rule.it with
  | RuleD (_id, bs, _op, e, prems) ->
    free_binds bs + (free_exp e + free_prems prems - bound_binds bs)

let free_clause clause =
  match clause.it with
  | DefD (bs, as_, e, prems) ->
    free_binds bs + (free_args as_ + free_exp e + free_prems prems - bound_binds bs)

let free_hintdef hd =
  match hd.it with
  | TypH (id, _) -> free_typid id
  | RelH (id, _) -> free_relid id
  | DecH (id, _) -> free_defid id

let rec free_def d =
  match d.it with
  | TypD (_id, ps, insts) -> free_params ps + free_list free_inst insts
  | RelD (_id, _mixop, t, rules) -> free_typ t + free_list free_rule rules
  | DecD (_id, ps, t, clauses) ->
    free_params ps + (free_typ t - bound_params ps)
      + free_list free_clause clauses
  | RecD ds -> free_list free_def ds
  | HintD hd -> free_hintdef hd

let rec bound_def d =
  match d.it with
  | TypD (id, _, _) -> free_typid id
  | RelD (id, _, _, _) -> free_relid id
  | DecD (id, _, _, _) -> free_defid id
  | RecD ds -> free_list bound_def ds
  | HintD _ -> empty
