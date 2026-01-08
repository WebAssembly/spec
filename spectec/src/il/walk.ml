(* 
  This file provides a more generic version of the "il_walk.ml" used in the IL2AL pass.
  This is adapted from the IL2AL, however it should give more flexibility to be used as
  well in the middlend. 

  This file currently supports four kinds of traversals:
  - Transformation traversal, which transforms a specific portion of the AST
  - Collection traversal, which traverses the AST, collecting a specific term, constructing a
  list in the process
  - Exists traversal, which checks a specific predicate is true at any point of the AST
  - Forall traversal, which checks whetehr a specific predicate is true everywhere in the
  AST.

  One can define custom functions that modifies how these traversals work currently for
  expressions, types, binders, iter expressions, and arguments. This can be extended
  for others if necessary.
*)
open Util.Source
open Ast

(* Base traversal *)

type 'env transformer = {
  transform_exp: exp -> exp;
  transform_bind: bind -> bind;
  transform_prem: prem -> prem;
  transform_iterexp: iterexp -> iterexp;
  transform_typ: typ -> typ;
  transform_arg: arg -> arg;
  transform_path: path -> path;

  (* IDs *)
  transform_var_id: id -> id;
  transform_typ_id: id -> id;
  transform_rel_id: id -> id;
  transform_def_id: id -> id;
  transform_gram_id: id -> id
  }

let id = Fun.id

let base_transformer = {
  transform_exp = id;
  transform_bind = id;
  transform_prem = id;
  transform_iterexp = id;
  transform_typ = id;
  transform_arg = id;
  transform_path = id;
  
  transform_var_id = id;
  transform_typ_id = id;
  transform_rel_id = id;
  transform_def_id = id;
  transform_gram_id = id
}

let rec transform_typ t typ = 
  let f = t.transform_typ in
  let t_typ = transform_typ t in 
  let it = 
    match typ.it with
    | VarT (id, args) -> VarT (t.transform_typ_id id, List.map (transform_arg t) args)
    | IterT (typ', iter) -> IterT (t_typ typ', transform_iter t iter)
    | TupT typs -> TupT (List.map (fun (e, typ') -> (transform_exp t e, transform_typ t typ')) typs)
    | t' -> t'
  in
  f { typ with it } 

and transform_exp t e =
  let f = t.transform_exp in
  let t_exp = transform_exp t in
  let it =
    match e.it with
    | BoolE _
    | NumE _
    | TextE _ -> e.it
    | VarE id -> VarE (t.transform_var_id id)
    | CvtE (e1, nt1, nt2) -> CvtE (t_exp e1, nt1, nt2)
    | UnE (op, nt, e1) -> UnE (op, nt, t_exp e1)
    | BinE (op, nt, e1, e2) -> BinE (op, nt, t_exp e1, t_exp e2)
    | CmpE (op, nt, e1, e2) -> CmpE (op, nt, t_exp e1, t_exp e2)
    | IdxE (e1, e2) -> IdxE (t_exp e1, t_exp e2)
    | SliceE (e1, e2, e3) -> SliceE (t_exp e1, t_exp e2, t_exp e3)
    | UpdE (e1, p, e2) -> UpdE (t_exp e1, transform_path t p, t_exp e2)
    | ExtE (e1, p, e2) -> ExtE (t_exp e1, transform_path t p, t_exp e2)
    | StrE efs -> StrE (List.map (fun (a, e) -> (a, t_exp e)) efs)
    | DotE (e1, atom) -> DotE (t_exp e1, atom)
    | CompE (e1, e2) -> CompE (t_exp e1, t_exp e2)
    | LenE e1 -> LenE (t_exp e1)
    | TupE es -> TupE ((List.map t_exp) es)
    | CallE (id, as1) -> CallE (t.transform_def_id id, List.map (transform_arg t) as1)
    | IterE (e1, iter) -> IterE (t_exp e1, transform_iterexp t iter)
    | ProjE (e1, i) -> ProjE (t_exp e1, i)
    | UncaseE (e1, op) -> UncaseE (t_exp e1, op)
    | OptE eo -> OptE ((Option.map t_exp) eo)
    | TheE e1 -> TheE (t_exp e1)
    | ListE es -> ListE ((List.map t_exp) es)
    | LiftE e1 -> LiftE (t_exp e1)
    | CatE (e1, e2) -> CatE (t_exp e1, t_exp e2)
    | MemE (e1, e2) -> MemE (t_exp e1, t_exp e2)
    | CaseE (mixop, e1) -> CaseE (mixop, t_exp e1)
    | SubE (e1, _t1, t2) -> SubE (t_exp e1, _t1, t2)
    | IfE (e1, e2, e3) -> IfE (t_exp e1, t_exp e2, t_exp e3)
  in
  f { e with it; note = transform_typ t e.note }

and transform_iter t iter =
  match iter with
  | ListN (exp, Some id) -> ListN (transform_exp t exp, Some (t.transform_var_id id))
  | ListN (exp, id) -> ListN (transform_exp t exp, id)
  | _ -> iter

and transform_iterexp t (iter, ides) =
  let f = t.transform_iterexp in
  let iterexp' = (transform_iter t iter, List.map (fun (id, e) -> (t.transform_var_id id, transform_exp t e)) ides) in
  f iterexp'

and transform_path t p =
  let f = t.transform_path in
  let it = (match p.it with
    | RootP -> RootP
    | DotP (p', a) -> DotP (transform_path t p', a)
    | IdxP (p', e) -> IdxP (transform_path t p', transform_exp t e)
    | SliceP (p', e1, e2) -> SliceP (transform_path t p', transform_exp t e1, transform_exp t e2)
    )
  in
  f { p with it = it; note = transform_typ t p.note }

and transform_arg t a =
  let f = t.transform_arg in
  let it =
    match a.it with
    | ExpA e -> ExpA (transform_exp t e)
    | TypA typ -> TypA (transform_typ t typ)
    | DefA id -> DefA (t.transform_def_id id)
    | GramA sym -> GramA (transform_sym t sym)
  in
  f { a with it }

and transform_prem t p =
  let f = t.transform_prem in
  let it = match p.it with
    | RulePr (id, op, e) -> RulePr (t.transform_rel_id id, op, transform_exp t e)
    | IfPr e -> IfPr (transform_exp t e)
    | LetPr (e1, e2, ss) -> LetPr (transform_exp t e1, transform_exp t e2, ss)
    | ElsePr -> ElsePr
    | IterPr (p, ie) -> IterPr (transform_prem t p, transform_iterexp t ie)
    | NegPr p -> NegPr (transform_prem t p)
  in
  f { p with it }

and transform_bind t b =
  let f = t.transform_bind in
  let it = match b.it with
    | ExpB (id, typ) -> ExpB (t.transform_var_id id, transform_typ t typ)
    | TypB id -> TypB (t.transform_typ_id id)
    | DefB (id, params, typ) -> DefB (t.transform_def_id id, List.map (transform_param t) params, transform_typ t typ)
    | GramB (id, params, typ) -> GramB (t.transform_gram_id id, List.map (transform_param t) params, transform_typ t typ)
  in
  f { b with it }

and transform_param t p =
  { p with it = match p.it with
    | ExpP (id, typ) -> ExpP (t.transform_var_id id, transform_typ t typ)
    | TypP id -> TypP (t.transform_typ_id id)
    | DefP (id, params, typ) -> DefP (t.transform_def_id id, List.map (transform_param t) params, transform_typ t typ)
    | GramP (id, typ) -> GramP (t.transform_gram_id id, transform_typ t typ)
  }

and transform_sym t s =
  { s with it = match s.it with
    | VarG (id, args) -> VarG (t.transform_gram_id id, List.map (transform_arg t) args)
    | NumG i -> NumG i
    | TextG st -> TextG st
    | EpsG -> EpsG
    | SeqG syms -> SeqG (List.map (transform_sym t) syms)
    | AltG syms -> AltG (List.map (transform_sym t) syms)
    | RangeG (s1, s2) -> RangeG (transform_sym t s1, transform_sym t s2)
    | IterG (s1, iterexp) -> IterG (transform_sym t s1, transform_iterexp t iterexp) 
    | AttrG (e, s1) -> AttrG (transform_exp t e, transform_sym t s1)
  }

and transform_deftyp t dt = 
  { dt with it = match dt.it with
    | AliasT typ -> AliasT (transform_typ t typ)
    | StructT typfields -> StructT (List.map (fun (a, (binds, typ, prems), hints) -> 
        (a, (List.map (transform_bind t) binds, transform_typ t typ, List.map (transform_prem t) prems), hints)) typfields
      )
    | VariantT typcases -> VariantT (List.map (fun (m, (binds, typ, prems), hints) -> 
        (m, (List.map (transform_bind t) binds, transform_typ t typ, List.map (transform_prem t) prems), hints)) typcases
      )
  }

and transform_clause t c =
  { c with it = match c.it with
    | DefD (bs, args, e, ps) ->
      DefD (List.map (transform_bind t) bs, List.map (transform_arg t) args, transform_exp t e, List.map (transform_prem t) ps) }

and transform_rule t r =
  let RuleD (id, binds, mixop, exp, prems) = r.it in
  RuleD (t.transform_rel_id id, List.map (transform_bind t) binds, mixop, transform_exp t exp, List.map (transform_prem t) prems) $ r.at

and transform_inst t inst = 
  { inst with it = match inst.it with
    | InstD (binds, args, deftyp) -> InstD (List.map (transform_bind t) binds, List.map (transform_arg t) args, transform_deftyp t deftyp)
  }
  
and transform_prod t p = 
  { p with it = match p.it with
    | ProdD (binds, sym, exp, prems) -> ProdD (List.map (transform_bind t) binds, transform_sym t sym, transform_exp t exp, List.map (transform_prem t) prems)
  }
and transform_def t d = 
  { d with it = match d.it with
    | TypD (id, params, insts) -> TypD (t.transform_typ_id id, List.map (transform_param t) params, List.map (transform_inst t) insts)
    | RelD (id, m, typ, rules) -> RelD (t.transform_rel_id id, m, transform_typ t typ, List.map (transform_rule t) rules)
    | DecD (id, params, typ, clauses) -> DecD (t.transform_def_id id, List.map (transform_param t) params, transform_typ t typ, List.map (transform_clause t) clauses)
    | GramD (id, params, typ, prods) -> GramD (t.transform_gram_id id, List.map (transform_param t) params, transform_typ t typ, List.map (transform_prod t) prods)
    | RecD defs -> RecD (List.map (transform_def t) defs)
    | d' -> d'
  }

(* Collection traversal *)

type 'a collector = {
  default: 'a;
  compose: 'a -> 'a -> 'a;
  collect_exp: exp -> 'a * bool;
  collect_bind: bind -> 'a * bool;
  collect_prem: prem -> 'a * bool;
  collect_iterexp: iterexp -> 'a * bool;
  collect_typ: typ -> 'a * bool;
  collect_arg: arg -> 'a * bool
  }

let no_collect default = fun _ -> (default, true)

let base_collector default compose = {
  default = default;
  compose = compose;
  collect_exp = no_collect default;
  collect_bind = no_collect default;
  collect_prem = no_collect default;
  collect_iterexp = no_collect default;
  collect_typ = no_collect default;
  collect_arg = no_collect default
}

let compose_list c (f : 'a -> 'b) (traverse_list : 'a list): 'b = 
  List.fold_right (fun v acc -> c.compose (f v) acc) traverse_list c.default

let rec collect_typ c typ = 
  let f = c.collect_typ in
  let c_typ = collect_typ c in 
  let ( $@ ) = c.compose in
  let traverse_list = 
    match typ.it with
    | VarT (_, args) -> compose_list c (collect_arg c) args
    | IterT (typ', iter) -> c_typ typ' $@ collect_iter c iter
    | TupT typs -> compose_list c (fun (e, typ') -> collect_exp c e $@ (c_typ typ')) typs
    | _ -> c.default
  in
  let (res, continue) = f typ in 
  res $@ if continue then traverse_list else c.default

and collect_exp c e =
  let f = c.collect_exp in
  let c_exp = collect_exp c in
  let ( $@ ) = c.compose in
  let traverse_list =
    match e.it with
    | VarE _ | BoolE _ | NumE _
    | OptE None | TextE _ -> c.default
    | CvtE (e1, _, _) | DotE (e1, _)| LenE e1
    | ProjE (e1, _) | UncaseE (e1, _) | OptE (Some e1)
    | TheE e1 | LiftE e1 | CaseE (_, e1) | UnE (_, _, e1) -> c_exp e1
    | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2) | CompE (e1, e2) 
    | CatE (e1, e2)| MemE (e1, e2) | IdxE (e1, e2) -> c_exp e1 $@ c_exp e2
    | IfE (e1, e2, e3) | SliceE (e1, e2, e3) -> c_exp e1 $@ c_exp e2 $@ c_exp e3
    | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> c_exp e1 $@ collect_path c p $@ c_exp e2
    | StrE efs -> compose_list c (fun (_, e) -> c_exp e) efs
    | ListE es
    | TupE es -> compose_list c c_exp es
    | CallE (_, as1) -> compose_list c (collect_arg c) as1
    | IterE (e1, iter) -> c_exp e1 $@ collect_iterexp c iter
    | SubE (e1, t1, t2) -> c_exp e1 $@ collect_typ c t1 $@ collect_typ c t2
  in
  let (res, continue) = f e in 
  res $@ if continue then traverse_list else c.default

and collect_iter c iter = 
  match iter with
  | ListN (exp, _) -> collect_exp c exp
  | _ -> c.default

and collect_iterexp c iterexp =
  let (iter, ides) = iterexp in
  let f = c.collect_iterexp in
  let ( $@ ) = c.compose in
  let traverse_list = collect_iter c iter $@ compose_list c (fun (_, e) -> collect_exp c e) ides in
  let (res, continue) = f iterexp in 
  res $@ if continue then traverse_list else c.default

and collect_path c p =
  let ( $@ ) = c.compose in
  match p.it with
  | RootP -> c.default
  | DotP (p', _) -> collect_path c p'
  | IdxP (p', e) -> collect_path c p' $@ collect_exp c e
  | SliceP (p', e1, e2) -> collect_path c p' $@ collect_exp c e1 $@ collect_exp c e2

and collect_arg c a =
  let f = c.collect_arg in
  let ( $@ ) = c.compose in
  let traverse_list =
    match a.it with
    | ExpA e -> collect_exp c e
    | TypA typ -> collect_typ c typ
    | GramA s -> collect_sym c s
    | _ -> c.default
  in
  let (res, continue) = f a in 
  res $@ if continue then traverse_list else c.default

and collect_prem c p =
  let f = c.collect_prem in
  let ( $@ ) = c.compose in
  let traverse_list = match p.it with
    | RulePr (_, _, e)
    | IfPr e -> collect_exp c e
    | LetPr (e1, e2, _) -> collect_exp c e1 $@ collect_exp c e2
    | ElsePr -> c.default
    | IterPr (p, ie) -> collect_prem c p $@ collect_iterexp c ie
    | NegPr p -> collect_prem c p
  in
  let (res, continue) = f p in 
  res $@ if continue then traverse_list else c.default

and collect_bind c b =
  let f = c.collect_bind in
  let ( $@ ) = c.compose in
  let traverse_list = match b.it with
    | ExpB (_, typ) -> collect_typ c typ
    | TypB _ -> c.default
    | DefB (_, params, typ) -> compose_list c (collect_param c) params $@ collect_typ c typ
    | GramB (_, params, typ) -> compose_list c (collect_param c) params $@ collect_typ c typ
  in
  let (res, continue) = f b in 
  res $@ if continue then traverse_list else c.default

and collect_param c p =
  let ( $@ ) = c.compose in
  match p.it with
  | ExpP (_, typ) -> collect_typ c typ
  | TypP _ -> c.default
  | DefP (_, params, typ) -> compose_list c (collect_param c) params $@ collect_typ c typ
  | GramP (_, typ) -> collect_typ c typ

and collect_sym c s =
  let ( $@ ) = c.compose in
  match s.it with
  | VarG (_, args) -> compose_list c (collect_arg c) args
  | NumG _
  | TextG _
  | EpsG -> c.default
  | SeqG syms 
  | AltG syms -> compose_list c (collect_sym c) syms
  | RangeG (s1, s2) -> collect_sym c s1 $@ collect_sym c s2
  | IterG (s1, iterexp) -> collect_sym c s1 $@ collect_iterexp c iterexp
  | AttrG (e, s1) -> collect_exp c e $@ collect_sym c s1

(* Concrete base collectors for convenience *)

let exists_base_checker = base_collector false (||)

let forall_base_checker = base_collector true (&&)