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

type transformer = {
  transform_exp: exp -> exp;
  transform_bind: bind -> bind;
  transform_prem: prem -> prem;
  transform_iterexp: iterexp -> iterexp;
  transform_typ: typ -> typ;
  transform_arg: arg -> arg
  }

let id = Fun.id

let base_transformer = {
  transform_exp = id;
  transform_bind = id;
  transform_prem = id;
  transform_iterexp = id;
  transform_typ = id;
  transform_arg = id
}

let rec transform_typ t typ = 
  let f = t.transform_typ in
  let t_typ = transform_typ t in 
  let it = 
    match typ.it with
    | VarT (id, args) -> VarT (id, List.map (transform_arg t) args)
    | IterT (typ', iter) -> IterT (t_typ typ', iter)
    | TupT typs -> TupT (List.map (fun (e, typ') -> (transform_exp t e, transform_typ t typ')) typs)
    | t' -> t'
  in
  f { typ with it } 

and transform_exp t e =
  let f = t.transform_exp in
  let t_exp = transform_exp t in
  let it =
    match e.it with
    | VarE _
    | BoolE _
    | NumE _
    | TextE _ -> e.it
    | CvtE (e1, nt1, nt2) -> CvtE (t_exp e1, nt1, nt2)
    | UnE (op, nt, e1) -> UnE (op, nt, t_exp e1)
    | BinE (op, nt, e1, e2) -> BinE (op, nt, t_exp e1, t_exp e2)
    | CmpE (op, nt, e1, e2) -> CmpE (op, nt, t_exp e1, t_exp e2)
    | IdxE (e1, e2) -> IdxE (t_exp e1, t_exp e2)
    | SliceE (e1, e2, e3) -> SliceE (t_exp e1, t_exp e2, t_exp e3)
    | UpdE (e1, p, e2) -> UpdE (t_exp e1, p, t_exp e2)
    | ExtE (e1, p, e2) -> ExtE (t_exp e1, p, t_exp e2)
    | StrE efs -> StrE (List.map (fun (a, e) -> (a, t_exp e)) efs)
    | DotE (e1, atom) -> DotE (t_exp e1, atom)
    | CompE (e1, e2) -> CompE (t_exp e1, t_exp e2)
    | LenE e1 -> LenE (t_exp e1)
    | TupE es -> TupE ((List.map t_exp) es)
    | CallE (id, as1) -> CallE (id, List.map (transform_arg t) as1)
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
  f { e with it }

and transform_iterexp t (iter, ides) =
  let f = t.transform_iterexp in
  let iterexp' = (iter, List.map (fun (id, e) -> (id, transform_exp t e)) ides) in
  f iterexp'

and transform_path t p =
  { p with it = match p.it with
    | RootP -> RootP
    | DotP (p', a) -> DotP (transform_path t p', a)
    | IdxP (p', e) -> IdxP (transform_path t p', transform_exp t e)
    | SliceP (p', e1, e2) -> SliceP (transform_path t p', transform_exp t e1, transform_exp t e2) }

and transform_arg t a =
  let f = t.transform_arg in
  let it =
    match a.it with
    | ExpA e -> ExpA (transform_exp t e)
    | TypA typ -> TypA (transform_typ t typ)
    | DefA id -> DefA id
    | GramA sym -> GramA (transform_sym t sym)
  in
  f { a with it }

and transform_prem t p =
  let f = t.transform_prem in
  let it = match p.it with
    | RulePr (id, op, e) -> RulePr (id, op, transform_exp t e)
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
    | ExpB (id, typ) -> ExpB (id, transform_typ t typ)
    | TypB id -> TypB id
    | DefB (id, params, typ) -> DefB (id, List.map (transform_param t) params, transform_typ t typ)
    | GramB (id, params, typ) -> GramB (id, List.map (transform_param t) params, transform_typ t typ)
  in
  f { b with it }

and transform_param t p =
  { p with it = match p.it with
    | ExpP (id, typ) -> ExpP (id, transform_typ t typ)
    | TypP id -> TypP id
    | DefP (id, params, typ) -> DefP (id, List.map (transform_param t) params, transform_typ t typ)
    | GramP (id, typ) -> GramP (id, transform_typ t typ)
  }

and transform_sym t s =
  { s with it = match s.it with
    | VarG (id, args) -> VarG (id, List.map (transform_arg t) args)
    | NumG i -> NumG i
    | TextG st -> TextG st
    | EpsG -> EpsG
    | SeqG syms -> SeqG (List.map (transform_sym t) syms)
    | AltG syms -> AltG (List.map (transform_sym t) syms)
    | RangeG (s1, s2) -> RangeG (transform_sym t s1, transform_sym t s2)
    | IterG (s1, iterexp) -> IterG (transform_sym t s1, transform_iterexp t iterexp) 
    | AttrG (e, s1) -> AttrG (transform_exp t e, transform_sym t s1)
  }

and transform_clause t c =
  { c with it = match c.it with
    | DefD (bs, args, e, ps) ->
      DefD (List.map (transform_bind t) bs, List.map (transform_arg t) args, transform_exp t e, List.map (transform_prem t) ps) }

and transform_rule t r =
  let RuleD (id, binds, mixop, exp, prems) = r.it in
  RuleD (id, List.map (transform_bind t) binds, mixop, transform_exp t exp, List.map (transform_prem t) prems) $ r.at

(* List collection traversal *)

type 'a collector = {
  collect_exp: exp -> 'a list;
  collect_bind: bind -> 'a list;
  collect_prem: prem -> 'a list;
  collect_iterexp: iterexp -> 'a list;
  collect_typ: typ -> 'a list;
  collect_arg: arg -> 'a list
  }

let no_collect = fun _ -> []

let base_collector = {
  collect_exp = no_collect;
  collect_bind = no_collect;
  collect_prem = no_collect;
  collect_iterexp = no_collect;
  collect_typ = no_collect;
  collect_arg = no_collect
}

let rec collect_typ c typ = 
  let f = c.collect_typ in
  let c_typ = collect_typ c in 
  let traverse_list = 
    match typ.it with
    | VarT (_, args) -> List.concat_map (collect_arg c) args
    | IterT (typ', _iter) -> c_typ typ'
    | TupT typs -> List.concat_map (fun (e, typ') -> collect_exp c e @ c_typ typ') typs
    | _ -> []
  in
  f typ @ traverse_list

and collect_exp c e =
  let f = c.collect_exp in
  let c_exp = collect_exp c in
  let lst =
    match e.it with
    | VarE _ | BoolE _ | NumE _
    | OptE None | TextE _ -> []
    | CvtE (e1, _, _) | DotE (e1, _)| LenE e1
    | ProjE (e1, _) | UncaseE (e1, _) | OptE (Some e1)
    | TheE e1 | LiftE e1 | CaseE (_, e1) | UnE (_, _, e1) -> c_exp e1
    | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2) | CompE (e1, e2) 
    | CatE (e1, e2)| MemE (e1, e2) | IdxE (e1, e2) -> c_exp e1 @ c_exp e2
    | IfE (e1, e2, e3) | SliceE (e1, e2, e3) -> c_exp e1 @ c_exp e2 @ c_exp e3
    | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> c_exp e1 @ collect_path c p @ c_exp e2
    | StrE efs -> List.concat_map (fun (_, e) -> c_exp e) efs
    | ListE es
    | TupE es -> List.concat_map c_exp es
    | CallE (_, as1) -> List.concat_map (collect_arg c) as1
    | IterE (e1, iter) -> c_exp e1 @ collect_iterexp c iter
    | SubE (e1, t1, t2) -> c_exp e1 @ collect_typ c t1 @ collect_typ c t2
  in
  f e @ lst

and collect_iterexp c iterexp =
  let (_, ides) = iterexp in
  let f = c.collect_iterexp in
  let lst = List.concat_map (fun (_, e) -> collect_exp c e) ides in
  f iterexp @ lst

and collect_path c p =
  match p.it with
  | RootP -> []
  | DotP (p', _) -> collect_path c p'
  | IdxP (p', e) -> collect_path c p' @ collect_exp c e
  | SliceP (p', e1, e2) -> collect_path c p' @ collect_exp c e1 @ collect_exp c e2

and collect_arg c a =
  let f = c.collect_arg in
  let lst =
    match a.it with
    | ExpA e -> collect_exp c e
    | TypA typ -> collect_typ c typ
    | GramA s -> collect_sym c s
    | _ -> []
  in
  f a @ lst

and collect_prem c p =
  let f = c.collect_prem in
  let lst = match p.it with
    | RulePr (_, _, e)
    | IfPr e -> collect_exp c e
    | LetPr (e1, e2, _) -> collect_exp c e1 @ collect_exp c e2
    | ElsePr -> []
    | IterPr (p, ie) -> collect_prem c p @ collect_iterexp c ie
    | NegPr p -> collect_prem c p
  in
  f p @ lst

and collect_bind c b =
  let f = c.collect_bind in
  let lst = match b.it with
    | ExpB (_, typ) -> collect_typ c typ
    | TypB _ -> []
    | DefB (_, params, typ) -> List.concat_map (collect_param c) params @ collect_typ c typ
    | GramB (_, params, typ) -> List.concat_map (collect_param c) params @ collect_typ c typ
  in
  f b @ lst

and collect_param c p =
  match p.it with
  | ExpP (_, typ) -> collect_typ c typ
  | TypP _ -> []
  | DefP (_, params, typ) -> List.concat_map (collect_param c) params @ collect_typ c typ
  | GramP (_, typ) -> collect_typ c typ

and collect_sym c s =
  match s.it with
    | VarG (_, args) -> List.concat_map (collect_arg c) args
    | NumG _
    | TextG _
    | EpsG -> []
    | SeqG syms 
    | AltG syms -> List.concat_map (collect_sym c) syms
    | RangeG (s1, s2) -> collect_sym c s1 @ collect_sym c s2
    | IterG (s1, iterexp) -> collect_sym c s1 @ collect_iterexp c iterexp
    | AttrG (e, s1) -> collect_exp c e @ collect_sym c s1


(* Exists traversal *)

type 'a exists_checker = {
  exists_exp: exp -> bool;
  exists_bind: bind -> bool;
  exists_prem: prem -> bool;
  exists_iterexp: iterexp -> bool;
  exists_typ: typ -> bool;
  exists_arg: arg -> bool
  }

let falsity = fun _ -> false

let base_exists_checker = {
  exists_exp = falsity;
  exists_bind = falsity;
  exists_prem = falsity;
  exists_iterexp = falsity;
  exists_typ = falsity;
  exists_arg = falsity
}

let rec exists_typ c typ = 
  let f = c.exists_typ in
  let c_typ = exists_typ c in 
  let traverse_list = 
    match typ.it with
    | VarT (_, args) -> List.exists (exists_arg c) args
    | IterT (typ', _iter) -> c_typ typ'
    | TupT typs -> List.exists (fun (e, typ') -> exists_exp c e || c_typ typ') typs
    | _ -> false
  in
  f typ || traverse_list

and exists_exp c e =
  let f = c.exists_exp in
  let c_exp = exists_exp c in
  let lst =
    match e.it with
    | VarE _ | BoolE _ | NumE _
    | OptE None | TextE _ -> false
    | CvtE (e1, _, _) | DotE (e1, _)| LenE e1
    | ProjE (e1, _) | UncaseE (e1, _) | OptE (Some e1)
    | TheE e1 | LiftE e1 | CaseE (_, e1) | UnE (_, _, e1) -> c_exp e1
    | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2) | CompE (e1, e2) 
    | CatE (e1, e2)| MemE (e1, e2) | IdxE (e1, e2) -> c_exp e1 || c_exp e2
    | IfE (e1, e2, e3) | SliceE (e1, e2, e3) -> c_exp e1 || c_exp e2 || c_exp e3
    | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> c_exp e1 || exists_path c p || c_exp e2
    | StrE efs -> List.exists (fun (_, e) -> c_exp e) efs
    | ListE es
    | TupE es -> List.exists c_exp es
    | CallE (_, as1) -> List.exists (exists_arg c) as1
    | IterE (e1, iter) -> c_exp e1 || exists_iterexp c iter
    | SubE (e1, t1, t2) -> c_exp e1 || exists_typ c t1 || exists_typ c t2
  in
  f e || lst

and exists_iterexp c iterexp =
  let (_, ides) = iterexp in
  let f = c.exists_iterexp in
  let lst = List.exists (fun (_, e) -> exists_exp c e) ides in
  f iterexp || lst

and exists_path c p =
  match p.it with
  | RootP -> false
  | DotP (p', _) -> exists_path c p'
  | IdxP (p', e) -> exists_path c p' || exists_exp c e
  | SliceP (p', e1, e2) -> exists_path c p' || exists_exp c e1 || exists_exp c e2

and exists_arg c a =
  let f = c.exists_arg in
  let lst =
    match a.it with
    | ExpA e -> exists_exp c e
    | TypA typ -> exists_typ c typ
    | GramA sym -> exists_sym c sym
    | _ -> false
  in
  f a || lst

and exists_prem c p =
  let f = c.exists_prem in
  let lst = match p.it with
    | RulePr (_, _, e)
    | IfPr e -> exists_exp c e
    | LetPr (e1, e2, _) -> exists_exp c e1 || exists_exp c e2
    | ElsePr -> false
    | IterPr (p, ie) -> exists_prem c p || exists_iterexp c ie
    | NegPr p -> exists_prem c p
  in
  f p || lst

and exists_bind c b =
  let f = c.exists_bind in
  let lst = match b.it with
    | ExpB (_, typ) -> exists_typ c typ
    | TypB _ -> false
    | DefB (_, params, typ) -> List.exists (exists_param c) params || exists_typ c typ
    | GramB (_, params, typ) -> List.exists (exists_param c) params || exists_typ c typ
  in
  f b || lst

and exists_param c p =
  match p.it with
  | ExpP (_, typ) -> exists_typ c typ
  | TypP _ -> false
  | DefP (_, params, typ) -> List.exists (exists_param c) params || exists_typ c typ
  | GramP (_, typ) -> exists_typ c typ

and exists_sym c s =
  match s.it with
    | VarG (_, args) -> List.exists (exists_arg c) args
    | NumG _
    | TextG _
    | EpsG -> false
    | SeqG syms 
    | AltG syms -> List.exists (exists_sym c) syms
    | RangeG (s1, s2) -> exists_sym c s1 || exists_sym c s2
    | IterG (s1, iterexp) -> exists_sym c s1 || exists_iterexp c iterexp
    | AttrG (e, s1) -> exists_exp c e || exists_sym c s1

(* Forall traversal *)
  
type 'a forall_checker = {
  forall_exp: exp -> bool;
  forall_bind: bind -> bool;
  forall_prem: prem -> bool;
  forall_iterexp: iterexp -> bool;
  forall_typ: typ -> bool;
  forall_arg: arg -> bool
  }

let tauto = fun _ -> true

let base_forall_checker = {
  forall_exp = tauto;
  forall_bind = tauto;
  forall_prem = tauto;
  forall_iterexp = tauto;
  forall_typ = tauto;
  forall_arg = tauto
}

let rec forall_typ c typ = 
  let f = c.forall_typ in
  let c_typ = forall_typ c in 
  let traverse_list = 
    match typ.it with
    | VarT (_, args) -> List.for_all (forall_arg c) args
    | IterT (typ', _iter) -> c_typ typ'
    | TupT typs -> List.for_all (fun (e, typ') -> forall_exp c e && c_typ typ') typs
    | _ -> true
  in
  f typ && traverse_list

and forall_exp c e =
  let f = c.forall_exp in
  let c_exp = forall_exp c in
  let lst =
    match e.it with
    | VarE _ | BoolE _ | NumE _
    | OptE None | TextE _ -> true
    | CvtE (e1, _, _) | DotE (e1, _)| LenE e1
    | ProjE (e1, _) | UncaseE (e1, _) | OptE (Some e1)
    | TheE e1 | LiftE e1 | CaseE (_, e1) | UnE (_, _, e1) -> c_exp e1
    | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2) | CompE (e1, e2) 
    | CatE (e1, e2)| MemE (e1, e2) | IdxE (e1, e2) -> c_exp e1 && c_exp e2
    | IfE (e1, e2, e3) | SliceE (e1, e2, e3) -> c_exp e1 && c_exp e2 && c_exp e3
    | UpdE (e1, p, e2) | ExtE (e1, p, e2) -> c_exp e1 && forall_path c p && c_exp e2
    | StrE efs -> List.for_all (fun (_, e) -> c_exp e) efs
    | ListE es
    | TupE es -> List.for_all c_exp es
    | CallE (_, as1) -> List.for_all (forall_arg c) as1
    | IterE (e1, iter) -> c_exp e1 && forall_iterexp c iter
    | SubE (e1, t1, t2) -> c_exp e1 && forall_typ c t1 && forall_typ c t2
  in
  f e && lst

and forall_iterexp c iterexp =
  let (_, ides) = iterexp in
  let f = c.forall_iterexp in
  let lst = List.for_all (fun (_, e) -> forall_exp c e) ides in
  f iterexp && lst

and forall_path c p =
  match p.it with
  | RootP -> true
  | DotP (p', _) -> forall_path c p'
  | IdxP (p', e) -> forall_path c p' && forall_exp c e
  | SliceP (p', e1, e2) -> forall_path c p' && forall_exp c e1 && forall_exp c e2

and forall_arg c a =
  let f = c.forall_arg in
  let lst =
    match a.it with
    | ExpA e -> forall_exp c e
    | TypA typ -> forall_typ c typ
    | GramA sym -> forall_sym c sym
    | _ -> true
  in
  f a && lst

and forall_prem c p =
  let f = c.forall_prem in
  let lst = match p.it with
    | RulePr (_, _, e)
    | IfPr e -> forall_exp c e
    | LetPr (e1, e2, _) -> forall_exp c e1 && forall_exp c e2
    | ElsePr -> true
    | IterPr (p, ie) -> forall_prem c p && forall_iterexp c ie
    | NegPr p -> forall_prem c p
  in
  f p && lst

and forall_bind c b =
  let f = c.forall_bind in
  let lst = match b.it with
    | ExpB (_, typ) -> forall_typ c typ
    | TypB _ -> true
    | DefB (_, params, typ) -> List.for_all (forall_param c) params && forall_typ c typ
    | GramB (_, params, typ) -> List.for_all (forall_param c) params && forall_typ c typ
  in
  f b && lst

and forall_param c p =
  match p.it with
  | ExpP (_, typ) -> forall_typ c typ
  | TypP _ -> true
  | DefP (_, params, typ) -> List.for_all (forall_param c) params && forall_typ c typ
  | GramP (_, typ) -> forall_typ c typ
  
and forall_sym c s =
  match s.it with
    | VarG (_, args) -> List.for_all (forall_arg c) args
    | NumG _
    | TextG _
    | EpsG -> false
    | SeqG syms 
    | AltG syms -> List.for_all (forall_sym c) syms
    | RangeG (s1, s2) -> forall_sym c s1 || forall_sym c s2
    | IterG (s1, iterexp) -> forall_sym c s1 || forall_iterexp c iterexp
    | AttrG (e, s1) -> forall_exp c e || forall_sym c s1