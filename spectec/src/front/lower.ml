open Util
open Source
open El
open Ast
open Print

module Il = struct include Il include Ast end

module Set = Free.Set
module Map = Map.Make(String)


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

type var_typ = typ
type syn_typ = deftyp
type rel_typ = nottyp * Il.rule list
type def_typ = typ * typ * Il.clause list

type env =
  { mutable vars : var_typ Map.t;
    mutable typs : syn_typ Map.t;
    mutable rels : rel_typ Map.t;
    mutable defs : def_typ Map.t;
  }

let fwd_deftyp id =
  NotationT (TypT (VarT (id $ no_region) $ no_region) $ no_region) $ no_region
let fwd_deftyp_bad = fwd_deftyp "(undefined)"
let fwd_deftyp_ok = fwd_deftyp "(forward)"

let new_env () =
  { vars = Map.empty;
    typs = Map.empty;
    rels = Map.empty;
    defs = Map.empty;
  }

let find space env' id =
  match Map.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind space env' id typ =
  if Map.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
    Map.add id.it typ env'

let rebind _space env' id typ =
  assert (Map.mem id.it env');
  Map.add id.it typ env'

let find_field fields atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fields with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_atom atom ^ "`")


let rec prefix_id id = prefix_id' id.it $ id.at
and prefix_id' id =
  match String.index_opt id '_', String.index_opt id '\'' with
  | None, None -> id
  | None, Some n | Some n, None -> String.sub id 0 n
  | Some n1, Some n2 -> String.sub id 0 (min n1 n2)


(* Type Accessors *)

let rec expand' env = function
  | VarT id as typ' ->
    (match (find "syntax type" env.typs id).it with
    | NotationT {it = TypT typ1; _} -> expand' env typ1.it
    | _ -> typ'
    )
  | ParenT typ -> expand' env typ.it
  | typ' -> typ'

let expand env typ = expand' env typ.it

let expand_singular' env typ' =
  match expand' env typ' with
  | IterT (typ1, (Opt | List | List1)) -> expand env typ1
  | typ' -> typ'


type direction = Infer | Check

let as_error at phrase dir typ expected =
  match dir with
  | Infer ->
    error at (
      phrase ^ "'s type `" ^ string_of_typ typ ^
      "` does not match expected type `" ^ expected ^ "`"
    )
  | Check ->
    error at (
      phrase ^ "'s type does not match expected type `" ^
      string_of_typ typ ^ "`"
    )

let as_iter_typ phrase env dir typ at : typ * iter =
  match expand' env typ.it with
  | IterT (typ1, iter) -> typ1, iter
  | _ -> as_error at phrase dir typ "(_)*"

let as_list_typ phrase env dir typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, (List | List1 | ListN _)) -> typ1
  | _ -> as_error at phrase dir typ "(_)*"

let as_tup_typ phrase env dir typ at : typ list =
  match expand_singular' env typ.it with
  | TupT typs -> typs
  | _ -> as_error at phrase dir typ "(_,...,_)"


let as_notation_typid' phrase env id at : nottyp =
  match (find "syntax type" env.typs id).it with
  | NotationT nottyp -> nottyp
  | _ -> as_error at phrase Infer (VarT id $ id.at) "_ ... _"

let as_notation_typ phrase env dir typ at : nottyp =
  match expand_singular' env typ.it with
  | VarT id -> as_notation_typid' phrase env id at
  | _ -> as_error at phrase dir typ "_ ... _"

let as_struct_typid' phrase env id at : typfield list =
  match (find "syntax type" env.typs id).it with
  | StructT fields -> fields
  | _ -> as_error at phrase Infer (VarT id $ id.at) "| ..."

let as_struct_typ phrase env dir typ at : typfield list =
  match expand_singular' env typ.it with
  | VarT id -> as_struct_typid' phrase env id at
  | _ -> as_error at phrase dir typ "{...}"

let rec as_variant_typid' phrase env id _at : typcase list =
  match (find "syntax type" env.typs id).it with
  | VariantT (ids, cases) ->
    List.concat (cases :: List.map (as_variant_typid "" env) ids)
  | _ -> as_error id.at phrase Infer (VarT id $ id.at) "| ..."

and as_variant_typid phrase env id : typcase list =
  as_variant_typid' phrase env id id.at

let as_variant_typ phrase env dir typ at : typcase list =
  match expand_singular' env typ.it with
  | VarT id -> as_variant_typid' phrase env id at
  | _ -> as_error at phrase dir typ "| ..."


let is_x_typ as_x_typ env typ =
  try ignore (as_x_typ "" env Check typ no_region); true
  with Error _ -> false

let is_iter_typ = is_x_typ as_iter_typ
let is_notation_typ = is_x_typ as_notation_typ
let is_variant_typ = is_x_typ as_variant_typ


let is_variant_nottyp env nottyp =
  match nottyp.it with
  | TypT typ -> is_variant_typ env typ
  | _ -> false

let as_variant_nottyp env nottyp at =
  match nottyp.it with
  | TypT typ -> as_variant_typ "" env Check typ at, typ
  | _ -> as_error at "expression" Check (VarT ("?" $ at) $ at) "| ..."


(* Type Equivalence *)

let equiv_list equiv_x xs1 xs2 =
  List.length xs1 = List.length xs2 && List.for_all2 equiv_x xs1 xs2

let rec equiv_typ env typ1 typ2 =
  (*
  Printf.printf "[equiv] (%s) == (%s)  eq=%b\n%!"
    (Print.string_of_typ typ1) (Print.string_of_typ typ2)
    (typ1.it = typ2.it);
  *)
  typ1.it = typ2.it ||
  match expand env typ1, expand env typ2 with
  | VarT id1, VarT id2 -> id1.it = id2.it
  | TupT typs1, TupT typs2 ->
    equiv_list (equiv_typ env) typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    equiv_typ env typ11 typ21 && Eq.eq_iter iter1 iter2
  | typ1', typ2' ->
    Eq.eq_typ (typ1' $ typ1.at) (typ2' $ typ2.at)


(* Hints *)

let lower_hint hint =
  let {hintid; hintexp} = hint.it in
  let ss =
    match hintexp.it with
    | SeqE exps -> List.map Print.string_of_exp exps
    | _ -> [Print.string_of_exp hintexp]
  in
  {Il.hintid; Il.hintexp = ss} $ hint.at

let lower_hints = List.map lower_hint


(* Atoms and Operators *)

let lower_atom = function
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

let lower_brack = function
  | Paren -> Il.LParen, Il.RParen
  | Brack -> Il.LBrack, Il.RBrack
  | Brace -> Il.LBrace, Il.RBrace

let lower_unop = function
  | NotOp -> Il.NotOp
  | PlusOp -> Il.PlusOp
  | MinusOp -> Il.MinusOp

let lower_binop = function
  | AndOp -> Il.AndOp
  | OrOp -> Il.OrOp
  | ImplOp -> Il.ImplOp
  | AddOp -> Il.AddOp
  | SubOp -> Il.SubOp
  | MulOp -> Il.MulOp
  | DivOp -> Il.DivOp
  | ExpOp -> Il.ExpOp

let lower_cmpop = function
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
  | _, atoms2::mixop2' ->
    let mixop1', atoms1 = Lib.List.split_last mixop1 in
    mixop1' @ [atoms1 @ atoms2] @ mixop2'


let check_atoms phrase item get_atom list at =
  let _, dups =
    List.fold_right (fun item (set, dups) ->
      let s = Print.string_of_atom (get_atom item) in
      if Set.mem s set then (set, s::dups) else (Set.add s set, dups)
    ) list (Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let rec lower_iter env iter : Il.iter =
  match iter with
  | Opt -> Il.Opt
  | List -> Il.List
  | List1 -> Il.List1
  | ListN exp -> Il.ListN (lower_exp env exp (NatT $ exp.at))


(* Types *)

and lower_typ env typ : Il.typ =
  match typ.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error typ.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    Il.VarT id $ typ.at
  | BoolT -> Il.BoolT $ typ.at
  | NatT -> Il.NatT $ typ.at
  | TextT -> Il.TextT $ typ.at
  | ParenT typ1 ->
    lower_typ env typ1
  | TupT typs ->
    Il.TupT (List.map (lower_typ env) typs) $ typ.at
  | IterT (typ1, iter) ->
    match iter with
    | List1 | ListN _ -> error typ.at "illegal iterator for types"
    | _ -> Il.IterT (lower_typ env typ1, lower_iter env iter) $ typ.at

and lower_deftyp env deftyp : Il.deftyp =
  match deftyp.it with
  | NotationT nottyp ->
    Il.NotationT (lower_nottyp' env nottyp) $ deftyp.at
  | StructT fields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) fields deftyp.at;
    Il.StructT (List.map (lower_typfield env) fields) $ deftyp.at
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let deftypI = find "syntax type" env.typs id in
      if deftypI = fwd_deftyp_ok || deftypI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (as_variant_typid "parent" env) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' deftyp.at;
    Il.VariantT (ids, List.map (lower_typcase env deftyp.at) cases) $ deftyp.at

and lower_nottyp env nottyp : Il.mixop * Il.typ list =
  match nottyp.it with
  | TypT typ ->
    [[]; []], [lower_typ env typ]
  | AtomT atom ->
    [[lower_atom atom]], []
  | SeqT [] ->
    [[]], []
  | SeqT (nottyp1::nottyps2) ->
    let mixop1', typs1' = lower_nottyp env nottyp1 in
    let mixop2', typs2' = lower_nottyp env (SeqT nottyps2 $ nottyp.at) in
    merge_mixop mixop1' mixop2', typs1' @ typs2'
  | InfixT (nottyp1, atom, nottyp2) ->
    let mixop1', typs1' = lower_nottyp env nottyp1 in
    let mixop2', typs2' = lower_nottyp env nottyp2 in
    merge_mixop (merge_mixop mixop1' [[lower_atom atom]]) mixop2', typs1' @ typs2'
  | BrackT (brack, nottyp1) ->
    let l, r = lower_brack brack in
    let mixop', typs' = lower_nottyp env nottyp1 in
    merge_mixop (merge_mixop [[l]] mixop') [[r]], typs'
  | ParenNT nottyp1 ->
    let mixop1', typs1' = lower_nottyp env nottyp1 in
    merge_mixop (merge_mixop [[Il.LParen]] mixop1') [[Il.RParen]], typs1'
  | IterNT (nottyp1, iter) ->
    match iter with
    | List1 | ListN _ -> error nottyp.at "illegal iterator for types"
    | _ ->
      let mixop', typs' = lower_nottyp env nottyp1 in
      let typ1' =
        match typs' with [typ'] -> typ' | _ -> Il.TupT typs' $ nottyp1.at in
      let op = match iter with Opt -> Il.Quest | _ -> Il.Star in
      mixop' @ [[op]], [Il.IterT (typ1', lower_iter env iter) $ nottyp.at]

and lower_nottyp' env nottyp : Il.typmix =
  let mixop', typs' = lower_nottyp env nottyp in
  mixop', tup_typ typs' nottyp.at

and lower_typfield env (atom, typ, hints) : Il.typfield =
  (lower_atom atom, lower_typ env typ, lower_hints hints)

and lower_typcase env at (atom, nottyps, hints) : Il.typcase =
  let typss' = List.map snd (List.map (lower_nottyp env) nottyps) in
  (lower_atom atom, tup_typ (List.concat typss') at, lower_hints hints)

and tup_typ typs' at =
  match typs' with
  | [typ'] -> typ'
  | _ -> Il.TupT typs' $ at


(* Expressions *)

and infer_unop = function
  | NotOp -> BoolT
  | PlusOp | MinusOp -> NatT

and infer_binop = function
  | AndOp | OrOp | ImplOp -> BoolT
  | AddOp | SubOp | MulOp | DivOp | ExpOp -> NatT

and infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp | GtOp | LeOp | GeOp -> Some NatT

and infer_exp env exp : typ =
  match exp.it with
  | VarE id -> find "variable" env.vars (prefix_id id)
  | AtomE _ -> error exp.at "cannot infer type of atom"
  | BoolE _ -> BoolT $ exp.at
  | NatE _ | LenE _ -> NatT $ exp.at
  | TextE _ -> TextT $ exp.at
  | UnE (unop, _) -> infer_unop unop $ exp.at
  | BinE (_, binop, _) -> infer_binop binop $ exp.at
  | CmpE _ -> BoolT $ exp.at
  | IdxE (exp1, _) ->
    as_list_typ "expression" env Infer (infer_exp env exp1) exp1.at
  | SliceE (exp1, _, _)
  | UpdE (exp1, _, _)
  | ExtE (exp1, _, _)
  | CommaE (exp1, _)
  | CompE (exp1, _) ->
    infer_exp env exp1
  | StrE _ -> error exp.at "cannot infer type of record"
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    find_field typfields atom exp1.at
  | SeqE _ -> error exp.at "cannot infer type of expression sequence"
  | TupE exps -> TupT (List.map (infer_exp env) exps) $ exp.at
  | ParenE exp1 -> ParenT (infer_exp env exp1) $ exp.at
  | CallE (id, _) ->
    let _, typ2, _ = find "function" env.defs id in
    typ2
  | InfixE _ -> error exp.at "cannot infer type of infix expression"
  | BrackE _ -> error exp.at "cannot infer type of bracket expression"
  | IterE (exp1, iter) ->
    let iter' = match iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env exp1, iter') $ exp.at
  | HoleE -> error exp.at "misplaced hole"
  | FuseE _ -> error exp.at "misplaced token concatenation"


and lower_exp env exp typ : Il.exp =
  (*
  Printf.printf "[lower %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  if is_iter_typ env typ then
    let exp1 = unseq_exp exp in
    lower_exp_iter env exp1 (as_iter_typ "" env Check typ exp.at) typ exp.at
  else
    lower_exp' env exp typ

and lower_exp' env exp typ : Il.exp =
  (*
  Printf.printf "[lower' %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  match exp.it with
  | VarE id ->
    let typ' = infer_exp env exp in
    cast_exp "variable" env (Il.VarE id $ exp.at) typ' typ
  | BoolE b ->
    let typ' = infer_exp env exp in
    cast_exp "boolean" env (Il.BoolE b $ exp.at) typ' typ
  | NatE n ->
    let typ' = infer_exp env exp in
    cast_exp "number" env (Il.NatE n $ exp.at) typ' typ
  | TextE t ->
    let typ' = infer_exp env exp in
    cast_exp "text" env (Il.TextE t $ exp.at) typ' typ
  | UnE (unop, exp1) ->
    let typ' = infer_unop unop $ exp.at in
    let exp1' = lower_exp env exp1 typ' in
    let exp' = Il.UnE (lower_unop unop, exp1') $ exp.at in
    cast_exp "unary operator" env exp' typ' typ
  | BinE (exp1, binop, exp2) ->
    let typ' = infer_binop binop $ exp.at in
    let exp1' = lower_exp env exp1 typ' in
    let exp2' = lower_exp env exp2 typ' in
    let exp' = Il.BinE (lower_binop binop, exp1', exp2') $ exp.at in
    cast_exp "binary operator" env exp' typ' typ
  | CmpE (exp1, cmpop, exp2) ->
    let typ' =
      match infer_cmpop cmpop with
      | Some typ' -> typ' $ exp.at
      | None -> infer_exp env exp1
    in
    let exp1' = lower_exp env exp1 typ' in
    let exp' =
      match exp2.it with
      | CmpE (exp21, _, _) ->
        let exp21' = lower_exp env exp21 typ' in
        let exp2' = lower_exp env exp2 (BoolT $ exp2.at) in
        Il.BinE (Il.AndOp,
          Il.CmpE (lower_cmpop cmpop, exp1', exp21') $ exp1.at,
          exp2'
        ) $ exp.at
      | _ ->
        let exp2' = lower_exp env exp2 typ' in
        Il.CmpE (lower_cmpop cmpop, exp1', exp2') $ exp.at
    in
    cast_exp "comparison operator" env exp' (BoolT $ exp.at) typ
  | IdxE (exp1, exp2) ->
    let typ1 = infer_exp env exp1 in
    let typ' = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp env exp2 (NatT $ exp2.at) in
    let exp' = Il.IdxE (exp1', exp2') $ exp.at in
    cast_exp "list element" env exp' typ' typ
  | SliceE (exp1, exp2, exp3) ->
    let _typ' = as_list_typ "expression" env Check typ exp1.at in
    let exp1' = lower_exp env exp1 typ in
    let exp2' = lower_exp env exp2 (NatT $ exp2.at) in
    let exp3' = lower_exp env exp3 (NatT $ exp3.at) in
    Il.SliceE (exp1', exp2', exp3') $ exp.at
  | UpdE (exp1, path, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let path', typ2 = lower_path env path typ in
    let exp2' = lower_exp env exp2 typ2 in
    Il.UpdE (exp1', path', exp2') $ exp.at
  | ExtE (exp1, path, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let path', typ2 = lower_path env path typ in
    let _typ21 = as_list_typ "path" env Check typ2 path.at in
    let exp2' = lower_exp env exp2 typ2 in
    Il.ExtE (exp1', path', exp2') $ exp.at
  | StrE expfields ->
    let typfields = as_struct_typ "record" env Check typ exp.at in
    let fields' = lower_expfields env expfields typfields exp.at in
    Il.StrE fields' $ exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let exp1' = lower_exp env exp1 typ1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    let typ' = find_field typfields atom exp1.at in
    let exp' = Il.DotE (exp1', lower_atom atom) $ exp.at in
    cast_exp "field" env exp' typ' typ
  | CommaE (exp1, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let typfields = as_struct_typ "expression" env Check typ exp1.at in
    (* TODO: this is a bit of a hack *)
    (match exp2.it with
    | SeqE ({it = AtomE atom; at} :: exps2) ->
      let _typ2 = find_field typfields atom at in
      let exp2 = match exps2 with [exp2] -> exp2 | _ -> SeqE exps2 $ exp2.at in
      let exp2' = lower_exp env (StrE [(atom, exp2)] $ exp2.at) typ in
      Il.CompE (exp1', exp2') $ exp.at
    | _ -> failwith "unimplemented check CommaE"
    )
  | CompE (exp1, exp2) ->
    let _ = as_struct_typ "record" env Check typ exp.at in
    let exp1' = lower_exp env exp1 typ in
    let exp2' = lower_exp env exp2 typ in
    Il.CompE (exp1', exp2') $ exp.at
  | LenE exp1 ->
    let typ1 = infer_exp env exp1 in
    let _typ11 = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = lower_exp env exp1 typ1 in
    let exp' = Il.LenE exp1' $ exp.at in
    cast_exp "list length" env exp' (NatT $ exp.at) typ
  | ParenE exp1 ->
    lower_exp env exp1 typ
  | TupE exps ->
    let typs = as_tup_typ "tuple" env Check typ exp.at in
    let exps' = lower_exps env exps typs exp.at in
    Il.TupE exps' $ exp.at
  | CallE (id, exp2) ->
    let typ2, typ', _ = find "function" env.defs id in
    let exp2' = lower_exp env exp2 typ2 in
    let exp' = Il.CallE (id, exp2') $ exp.at in
    cast_exp "expression" env exp' typ' typ
  | AtomE _
  | InfixE _
  | BrackE _
  | SeqE _ ->
    if is_notation_typ env typ then
      lower_exp_notation env exp (as_notation_typ "" env Check typ exp.at)
    else if is_variant_typ env typ then
      lower_exp_variant env (unseq_exp exp)
        (as_variant_typ "" env Check typ exp.at) typ exp.at
    else
      error exp.at ("expression does not match expected type `" ^
        string_of_typ typ ^ "`")
  | IterE (exp1, iter2) ->
    let typ1, _iter = as_iter_typ "iteration" env Check typ exp.at in
    let exp1' = lower_exp env exp1 typ1 in
    let iter2' = lower_iter env iter2 in
    Il.IterE (exp1', iter2') $ exp.at
  | HoleE -> error exp.at "misplaced hole"
  | FuseE _ -> error exp.at "misplaced token fuse"

and lower_exps env exps typs at : Il.exp list =
  if List.length exps <> List.length typs then
    error at "arity mismatch for expression list";
  List.map2 (lower_exp env) exps typs

and lower_expfields env expfields typfields at : Il.expfield list =
  match expfields, typfields with
  | [], [] -> []
  | (atom1, exp)::expfields', (atom2, typ, _)::typfields' when atom1 = atom2 ->
    let exp' = lower_exp env exp typ in
    (lower_atom atom1, exp') :: lower_expfields env expfields' typfields' at
  | _, (atom, typ, _)::typfields' ->
    let exp' =
      cast_empty ("omitted record field `" ^ string_of_atom atom ^ "`") env typ at in
    (lower_atom atom, exp') :: lower_expfields env expfields typfields' at
  | (atom, exp)::_, [] ->
    error exp.at ("unexpected record field " ^ string_of_atom atom)

and lower_path env path typ : Il.path * typ =
  match path.it with
  | RootP ->
    Il.RootP $ path.at, typ
  | IdxP (path1, exp2) ->
    let path1', typ1 = lower_path env path1 typ in
    let exp2' = lower_exp env exp2 (NatT $ exp2.at) in
    let typ1 = as_list_typ "path" env Check typ1 path1.at in
    Il.IdxP (path1', exp2') $ path.at, typ1
  | DotP (path1, atom) ->
    let path1', typ1 = lower_path env path1 typ in
    let typfields = as_struct_typ "path" env Check typ1 path1.at in
    Il.DotP (path1', lower_atom atom) $ path.at, find_field typfields atom path1.at

and lower_exp_notation env exp nottyp : Il.exp =
  (*
  Printf.printf "[notation %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_nottyp nottyp);
  *)
  let mixop', exps' = lower_exp_notation' env exp nottyp in
  Il.MixE (mixop', tup_exp exps' exp.at) $ exp.at

and lower_exp_notation' env exp nottyp : Il.mixop * Il.exp list =
  (*
  Printf.printf "[notation' %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_nottyp nottyp);
  *)
  match exp.it, nottyp.it with
  | _, TypT typ1 ->
    [[]; []], [lower_exp env exp typ1]
  | AtomE atom, AtomT atom' ->
    if atom <> atom' then
      error exp.at ("atom does not match expected notation type `" ^
        string_of_nottyp nottyp ^ "`");
    [[lower_atom atom]], []
  | InfixE (exp1, atom, exp2), InfixT (nottyp1, atom', nottyp2) ->
    if atom <> atom' then
      error exp.at ("infix expression does not match expected notation type `" ^
        string_of_nottyp nottyp ^ "`");
    let mixop1', exps1' = lower_exp_notation' env exp1 nottyp1 in
    let mixop2', exps2' = lower_exp_notation' env exp2 nottyp2 in
    merge_mixop (merge_mixop mixop1' [[lower_atom atom]]) mixop2', exps1' @ exps2'
  | BrackE (brack, exp1), BrackT (brack', nottyp1) ->
    if brack <> brack' then
      error exp.at ("bracket expression does not match expected notation type `" ^
        string_of_nottyp nottyp ^ "`");
    let mixop1', exps1' = lower_exp_notation' env exp1 nottyp1 in
    let l, r = lower_brack brack in
    merge_mixop (merge_mixop [[l]] mixop1') [[r]], exps1'

  | _, ParenNT nottyp1 ->
    let mixop1', typs1' = lower_exp_notation' env exp nottyp1 in
    merge_mixop (merge_mixop [[Il.LParen]] mixop1') [[Il.RParen]], typs1'

  | SeqE exps, IterNT (nottyp1, iter) ->
    let mixop', _ = lower_nottyp env nottyp in
    mixop', [lower_exp_notation_iter env exps (nottyp1, iter) nottyp exp.at]

  | SeqE [], SeqT [] ->
    [], []
  | _, SeqT [{it = IterNT _ | TypT {it = IterT _; _}; _} as nottyp1] ->
    lower_exp_notation' env exp nottyp1
  | SeqE (exp1::exps2), SeqT (nottyp1::nottyps2) ->
    let mixop1', exps1' = lower_exp_notation' env (unparen_exp exp1) nottyp1 in
    let mixop2', exps2' = lower_exp_notation' env (SeqE exps2 $ exp.at) (SeqT nottyps2 $ nottyp.at) in
    merge_mixop mixop1' mixop2', exps1' @ exps2'
  | SeqE [], SeqT (nottyp1::nottyps2) ->
    let exp1' = cast_empty_notation "omitted sequence tail" env nottyp1 exp.at in
    let mixop2', exps2' = lower_exp_notation' env (SeqE [] $ exp.at) (SeqT nottyps2 $ nottyp.at) in
    [[]] @ mixop2', [exp1'] @ exps2'
  | SeqE (exp1::_), SeqT [] ->
    error exp1.at ("superfluous expression does not match expected empty notation type")
  | _, SeqT _ ->
    lower_exp_notation' env (SeqE [exp] $ exp.at) nottyp

  | _, _ ->
    error exp.at ("expression does not match expected notation type `" ^
      string_of_nottyp nottyp ^ "`")

and lower_exp_notation_iter env exps (nottyp1, iter) nottyp at : Il.exp =
  (*
  Printf.printf "[niteration %s] %s  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp exps))
    (string_of_nottyp nottyp);
  *)
  match exps, iter with
  | {it = AtomE _; _}::_, _ when is_variant_nottyp env nottyp1 ->
    let cases, typ1 = as_variant_nottyp env nottyp1 at in
    Il.ListE [lower_exp_variant env exps cases typ1 at] $ at

  | [], Opt ->
    Il.OptE None $ at
  | [{it = ParenE exp1; _}], Opt ->
    let _mixop1', exps1' = lower_exp_notation' env exp1 nottyp1 in
    let exp1' = tup_exp exps1' exp1.at in
    Il.OptE (Some exp1') $ at
  | [exp1], Opt ->
    lower_exp_notation env exp1 nottyp

  | [], List ->
    Il.ListE [] $ at
  | {it = ParenE exp1; _}::exps2, List ->
    let _mixop1', exps1' = lower_exp_notation' env exp1 nottyp1 in
    let exp2' = lower_exp_notation_iter env exps2 (nottyp1, iter) nottyp at in
    cons_exp (tup_exp exps1' exp1.at) exp2' $ at
  | exp1::exps2, List ->
    let _mixop1', exps1' = lower_exp_notation' env exp1 nottyp in
    let exp2' = lower_exp_notation_iter env exps2 (nottyp1, iter) nottyp at in
    cat_exp (tup_exp exps1' exp1.at) exp2' $ at

  | _, _ ->
    error at ("expression does not match expected iteration type `" ^
      string_of_nottyp nottyp ^ "`")

and lower_exp_iter env exps (typ1, iter) typ at : Il.exp =
  (*
  Printf.printf "[iteration %s] %s  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp exps))
    (string_of_typ typ);
  *)
  match exps, iter with
  | {it = AtomE _; _}::_, _ when is_variant_typ env typ1 ->
    let cases = as_variant_typ "" env Check typ1 at in
    Il.ListE [lower_exp_variant env exps cases typ1 at] $ at

  | [], Opt ->
    Il.OptE None $ at
  | [{it = ParenE exp1; _}], Opt ->
    let exp1' = lower_exp env exp1 typ1 in
    Il.OptE (Some exp1') $ at
  | [exp1], Opt ->
    lower_exp' env exp1 typ

  | [], List ->
    Il.ListE [] $ at
  | {it = ParenE exp1; _}::exps2, List ->
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp_iter env exps2 (typ1, iter) typ at in
    cons_exp exp1' exp2' $ at
  | exp1::exps2, List ->
    let exp1' = lower_exp' env exp1 typ in
    let exp2' = lower_exp_iter env exps2 (typ1, iter) typ at in
    cat_exp exp1' exp2' $ at
  | _, _ ->
    error at ("expression does not match expected iteration type `" ^
      string_of_typ typ ^ "`")

and lower_exp_variant env exps cases typ at : Il.exp =
  (*
  Printf.printf "[variant %s] {%s}  :  %s\n%!"
    (string_of_region at)
    (String.concat " " (List.map string_of_exp exps))
    (string_of_typ typ);
  (*
    (String.concat " | "
      (List.map (fun (atom, nottyps, _) ->
          string_of_nottyp (SeqT ((AtomT atom $ at) :: nottyps) $ at)
        ) cases
      )
    );
  *)
  *)
  match exps with
  | {it = AtomE atom; _} :: exps ->
    let nottyps = find_case cases atom at in
    (* TODO: this is a bit hacky *)
    let exp2 = SeqE exps $ at in
    let _mixop', exps' = lower_exp_notation' env exp2 (SeqT nottyps $ typ.at) in
    Il.CaseE (lower_atom atom, tup_exp exps' at) $ at
  | _ ->
    error at ("expression does not match expected variant type `" ^
      string_of_typ typ ^ "`")

and unparen_exp exp =
  match exp.it with
  | ParenE exp1 -> exp1
  | _ -> exp

and unseq_exp exp =
  match exp.it with
  | SeqE exps -> exps
  | _ -> [exp]

and tup_exp exps' at =
  match exps' with
  | [exp'] -> exp'
  | _ -> Il.TupE exps' $ at

and cons_exp exp1' exp2' =
  match exp2'.it with
  | Il.ListE exps2' -> Il.ListE (exp1' :: exps2')
  | _ -> Il.CatE (Il.ListE [exp1'] $ exp1'.at, exp2')

and cat_exp exp1' exp2' =
  match exp2'.it with
  | Il.ListE [] -> exp1'.it
  | _ -> Il.CatE (exp1', exp2')


and cast_empty phrase env typ at : Il.exp =
  match expand env typ with
  | IterT (_, Opt) ->
    Il.OptE None $ at
  | IterT (_, List) ->
    Il.ListE [] $ at
  | _ ->
    error at (phrase ^ " does not match expected type `" ^
      string_of_typ typ ^ "`")

and cast_empty_notation phrase env nottyp at : Il.exp =
  match nottyp.it with
  | TypT typ -> cast_empty phrase env typ at
  | _ ->
    error at (phrase ^ " does not match expected notation type `" ^
      string_of_nottyp nottyp ^ "`")

and cast_exp phrase env exp' typ1 typ2 : Il.exp =
  (*
  Printf.printf "[cast %s] (%s) <: (%s)  >>  (%s) <: (%s)  eq=%b\n%!"
    (string_of_region exp.at)
    (string_of_typ typ1) (string_of_typ typ2)
    (string_of_typ (expand env typ1 $ typ1.at))
    (string_of_typ (expand env typ2 $ typ2.at))
    (equiv_typ env typ1 typ2);
  *)
  if equiv_typ env typ1 typ2 then exp' else
  match expand env typ2 with
  | IterT (typ21, Opt) ->
    Il.OptE (Some (cast_exp_variant phrase env exp' typ1 typ21)) $ exp'.at
  | IterT (typ21, (List | List1)) ->
    Il.ListE [cast_exp_variant phrase env exp' typ1 typ21] $ exp'.at
  | _ ->
    cast_exp_variant phrase env exp' typ1 typ2

and cast_exp_variant phrase env exp' typ1 typ2 : Il.exp =
  if equiv_typ env typ1 typ2 then exp' else
  if is_variant_typ env typ1 && is_variant_typ env typ2 then
    let cases1 = as_variant_typ "" env Check typ1 exp'.at in
    let cases2 = as_variant_typ "" env Check typ2 exp'.at in
    (try
      List.iter (fun (atom, nottyps1, _) ->
        let nottyps2 = find_case cases2 atom typ1.at in
        (* Shallow subtyping on variants *)
        if List.length nottyps1 <> List.length nottyps2
        || not (List.for_all2 Eq.eq_nottyp nottyps1 nottyps2) then
          error exp'.at ("type mismatch for case `" ^ string_of_atom atom ^ "`")
      ) cases1
    with Error (_, msg) ->
      error exp'.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
        "does not match expected type `" ^ string_of_typ typ2 ^ "`, " ^ msg)
    );
    Il.SubE (exp', lower_typ env typ1, lower_typ env typ2) $ exp'.at
  else
    error exp'.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ typ2 ^ "`")


(* Definitions *)

let make_binds env free at =
  List.map (fun id' ->
    let id = id' $ at in
    (id, lower_typ env (find "variable" env.vars (prefix_id id)))
  ) (Set.elements free)


let lower_prem env prem : Il.premise =
  match prem.it with
  | RulePr (id, exp, iter_opt) ->
    let nottyp, _ = find "relation" env.rels id in
    let mixop', exps' = lower_exp_notation' env exp nottyp in
    let iter_opt' = Option.map (lower_iter env) iter_opt in
    Il.RulePr (id, mixop', tup_exp exps' exp.at, iter_opt') $ prem.at
  | IffPr (exp, iter_opt) ->
    let exp' = lower_exp env exp (BoolT $ exp.at) in
    let iter_opt' = Option.map (lower_iter env) iter_opt in
    Il.IffPr (exp', iter_opt') $ prem.at
  | ElsePr ->
    Il.ElsePr $ prem.at


let infer_deftyp _env deftyp =
  match deftyp.it with
  | NotationT _ -> fwd_deftyp_bad
  | _ -> fwd_deftyp_ok

let infer_def env def =
  match def.it with
  | SynD (id, deftyp, _) ->
    env.typs <- bind "syntax" env.typs id (infer_deftyp env deftyp)
  | _ -> ()

let lower_def env def : Il.def list =
  match def.it with
  | SynD (id, deftyp, hints) ->
    let deftyp' = lower_deftyp env deftyp in
    env.typs <- rebind "syntax" env.typs id deftyp;
    env.vars <- bind "variable" env.vars id (VarT id $ id.at);
    [Il.SynD (id, deftyp', lower_hints hints) $ def.at]
  | RelD (id, nottyp, hints) ->
    let mixop', typs' = lower_nottyp env nottyp in
    let typmix = mixop', tup_typ typs' nottyp.at in
    env.rels <- bind "relation" env.rels id (nottyp, []);
    [Il.RelD (id, typmix, [], lower_hints hints) $ def.at]
  | RuleD (id1, id2, exp, prems) ->
    let nottyp, rules' = find "relation" env.rels id1 in
    let mixop', exps' = lower_exp_notation' env exp nottyp in
    let prems' = List.map (lower_prem env) prems in
    let free =
      Free.(Set.union (free_exp exp).varid (free_list free_prem prems).varid) in
    let binds' = make_binds env free def.at in
    let rule' = Il.RuleD (id2, binds', mixop', tup_exp exps' exp.at, prems') $ def.at in
    env.rels <- rebind "relation" env.rels id1 (nottyp, rule'::rules');
    []
  | VarD (id, typ, _hints) ->
    let _typ' = lower_typ env typ in
    env.vars <- bind "variable" env.vars id typ;
    []
  | DecD (id, exp1, typ2, hints) ->
    let typ1 = infer_exp env exp1 in
    let _exp1' = lower_exp env exp1 typ1 in
    let typ1' = lower_typ env typ1 in
    let typ2' = lower_typ env typ2 in
    env.defs <- bind "function" env.defs id (typ1, typ2, []);
    [Il.DecD (id, typ1', typ2', [], lower_hints hints) $ def.at]
  | DefD (id, exp1, exp2, premo) ->
    let typ1, typ2, clauses' = find "function" env.defs id in
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp env exp2 typ2 in
    let premo' = Option.map (lower_prem env) premo in
    let free =
      Free.(Set.elements (Set.diff (free_exp exp2).varid (free_exp exp1).varid))
    in
    if free <> [] then
      error def.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" free ^ "`");
    let free = Free.(Set.union (free_exp exp1).varid (free_exp exp1).varid) in
    let binds' = make_binds env free def.at in
    let clause' = Il.DefD (binds', exp1', exp2', premo') $ def.at in
    env.defs <- rebind "definition" env.defs id (typ1, typ2, clause'::clauses');
    []

let populate_def env def' : Il.def =
  match def'.it with
  | Il.SynD _ ->
    def'
  | Il.RelD (id, typ', [], hints') ->
    let _, rules' = find "relation" env.rels id in
    Il.RelD (id, typ', rules', hints') $ def'.at
  | Il.DecD (id, typ1', typ2', [], hints') ->
    let _, _, clauses' = find "function" env.defs id in
    Il.DecD (id, typ1', typ2', clauses', hints') $ def'.at
  | _ ->
    assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il.Free.Set.t) =
  Il.Free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il.Free.Set.t) : int array =
  Array.map (fun id -> Map.find id map) (Array.of_seq (Il.Free.Set.to_seq set))

let check_homogeneous def' defs' =
  List.iter (fun def2' ->
    match def'.it, def2'.it with
    | Il.SynD _, Il.SynD _
    | Il.RelD _, Il.RelD _
    | Il.DecD _, Il.DecD _ -> ()
    | _, _ ->
      error def'.at (" " ^ string_of_region def2'.at ^
        ": invalid recurion between definitions of different sort")
  ) defs'

let recursify_defs defs' : Il.def list =
  let open Il.Free in
  let defa = Array.of_list defs' in
  let map_synid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let frees = Array.map Il.Free.free_def defa in
  let bounds = Array.map Il.Free.bound_def defa in
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
    let defs'' = List.map (fun i -> defa.(i)) (Scc.Set.elements set) in
    check_homogeneous (List.hd defs'') defs'';
    let i = Scc.Set.choose set in
    match defs'' with
    | [def'] when not (Il.Free.subset bounds.(i) frees.(i)) -> def'
    | defs'' ->
      (* TODO: check that notation is non-recursive and defs are inductive? *)
      Il.RecD defs'' $ Source.over_region (List.map at defs'')
  ) sccs

let lower defs : Il.script =
  let env = new_env () in
  List.iter (infer_def env) defs;
  let defs' = List.concat_map (lower_def env) defs in
  let defs' = List.map (populate_def env) defs' in
  recursify_defs defs'
