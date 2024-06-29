open Util.Source
open Ast


(* Data Structure *)

module Set = Set.Make(String)

type sets =
  { typid : Set.t;
    gramid : Set.t;
    relid : Set.t;
    varid : Set.t;
    defid : Set.t;
  }

let empty =
  { typid = Set.empty;
    gramid = Set.empty;
    relid = Set.empty;
    varid = Set.empty;
    defid = Set.empty;
  }

let union sets1 sets2 =
  { typid = Set.union sets1.typid sets2.typid;
    gramid = Set.union sets1.gramid sets2.gramid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
  }

let inter sets1 sets2 =
  { typid = Set.inter sets1.typid sets2.typid;
    gramid = Set.inter sets1.gramid sets2.gramid;
    relid = Set.inter sets1.relid sets2.relid;
    varid = Set.inter sets1.varid sets2.varid;
    defid = Set.inter sets1.defid sets2.defid;
  }

let diff sets1 sets2 =
  { typid = Set.diff sets1.typid sets2.typid;
    gramid = Set.diff sets1.gramid sets2.gramid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
  }

let (+) = union
let (-) = diff

let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left (+) empty (map free_x xs))

let rec free_list_dep free_x bound_x = function
  | [] -> empty
  | x::xs -> free_x x + (free_list_dep free_x bound_x xs - bound_x x)

let free_nl_elem free_x = function Nl -> empty | Elem x -> free_x x
let free_nl_list free_x xs = List.(fold_left (+) empty (map (free_nl_elem free_x) xs))

let bound_list = free_list


(* Identifiers *)

let free_typid id = {empty with typid = Set.singleton (Convert.strip_var_suffix id).it}
let free_gramid id = {empty with gramid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}

let bound_typid id = if id.it = "_" then empty else free_typid id
let bound_gramid id = if id.it = "_" then empty else free_gramid id
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
  | ParenT t1 -> free_typ t1
  | TupT ts -> free_list free_typ ts
  | IterT (t1, iter) -> free_typ t1 + free_iter iter
  | StrT tfs ->
    free_nl_list (fun tf -> free_typfield tf - det_typfield tf) tfs
  | CaseT (_, ts, tcs, _) ->
    free_nl_list free_typ ts +
      free_nl_list (fun tc -> free_typcase tc - det_typcase tc) tcs
  | ConT tc -> free_typcon tc - det_typcon tc
  | RangeT tes -> free_nl_list free_typenum tes
  | AtomT _ -> empty
  | SeqT ts -> free_list free_typ ts
  | InfixT (t1, _, t2) -> free_typ t1 + free_typ t2
  | BrackT (_, t1, _) -> free_typ t1

and free_typfield (_, (t, prems), _) = free_typ t + free_prems prems
and free_typcase (_, (t, prems), _) = free_typ t + free_prems prems
and free_typcon ((t, prems), _) = free_typ t + free_prems prems
and free_typenum (e, eo) = free_exp e + free_opt free_exp eo


(* Variables can be determined by types through implicit binders *)
and det_typ t = det_exp (Convert.pat_of_typ t)

and det_typfield (_, (t, prems), _) = det_typ t + det_prems prems
and det_typcase (_, (t, prems), _) = det_typ t + det_prems prems
and det_typcon ((t, prems), _) = det_typ t + det_prems prems


(* Expressions *)

and free_exp e =
  match e.it with
  | VarE (id, as_) -> free_varid id + free_list free_arg as_
  | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE | HoleE _ | LatexE _ ->
    empty
  | UnE (_, e1) | DotE (e1, _) | LenE e1
  | ParenE (e1, _) | BrackE (_, e1, _) | ArithE e1 | UnparenE e1 -> free_exp e1
  | SizeE id -> free_gramid id
  | BinE (e1, _, e2) | CmpE (e1, _, e2)
  | IdxE (e1, e2) | CommaE (e1, e2) | CompE (e1, e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) -> free_exp e1 + free_exp e2
  | SliceE (e1, e2, e3) -> free_exp e1 + free_exp e2 + free_exp e3
  | SeqE es | TupE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    free_exp e1 + free_path p + free_exp e2
  | StrE efs -> free_nl_list free_expfield efs
  | CallE (id, as_) -> free_defid id + free_list free_arg as_
  | IterE (e1, iter) -> free_exp e1 + free_iter iter
  | TypE (e1, t) -> free_exp e1 + free_typ t

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> free_path p1 + free_exp e
  | SliceP (p1, e1, e2) -> free_path p1 + free_exp e1 + free_exp e2
  | DotP (p1, _) -> free_path p1


and det_exp e =
  match e.it with
  | VarE (id, []) -> bound_varid id
  | VarE _ -> assert false
  | UnE ((PlusOp | MinusOp), e1)
  | ParenE (e1, _) | BrackE (_, e1, _) | ArithE e1 -> det_exp e1
  (* We consider arithmetic expressions determinate,
   * since we sometimes need to use invertible formulas. *)
  | BinE (e1, (AddOp | SubOp | MulOp | DivOp | ModOp | ExpOp), e2)
  | InfixE (e1, _, e2) -> det_exp e1 + det_exp e2
  | SeqE es | TupE es -> free_list det_exp es
  | StrE efs -> free_nl_list det_expfield efs
  | IterE (e1, iter) -> det_exp e1 + det_iter iter
  (* As a special hack to work with bijective functions,
   * we treat last position of a call as a pattern, too. *)
  | CallE (_, []) -> empty
  | CallE (_, as_) ->
    free_list idx_arg as_ + det_arg (Util.Lib.List.last as_)
  | TypE (e1, _) -> det_exp e1
  | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE -> empty
  | UnE _ | BinE _ | CmpE _
  | IdxE _ | SliceE _ | UpdE _ | ExtE _ | CommaE _ | CompE _
  | DotE _ | LenE _ | SizeE _ -> idx_exp e
  | HoleE _ | FuseE _ | UnparenE _ | LatexE _ -> assert false

and det_expfield (_, e) = det_exp e

and det_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> det_exp e + free_opt bound_varid id_opt

and idx_exp e =
  match e.it with
  | VarE _ -> empty
  | ParenE (e1, _) | BrackE (_, e1, _) | ArithE e1 -> idx_exp e1
  | InfixE (e1, _, e2) -> idx_exp e1 + idx_exp e2
  | SeqE es | TupE es -> free_list idx_exp es
  | StrE efs -> free_nl_list idx_expfield efs
  | IterE (e1, iter) -> idx_exp e1 + idx_iter iter
  | CallE (_, as_) -> free_list idx_arg as_
  | TypE (e1, _) -> idx_exp e1
  | IdxE (_, e2) -> det_exp e2
  | _ -> empty

and idx_expfield (_, e) = idx_exp e

and idx_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> idx_exp e + free_opt bound_varid id_opt

and det_cond_exp e =
  match e.it with
  | UnE (NotOp, e1) -> det_cond_exp e1
  | BinE (e1, (AndOp | OrOp | EquivOp | ImplOp), e2) -> det_cond_exp e1 + det_cond_exp e2
  | CmpE (e1, EqOp, e2) -> det_exp e1 + det_exp e2
  | ParenE (e1, _) | ArithE e1 -> det_cond_exp e1
  | _ -> empty


(* Grammars *)

and free_sym g =
  match g.it with
  | VarG (id, as_) -> free_gramid id + free_args as_
  | NatG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> free_nl_list free_sym gs
  | RangeG (g1, g2) | FuseG (g1, g2) -> free_sym g1 + free_sym g2
  | ParenG g1 | UnparenG g1 -> free_sym g1
  | TupG gs -> free_list free_sym gs
  | IterG (g1, iter) -> free_sym g1 + free_iter iter
  | ArithG e -> free_exp e
  | AttrG (e, g1) -> free_exp e + free_sym g1

and det_sym g =
  match g.it with
  | VarG _ | NatG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> free_nl_list det_sym gs
  | RangeG (g1, g2) -> det_sym g1 + det_sym g2
  | ParenG g1 -> det_sym g1
  | TupG gs -> free_list det_sym gs
  | IterG (g1, iter) -> det_sym g1 + det_iter iter
  | ArithG e -> det_exp e
  | AttrG (e, g1) -> det_exp e + det_sym g1
  | FuseG _ | UnparenG _ -> assert false

and free_prod prod =
  let (g, e, prems) = prod.it in
  free_sym g + free_exp e + free_prems prems

and det_prod prod =
  let (g, _e, prems) = prod.it in
  det_sym g + det_prems prems

and free_gram gram =
  let (_dots1, prods, _dots2) = gram.it in
  let s = free_nl_list free_prod prods in
  {s with varid = Set.empty}


(* Premises *)

and free_prem prem =
  match prem.it with
  | VarPr (id, t) -> free_varid id + free_typ t
  | RulePr (id, e) -> free_relid id + free_exp e
  | IfPr e -> free_exp e
  | ElsePr -> empty
  | IterPr (prem1, iter) -> free_prem prem1 + free_iter iter

and det_prem prem =
  match prem.it with
  | VarPr (_id, _t) -> empty
  | RulePr (_id, e) -> det_exp e
  | IfPr e -> det_cond_exp e
  | ElsePr -> empty
  | IterPr (prem1, iter) -> det_prem prem1 + det_iter iter

and free_prems prems = free_nl_list free_prem prems
and det_prems prems = free_nl_list det_prem prems


(* Definitions *)

and free_arg a =
  match !(a.it) with
  | ExpA e -> free_exp e
  | TypA t -> free_typ t
  | GramA g -> free_sym g
  | DefA id -> free_defid id

and det_arg a =
  match !(a.it) with
  | ExpA e -> det_exp e
  | TypA t -> free_typ t  (* must be an id *)
  | GramA g -> free_sym g (* must be an id *)
  | DefA id -> free_defid id

and idx_arg a =
  match !(a.it) with
  | ExpA e -> idx_exp e
  | TypA _ -> empty
  | GramA _ -> empty
  | DefA _ -> empty

and free_param p =
  match p.it with
  | ExpP (_, t) -> free_typ t
  | TypP _ -> empty
  | GramP (_, t) -> free_typ t
  | DefP (_, ps, t) -> free_params ps + free_typ t - bound_params ps

and bound_param p =
  match p.it with
  | ExpP (id, _) -> bound_varid id
  | TypP id -> bound_typid id
  | GramP (id, _) -> bound_gramid id
  | DefP (id, _, _) -> bound_defid id

and free_args as_ = free_list free_arg as_
and det_args as_ = free_list det_arg as_

and free_params ps = free_list_dep free_param bound_param ps
and bound_params ps = bound_list bound_param ps

let free_def d =
  match d.it with
  | FamD (_id, ps, _hints) ->
    free_list free_param ps
  | TypD (_id1, _id2, as_, t, _hints) ->
    free_args as_ + free_typ t
  | GramD (_id1, _id2, ps, t, gram, _hints) ->
    free_params ps + (free_typ t + free_gram gram - bound_params ps)
  | VarD (_id, t, _hints) -> free_typ t
  | SepD -> empty
  | RelD (_id, t, _hints) -> free_typ t
  | RuleD (id1, _id2, e, prems) ->
    free_relid id1 + free_exp e + free_prems prems
  | DecD (_id, ps, t, _hints) ->
    free_params ps + free_typ t - bound_params ps
  | DefD (id, as_, e, prems) ->
    free_defid id + free_args as_ + free_exp e + free_prems prems
  | HintD _ -> empty

let det_def d =
  match d.it with
  | FamD _ | GramD _ | VarD _ | SepD | RelD _ | DecD _ | HintD _ -> empty
  | TypD (_id1, _id2, as_, _t, _hints) -> det_args as_
  | RuleD (_id1, _id2, e, prems) -> det_exp e + det_prems prems
  | DefD (_id, as_, e, prems) -> det_args as_ + idx_exp e + det_prems prems
