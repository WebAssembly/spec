open Util
open Source
open El
open Ast
open Print

module Il = struct include Il include Ast end

module Set = Free.Set
module Map = Map.Make(String)

let filter_nl xs = List.filter_map (function Nl -> None | Elem x -> Some x) xs
let map_nl_list f xs = List.map f (filter_nl xs)


(* Errors *)

let error at msg = Source.error at "type" msg

let error_atom at atom msg =
  error at (msg ^ " `" ^ string_of_atom atom ^ "`")

let error_id id msg =
  error id.at (msg ^ " `" ^ id.it ^ "`")

let error_typ at phrase t =
  error at (phrase ^ " does not match expected type `" ^ string_of_typ t ^ "`")

let error_typ2 at phrase t1 t2 reason =
  error at (phrase ^ "'s type `" ^ string_of_typ t1 ^ "`" ^
    " does not match expected type `" ^ string_of_typ t2 ^ "`" ^ reason)

type direction = Infer | Check

let error_dir_typ at phrase dir t expected =
  match dir with
  | Check -> error_typ at phrase t
  | Infer ->
    error at (phrase ^ "'s type `" ^ string_of_typ t ^ "`" ^
      " does not match expected type " ^ expected)


(* Helpers *)

let unparen_exp e =
  match e.it with
  | ParenE (e1, _) -> e1
  | _ -> e

let unseq_exp e =
  match e.it with
  | EpsE -> []
  | SeqE es -> es
  | _ -> [e]

let tup_typ' ts' at =
  match ts' with
  | [t'] -> t'
  | _ -> Il.TupT ts' $ at

let tup_exp' es' at =
  match es' with
  | [e'] -> e'
  | _ -> Il.TupE es' $$ (at, Il.TupT (List.map note es') $ at)

let lift_exp' e' iter' =
  if iter' = Opt then
    Il.OptE (Some e')
  else
    Il.ListE [e']

let cat_exp' e1' e2' =
  match e1'.it, e2'.it with
  | _, Il.ListE [] -> e1'.it
  | Il.ListE [], _ -> e2'.it
  | Il.ListE es1, Il.ListE es2 -> Il.ListE (es1 @ es2)
  | _ -> Il.CatE (e1', e2')



(* Environment *)

type fwd_typ = Bad | Ok
type var_typ = typ
type syn_typ = (fwd_typ, typ * Il.deftyp) Either.t
type rel_typ = typ * Il.rule list
type def_typ = typ * typ * Il.clause list

type env =
  { mutable vars : var_typ Map.t;
    mutable typs : syn_typ Map.t;
    mutable rels : rel_typ Map.t;
    mutable defs : def_typ Map.t;
  }

let new_env () =
  { vars = Map.empty
      |> Map.add "bool" (BoolT $ no_region)
      |> Map.add "nat" (NatT $ no_region)
      |> Map.add "text" (TextT $ no_region);
    typs = Map.empty;
    rels = Map.empty;
    defs = Map.empty;
  }

let bound env' id = Map.mem id.it env'

let find space env' id =
  match Map.find_opt id.it env' with
  | None -> error_id id ("undeclared " ^ space)
  | Some t -> t

let bind space env' id t =
  if Map.mem id.it env' then
    error_id id ("duplicate declaration for " ^ space)
  else
    Map.add id.it t env'

let rebind _space env' id t =
  assert (Map.mem id.it env');
  Map.add id.it t env'

let find_field fs atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fs with
  | Some (_, x, _) -> x
  | None -> error_atom at atom "unbound field"

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error_atom at atom "unknown case"


let rec prefix_id id = prefix_id' id.it $ id.at
and prefix_id' id =
  match String.index_opt id '_', String.index_opt id '\'' with
  | None, None -> id
  | None, Some n | Some n, None -> String.sub id 0 n
  | Some n1, Some n2 -> String.sub id 0 (min n1 n2)


(* Type Accessors *)

let as_defined_typid' env id at : typ' * [`Alias | `NoAlias] =
  match find "syntax type" env.typs id with
  | Either.Right (t, {it = Il.AliasT _t'; _}) -> t.it, `Alias
  | Either.Right (t, _deftyp') -> t.it, `NoAlias
  | Either.Left _ ->
    error_id (id.it $ at) "invalid forward use of syntax type"

let rec expand' env = function
  | VarT id as t' ->
    (match as_defined_typid' env id id.at with
    | t1, `Alias -> expand' env t1
    | _ -> t'
    )
  | ParenT t -> expand' env t.it
  | t' -> t'

let expand env t = expand' env t.it

let expand_singular' env t' =
  match expand' env t' with
  | IterT (t1, (Opt | List | List1)) -> expand env t1
  | t' -> t'


let as_iter_typ phrase env dir t at : typ * iter =
  match expand' env t.it with
  | IterT (t1, iter) -> t1, iter
  | _ -> error_dir_typ at phrase dir t "(_)*"

let as_list_typ phrase env dir t at : typ =
  match expand' env t.it with
  | IterT (t1, (List | List1 | ListN _)) -> t1
  | _ -> error_dir_typ at phrase dir t "(_)*"

let as_tup_typ phrase env dir t at : typ list =
  match expand_singular' env t.it with
  | TupT ts -> ts
  | _ -> error_dir_typ at phrase dir t "(_,...,_)"


let as_notation_typid' phrase env id at : typ =
  match as_defined_typid' env id at with
  | (AtomT _ | SeqT _ | InfixT _ | BrackT _) as t, _ -> t $ at
  | _ -> error_dir_typ at phrase Infer (VarT id $ id.at) "_ ... _"

let as_notation_typ phrase env dir t at : typ =
  match expand_singular' env t.it with
  | VarT id -> as_notation_typid' phrase env id at
  | _ -> error_dir_typ at phrase dir t "_ ... _"

let as_struct_typid' phrase env id at : typfield list =
  match as_defined_typid' env id at with
  | StrT tfs, _ -> filter_nl tfs
  | _ -> error_dir_typ at phrase Infer (VarT id $ id.at) "| ..."

let as_struct_typ phrase env dir t at : typfield list =
  match expand_singular' env t.it with
  | VarT id -> as_struct_typid' phrase env id at
  | _ -> error_dir_typ at phrase dir t "{...}"

let rec as_variant_typid' phrase env id at : typcase list * dots =
  match as_defined_typid' env id at with
  | CaseT (_dots1, ids, cases, dots2), _ ->
    let casess = map_nl_list (as_variant_typid "" env) ids in
    List.concat (filter_nl cases :: List.map fst casess), dots2
  | _ -> error_dir_typ id.at phrase Infer (VarT id $ id.at) "| ..."

and as_variant_typid phrase env id : typcase list * dots =
  as_variant_typid' phrase env id id.at

let as_variant_typ phrase env dir t at : typcase list * dots =
  match expand_singular' env t.it with
  | VarT id -> as_variant_typid' phrase env id at
  | _ -> error_dir_typ at phrase dir t "| ..."

let case_has_args env t atom at : bool =
  let cases, _ = as_variant_typ "" env Check t at in
  find_case cases atom at <> []


let is_x_typ as_x_typ env t =
  try ignore (as_x_typ "" env Check t no_region); true
  with Error _ -> false

let is_iter_typ = is_x_typ as_iter_typ
let is_notation_typ = is_x_typ as_notation_typ
let is_variant_typ = is_x_typ as_variant_typ


(* Type Equivalence *)

let equiv_list equiv_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 equiv_x xs1 xs2

let rec equiv_typ env t1 t2 =
  (*
  Printf.printf "[equiv] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ t1) (Print.string_of_typ t2)
    (t1.it = t2.it);
  *)
  t1.it = t2.it ||
  match expand env t1, expand env t2 with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT ts1, TupT ts2 -> equiv_list (equiv_typ env) ts1 ts2
  | IterT (t11, iter1), IterT (t21, iter2) ->
    equiv_typ env t11 t21 && Eq.eq_iter iter1 iter2
  | t1', t2' -> Eq.eq_typ (t1' $ t1.at) (t2' $ t2.at)


(* Hints *)

let elab_hint {hintid; hintexp} : Il.hint =
  let ss =
    match hintexp.it with
    | SeqE es -> List.map Print.string_of_exp es
    | _ -> [Print.string_of_exp hintexp]
  in
  {Il.hintid; Il.hintexp = ss}

let elab_hints = List.map elab_hint


(* Atoms and Operators *)

let elab_atom = function
  | Atom s -> Il.Atom s
  | Bot -> Il.Bot
  | Dot -> Il.Dot
  | Dot2 -> Il.Dot2
  | Dot3 -> Il.Dot3
  | Semicolon -> Il.Semicolon
  | Arrow -> Il.Arrow
  | Colon -> Il.Colon
  | Sub -> Il.Sub
  | SqArrow -> Il.SqArrow
  | Turnstile -> Il.Turnstile
  | Tilesturn -> Il.Tilesturn

let elab_brack = function
  | Paren -> Il.LParen, Il.RParen
  | Brack -> Il.LBrack, Il.RBrack
  | Brace -> Il.LBrace, Il.RBrace

let elab_unop = function
  | NotOp -> Il.NotOp
  | PlusOp -> Il.PlusOp
  | MinusOp -> Il.MinusOp

let elab_binop = function
  | AndOp -> Il.AndOp
  | OrOp -> Il.OrOp
  | ImplOp -> Il.ImplOp
  | EquivOp -> Il.EquivOp
  | AddOp -> Il.AddOp
  | SubOp -> Il.SubOp
  | MulOp -> Il.MulOp
  | DivOp -> Il.DivOp
  | ExpOp -> Il.ExpOp

let elab_cmpop = function
  | EqOp -> Il.EqOp
  | NeOp -> Il.NeOp
  | LtOp -> Il.LtOp
  | GtOp -> Il.GtOp
  | LeOp -> Il.LeOp
  | GeOp -> Il.GeOp

let merge_mixop mixop1 mixop2 =
  match mixop1, mixop2 with
  | _, [] -> mixop1
  | [], _ -> mixop2
  | mixop1, atoms2::mixop2' ->
    let mixop1', atoms1 = Lib.List.split_last mixop1 in
    mixop1' @ [atoms1 @ atoms2] @ mixop2'


let check_atoms phrase item list at =
  let _, dups =
    List.fold_right (fun (atom, _, _) (set, dups) ->
      let s = Print.string_of_atom atom in
      if Set.mem s set then (set, s::dups) else (Set.add s set, dups)
    ) list (Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let rec elab_iter env iter : Il.iter =
  match iter with
  | Opt -> Il.Opt
  | List -> Il.List
  | List1 -> Il.List1
  | ListN e -> Il.ListN (elab_exp env e (NatT $ e.at))


(* Types *)

and elab_typ env t : Il.typ =
  match t.it with
  | VarT id ->
    (match find "syntax type" env.typs id with
    | Either.Left Bad -> error_id id "invalid forward reference to syntax type"
    | _ -> Il.VarT id $ t.at
    )
  | BoolT -> Il.BoolT $ t.at
  | NatT -> Il.NatT $ t.at
  | TextT -> Il.TextT $ t.at
  | ParenT t1 -> elab_typ env t1
  | TupT ts -> Il.TupT (List.map (elab_typ env) ts) $ t.at
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in syntax type"
    | _ -> Il.IterT (elab_typ env t1, elab_iter env iter) $ t.at
    )
  | StrT _ | CaseT _ | AtomT _ | SeqT _ | InfixT _ | BrackT _ ->
    failwith(*error t.at*) "this type is only allowed in type definitions"

and elab_typ_definition env id t : Il.deftyp =
  (match t.it with
  | StrT tfs ->
    let tfs' = filter_nl tfs in
    check_atoms "record" "field" tfs' t.at;
    Il.StructT (map_nl_list (elab_typfield env) tfs)
  | CaseT (dots1, ids, cases, _dots2) ->
    let cases0 =
      if dots1 = Dots then fst (as_variant_typid "own type" env id) else [] in
    let casess = map_nl_list (as_variant_typid "parent type" env) ids in
    let cases' =
      List.flatten (cases0 :: List.map fst casess @ [filter_nl cases]) in
    let tcs' = List.map (elab_typcase env t.at) cases' in
    check_atoms "variant" "case" cases' t.at;
    Il.VariantT tcs'
  | _ ->
    match elab_typ_notation env t with
    | false, _mixop, ts' -> Il.AliasT (tup_typ' ts' t.at)
    | true, mixop, ts' -> Il.NotationT (mixop, tup_typ' ts' t.at)
  ) $ t.at

and elab_typ_notation env t : bool * Il.mixop * Il.typ list =
  (*
  Printf.printf "[typ_not %s] %s\n%!"
    (string_of_region t.at) (string_of_typ t);
  *)
  match t.it with
  | AtomT atom ->
    true, [[elab_atom atom]], []
  | SeqT [] ->
    true, [[]], []
  | SeqT (t1::ts2) ->
    let _b1, mixop1, ts1' = elab_typ_notation env t1 in
    let _b2, mixop2, ts2' = elab_typ_notation env (SeqT ts2 $ t.at) in
    true, merge_mixop mixop1 mixop2, ts1' @ ts2'
  | InfixT (t1, atom, t2) ->
    let _b1, mixop1, ts1' = elab_typ_notation env t1 in
    let _b2, mixop2, ts2' = elab_typ_notation env t2 in
    true, merge_mixop (merge_mixop mixop1 [[elab_atom atom]]) mixop2, ts1' @ ts2'
  | BrackT (brack, t1) ->
    let l, r = elab_brack brack in
    let _b1, mixop1, ts' = elab_typ_notation env t1 in
    true, merge_mixop (merge_mixop [[l]] mixop1) [[r]], ts'
  | ParenT t1 ->
    let b1, mixop1, ts1' = elab_typ_notation env t1 in
    b1, merge_mixop (merge_mixop [[Il.LParen]] mixop1) [[Il.RParen]], ts1'
  | IterT (t1, iter) ->
    (match iter with
    | List1 | ListN _ -> error t.at "illegal iterator in notation type"
    | _ ->
      let b1, mixop1, ts' = elab_typ_notation env t1 in
      let iter' = elab_iter env iter in
      let t' = Il.IterT (tup_typ' ts' t1.at, iter') $ t.at in
      let op = match iter with Opt -> Il.Quest | _ -> Il.Star in
      b1, [List.flatten mixop1] @ [[op]], [t']
    )
  | _ ->
    false, [[]; []], [elab_typ env t]


and elab_typfield env (atom, t, hints) : Il.typfield =
  let _, _, ts' = elab_typ_notation env t in
  (elab_atom atom, tup_typ' ts' t.at, elab_hints hints)

and elab_typcase env at (atom, ts, hints) : Il.typcase =
  let tss' =
    List.map (fun (_, _, ts) -> ts) (List.map (elab_typ_notation env) ts) in
  (elab_atom atom, tup_typ' (List.concat tss') at, elab_hints hints)


and (!!) env t = elab_typ env t
and (!!!) env t = let _, _, ts' = elab_typ_notation env t in tup_typ' ts' t.at


(* Expressions *)

and infer_unop = function
  | NotOp -> BoolT
  | PlusOp | MinusOp -> NatT

and infer_binop = function
  | AndOp | OrOp | ImplOp | EquivOp -> BoolT
  | AddOp | SubOp | MulOp | DivOp | ExpOp -> NatT

and infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp | GtOp | LeOp | GeOp -> Some NatT

(* TODO: turn this into a properly bidirectional formulation *)
and infer_exp env e : typ =
  match e.it with
  | VarE id -> find "variable" env.vars (prefix_id id)
  | AtomE _ -> error e.at "cannot infer type of atom"
  | BoolE _ -> BoolT $ e.at
  | NatE _ | LenE _ -> NatT $ e.at
  | TextE _ -> TextT $ e.at
  | UnE (op, _) -> infer_unop op $ e.at
  | BinE (_, op, _) -> infer_binop op $ e.at
  | CmpE _ -> BoolT $ e.at
  | IdxE (e1, _) -> as_list_typ "expression" env Infer (infer_exp env e1) e1.at
  | SliceE (e1, _, _)
  | UpdE (e1, _, _)
  | ExtE (e1, _, _)
  | CommaE (e1, _)
  | CompE (e1, _) -> infer_exp env e1
  | StrE _ -> error e.at "cannot infer type of record"
  | DotE (e1, atom) ->
    let t1 = infer_exp env e1 in
    let tfs = as_struct_typ "expression" env Infer t1 e1.at in
    find_field tfs atom e1.at
  | EpsE -> error e.at "cannot infer type of empty sequence"
  | SeqE _ -> error e.at "cannot infer type of expression sequence"
  | TupE es -> TupT (List.map (infer_exp env) es) $ e.at
  | ParenE (e1, _) -> ParenT (infer_exp env e1) $ e.at
  | CallE (id, _) -> let _, t2, _ = find "function" env.defs id in t2
  | InfixE _ -> error e.at "cannot infer type of infix expression"
  | BrackE _ -> error e.at "cannot infer type of bracket expression"
  | IterE (e1, iter) ->
    let iter' = match iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env e1, iter') $ e.at
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token concatenation"
  | ElementsOfE _ -> BoolT $ e.at


and elab_exp env e t : Il.exp =
  (*
  Printf.printf "[elab %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  match e.it with
  | VarE id ->
    let t' = infer_exp env e in
    cast_exp "variable" env (Il.VarE id $$ e.at % !!env t') t' t
  | BoolE b ->
    let t' = infer_exp env e in
    cast_exp "boolean" env (Il.BoolE b $$ e.at % !!env t') t' t
  | NatE n ->
    let t' = infer_exp env e in
    cast_exp "number" env (Il.NatE n $$ e.at % !!env t') t' t
  | TextE s ->
    let t' = infer_exp env e in
    cast_exp "text" env (Il.TextE s $$ e.at % !!env t') t' t
  | UnE (op, e1) ->
    let t' = infer_unop op $ e.at in
    let e1' = elab_exp env e1 t' in
    let e' = Il.UnE (elab_unop op, e1') $$ e.at % !!env t' in
    cast_exp "unary operator" env e' t' t
  | BinE (e1, op, e2) ->
    let t' = infer_binop op $ e.at in
    let e1' = elab_exp env e1 t' in
    let e2' = elab_exp env e2 t' in
    let e' = Il.BinE (elab_binop op, e1', e2') $$ e.at % !!env t' in
    cast_exp "binary operator" env e' t' t
  | CmpE (e1, op, e2) ->
    let t1' =
      match infer_cmpop op with
      | Some t1' -> t1' $ e.at
      | None -> infer_exp env e1
    in
    let e1' = elab_exp env e1 t1' in
    let t' = BoolT $ e.at in
    let e' =
      match e2.it with
      | CmpE (e21, _, _) ->
        let e21' = elab_exp env e21 t1' in
        let e2' = elab_exp env e2 (BoolT $ e2.at) in
        Il.BinE (Il.AndOp,
          Il.CmpE (elab_cmpop op, e1', e21') $$ e1.at % !!env t' , e2') $$ e.at % !!env t'
      | _ ->
        let e2' = elab_exp env e2 t1' in
        Il.CmpE (elab_cmpop op, e1', e2') $$ e.at % !!env t'
    in
    cast_exp "comparison operator" env e' t' t
  | IdxE (e1, e2) ->
    let t1 = infer_exp env e1 in
    let t' = as_list_typ "expression" env Infer t1 e1.at in
    let e1' = elab_exp env e1 t1 in
    let e2' = elab_exp env e2 (NatT $ e2.at) in
    let e' = Il.IdxE (e1', e2') $$ e.at % !!env t' in
    cast_exp "list element" env e' t' t
  | SliceE (e1, e2, e3) ->
    let _t' = as_list_typ "expression" env Check t e1.at in
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp env e2 (NatT $ e2.at) in
    let e3' = elab_exp env e3 (NatT $ e3.at) in
    Il.SliceE (e1', e2', e3') $$ e.at % !!env t
  | UpdE (e1, p, e2) ->
    let e1' = elab_exp env e1 t in
    let p', t2 = elab_path env p t in
    let e2' = elab_exp env e2 t2 in
    Il.UpdE (e1', p', e2') $$ e.at % !!env t
  | ExtE (e1, p, e2) ->
    let e1' = elab_exp env e1 t in
    let p', t2 = elab_path env p t in
    let _t21 = as_list_typ "path" env Check t2 p.at in
    let e2' = elab_exp env e2 t2 in
    Il.ExtE (e1', p', e2') $$ e.at % !!env t
  | StrE efs ->
    let tfs = as_struct_typ "record" env Check t e.at in
    let efs' = elab_expfields env (filter_nl efs) tfs e.at in
    Il.StrE efs' $$ e.at % !!env t
  | DotE (e1, atom) ->
    let t1 = infer_exp env e1 in
    let e1' = elab_exp env e1 t1 in
    let tfs = as_struct_typ "expression" env Infer t1 e1.at in
    let t' = find_field tfs atom e1.at in
    let e' = Il.DotE (e1', elab_atom atom) $$ e.at % !!env t' in
    cast_exp "field" env e' t' t
  | CommaE (e1, e2) ->
    let e1' = elab_exp env e1 t in
    let tfs = as_struct_typ "expression" env Check t e1.at in
    (* TODO: this is a bit of a hack *)
    (match e2.it with
    | SeqE ({it = AtomE atom; at; _} :: es2) ->
      let _t2 = find_field tfs atom at in
      let e2 = match es2 with [e2] -> e2 | _ -> SeqE es2 $ e2.at in
      let e2' = elab_exp env (StrE [Elem (atom, e2)] $ e2.at) t in
      Il.CompE (e1', e2') $$ e.at % !!env t
    | _ -> failwith "unimplemented check CommaE"
    )
  | CompE (e1, e2) ->
    let _ = as_struct_typ "record" env Check t e.at in
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp env e2 t in
    Il.CompE (e1', e2') $$ e.at % !!env t
  | LenE e1 ->
    let t1 = infer_exp env e1 in
    let _t11 = as_list_typ "expression" env Infer t1 e1.at in
    let e1' = elab_exp env e1 t1 in
    let e' = Il.LenE e1' $$ e.at % !!env (NatT $ e.at) in
    cast_exp "list length" env e' (NatT $ e.at) t
  | ParenE (e1, true) when is_iter_typ env t ->
    (* Significant parentheses indicate a singleton *)
    let t1, _iter = as_iter_typ "expression" env Check t e.at in
    let e1' = elab_exp env e1 t1 in
    cast_exp "expression" env e1' t1 t
  | ParenE (e1, _) ->
    elab_exp env e1 t
  | TupE es ->
    let ts = as_tup_typ "tuple" env Check t e.at in
    let es' = elab_exps env es ts e.at in
    Il.TupE es' $$ e.at % !!env t
  | CallE (id, e2) ->
    let t2, t', _ = find "function" env.defs id in
    let e2' = elab_exp env e2 t2 in
    let e' = Il.CallE (id, e2') $$ e.at % !!env t' in
    cast_exp "expression" env e' t' t
  | SeqE [_] -> assert false  (* sequences cannot be singleton *)
  | EpsE | SeqE _ when is_iter_typ env t ->
    let e1 = unseq_exp e in
    elab_exp_iter env e1 (as_iter_typ "" env Check t e.at) t e.at
  | EpsE ->
    error_typ e.at "empty expression" t
  | AtomE _
  | InfixE _
  | BrackE _
  | SeqE _ ->
    (* All these expression forms can only be used when checking against
     * either a defined notation/variant type or (for SeqE) an iteration type;
     * the latter case is already captured above *)
    if is_notation_typ env t then
      elab_exp_notation env e (as_notation_typ "" env Check t e.at) t
    else if is_variant_typ env t then
      elab_exp_variant env (unseq_exp e)
        (fst (as_variant_typ "" env Check t e.at)) t e.at
    else
      error_typ e.at "expression" t
  | IterE (e1, iter2) ->
    (* An iteration expression must match the expected type directly,
     * significant parentheses have to be used otherwise *)
    let t1, iter = as_iter_typ "iteration" env Check t e.at in
    if (iter = Opt) <> (iter2 = Opt) then
      error_typ e.at "iteration expression" t;
    let e1' = elab_exp env e1 t1 in
    let iter2' = elab_iterexp env iter2 in
    Il.IterE (e1', iter2') $$ e.at % !!env t
  | HoleE _ -> error e.at "misplaced hole"
  | FuseE _ -> error e.at "misplaced token fuse"
  | ElementsOfE _ ->
      failwith "TODO: elab_exp ElementsOfE"

and elab_exps env es ts at : Il.exp list =
  if List.length es <> List.length ts then
    error at "arity mismatch for expression list";
  List.map2 (elab_exp env) es ts

and elab_expfields env efs tfs at : Il.expfield list =
  match efs, tfs with
  | [], [] -> []
  | (atom1, e)::efs2, (atom2, t, _)::tfs2 when atom1 = atom2 ->
    let es' = elab_exp_notation' env e t in
    let efs2' = elab_expfields env efs2 tfs2 at in
    (elab_atom atom1, tup_exp' es' e.at) :: efs2'
  | _, (atom, t, _)::tfs2 ->
    let atom' = string_of_atom atom in
    let e' =
      cast_empty ("omitted record field `" ^ atom' ^ "`") env t at (!!env t) in
    let efs2' = elab_expfields env efs tfs2 at in
    (elab_atom atom, e') :: efs2'
  | (atom, e)::_, [] ->
    error_atom e.at atom "unexpected record field"

and elab_exp_iter env es (t1, iter) t at : Il.exp =
  (*
  Printf.printf "[iteration %s] %s  :  %s = (%s)%s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp es))
    (string_of_typ t) (string_of_typ t1) (string_of_iter iter);
  *)
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, _ when is_variant_typ env t1 &&
      case_has_args env t1 atom at1 ->
    let cases, _dots = as_variant_typ "" env Check t1 at in
    lift_exp' (elab_exp_variant env es cases t1 at) iter $$ at % !!env t

  (* An empty sequence represents the None case for options *)
  | [], Opt ->
    Il.OptE None $$ at % !!env t
  (* An empty sequence represents the Nil case for lists *)
  | [], List ->
    Il.ListE [] $$ at % !!env t
  (* All other elements are either splices or (by cast injection) elements *)
  | e1::es2, List ->
    let e1' = elab_exp env e1 t in
    let e2' = elab_exp_iter env es2 (t1, iter) t at in
    cat_exp' e1' e2' $$ at % !!env t

  | _, _ ->
    error_typ at "expression" t

and elab_exp_notation env e nt t : Il.exp =
  (*
  Printf.printf "[notation %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  (* Convert notation into applications of mixin operators *)
  let e' = tup_exp' (elab_exp_notation' env e nt) e.at in
  match elab_typ_notation env nt with
  | false, _, _ -> e'
  | true, mixop, _ -> Il.MixE (mixop, e') $$ e.at % !!env t

and elab_exp_notation' env e t : Il.exp list =
  (*
  Printf.printf "[notation %s] %s  :  %s\n%!"
    (string_of_region e.at) (string_of_exp e) (string_of_typ t);
  *)
  match e.it, t.it with
  | AtomE atom, AtomT atom' ->
    if atom <> atom' then error_typ e.at "atom" t;
    []
  | InfixE (e1, atom, e2), InfixT (t1, atom', t2) ->
    if atom <> atom' then error_typ e.at "infix expression" t;
    let es1' = elab_exp_notation' env e1 t1 in
    let es2' = elab_exp_notation' env e2 t2 in
    es1' @ es2'
  | BrackE (brack, e1), BrackT (brack', t1) ->
    if brack <> brack' then error_typ e.at "bracket expression" t;
    elab_exp_notation' env e1 t1

  | SeqE [], SeqT [] ->
    []
  (* Iterations at the end of a sequence may be inlined *)
  | _, SeqT [{it = IterT _; _} as t1] ->
    elab_exp_notation' env e t1
  (* Optional iterations may always be inlined, use backtracking *)
  | SeqE (e1::es2), SeqT (({it = IterT (_, Opt); _} as t1)::ts2) ->
    (try
      let es1' = [cast_empty "omitted sequence tail" env t1 e.at (!!!env t1)] in
      let es2' = elab_exp_notation' env e (SeqT ts2 $ t.at) in
      es1' @ es2'
    with Source.Error _ ->
      (*
      Printf.printf "[backtrack %s] %s  :  %s\n%!"
        (string_of_region e.at) (string_of_exp e) (string_of_typ t);
      *)
      let es1' = elab_exp_notation' env e1 t1 in
      let es2' = elab_exp_notation' env (SeqE es2 $ e.at) (SeqT ts2 $ t.at) in
      es1' @ es2'
    )
  | SeqE (e1::es2), SeqT (t1::ts2) ->
    let es1' = elab_exp_notation' env (unparen_exp e1) t1 in
    let es2' = elab_exp_notation' env (SeqE es2 $ e.at) (SeqT ts2 $ t.at) in
    es1' @ es2'
  (* Trailing elements can be omitted if they can be epsilon *)
  | SeqE [], SeqT (t1::ts2) ->
    let e1' = cast_empty "omitted sequence tail" env t1 e.at (!!!env t1) in
    let es2' =
      elab_exp_notation' env (SeqE [] $ e.at) (SeqT ts2 $ t.at) in
    [e1'] @ es2'
  | SeqE (e1::_), SeqT [] ->
    error e1.at
      "superfluous expression does not match expected empty notation type"
  (* Since trailing elements can be omitted, a singleton may match a sequence *)
  | _, SeqT _ ->
    elab_exp_notation' env (SeqE [e] $ e.at) t

  | SeqE [e1], IterT _ ->
    [elab_exp env e1 t]
  | (EpsE | SeqE _), IterT (t1, iter) ->
    [elab_exp_notation_iter env (unseq_exp e) (t1, iter) t e.at]
  | IterE (e1, iter1), IterT (t1, iter) ->
    if (iter = Opt) <> (iter1 = Opt) then
      error_typ e.at "iteration expression" t;
    let es1' = elab_exp_notation' env e1 t1 in
    let iter1' = elab_iter env iter1 in
    [Il.IterE (tup_exp' es1' e1.at, (iter1', [])) $$ e.at % !!!env t]
  (* Significant parentheses indicate a singleton *)
  | ParenE (e1, true), IterT (t1, iter) ->
    let es' = elab_exp_notation' env e1 t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % !!env t]
  (* Elimination forms are considered splices *)
  | (IdxE _ | SliceE _ | UpdE _ | ExtE _ | DotE _ | CallE _), IterT _ ->
    [elab_exp env e t]
  (* All other expressions are considered splices *)
  (* TODO: can't they be splices, too? *)
  | _, IterT (t1, iter) ->
    let es' = elab_exp_notation' env e t1 in
    [lift_exp' (tup_exp' es' e.at) iter $$ e.at % !!!env t]

  | ParenE (e1, _), _ ->
    elab_exp_notation' env e1 t
  | _, ParenT t1 ->
    elab_exp_notation' env e t1

  | _, _ ->
    [elab_exp env e t]

and elab_exp_notation_iter env es (t1, iter) t at : Il.exp =
  (*
  Printf.printf "[niteration %s] %s  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp es))
    (string_of_typ t);
  *)
  match es, iter with
  (* If the sequence actually starts with a non-nullary constructor,
   * then assume this is a singleton iteration and fallback to variant *)
  | {it = AtomE atom; at = at1; _}::_, iter when is_variant_typ env t1 &&
      case_has_args env t1 atom at1 ->
    let cases, _ = as_variant_typ "expression" env Check t1 at in
    lift_exp' (elab_exp_variant env es cases t1 at) iter $$ at % !!!env t

  (* An empty sequence represents the None case for options *)
  | [], Opt ->
    Il.OptE None $$ at % !!!env t
  (* An empty sequence represents the Nil case for lists *)
  | [], List ->
    Il.ListE [] $$ at % !!!env t
  (* All other elements are either splices or (by cast injection) elements;
   * nested expressions must be lifted into a tuple *)
  | e1::es2, List ->
    let es1' = elab_exp_notation' env e1 t in
    let e2' = elab_exp_notation_iter env es2 (t1, iter) t at in
    cat_exp' (tup_exp' es1' e1.at) e2' $$ at % !!!env t

  | _, _ ->
    error_typ at "expression" t

and elab_exp_variant env es cases t at : Il.exp =
  (*
  Printf.printf "[variant %s] {%s}  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp es))
    (string_of_typ t);
  (*
    (String.concat " | "
      (List.map (fun (atom, ts, _) ->
          string_of_typ (SeqT ((AtomT atom $ at) :: ts) $ at)
        ) cases
      )
    );
  *)
  *)
  match es with
  | {it = AtomE atom; _}::es ->
    let ts = find_case cases atom at in
    (* TODO: this is a bit hacky *)
    let e2 = SeqE es $ at in
    let es' = elab_exp_notation' env e2 (SeqT ts $ t.at) in
    let t2 = expand_singular' env t.it $ at in
    cast_exp "variant case" env
      (Il.CaseE (elab_atom atom, tup_exp' es' at) $$ at % !!env t2) t2 t
  | _ ->
    error_typ at "expression" t


and elab_path env p t : Il.path * typ =
  match p.it with
  | RootP ->
    Il.RootP $$ p.at % !!env t, t
  | IdxP (p1, e1) ->
    let p1', t1 = elab_path env p1 t in
    let e1' = elab_exp env e1 (NatT $ e1.at) in
    let t' = as_list_typ "path" env Check t1 p1.at in
    Il.IdxP (p1', e1') $$ p.at % !!env t', t'
  | SliceP (p1, e1, e2) ->
    let p1', t1 = elab_path env p1 t in
    let e1' = elab_exp env e1 (NatT $ e1.at) in
    let e2' = elab_exp env e2 (NatT $ e2.at) in
    let _ = as_list_typ "path" env Check t1 p1.at in
    Il.SliceP (p1', e1', e2') $$ p.at % !!env t1, t1
  | DotP (p1, atom) ->
    let p1', t1 = elab_path env p1 t in
    let tfs = as_struct_typ "path" env Check t1 p1.at in
    let t' = find_field tfs atom p1.at in
    Il.DotP (p1', elab_atom atom) $$ p.at % !!env t', t'


and cast_empty phrase env t at t' : Il.exp =
  match expand env t with
  | IterT (_, Opt) -> Il.OptE None $$ at % t'
  | IterT (_, List) -> Il.ListE [] $$ at % t'
  | _ -> error_typ at phrase t

and cast_exp phrase env e' t1 t2 : Il.exp =
  (*
  Printf.printf "[cast %s] (%s) <: (%s)  >>  (%s) <: (%s)  eq=%b\n%!"
    (string_of_region e'.at)
    (string_of_typ t1) (string_of_typ t2)
    (string_of_typ (expand env t1 $ t1.at))
    (string_of_typ (expand env t2 $ t2.at))
    (equiv_typ env t1 t2);
  *)
  if equiv_typ env t1 t2 then e' else
  match expand env t2 with
  | IterT (t21, Opt) ->
    Il.OptE (Some (cast_exp_variant phrase env e' t1 t21)) $$ e'.at % !!env t2
  | IterT (t21, (List | List1)) ->
    Il.ListE [cast_exp_variant phrase env e' t1 t21] $$ e'.at % !!env t2
  | _ ->
    cast_exp_variant phrase env e' t1 t2

and cast_exp_variant phrase env e' t1 t2 : Il.exp =
  if equiv_typ env t1 t2 then e' else
  if is_variant_typ env t1 && is_variant_typ env t2 then
    let cases1, dots1 = as_variant_typ "" env Check t1 e'.at in
    let cases2, _dots2 = as_variant_typ "" env Check t2 e'.at in
    if dots1 = Dots then
      error e'.at "used variant type is only partially defined at this point";
    (try
      List.iter (fun (atom, ts1, _) ->
        let ts2 = find_case cases2 atom t1.at in
        (* Shallow subtyping on variants *)
        if List.length ts1 <> List.length ts2
        || not (List.for_all2 Eq.eq_typ ts1 ts2) then
          error_atom e'.at atom "type mismatch for case"
      ) cases1
    with Error (_, msg) -> error_typ2 e'.at phrase t1 t2 (", " ^ msg)
    );
    Il.SubE (e', elab_typ env t1, elab_typ env t2) $$ e'.at % !!env t2
  else
    error_typ2 e'.at phrase t1 t2 ""


and elab_iterexp env iter =
  (elab_iter env iter, [])


(* Definitions *)

let make_binds env free dims at : Il.binds =
  List.map (fun id' ->
    let id = id' $ at in
    let t = elab_typ env (find "variable" env.vars (prefix_id id)) in
    let ctx = List.map (elab_iter env) (Multiplicity.Env.find id.it dims) in
    (id, t, ctx)
  ) (Set.elements free)


let rec elab_prem env prem : Il.premise =
  match prem.it with
  | RulePr (id, e) ->
    let t, _ = find "relation" env.rels id in
    let _, mixop, _ = elab_typ_notation env t in
    let es' = elab_exp_notation' env e t in
    Il.RulePr (id, mixop, tup_exp' es' e.at) $ prem.at
  | IfPr e ->
    let e' = elab_exp env e (BoolT $ e.at) in
    Il.IfPr e' $ prem.at
  | ElsePr ->
    Il.ElsePr $ prem.at
  | IterPr (prem1, iter) ->
    let prem1' = elab_prem env prem1 in
    let iter' = elab_iterexp env iter in
    Il.IterPr (prem1', iter') $ prem.at


let infer_typ_definition _env t : syn_typ =
  match t.it with
  | StrT _ | CaseT _ -> Either.Left Ok
  | _ -> Either.Left Bad

let infer_def env d =
  match d.it with
  | SynD (id1, _id2, t, _hints) ->
    if not (bound env.typs id1) then (
      env.typs <- bind "syntax type" env.typs id1 (infer_typ_definition env t);
      env.vars <- bind "variable" env.vars id1 (VarT id1 $ id1.at);
    )
  | _ -> ()

let elab_hintdef _env hd : Il.def list =
  match hd.it with
  | SynH (id1, _id2, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.SynH (id1, elab_hints hints) $ hd.at) $ hd.at]
  | RelH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.RelH (id, elab_hints hints) $ hd.at) $ hd.at]
  | DecH (id, hints) ->
    if hints = [] then [] else
    [Il.HintD (Il.DecH (id, elab_hints hints) $ hd.at) $ hd.at]
  | AtomH _ | VarH _ ->
    []

let elab_def env d : Il.def list =
  match d.it with
  | SynD (id1, id2, t, hints) ->
    let dt' = elab_typ_definition env id1 t in
    let t1, closed =
      match find "syntax type" env.typs id1, t.it with
      | Either.Left _, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of not yet defined syntax type"
      | Either.Left _, CaseT (NoDots, _, _, dots2) ->
        t, dots2 = NoDots
      | Either.Left _, _ ->
        t, true
      | Either.Right ({it = CaseT (dots1, ids1, tcs1, Dots); at; _}, _),
          CaseT (Dots, ids2, tcs2, dots2) ->
        CaseT (dots1, ids1 @ ids2, tcs1 @ tcs2, dots2) $ over_region [at; t.at],
          dots2 = NoDots
      | Either.Right _, CaseT (Dots, _, _, _) ->
        error_id id1 "extension of non-extensible syntax type"
      | Either.Right _, _ ->
        error_id id1 "duplicate declaration for syntax type";
    in
    (*
    Printf.printf "[def %s] %s ~> %s\n%!" id1.it
      (string_of_typ t) (Il.Print.string_of_deftyp dt');
    *)
    env.typs <- rebind "syntax type" env.typs id1 (Either.Right (t1, dt'));
    (if not closed then [] else [Il.SynD (id1, dt') $ d.at])
      @ elab_hintdef env (SynH (id1, id2, hints) $ d.at)
  | RelD (id, t, hints) ->
    let _, mixop, ts' = elab_typ_notation env t in
    env.rels <- bind "relation" env.rels id (t, []);
    [Il.RelD (id, mixop, tup_typ' ts' t.at, []) $ d.at]
      @ elab_hintdef env (RelH (id, hints) $ d.at)
  | RuleD (id1, id2, e, prems) ->
    let dims = Multiplicity.check_def d in
    let dims' = Multiplicity.Env.map (List.map (elab_iter env)) dims in
    let t, rules' = find "relation" env.rels id1 in
    let _, mixop, _ = elab_typ_notation env t in
    let es' = List.map (Multiplicity.annot_exp dims') (elab_exp_notation' env e t) in
    let prems' = List.map (Multiplicity.annot_prem dims')
      (map_nl_list (elab_prem env) prems) in
    let free = (Free.free_def d).Free.varid in
    let binds' = make_binds env free dims d.at in
    let rule' = Il.RuleD (id2, binds', mixop, tup_exp' es' e.at, prems') $ d.at in
    env.rels <- rebind "relation" env.rels id1 (t, rule'::rules');
    []
  | VarD (id, t, _hints) ->
    let _t' = elab_typ env t in
    env.vars <- bind "variable" env.vars id t;
    []
  | DecD (id, e1, t2, hints) ->
    let t1 = infer_exp env e1 in
    let _exp1' = elab_exp env e1 t1 in
    let t1' = elab_typ env t1 in
    let t2' = elab_typ env t2 in
    env.defs <- bind "function" env.defs id (t1, t2, []);
    [Il.DecD (id, t1', t2', []) $ d.at]
      @ elab_hintdef env (DecH (id, hints) $ d.at)
  | DefD (id, e1, e2, prems) ->
    let dims = Multiplicity.check_def d in
    let dims' = Multiplicity.Env.map (List.map (elab_iter env)) dims in
    let t1, t2, clauses' = find "function" env.defs id in
    let e1' = Multiplicity.annot_exp dims' (elab_exp env e1 t1) in
    let e2' = Multiplicity.annot_exp dims' (elab_exp env e2 t2) in
    let prems' = List.map (Multiplicity.annot_prem dims')
      (map_nl_list (elab_prem env) prems) in
    let free_rh =
      Free.(Set.diff (Set.diff (free_exp e2).varid
        (free_exp e1).varid) (free_list free_prem (filter_nl prems)).varid)
    in
    if free_rh <> Free.Set.empty then
      error d.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" (Free.Set.elements free_rh) ^ "`");
    let free = Free.(Set.union
      (free_exp e1).varid (free_nl_list free_prem prems).varid) in
    let binds' = make_binds env free dims d.at in
    let clause' = Il.DefD (binds', e1', e2', prems') $ d.at in
    env.defs <- rebind "definition" env.defs id (t1, t2, clause'::clauses');
    []
  | SepD ->
    []
  | HintD hd ->
    elab_hintdef env hd


let populate_def env d' : Il.def =
  match d'.it with
  | Il.SynD _ | Il.HintD _ -> d'
  | Il.RelD (id, mixop, t', []) ->
    let _, rules' = find "relation" env.rels id in
    Il.RelD (id, mixop, t', List.rev rules') $ d'.at
  | Il.DecD (id, t1', t2', []) ->
    let _, _, clauses' = find "function" env.defs id in
    Il.DecD (id, t1', t2', List.rev clauses') $ d'.at
  | _ ->
    assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id ->
try
   Map.find id map
with Not_found as e -> Printf.printf "[%s]\n%!" id; raise e
 ) (Array.of_seq (Il.Free.Set.to_seq set))


let check_recursion ds' =
  List.iter (fun d' ->
    match d'.it, (List.hd ds').it with
    | Il.HintD _, _ | _, Il.HintD _
    | Il.SynD _, Il.SynD _
    | Il.RelD _, Il.RelD _
    | Il.DecD _, Il.DecD _ -> ()
    | _, _ ->
      error (List.hd ds').at (" " ^ string_of_region d'.at ^
        ": invalid recursion between definitions of different sort")
  ) ds'
  (* TODO: check that notations are non-recursive and defs are inductive? *)

let recursify_defs ds' : Il.def list =
  let open Il.Free in
  let da = Array.of_list ds' in
  let map_synid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let frees = Array.map Il.Free.free_def da in
  let bounds = Array.map Il.Free.bound_def da in
  Array.iteri (fun i bound ->
    origins i map_synid bound.synid;
    origins i map_relid bound.relid;
    origins i map_defid bound.defid;
  ) bounds;
  let graph =
    Array.map (fun free ->
      Array.concat
        [ deps !map_synid free.synid;
          deps !map_relid free.relid;
          deps !map_defid free.defid;
        ];
    ) frees
  in
  let sccs = Scc.sccs graph in
  List.map (fun set ->
    let ds'' = List.map (fun i -> da.(i)) (Scc.Set.elements set) in
    check_recursion ds'';
    let i = Scc.Set.choose set in
    match ds'' with
    | [d'] when Il.Free.disjoint bounds.(i) frees.(i) -> d'
    | ds'' -> Il.RecD ds'' $ Source.over_region (List.map at ds'')
  ) sccs

let elab ds : Il.script =
  let env = new_env () in
  List.iter (infer_def env) ds;
  let ds' = List.concat_map (elab_def env) ds in
  let ds' = List.map (populate_def env) ds' in
  recursify_defs ds'
