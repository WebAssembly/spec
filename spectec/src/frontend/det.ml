open Util.Source
open Il.Ast
open Il.Free

include Xl.Gen_free

let det_list = free_list
let det_list_dep = free_list_dep


(* Iterations *)

let rec det_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, x_opt) -> det_exp e ++ free_opt bound_varid x_opt


(* Types *)

and det_typ t =
  Il.Debug.(log_at "il.det_typ" t.at
    (fun _ -> fmt "%s" (il_typ t))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match t.it with
  | VarT (_x, as_) -> det_list det_arg as_
  | BoolT | NumT _ | TextT -> empty
  | TupT xts -> det_list_dep det_typbind bound_typbind xts
  | IterT (t1, iter) -> det_typ t1 ++ det_iter iter

and det_typbind (_x, t) = det_typ t
and bound_typbind (x, _t) = bound_varid x


(* Expressions *)

and det_exp e =
  Il.Debug.(log_at "il.det_exp" e.at
    (fun _ -> fmt "%s" (il_exp e))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match e.it with
  | VarE x -> bound_varid x
  | BoolE _ | NumE _ | TextE _ -> empty
  (* We consider arithmetic expressions determinate,
   * since we sometimes need to use invertible formulas. *)
  | CvtE (e1, _, _) | UnE (#Xl.Num.unop, _, e1) | TheE e1 | LiftE e1
  | SubE (e1, _, _) -> det_exp e1
  | BinE (#Xl.Num.binop, _, e1, e2) | CatE (e1, e2) -> det_exp e1 ++ det_exp e2
  | OptE eo -> free_opt det_exp eo
  | ListE es | TupE es -> det_list det_exp es
  | CaseE (_, as_, e1) | UncaseE (e1, _, as_) -> det_exp e1 ++ det_list det_arg as_
  | StrE efs -> det_list det_expfield efs
  | IterE (e1, ite) -> det_iterexp (det_exp e1) ite
  (* As a special hack to work with bijective functions,
   * we treat last position of a call as a pattern, too. *)
  | CallE (_, []) -> empty
  | CallE (_, as_) -> det_list det_idx_arg as_ ++ det_arg (Util.Lib.List.last as_)
  | UnE _ | BinE _ | CmpE _
  | IdxE _ | SliceE _ | UpdE _ | ExtE _ | CompE _ | MemE _
  | ProjE _ | DotE _ | LenE _ -> det_idx_exp e

and det_expfield (_, as_, e) = det_list det_quant_arg as_ ++ det_exp e

and det_iterexp s1 (it, xes) =
  s1 -- free_list bound_varid (List.map fst xes) ++
  det_iter it ++
  det_list det_exp (List.filter_map
    (fun (x, e) -> if Set.mem x.it s1.varid then Some e else None) xes)


and det_cond_exp e =
  Il.Debug.(log_at "il.det_cond_exp" e.at
    (fun _ -> fmt "%s" (il_exp e))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match e.it with
  | UnE (#Xl.Bool.unop, _, e1) -> det_cond_exp e1
  | BinE (#Xl.Bool.binop, _, e1, e2) -> det_cond_exp e1 ++ det_cond_exp e2
  | CmpE (`EqOp, _, e1, e2) -> det_exp e1 ++ det_exp e2
  | MemE (e1, e2) -> det_exp e1 ++ det_quant_exp e2
  | _ -> det_quant_exp e


and det_idx_exp e =
  Il.Debug.(log_at "il.det_idx_exp" e.at
    (fun _ -> fmt "%s" (il_exp e))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match e.it with
  | VarE _ -> empty
  | LiftE e1 | SubE (e1, _, _) -> det_idx_exp e1
  | CaseE (_, as_, e1) -> det_list det_quant_arg as_ ++ det_idx_exp e1
  | OptE eo -> free_opt det_idx_exp eo
  | ListE es | TupE es -> det_list det_idx_exp es
  | StrE efs -> det_list det_idx_expfield efs
  | IterE (e1, ite) -> det_idx_iterexp (det_idx_exp e1) ite
  | CallE (_, as_) -> det_list det_idx_arg as_
  | IdxE (e1, e2) -> det_quant_exp e1 ++ det_exp e2
  | _ -> det_quant_exp e

and det_idx_expfield (_, as_, e) =
  det_list det_quant_arg as_ ++ det_idx_exp e

and det_idx_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, x_opt) -> det_idx_exp e ++ free_opt bound_varid x_opt

and det_idx_iterexp s1 (it, xes) =
  s1 -- free_list bound_varid (List.map fst xes) ++
  det_idx_iter it ++
  det_list det_exp (List.filter_map
    (fun (x, e) -> if Set.mem x.it s1.varid then Some e else None) xes)


and det_quant_exp e =
  Il.Debug.(log_at "il.det_quant_exp" e.at
    (fun _ -> fmt "%s" (il_exp e))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match e.it with
  | VarE x -> bound_varid x
  | BoolE _ | NumE _ | TextE _ -> empty
  | UnE (_, _, e1) | ProjE (e1, _) | TheE e1 | LiftE e1 | LenE e1
  | CvtE (e1, _, _) | SubE (e1, _, _) ->
    det_quant_exp e1
  | BinE (_, _, e1, e2) | CmpE (_, _, e1, e2)
  | IdxE (e1, e2) | MemE (e1, e2) | CatE (e1, e2) | CompE (e1, e2) ->
    det_quant_exp e1 ++ det_quant_exp e2
  | SliceE (e1, e2, e3) ->
    det_quant_exp e1 ++ det_quant_exp e2 ++ det_quant_exp e3
  | UpdE (e1, p, e2) | ExtE (e1, p, e2) ->
    det_quant_exp e1 ++ det_quant_path p ++ det_quant_exp e2
  | DotE (e1, _, as_) | CaseE (_, as_, e1) | UncaseE(e1, _, as_) ->
    det_list det_arg as_ ++ det_quant_exp e1
  | OptE eo -> free_opt det_quant_exp eo
  | ListE es | TupE es -> det_list det_quant_exp es
  | StrE efs -> det_list det_quant_expfield efs
  | IterE (e1, ite) -> det_quant_iterexp (det_quant_exp e1) ite
  | CallE (_, as_) -> det_list det_quant_arg as_

and det_quant_expfield (_, as_, e) =
  det_list det_quant_arg as_ ++ det_quant_exp e

and det_quant_iterexp s1 (it, xes) =
  s1 -- free_list bound_varid (List.map fst xes) ++
  det_quant_iter it ++
  det_list det_exp (List.filter_map
    (fun (x, e) -> if Set.mem x.it s1.varid then Some e else None) xes)

and det_quant_path p =
  match p.it with
  | RootP -> empty
  | IdxP (p1, e) -> det_quant_path p1 ++ det_quant_exp e
  | SliceP (p1, e1, e2) ->
    det_quant_path p1 ++ det_quant_exp e1 ++ det_quant_exp e2
  | DotP (p1, _, as_) -> det_quant_path p1 ++ det_list det_quant_arg as_

and det_quant_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN (e, _x_opt) -> det_quant_exp e


(* Grammars *)

and det_sym g =
  Il.Debug.(log_at "il.det_sym" g.at
    (fun _ -> fmt "%s" (il_sym g))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match g.it with
  | VarG (_x, as_) -> det_list det_arg as_
  | NumG _ | TextG _ | EpsG -> empty
  | SeqG gs | AltG gs -> det_list det_sym gs
  | RangeG (g1, g2) -> det_sym g1 ++ det_sym g2
  | IterG (g1, ite) -> det_iterexp (det_sym g1) ite
  | AttrG (e, g1) -> det_exp e ++ det_sym g1


(* Premises *)

and det_prem pr =
  Il.Debug.(log_at "il.det_prem" pr.at
    (fun _ -> fmt "%s" (il_prem pr))
    (fun s -> String.concat ", " (Set.elements s.varid))
  ) @@ fun _ ->
  match pr.it with
  | RulePr (_x, _mixop, e) -> det_exp e
  | IfPr e -> det_cond_exp e
  | LetPr (e1, _e2, _xs) -> det_exp e1
  | ElsePr -> empty
  | IterPr (pr1, ite) -> det_iterexp (det_prem pr1) ite


(* Definitions *)

and det_arg a =
  match a.it with
  | ExpA e -> det_exp e
  | TypA t -> free_typ t  (* must be an id *)
  | GramA g -> free_sym g (* must be an id *)
  | DefA x -> bound_defid x

and det_idx_arg a =
  match a.it with
  | ExpA e -> det_idx_exp e
  | TypA _ -> empty
  | GramA _ -> empty
  | DefA _ -> empty

and det_quant_arg a =
  match a.it with
  | ExpA e -> det_quant_exp e
  | TypA _ -> empty
  | GramA _ -> empty
  | DefA _ -> empty
