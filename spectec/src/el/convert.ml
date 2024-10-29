open Util
open Source
open Ast
open Xl

let error at msg = Error.error at "syntax" msg


let filter_nl xs = List.filter_map (function Nl -> None | Elem x -> Some x) xs
let empty_nl_list xs = filter_nl xs = []
let hd_nl_list xs = List.hd (filter_nl xs)
let last_nl_list xs = Lib.List.last (filter_nl xs)
let forall_nl_list f xs = List.for_all f (filter_nl xs)
let exists_nl_list f xs = List.exists f (filter_nl xs)
let find_nl_list f xs = List.find_opt f (filter_nl xs)
let iter_nl_list f xs = List.iter f (filter_nl xs)
let map_filter_nl_list f xs = List.map f (filter_nl xs)
let map_nl_list f xs = List.map (function Nl -> Nl | Elem x -> Elem (f x)) xs
let filter_nl_list f xs = List.filter (function Nl -> true | Elem x -> f x) xs
let concat_map_nl_list f xs = List.concat_map (function Nl -> [Nl] | Elem x -> f x) xs
let concat_map_filter_nl_list f xs = List.concat_map (function Nl -> [] | Elem x -> f x) xs

let rec is_sub s i = i = String.length s || s.[i] = '_' && is_sub s (i + 1)

let strip_var_suffix id =
  match String.index_opt id.it '_', String.index_opt id.it '\'' with
  | None, None -> id
  | Some n, None when is_sub id.it n -> id  (* keep trailing underscores *)
  | None, Some n | Some n, None -> String.sub id.it 0 n $ id.at
  | Some n1, Some n2 -> String.sub id.it 0 (min n1 n2) $ id.at

let strip_var_sub id =
  let n = ref 0 in
  while !n < String.length id.it && id.it.[String.length id.it - !n - 1] = '_' do incr n done;
  String.sub id.it 0 (String.length id.it - !n) $ id.at


let arg_of_exp e =
  ref (ExpA e) $ e.at


let typ_of_varid id =
    (match id.it with
    | "bool" -> BoolT
    | "nat" -> NumT Num.NatT
    | "int" -> NumT Num.IntT
    | "rat" -> NumT Num.RatT
    | "real" -> NumT Num.RealT
    | "text" -> TextT
    | _ -> VarT (id, [])
    ) $ id.at

let rec varid_of_typ t =
  (match t.it with
  | VarT (id, _) -> id.it
  | BoolT -> "bool"
  | NumT Num.NatT -> "nat"
  | NumT Num.IntT -> "int"
  | NumT Num.RatT -> "rat"
  | NumT Num.RealT -> "real"
  | TextT -> "text"
  | ParenT t1 -> (varid_of_typ t1).it
  | _ -> "_"
  ) $ t.at


let rec typ_of_exp e =
  (match e.it with
  | VarE (id, []) -> (typ_of_varid id).it
  | VarE (id, args) -> VarT (id, args)
  | ParenE (e1, _) -> ParenT (typ_of_exp e1)
  | TupE es -> TupT (List.map typ_of_exp es)
  | IterE (e1, iter) -> IterT (typ_of_exp e1, iter)
  | StrE efs -> StrT (map_nl_list typfield_of_expfield efs)
  | AtomE atom -> AtomT atom
  | SeqE es -> SeqT (List.map typ_of_exp es)
  | InfixE (e1, atom, e2) -> InfixT (typ_of_exp e1, atom, typ_of_exp e2)
  | BrackE (l, e1, r) -> BrackT (l, typ_of_exp e1, r)
  | _ -> error e.at "malformed type"
  ) $ e.at

and typfield_of_expfield (atom, e) =
  (atom, (typ_of_exp e, []), [])


let rec exp_of_typ t =
  (match t.it with
  | VarT (id, args) -> VarE (id, args)
  | BoolT | NumT _ | TextT -> VarE (varid_of_typ t, [])
  | ParenT t1 -> ParenE (exp_of_typ t1, `Insig)
  | TupT ts -> TupE (List.map exp_of_typ ts)
  | IterT (t1, iter) -> IterE (exp_of_typ t1, iter)
  | StrT tfs -> StrE (map_nl_list expfield_of_typfield tfs)
  | AtomT atom -> AtomE atom
  | SeqT ts -> SeqE (List.map exp_of_typ ts)
  | InfixT (t1, atom, t2) -> InfixE (exp_of_typ t1, atom, exp_of_typ t2)
  | BrackT (l, t1, r) -> BrackE (l, exp_of_typ t1, r)
  | CaseT _ | ConT _ | RangeT _ -> error t.at "malformed expression"
  ) $ t.at

and expfield_of_typfield (atom, (t, _prems), _) =
  (atom, exp_of_typ t)


let expify t = function
  | Some e -> e
  | None -> VarE ("_" $ t.at, []) $ t.at

module Set = Set.Make(String)

let rec pat_of_typ' s t : exp option =
  let (let*) = Option.bind in
  match t.it with
  | VarT (id, _args) ->
    if Set.mem id.it !s then None else
    (
      (* Suppress duplicates. *)
      s := Set.add id.it !s;
      Some (VarE (id, []) $ t.at)
    )
  | BoolT | NumT _ | TextT ->
    let id = varid_of_typ t in
    if Set.mem id.it !s then None else
    (
      (* Suppress duplicates. *)
      s := Set.add id.it !s;
      Some (VarE (id, []) $ t.at)
    )
  | ParenT t1 ->
    let* e1 = pat_of_typ' s t1 in
    Some (ParenE (e1, `Insig) $ t.at)
  | TupT ts ->
    let* es = pats_of_typs' s ts in
    Some (TupE es $ t.at)
  | SeqT ts ->
    let* es = pats_of_typs' s ts in
    Some (SeqE es $ t.at)
  | IterT (t1, iter) ->
    let* e1 = pat_of_typ' s t1 in
    Some (IterE (e1, iter) $ t.at)
  | _ -> None

and pats_of_typs' s ts : exp list option =
  let eos = List.map (pat_of_typ' s) ts in
  if List.for_all ((=) None) eos then None else
  Some (List.map2 expify ts eos)

let pat_of_typ t = expify t (pat_of_typ' (ref Set.empty) t)
let pats_of_typs ts = List.map2 expify ts (List.map (pat_of_typ' (ref Set.empty)) ts)


let rec sym_of_exp e =
  (match e.it with
  | VarE (id, args) -> VarG (id, args)
  | AtomE {it = Atom id; _} -> VarG (id $ e.at, [])  (* for uppercase grammar ids in show hints *)
  | NumE (op, Num.Nat n) -> NumG (op, n)
  | TextE s -> TextG s
  | EpsE -> EpsG
  | SeqE es -> SeqG (List.map (fun e -> Elem (sym_of_exp e)) es)
  | ParenE (e1, _) -> ParenG (sym_of_exp e1)
  | TupE es -> TupG (List.map sym_of_exp es)
  | IterE (e1, iter) -> IterG (sym_of_exp e1, iter)
  | TypE (e1, t) -> AttrG (e1, sym_of_exp (exp_of_typ t))
  | FuseE (e1, e2) -> FuseG (sym_of_exp e1, sym_of_exp e2)
  | UnparenE e1 -> UnparenG (sym_of_exp e1)
  | ArithE e -> ArithG e
  | _ -> ArithG e
  ) $ e.at

let rec exp_of_sym g =
  (match g.it with
  | VarG (id, args) -> VarE (id, args)
  | NumG (op, n) -> NumE (op, Num.Nat n)
  | TextG t -> TextE t
  | EpsG -> EpsE
  | SeqG gs -> SeqE (map_filter_nl_list exp_of_sym gs)
  | ParenG g1 -> ParenE (exp_of_sym g1, `Insig)
  | TupG gs -> TupE (List.map exp_of_sym gs)
  | IterG (g1, iter) -> IterE (exp_of_sym g1, iter)
  | ArithG e -> ArithE e
  | AttrG (e, g2) -> TypE (e, typ_of_exp (exp_of_sym g2))
  | FuseG (g1, g2) -> FuseE (exp_of_sym g1, exp_of_sym g2)
  | UnparenG g1 -> UnparenE (exp_of_sym g1)
  | _ -> error g.at "malformed expression"
  ) $ g.at


let exp_of_arg a =
  match !(a.it) with
  | ExpA e -> e
  | _ -> error a.at "malformed expression"

let rec param_of_arg a =
  (match !(a.it) with
  | ExpA e ->
    (match e.it with
    | TypE ({it = VarE (id, []); _}, t) -> ExpP (id, t)
    | VarE (id, args) ->
      ExpP (id, typ_of_exp (VarE (strip_var_suffix id, args) $ e.at))
    | TypE ({it = CallE (id, as_); _}, t) ->
      DefP (id, List.map param_of_arg as_, t)
    | _ -> ExpP ("_" $ e.at, typ_of_exp e)
    )
  | TypA {it = VarT (id, []); _} ->
    if id.it <> (strip_var_suffix id).it then
      error id.at "invalid identifer suffix in binding position";
    TypP id
  | GramA {it = AttrG ({it = VarE (id, []); _}, g); _} ->
    GramP (id, typ_of_exp (exp_of_sym g))
  | _ -> error a.at "malformed parameter"
  ) $ a.at

let arg_of_param p =
  (match p.it with
  | ExpP (id, _t) -> ExpA ((*TypE ( *)VarE (id, []) $ id.at(*, t) $ p.at*))
  | TypP id -> TypA (VarT (id, []) $ id.at)
  | GramP (id, _t) -> GramA (VarG (id, []) $ id.at)
  | DefP (id, _params, _t) -> DefA id
  ) |> ref $ p.at
