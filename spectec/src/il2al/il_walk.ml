open Util.Source
open Il.Ast

(* Walker-based transformer *)

type transformer = {
  transform_exp: exp -> exp;
  transform_param: param -> param;
  transform_prem: prem -> prem;
  transform_iterexp: iterexp -> iterexp;
  }

let id = Fun.id
let base_transformer = {
  transform_exp = id;
  transform_param = id;
  transform_prem = id;
  transform_iterexp = id;
}

let rec transform_exp t e =
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
    | StrE efs -> StrE (List.map (fun (a, as_, e) -> (a, List.map (transform_arg t) as_, t_exp e)) efs)
    | DotE (e1, atom, as1) -> DotE (t_exp e1, atom, List.map (transform_arg t) as1)
    | CompE (e1, e2) -> CompE (t_exp e1, t_exp e2)
    | LenE e1 -> LenE (t_exp e1)
    | TupE es -> TupE ((List.map t_exp) es)
    | CallE (id, as1) -> CallE (id, List.map (transform_arg t) as1)
    | IterE (e1, iter) -> IterE (t_exp e1, transform_iterexp t iter) (* TODO iter *)
    | ProjE (e1, i) -> ProjE (t_exp e1, i)
    | UncaseE (e1, op, as1) -> UncaseE (t_exp e1, op, List.map (transform_arg t) as1)
    | OptE eo -> OptE ((Option.map t_exp) eo)
    | TheE e1 -> TheE (t_exp e1)
    | ListE es -> ListE ((List.map t_exp) es)
    | LiftE e1 -> LiftE (t_exp e1)
    | CatE (e1, e2) -> CatE (t_exp e1, t_exp e2)
    | MemE (e1, e2) -> MemE (t_exp e1, t_exp e2)
    | CaseE (mixop, as1, e1) -> CaseE (mixop, List.map (transform_arg t) as1, t_exp e1)
    | SubE (e1, _t1, t2) -> SubE (t_exp e1, _t1, t2)
  in
  f { e with it }

and transform_iterexp t (iter, ides) =
  let f = t.transform_iterexp in
  let iterexp' = (iter, List.map (fun (id, e) -> (id, transform_exp t e)) ides) in
  f iterexp'

and transform_arg t a =
  { a with it = match a.it with
    | ExpA e -> ExpA (transform_exp t e)
    | TypA t -> TypA t
    | DefA id -> DefA id
    | GramA sym -> GramA sym }

and transform_prem t p =
  let f = t.transform_prem in
  let it = match p.it with
    | RulePr (id, op, e) -> RulePr (id, op, transform_exp t e)
    | IfPr e -> IfPr (transform_exp t e)
    | LetPr (e1, e2, ss) -> LetPr (transform_exp t e1, transform_exp t e2, ss)
    | ElsePr -> ElsePr
    | IterPr (p, ie) -> IterPr (transform_prem t p, transform_iterexp t ie)
  in
  f { p with it }

and transform_param t p =
  let f = t.transform_param in
  let it = match p.it with
    | ExpP (id, typ) -> ExpP (id, typ)
    | TypP id -> TypP id
    | DefP (id, params, typ) -> DefP (id, params, typ)
    | GramP (id, params, typ) -> GramP (id, params, typ)
  in
  f { p with it }

and transform_clause t c =
  { c with it = match c.it with
    | DefD (bs, args, e, ps) ->
      DefD (List.map (transform_param t) bs, List.map (transform_arg t) args, transform_exp t e, List.map (transform_prem t) ps) }


(* For unification *)

and transform_rule_clause t rc =
  match rc with
  | (id, e1, e2, ps) -> (id, transform_exp t e1, transform_exp t e2, List.map (transform_prem t) ps)

and transform_rule_def t rd =
  { rd with it = match rd.it with
    | (s, id, rcs) -> (s, id, List.map (transform_rule_clause t) rcs) }

and transform_helper_def t hd =
  { hd with it = match hd.it with
    | (id, cs, partial) -> (id, List.map (transform_clause t) cs, partial) }

and transform_rule t r =
  let RuleD (id, params, mixop, exp, prems) = r.it in
  RuleD (id, params, mixop, transform_exp t exp, List.map (transform_prem t) prems) $ r.at
