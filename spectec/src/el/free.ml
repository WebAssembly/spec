open Util.Source
open Ast


(* Data Structure *)

module Set = Set.Make(String)

type sets = {synid : Set.t; gramid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

let empty =
  {synid = Set.empty; gramid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}

let union sets1 sets2 =
  { synid = Set.union sets1.synid sets2.synid;
    gramid = Set.union sets1.gramid sets2.gramid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
  }

let diff sets1 sets2 =
  { synid = Set.diff sets1.synid sets2.synid;
    gramid = Set.diff sets1.gramid sets2.gramid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
  }

let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left union empty (map free_x xs))

let free_nl_elem free_x = function Nl -> empty | Elem x -> free_x x
let free_nl_list free_x xs = List.(fold_left union empty (map (free_nl_elem free_x) xs))

let bound_opt = free_opt
let bound_list = free_list
let bound_nl_list = free_nl_list


(* Identifiers *)

let free_synid id = {empty with synid = Set.singleton id.it}
let free_gramid id = {empty with gramid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}

let bound_varid = free_varid


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> union (free_exp e) (free_opt free_varid id_opt)


(* Types *)

and free_typ t =
  match t.it with
  | VarT id -> free_synid id
  | BoolT | NumT _ | TextT -> empty
  | ParenT t1 -> free_typ t1
  | TupT ts -> free_list free_typ ts
  | IterT (t1, iter) -> union (free_typ t1) (free_iter iter)
  | StrT tfs -> free_nl_list free_typfield tfs
  | CaseT (_, ids, tcases, _) ->
    union (free_nl_list free_synid ids) (free_nl_list free_typcase tcases)
  | RangeT tes -> free_nl_list free_typenum tes
  | AtomT _ -> empty
  | SeqT ts -> free_list free_typ ts
  | InfixT (t1, _, t2) -> free_list free_typ [t1; t2]
  | BrackT (_, t1) -> free_typ t1

and free_typfield (_, (t, prems), _) =
  union (free_typ t) (free_nl_list free_prem prems)
and free_typcase (_, (ts, prems), _) =
  union (free_list free_typ ts) (free_nl_list free_prem prems)
and free_typenum (e, eo) =
  union (free_exp e) (free_opt free_exp eo)


(* Expressions *)

and free_exp e =
  match e.it with
  | VarE id -> free_varid id
  | AtomE _ | BoolE _ | NatE _ | HexE _ | CharE _ | TextE _ | EpsE | HoleE _ ->
    empty
  | UnE (_, e1) | DotE (e1, _) | LenE e1
  | ParenE (e1, _) | BrackE (_, e1) -> free_exp e1
  | BinE (e1, _, e2) | CmpE (e1, _, e2)
  | IdxE (e1, e2) | CommaE (e1, e2) | CompE (e1, e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) -> free_list free_exp [e1; e2]
  | SliceE (e1, e2, e3) -> free_list free_exp [e1; e2; e3]
  | SeqE es | TupE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (free_list free_exp [e1; e2]) (free_path p)
  | StrE efs -> free_nl_list free_expfield efs
  | CallE (id, e1) -> union (free_defid id) (free_exp e1)
  | IterE (e1, iter) -> union (free_exp e1) (free_iter iter)
  | SizeE id -> free_gramid id

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (free_path p1) (free_exp e)
  | SliceP (p1, e1, e2) ->
    union (free_path p1) (union (free_exp e1) (free_exp e2))
  | DotP (p1, _) -> free_path p1

(* We consider all variables "bound" that occur as iteration variable
 * or in an equation in "pattern" position. *)
and bound_exp e =
  match e.it with
  | CmpE (e1, EqOp, e2) -> union (pat_exp e1) (pat_exp e2)
  | VarE _ | AtomE _ | BoolE _ | NatE _ | HexE _ | CharE _ | TextE _
  | SizeE _ | EpsE | HoleE _ -> empty
  | UnE (_, e1) | DotE (e1, _) | LenE e1
  | ParenE (e1, _) | BrackE (_, e1) -> bound_exp e1
  | BinE (e1, _, e2) | CmpE (e1, _, e2) -> union (bound_exp e1) (bound_exp e2)
  | IdxE (e1, e2) | CommaE (e1, e2) | CompE (e1, e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) -> bound_list bound_exp [e1; e2]
  | SliceE (e1, e2, e3) -> bound_list bound_exp [e1; e2; e3]
  | SeqE es | TupE es -> bound_list bound_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    union (bound_list bound_exp [e1; e2]) (bound_path p)
  | StrE efs -> bound_nl_list bound_expfield efs
  | CallE (_, e1) -> bound_exp e1
  | IterE (e1, iter) -> union (bound_exp e1) (bound_iter iter)

and bound_expfield (_, e) = bound_exp e

and bound_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> union (bound_path p1) (bound_exp e)
  | SliceP (p1, e1, e2) ->
    union (bound_path p1) (union (bound_exp e1) (bound_exp e2))
  | DotP (p1, _) -> bound_path p1

and bound_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> union (bound_exp e) (bound_opt bound_varid id_opt)

and pat_exp e =
  match e.it with
  | VarE id -> bound_varid id
  | UnE ((PlusOp | MinusOp), e1)
  | ParenE (e1, _) | BrackE (_, e1) -> pat_exp e1
  (* We consider all arithmetic expressions patterns,
   * since we sometimes need to use invertible formulas. *)
  | BinE (e1, (AddOp | SubOp | MulOp | DivOp | ExpOp), e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) -> bound_list pat_exp [e1; e2]
  | SeqE es | TupE es -> bound_list pat_exp es
  | StrE efs -> bound_nl_list pat_expfield efs
  | IterE (e1, iter) -> union (pat_exp e1) (pat_iter iter)
  (* As a special hack to work with bijective functions,
   * we treat last position of a call as a pattern, too. *)
  | CallE (_, {it = TupE (_::_ as es); _}) ->
    let es', eN = Util.Lib.List.split_last es in
    union (bound_list bound_exp es') (pat_exp eN)
  | CallE (_, e1) -> pat_exp e1
  | _ -> bound_exp e

and pat_expfield (_, e) = pat_exp e

and pat_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> union (pat_exp e) (bound_opt bound_varid id_opt)


(* Premises *)

and free_prem prem =
  match prem.it with
  | RulePr (id, e) -> union (free_relid id) (free_exp e)
  | IfPr e -> free_exp e
  | ElsePr -> empty
  | IterPr (prem', iter) -> union (free_prem prem') (free_iter iter)

(* We consider all variables "bound" that occur in a judgement
 * or are bound in a condition. *)
and bound_prem prem =
  match prem.it with
  | RulePr (_id, e) -> free_exp e
  | IfPr e -> bound_exp e
  | ElsePr -> empty
  | IterPr (prem', _iter) -> bound_prem prem'


(* Grammars *)

let rec free_sym g =
  match g.it with
  | VarG (id, gs) -> union (free_gramid id) (free_list free_sym gs)
  | NatG _ | HexG _ | CharG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> free_nl_list free_sym gs
  | RangeG (g1, g2) -> union (free_sym g1) (free_sym g2)
  | ParenG g1 -> free_sym g1
  | TupG gs -> free_list free_sym gs
  | IterG (g1, iter) -> union (free_sym g1) (free_iter iter)
  | ArithG e -> free_exp e
  | AttrG (g1, e) -> union (free_sym g1) (free_exp e)

let free_prod prod =
  let (g, e, prems) = prod.it in
  union (union (free_sym g) (free_exp e)) (free_nl_list free_prem prems)

let free_gram gram =
  let (_dots1, prods, _dots2) = gram.it in
  free_nl_list free_prod prods


(* Definitions *)

let bound_param p =
  match p.it with
  | VarP id -> free_varid id
  | GramP (id1, id2, iters) ->
    union (union (free_gramid id1) (free_varid id2)) (free_list free_iter iters)

let bound_params ps = free_list bound_param ps

let free_def d =
  match d.it with
  | SynD (_id1, _id2, t, _hints) -> free_typ t
  | GramD (_id1, _id2, ps, t, gram, _hints) ->
    diff (union (free_typ t) (free_gram gram)) (bound_params ps)
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
