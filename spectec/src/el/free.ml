open Util.Source
open Ast

include Xl.Gen_free


(* Aggregates *)

let free_nl_elem free_x = function Nl -> empty | Elem x -> free_x x
let free_nl_list free_x xs = List.(fold_left (++) empty (map (free_nl_elem free_x) xs))


(* Identifiers *)

let free_typid id =
  let id' = Convert.strip_var_suffix id in
  match (Convert.typ_of_varid id').it with
  | VarT _ -> Xl.Gen_free.free_typid id'
  | _ -> empty

let free_op op = {empty with varid = Set.singleton op}


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, id_opt) -> free_exp e ++ free_opt free_varid id_opt


(* Types *)

and free_typ t =
  match t.it with
  | VarT (id, as_) -> free_typid id ++ free_args as_
  | BoolT | NumT _ | TextT -> empty
  | ParenT t1 -> free_typ t1
  | TupT ts -> free_list free_typ ts
  | IterT (t1, iter) -> free_typ t1 ++ free_iter iter
  | StrT (_, ts, tfs, _) ->
    free_nl_list free_typ ts ++
      free_nl_list (fun tf -> free_typfield tf) tfs
  | CaseT (_, ts, tcs, _) ->
    free_nl_list free_typ ts ++
      free_nl_list (fun tc -> free_typcase tc) tcs
  | ConT tc -> free_typcon tc
  | RangeT tes -> free_nl_list free_typenum tes
  | AtomT _ -> empty
  | SeqT ts -> free_list free_typ ts
  | InfixT (t1, _, t2) -> free_typ t1 ++ free_typ t2
  | BrackT (_, t1, _) -> free_typ t1

and free_typfield (_, (t, prems), _) = free_typ t ++ free_prems prems
and free_typcase (_, (t, prems), _) = free_typ t ++ free_prems prems
and free_typcon ((t, prems), _) = free_typ t ++ free_prems prems
and free_typenum (e, eo) = free_exp e ++ free_opt free_exp eo


(* Expressions *)

and free_unop = function
  | #signop as op -> free_op (Print.string_of_unop op)
  | _ -> empty

and free_exp e =
  match e.it with
  | VarE (id, as_) -> free_varid id ++ free_list free_arg as_
  | AtomE _ | BoolE _ | NumE _ | TextE _ | EpsE | HoleE _ | LatexE _ -> empty
  | UnE (op, e1) -> free_unop op ++ free_exp e1
  | CvtE (e1, _) | DotE (e1, _) | LenE e1
  | ParenE e1 | BrackE (_, e1, _) | ArithE e1 | UnparenE e1 -> free_exp e1
  | SizeE id -> free_gramid id
  | BinE (e1, _, e2) | CmpE (e1, _, e2)
  | IdxE (e1, e2) | CommaE (e1, e2) | CatE (e1, e2) | MemE (e1, e2)
  | InfixE (e1, _, e2) | FuseE (e1, e2) -> free_exp e1 ++ free_exp e2
  | SliceE (e1, e2, e3) -> free_exp e1 ++ free_exp e2 ++ free_exp e3
  | SeqE es | ListE es | TupE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    free_exp e1 ++ free_path p ++ free_exp e2
  | StrE efs -> free_nl_list free_expfield efs
  | CallE (id, as_) -> free_defid id ++ free_list free_arg as_
  | IterE (e1, iter) -> free_exp e1 ++ free_iter iter
  | TypE (e1, t) -> free_exp e1 ++ free_typ t

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> free_path p1 ++ free_exp e
  | SliceP (p1, e1, e2) -> free_path p1 ++ free_exp e1 ++ free_exp e2
  | DotP (p1, _) -> free_path p1


(* Grammars *)

and free_sym g =
  match g.it with
  | VarG (id, as_) -> free_gramid id ++ free_args as_
  | NumG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> free_nl_list free_sym gs
  | RangeG (g1, g2) | FuseG (g1, g2) -> free_sym g1 ++ free_sym g2
  | ParenG g1 | UnparenG g1 -> free_sym g1
  | TupG gs -> free_list free_sym gs
  | IterG (g1, iter) -> free_sym g1 ++ free_iter iter
  | ArithG e -> free_exp e
  | AttrG (e, g1) -> free_exp e ++ free_sym g1

and free_prod prod =
  match prod.it with
  | SynthP (g, e, prems) -> free_sym g ++ free_exp e ++ free_prems prems
  | RangeP (g1, e1, g2, e2) ->
    free_sym g1 ++ free_exp e1 ++ free_sym g2 ++ free_exp e2
  | EquivP (g1, g2, prems) -> free_sym g1 ++ free_sym g2 ++ free_prems prems

and free_gram gram =
  let (_dots1, prods, _dots2) = gram.it in
  let s = free_nl_list free_prod prods in
  {s with varid = Set.empty}


(* Premises *)

and free_prem prem =
  match prem.it with
  | VarPr (id, t) -> free_varid id ++ free_typ t
  | RulePr (id, e) -> free_relid id ++ free_exp e
  | IfPr e -> free_exp e
  | ElsePr -> empty
  | IterPr (prem1, iter) -> free_prem prem1 ++ free_iter iter

and free_prems prems = free_nl_list free_prem prems


(* Definitions *)

and free_arg a =
  match !(a.it) with
  | ExpA e -> free_exp e
  | TypA t -> free_typ t
  | GramA g -> free_sym g
  | DefA id -> free_defid id

and free_param p =
  match p.it with
  | ExpP (_, t) -> free_typ t
  | TypP _ -> empty
  | GramP (_, ps, t) -> free_params ps ++ free_typ t -- bound_params ps -- impl_bound_typ ps t
  | DefP (_, ps, t) -> free_params ps ++ free_typ t -- bound_params ps

and impl_bound_typ ps t = {empty with typid = (free_typ t).typid} -- bound_params ps

and bound_param p =
  match p.it with
  | ExpP (id, _) -> bound_varid id
  | TypP id -> bound_typid id
  | GramP (id, ps, t) -> bound_gramid id ++ impl_bound_typ ps t
  | DefP (id, _, _) -> bound_defid id

and free_args as_ = free_list free_arg as_
and free_params ps = free_list_dep free_param bound_param ps
and bound_params ps = bound_list bound_param ps

let free_def d =
  match d.it with
  | FamD (_id, ps, _hints) ->
    free_list free_param ps
  | TypD (_id1, _id2, as_, t, _hints) ->
    free_args as_ ++ free_typ t
  | GramD (_id1, _id2, ps, t, gram, _hints) ->
    free_params ps ++ (free_typ t ++ free_gram gram -- bound_params ps -- impl_bound_typ ps t)
  | VarD (_id, t, _hints) -> free_typ t
  | SepD -> empty
  | RelD (_id, t, _hints) -> free_typ t
  | RuleD (id1, _id2, e, prems) ->
    free_relid id1 ++ free_exp e ++ free_prems prems
  | DecD (_id, ps, t, _hints) ->
    free_params ps ++ free_typ t -- bound_params ps
  | DefD (id, as_, e, prems) ->
    free_defid id ++ free_args as_ ++ free_exp e ++ free_prems prems
  | HintD _ -> empty
