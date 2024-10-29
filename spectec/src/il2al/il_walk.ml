open Util.Source
open Il.Ast

(* Walker-based transformer *)

let rec transform_expr f e =
  let new_ = transform_expr f in
  let it =
    match e.it with
    | VarE _
    | BoolE _
    | NumE _
    | TextE _ -> e.it
    | CvtE (e1, nt1, nt2) -> CvtE (new_ e1, nt1, nt2)
    | UnE (op, e1) -> UnE (op, new_ e1)
    | BinE (op, e1, e2) -> BinE (op, new_ e1, new_ e2)
    | CmpE (op, e1, e2) -> CmpE (op, new_ e1, new_ e2)
    | IdxE (e1, e2) -> IdxE (new_ e1, new_ e2)
    | SliceE (e1, e2, e3) -> SliceE (new_ e1, new_ e2, new_ e3)
    | UpdE (e1, p, e2) -> UpdE (new_ e1, p, new_ e2)
    | ExtE (e1, p, e2) -> ExtE (new_ e1, p, new_ e2)
    | StrE efs -> StrE efs (* TODO efs *)
    | DotE (e1, atom) -> DotE (new_ e1, atom)
    | CompE (e1, e2) -> CompE (new_ e1, new_ e2)
    | LenE e1 -> LenE (new_ e1)
    | TupE es -> TupE ((List.map new_) es)
    | CallE (id, as1) -> CallE (id, List.map (transform_arg f) as1)
    | IterE (e1, iter) -> IterE (new_ e1, iter) (* TODO iter *)
    | ProjE (e1, i) -> ProjE (new_ e1, i)
    | UncaseE (e1, op) -> UncaseE (new_ e1, op)
    | OptE eo -> OptE ((Option.map new_) eo)
    | TheE e1 -> TheE (new_ e1)
    | ListE es -> ListE ((List.map new_) es)
    | CatE (e1, e2) -> CatE (new_ e1, new_ e2)
    | MemE (e1, e2) -> MemE (new_ e1, new_ e2)
    | CaseE (mixop, e1) -> CaseE (mixop, new_ e1)
    | SubE (e1, _t1, t2) -> SubE (new_ e1, _t1, t2)
  in
  f { e with it }


and transform_arg f a =
  { a with it = match a.it with
    | ExpA e -> ExpA (transform_expr f e)
    | TypA t -> TypA t
    | DefA id -> DefA id
    | GramA id -> GramA id }
