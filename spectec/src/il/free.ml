open Util.Source
open Ast

include Xl.Gen_free


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, _) -> free_exp e

and bound_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (_, xo) -> free_opt bound_varid xo


(* Types *)

and free_typ t =
  Util.Debug_log.(log "il.free_typ"
    (fun _ -> Print.string_of_typ t)
    (fun s -> list quote (Set.elements s.typid @ Set.elements s.varid))
  ) @@ fun _ ->
  match t.it with
  | VarT (x, as_) -> free_typid x ++ free_args as_
  | BoolT | NumT _ | TextT -> empty
  | TupT xts -> free_typbinds xts
  | IterT (t1, iter) -> free_typ t1 ++ free_iter iter

and bound_typ t =
  match t.it with
  | TupT xts -> bound_typbinds xts
  | _ -> empty

and free_typbind (_, t) = free_typ t
and bound_typbind (x, _) = bound_varid x
and free_typbinds xts = free_list_dep free_typbind bound_typbind xts
and bound_typbinds xts = free_list bound_typbind xts

and free_deftyp dt =
  match dt.it with
  | AliasT t -> free_typ t
  | StructT tfs -> free_list free_typfield tfs
  | VariantT tcs -> free_list free_typcase tcs

and free_typfield (_, (qs, t, prems), _) =
  free_quants qs ++ (free_typ t ++ free_prems prems -- bound_quants qs -- bound_typ t)
and free_typcase (_, (qs, t, prems), _) =
  free_quants qs ++ (free_typ t ++ free_prems prems -- bound_quants qs -- bound_typ t)


(* Expressions *)

and free_exp e =
  Util.Debug_log.(log "il.free_exp"
    (fun _ -> Print.string_of_exp e)
    (fun s -> list quote (Set.elements s.typid @ Set.elements s.varid))
  ) @@ fun _ ->
  match e.it with
  | VarE x -> free_varid x
  | BoolE _ | NumE _ | TextE _ -> empty
  | UnE (_, _, e1) | LiftE e1 | LenE e1 | ProjE (e1, _) | TheE e1 -> free_exp e1
  | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2)
  | IdxE (e1, e2) | CompE (e1, e2) | MemE (e1, e2) | CatE (e1, e2) -> free_exp e1 ++ free_exp e2
  | SliceE (e1, e2, e3) -> free_list free_exp [e1; e2; e3]
  | OptE eo -> free_opt free_exp eo
  | TupE es | ListE es -> free_list free_exp es
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> free_exp e1 ++ free_path p ++ free_exp e2
  | StrE efs -> free_list free_expfield efs
  | DotE (e1, _) | CaseE (_, e1) | UncaseE (e1, _) -> free_exp e1
  | CallE (x, as1) -> free_defid x ++ free_args as1
  | IterE (e1, ite) -> (free_exp e1 -- bound_iterexp ite) ++ free_iterexp ite
  | CvtE (e1, _nt1, _nt2) -> free_exp e1
  | SubE (e1, t1, t2) -> free_exp e1 ++ free_typ t1 ++ free_typ t2

and free_expfield (_, e) = free_exp e

and free_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> free_path p1 ++ free_exp e
  | SliceP (p1, e1, e2) -> free_path p1 ++ free_exp e1 ++ free_exp e2
  | DotP (p1, _atom) -> free_path p1

and free_iterexp (iter, xes) =
  free_iter iter ++ free_list free_exp (List.map snd xes)

and bound_iterexp (iter, xes) =
  bound_iter iter ++ free_list bound_varid (List.map fst xes)


(* Grammars *)

and free_sym g =
  match g.it with
  | VarG (x, as_) -> free_gramid x ++ free_args as_
  | NumG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> free_list free_sym gs
  | RangeG (g1, g2) -> free_sym g1 ++ free_sym g2
  | IterG (g1, ite) -> (free_sym g1 -- bound_iterexp ite) ++ free_iterexp ite
  | AttrG (e, g1) -> free_exp e ++ free_sym g1


(* Premises *)

and free_prem prem =
  match prem.it with
  | RulePr (x, _op, e) -> free_relid x ++ free_exp e
  | IfPr e -> free_exp e
  | LetPr (e1, e2, _) -> free_exp e1 ++ free_exp e2
  | ElsePr -> empty
  | IterPr (prem1, ite) -> (free_prem prem1 -- bound_iterexp ite) ++ free_iterexp ite

and free_prems prems = free_list free_prem prems


(* Definitions *)

and free_arg a =
  match a.it with
  | ExpA e -> free_exp e
  | TypA t -> free_typ t
  | DefA x -> free_defid x
  | GramA g -> free_sym g

and free_param p =
  Util.Debug_log.(log "il.free_param"
    (fun _ -> Print.string_of_param p)
    (fun s -> list quote (Set.elements s.typid @ Set.elements s.varid))
  ) @@ fun _ ->
  match p.it with
  | ExpP (_, t) -> free_typ t
  | TypP _ -> empty
  | DefP (_, ps, t) -> free_params ps ++ (free_typ t -- bound_params ps)
  | GramP (_, ps, t) -> free_params ps ++ (free_typ t -- bound_params ps)

and bound_param p =
  match p.it with
  | ExpP (x, _) -> bound_varid x
  | TypP x -> bound_typid x
  | DefP (x, _, _) -> bound_defid x
  | GramP (x, _, _) -> bound_gramid x

and free_quant q = free_param q
and bound_quant q = bound_param q

and free_args as_ = free_list free_arg as_
and free_params ps = free_list_dep free_param bound_param ps
and free_quants qs = free_list_dep free_quant bound_quant qs
and bound_params ps = free_list bound_param ps
and bound_quants qs = free_list bound_quant qs

let free_inst inst =
  match inst.it with
  | InstD (qs, as_, dt) ->
    free_quants qs ++ (free_args as_ ++ free_deftyp dt -- bound_quants qs)

let free_rule rule =
  match rule.it with
  | RuleD (_x, qs, _op, e, prems) ->
    free_quants qs ++ (free_exp e ++ free_prems prems -- bound_quants qs)

let free_clause clause =
  match clause.it with
  | DefD (qs, as_, e, prems) ->
    free_quants qs ++ (free_args as_ ++ free_exp e ++ free_prems prems -- bound_quants qs)

let free_prod prod =
  match prod.it with
  | ProdD (qs, g, e, prems) ->
    free_quants qs ++ (free_sym g ++ free_exp e ++ free_prems prems -- bound_quants qs)

let free_hintdef hd =
  match hd.it with
  | TypH (x, _) -> free_typid x
  | RelH (x, _) -> free_relid x
  | DecH (x, _) -> free_defid x
  | GramH (x, _) -> free_gramid x

let rec free_def d =
  match d.it with
  | TypD (_x, ps, insts) -> free_params ps ++ free_list free_inst insts
  | RelD (_x, _mixop, t, rules) -> free_typ t ++ free_list free_rule rules
  | DecD (_x, ps, t, clauses) ->
    free_params ps ++ (free_typ t -- bound_params ps)
      ++ free_list free_clause clauses
  | GramD (_x, ps, t, prods) ->
    free_params ps ++ (free_typ t ++ free_list free_prod prods -- bound_params ps)
  | RecD ds -> free_list free_def ds
  | HintD hd -> free_hintdef hd

let rec bound_def d =
  match d.it with
  | TypD (x, _, _) -> bound_typid x
  | RelD (x, _, _, _) -> bound_relid x
  | DecD (x, _, _, _) -> bound_defid x
  | GramD (x, _, _, _) -> bound_gramid x
  | RecD ds -> free_list bound_def ds
  | HintD _ -> empty
