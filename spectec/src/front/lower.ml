open Source
open Ast
open Print

module Set = Free.Set
module Map = Map.Make(String)


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

type var_typ = typ
type syn_typ = deftyp
type rel_typ = typ * Il.rule list
type def_typ = typ * typ * Il.clause list

type env =
  { mutable vars : var_typ Map.t;
    mutable typs : syn_typ Map.t;
    mutable rels : rel_typ Map.t;
    mutable defs : def_typ Map.t;
  }

let fwd_deftyp id = AliasT (VarT (id @@ no_region) @@ no_region) @@ no_region
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


let rec prefix_id id = prefix_id' id.it @@ id.at
and prefix_id' id =
  match String.index_opt id '_', String.index_opt id '\'' with
  | None, None -> id
  | None, Some n | Some n, None -> String.sub id 0 n
  | Some n1, Some n2 -> String.sub id 0 (min n1 n2)


(* Type Accessors *)

let rec expand' env = function
  | VarT id as typ' ->
    (match (find "syntax type" env.typs id).it with
    | AliasT typ1 -> expand' env typ1.it
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

let as_seq_typ phrase env dir typ at : typ list =
  match expand' env typ.it with
  | SeqT typs -> typs
  | _ -> as_error at phrase dir typ "_ ... _"

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

let as_rel_typ relop phrase env dir typ at : typ * typ =
  match expand_singular' env typ.it with
  | RelT (typ1, relop', typ2) when relop' = relop -> typ1, typ2
  | _ -> as_error at phrase dir typ ("(_ " ^ string_of_relop relop ^ " _)")

let as_brack_typ brackop phrase env dir typ at : typ list =
  match expand_singular' env typ.it with
  | BrackT (brackop', typs) when brackop' = brackop -> typs
  | _ ->
    let l, r = string_of_brackop brackop in
    as_error at phrase dir typ ("`" ^ l ^ "..." ^ r)


let as_struct_typid' phrase env id at : typfield list =
  match (find "syntax type" env.typs id).it with
  | StructT fields -> fields
  | _ -> as_error at phrase Infer (VarT id @@ id.at) "| ..."

let as_struct_typ phrase env dir typ at : typfield list =
  match expand_singular' env typ.it with
  | VarT id -> as_struct_typid' phrase env id at
  | StrT fields -> fields
  | _ -> as_error at phrase dir typ "{...}"

let rec as_variant_typid' phrase env id _at : typcase list =
  match (find "syntax type" env.typs id).it with
  | VariantT (ids, cases) ->
    List.concat (cases :: List.map (as_variant_typid "" env) ids)
  | _ -> as_error id.at phrase Infer (VarT id @@ id.at) "| ..."

and as_variant_typid phrase env id : typcase list =
  as_variant_typid' phrase env id id.at

let as_variant_typ phrase env dir typ at : typcase list =
  match expand_singular' env typ.it with
  | VarT id -> as_variant_typid' phrase env id at
  | _ -> as_error at phrase dir typ "| ..."


let is_x_typ as_x_typ env typ =
  try ignore (as_x_typ "" env Check typ no_region); true
  with Error _ -> false

let is_seq_typ = is_x_typ as_seq_typ
let is_iter_typ = is_x_typ as_iter_typ
let is_variant_typ = is_x_typ as_variant_typ


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
  | SeqT typs1, SeqT typs2
  | TupT typs1, TupT typs2 ->
    equiv_list (equiv_typ env) typs1 typs2
  | StrT _, StrT _ -> assert false
  | RelT (typ11, relop1, typ12), RelT (typ21, relop2, typ22) ->
    equiv_typ env typ11 typ21 && relop1 = relop2 && equiv_typ env typ12 typ22
  | BrackT (brackop1, typs1), BrackT (brackop2, typs2) ->
    brackop1 = brackop2 && List.for_all2 (equiv_typ env) typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    equiv_typ env typ11 typ21 && Eq.eq_iter iter1 iter2
  | typ1', typ2' ->
    Eq.eq_typ (typ1' @@ typ1.at) (typ2' @@ typ2.at)


(* Hints *)

let lower_hint hint =
  let {hintid; hintexp} = hint.it in
  let ss =
    match hintexp.it with
    | SeqE exps -> List.map Print.string_of_exp exps
    | _ -> [Print.string_of_exp hintexp]
  in
  {Il.hintid; Il.hintexp = ss} @@ hint.at

let lower_hints = List.map lower_hint


(* Operators *)

let infer_unop = function
  | NotOp -> BoolT
  | PlusOp | MinusOp -> NatT

let infer_binop = function
  | AndOp | OrOp | ImplOp -> BoolT
  | AddOp | SubOp | MulOp | DivOp | ExpOp -> NatT

let infer_cmpop = function
  | EqOp | NeOp -> None
  | LtOp | GtOp | LeOp | GeOp -> Some NatT


(* Atoms *)

let is_mixfix = function
  | Colon | Sub | SqArrow | Turnstile | Tilesturn -> true
  | _ -> false

let lower_atom = function
  | Atom s -> Il.Atom s
  | Bot -> Il.Bot

let lower_brackop = function
  | Paren -> Il.LParen, Il.RParen
  | Brack -> Il.LBrack, Il.RBrack
  | Brace -> Il.LBrace, Il.RBrace

let lower_relop = function
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
  | ListN exp -> Il.ListN (lower_exp env exp (NatT @@ exp.at))


(* Types *)

and lower_typ env typ : Il.typ =
  match typ.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error typ.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    Il.VarT id @@ typ.at
  | AtomT atom ->
    Il.RelT ([[lower_atom atom]], []) @@ typ.at
  | BoolT -> Il.BoolT @@ typ.at
  | NatT -> Il.NatT @@ typ.at
  | TextT -> Il.TextT @@ typ.at
  | SeqT typs ->
    let atoms', relop', typs' = lower_typ_seq env typs in
    Il.RelT (atoms'::relop', typs') @@ typ.at
  | StrT _ ->
    assert false
  | ParenT typ1 ->
    lower_typ env typ1
  | TupT typs ->
    Il.TupT (List.map (lower_typ env) typs) @@ typ.at
  | RelT (_, relop, _) when is_mixfix relop ->
    let relop', typs' = lower_typ_mixfix env typ in
    Il.RelT (relop', typs') @@ typ.at
  | RelT (typ1, relop, typ2) ->
    let relop' = [[]; [lower_relop relop]; []] in
    Il.RelT (relop', [lower_typ env typ1; lower_typ env typ2]) @@ typ.at
  | BrackT (brackop, typs) ->
    let l, r = lower_brackop brackop in
    let atoms1', relop', typs' = lower_typ_seq env typs in
    let relop'', atoms2' =
      match relop' with [] -> [], [] | _ -> Lib.List.split_last relop' in
    Il.RelT ([[l] @ atoms1'] @ relop'' @ [atoms2' @ [r]], typs') @@ typ.at
  | IterT (typ1, iter) ->
    match iter with
    | List1 | ListN _ -> error typ.at "illegal iterator for types"
    | _ -> Il.IterT (lower_typ env typ1, lower_iter env iter) @@ typ.at

and lower_typ_seq env typs : Il.atom list * Il.relop * Il.typ list =
  match typs with
  | [] -> [], [], []
  | {it = AtomT atom; _} :: typs2 ->
    let atom' = lower_atom atom in
    let atoms', relop', typs' = lower_typ_seq env typs2 in
    atom'::atoms', relop', typs'
  | typ1 :: typs2 ->
    let typ1' = lower_typ env typ1 in
    let atoms', relop', typs' = lower_typ_seq env typs2 in
    [], atoms'::relop', typ1'::typs'

and lower_typ_mixfix env typ : Il.relop * Il.typ list =
  match typ.it with
  | RelT (typ1, relop, typ2) when is_mixfix relop ->
    let relop1', typs1' = lower_typ_mixfix env typ1 in
    let relop2', typs2' = lower_typ_mixfix env typ2 in
    let relop1'', atoms1' = Lib.List.split_last relop1' in
    let atoms2', relop2'' = Lib.List.split_hd relop2' in
    let atoms'' = atoms1' @ [lower_relop relop] @ atoms2' in
    relop1'' @ [atoms''] @ relop2'', typs1' @ typs2'
  | SeqT [] ->
    [[]], []
  | SeqT typs ->
    let atoms1', relop', typs' = lower_typ_seq env typs in
    atoms1'::relop', typs'
  | _ ->
    [[]; []], [lower_typ env typ]

and lower_deftyp env deftyp : Il.deftyp =
  match deftyp.it with
  | AliasT typ ->
    Il.AliasT (lower_typ env typ) @@ deftyp.at
  | StructT fields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) fields deftyp.at;
    Il.StructT (List.map (lower_typfield env) fields) @@ deftyp.at
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let deftypI = find "syntax type" env.typs id in
      if deftypI = fwd_deftyp_ok || deftypI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (as_variant_typid "parent" env) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' deftyp.at;
    Il.VariantT (ids, List.map (lower_typcase env deftyp.at) cases) @@ deftyp.at

and lower_typfield env (atom, typ, hints) : Il.typfield =
  (lower_atom atom, lower_typ env typ, lower_hints hints)

and lower_typcase env at (atom, typs, hints) : Il.typcase =
  (lower_atom atom, Il.TupT (List.map (lower_typ env) typs) @@ at, lower_hints hints)


(* Expressions *)

and infer_exp env exp : typ =
  match exp.it with
  | VarE id -> find "variable" env.vars (prefix_id id)
  | AtomE atom -> AtomT atom @@ exp.at
  | BoolE _ -> BoolT @@ exp.at
  | NatE _ | LenE _ -> NatT @@ exp.at
  | TextE _ -> TextT @@ exp.at
  | UnE (unop, _) -> infer_unop unop @@ exp.at
  | BinE (_, binop, _) -> infer_binop binop @@ exp.at
  | CmpE _ -> BoolT @@ exp.at
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
  | SeqE exps -> SeqT (List.map (infer_exp env) exps) @@ exp.at
  | TupE exps -> TupT (List.map (infer_exp env) exps) @@ exp.at
  | ParenE exp1 -> ParenT (infer_exp env exp1) @@ exp.at
  | CallE (id, _) ->
    let _, typ2, _ = find "function" env.defs id in
    typ2
  | RelE (exp1, relop, exp2) ->
    RelT (infer_exp env exp1, relop, infer_exp env exp2) @@ exp.at
  | BrackE (brackop, exps) ->
    BrackT (brackop, List.map (infer_exp env) exps) @@ exp.at
  | IterE (exp1, iter) ->
    let iter' = match iter with ListN _ -> List | iter' -> iter' in
    IterT (infer_exp env exp1, iter') @@ exp.at
  | OptE _ | ListE _ | CatE _ | CaseE _ | SubE _ -> assert false
  | HoleE -> error exp.at "misplaced hole"
  | FuseE _ -> error exp.at "misplaced token concatenation"


and lower_exp env exp typ : Il.exp =
  (*
  Printf.printf "[elab %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  if is_seq_typ env typ then
    untup_exp (lower_exp_seq env (unseq_exp exp) (as_seq_typ "" env Check typ exp.at) typ exp.at)
  else if is_iter_typ env typ then
    lower_exp_iter env (unseq_exp exp) (as_iter_typ "" env Check typ exp.at) typ exp.at
  else
    lower_exp' env exp typ
(* TODO
  match exp.it with
  | ParenE exp1 when is_iter_typ env typ ->
    let typ1, _ = as_iter_typ "" env Check typ exp.at in
    let exp' = lower_exp env exp1 typ1 in
    cast_exp "expression" env exp' typ1 typ
  | _ ->
    lower_exp' env exp typ
*)


and lower_exp' env exp typ : Il.exp =
  if is_variant_typ env typ then
    lower_exp_variant env (unseq_exp exp) (as_variant_typ "" env Check typ exp.at) exp typ exp.at
  else
    lower_exp'' env exp typ

and lower_exp'' env exp typ : Il.exp =
  match exp.it with
  | VarE id ->
    let typ' = infer_exp env exp in
    cast_exp "variable" env (Il.VarE id @@ exp.at) typ' typ
  | AtomE atom ->
    let typ' = infer_exp env exp in
    cast_exp "atom" env (Il.RelE ([[lower_atom atom]], []) @@ exp.at) typ' typ
  | BoolE b ->
    let typ' = infer_exp env exp in
    cast_exp "boolean" env (Il.BoolE b @@ exp.at) typ' typ
  | NatE n ->
    let typ' = infer_exp env exp in
    cast_exp "number" env (Il.NatE n @@ exp.at) typ' typ
  | TextE t ->
    let typ' = infer_exp env exp in
    cast_exp "text" env (Il.TextE t @@ exp.at) typ' typ
  | UnE (unop, exp1) ->
    let typ' = infer_unop unop @@ exp.at in
    let exp1' = lower_exp env exp1 typ' in
    let exp' = Il.UnE (lower_unop unop, exp1') @@ exp.at in
    cast_exp "unary operator" env exp' typ' typ
  | BinE (exp1, binop, exp2) ->
    let typ' = infer_binop binop @@ exp.at in
    let exp1' = lower_exp env exp1 typ' in
    let exp2' = lower_exp env exp2 typ' in
    let exp' = Il.BinE (lower_binop binop, exp1', exp2') @@ exp.at in
    cast_exp "binary operator" env exp' typ' typ
  | CmpE (exp1, cmpop, exp2) ->
    let typ' =
      match infer_cmpop cmpop with
      | Some typ' -> typ' @@ exp.at
      | None -> infer_exp env exp1
    in
    let exp1' = lower_exp env exp1 typ' in
    let exp' =
      match exp2.it with
      | CmpE (exp21, _, _) ->
        let exp21' = lower_exp env exp21 typ' in
        let exp2' = lower_exp env exp2 (BoolT @@ exp2.at) in
        Il.BinE (Il.AndOp,
          Il.CmpE (lower_cmpop cmpop, exp1', exp21') @@ exp1.at,
          exp2'
        ) @@ exp.at
      | _ ->
        let exp2' = lower_exp env exp2 typ' in
        Il.CmpE (lower_cmpop cmpop, exp1', exp2') @@ exp.at
    in
    cast_exp "comparison operator" env exp' (BoolT @@ exp.at) typ
  | SeqE _ ->
    error exp.at ("sequence expression does not match expected type `" ^
      string_of_typ typ ^ "`")
  | IdxE (exp1, exp2) ->
    let typ1 = infer_exp env exp1 in
    let typ' = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp env exp2 (NatT @@ exp2.at) in
    let exp' = Il.IdxE (exp1', exp2') @@ exp.at in
    cast_exp "list element" env exp' typ' typ
  | SliceE (exp1, exp2, exp3) ->
    let _typ' = as_list_typ "expression" env Check typ exp1.at in
    let exp1' = lower_exp env exp1 typ in
    let exp2' = lower_exp env exp2 (NatT @@ exp2.at) in
    let exp3' = lower_exp env exp3 (NatT @@ exp3.at) in
    Il.SliceE (exp1', exp2', exp3') @@ exp.at
  | UpdE (exp1, path, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let path', typ2 = lower_path env path typ in
    let exp2' = lower_exp env exp2 typ2 in
    Il.UpdE (exp1', path', exp2') @@ exp.at
  | ExtE (exp1, path, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let path', typ2 = lower_path env path typ in
    let _typ21 = as_list_typ "path" env Check typ2 path.at in
    let exp2' = lower_exp env exp2 typ2 in
    Il.ExtE (exp1', path', exp2') @@ exp.at
  | StrE expfields ->
    let typfields = as_struct_typ "record" env Check typ exp.at in
    let fields' = lower_expfields env expfields typfields exp.at in
    Il.StrE fields' @@ exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let exp1' = lower_exp env exp1 typ1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    let typ' = find_field typfields atom exp1.at in
    let exp' = Il.DotE (exp1', lower_atom atom) @@ exp.at in
    cast_exp "field" env exp' typ' typ
  | CommaE (exp1, exp2) ->
    let exp1' = lower_exp env exp1 typ in
    let typfields = as_struct_typ "expression" env Check typ exp1.at in
    (* TODO: this is a bit of a hack *)
    (match exp2.it with
    | SeqE ({it = AtomE atom; at} :: exps2) ->
      let _typ2 = find_field typfields atom at in
      let exp2 = match exps2 with [exp2] -> exp2 | _ -> SeqE exps2 @@ exp2.at in
      let exp2' = lower_exp env (StrE [(atom, exp2)] @@ exp2.at) typ in
      Il.CompE (exp1', exp2') @@ exp.at
    | _ -> failwith "unimplemented check CommaE"
    )
  | CompE (exp1, exp2) ->
    let _ = as_struct_typ "record" env Check typ exp.at in
    let exp1' = lower_exp env exp1 typ in
    let exp2' = lower_exp env exp2 typ in
    Il.CompE (exp1', exp2') @@ exp.at
  | LenE exp1 ->
    let typ1 = infer_exp env exp1 in
    let _typ11 = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = lower_exp env exp1 typ1 in
    let exp' = Il.LenE exp1' @@ exp.at in
    cast_exp "list length" env exp' (NatT @@ exp.at) typ
  | ParenE exp1 ->
    lower_exp env exp1 typ
  | TupE exps ->
    let typs = as_tup_typ "tuple" env Check typ exp.at in
    let exps' = lower_exps env exps typs exp.at in
    Il.TupE exps' @@ exp.at
  | CallE (id, exp2) ->
    let typ2, typ', _ = find "function" env.defs id in
    let exp2' = lower_exp env exp2 typ2 in
    let exp' = Il.CallE (id, exp2') @@ exp.at in
    cast_exp "expression" env exp' typ' typ
  | RelE (exp1, relop, exp2) ->
    (* TODO: follow structure of type *)
    let typ1, typ2 = as_rel_typ relop "relation" env Check typ exp.at in
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp env exp2 typ2 in
    Il.RelE ([[]; [lower_relop relop]; []], [exp1'; exp2']) @@ exp.at
  | BrackE (brackop, exps) ->
    (* TODO: follow structure of type *)
    let l, r = lower_brackop brackop in
    let typs = as_brack_typ brackop "bracket" env Check typ exp.at in
    let exps' = lower_exps env exps typs exp.at in
    Il.RelE ([[l]; [r]], exps') @@ exp.at
  | IterE (exp1, iter2) ->
    let typ1, _iter = as_iter_typ "iteration" env Check typ exp.at in
    let exp1' = lower_exp env exp1 typ1 in
    let iter2' = lower_iter env iter2 in
    Il.IterE (exp1', iter2') @@ exp.at
  | OptE _ | ListE _ | CatE _ | CaseE _ | SubE _ -> assert false
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
      cast_exp "omitted record field" env (Il.ListE [] @@ at) (SeqT [] @@ at) typ in
    (lower_atom atom, exp') :: lower_expfields env expfields typfields' at
  | (atom, exp)::_, [] ->
    error exp.at ("unexpected record field " ^ string_of_atom atom)

and lower_path env path typ : Il.path * typ =
  match path.it with
  | RootP ->
    Il.RootP @@ path.at, typ
  | IdxP (path1, exp2) ->
    let path1', typ1 = lower_path env path1 typ in
    let exp2' = lower_exp env exp2 (NatT @@ exp2.at) in
    let typ1 = as_list_typ "path" env Check typ1 path1.at in
    Il.IdxP (path1', exp2') @@ path.at, typ1
  | DotP (path1, atom) ->
    let path1', typ1 = lower_path env path1 typ in
    let typfields = as_struct_typ "path" env Check typ1 path1.at in
    Il.DotP (path1', lower_atom atom) @@ path.at, find_field typfields atom path1.at

and lower_exp_seq env exps typs typ at : Il.exp =
  match exps, typs with
  | [], [] ->
    Il.TupE [] @@ at
  | [exp1], [typ1] ->
    Il.TupE [lower_exp env exp1 typ1] @@ at
  | [exp1], _ ->
    Il.TupE [lower_exp' env exp1 typ] @@ at
  | _, [typ1] ->
    Il.TupE [lower_exp env (SeqE exps @@ at) typ1] @@ at
  | exp1::exps2, typ1::typs2 ->
    let exp1' = lower_exp env exp1 typ1 in
    tup_exp exp1' (lower_exp_seq env exps2 typs2 typ at) @@ at
  | [], typ1::typs ->
    let exp1' = cast_exp "empty tail" env (Il.ListE [] @@ at) (SeqT [] @@ at) typ1 in
    tup_exp exp1' (lower_exp_seq env [] typs typ at) @@ at
  | exp1::_, [] ->
    error exp1.at ("superfluous element does not match expected sequence type `" ^
      string_of_typ typ ^ "`")

and lower_exp_iter env exps (typ1, iter) typ at : Il.exp =
  match exps, iter with
  | [], Opt ->
    Il.OptE None @@ at
  | [{it = ParenE _; _} as exp1], Opt ->
    let exp1' = lower_exp env exp1 typ1 in
    Il.OptE (Some exp1') @@ at
  | [exp1], Opt ->
    lower_exp' env exp1 typ

  | [], List ->
    Il.ListE [] @@ at
  | ({it = ParenE _; _} as exp1)::exps2, (List | List1) ->
    let exp1' = lower_exp env exp1 typ1 in
    let exp2' = lower_exp_iter env exps2 (typ1, iter) typ at in
    cons_exp exp1' exp2' @@ at
  | exp1::exps2, (List | List1) ->
    let exp1' = lower_exp' env exp1 typ in
    let exp2' = lower_exp_iter env exps2 (typ1, iter) typ at in
    Il.CatE (exp1', exp2') @@ at
  | _, _ ->
    error at ("expression does not match expected iteration type `" ^
      string_of_typ typ ^ "`")

and lower_exp_variant env exps cases exp typ at : Il.exp =
  match exps with
  | {it = AtomE atom; _} :: exps ->
    let typs = find_case cases atom at in
    let exp' = lower_exp_seq env exps typs (SeqT typs @@ typ.at) at in
    Il.CaseE (lower_atom atom, untup_exp exp') @@ at
  | _ ->
    lower_exp'' env exp typ

(*
and lower_exp_seq env exps typ at : Il.exp =
  match exps, expand env typ with
  | {it = AtomE atom; _} :: exps, _ when is_variant_typ env typ ->
    let cases = as_variant_typ "" env Check typ at in
    let typs = find_case cases atom at in
    let exp' = lower_exp_seq env exps (SeqT typs @@ typ.at) at in
    Il.CaseE (lower_atom atom, untup_exp exp') @@ at

  | [], IterT (_, Opt) ->
    Il.OptE None @@ at
  | [{it = ParenE _; _} as exp1], IterT (typ1, Opt) ->
    let exp1' = lower_exp' env exp1 typ1 in
    Il.OptE (Some exp1') @@ at
  | [exp1], IterT (_, Opt) ->
    lower_exp' env exp1 typ

  | [], IterT (_, List) ->
    Il.ListE [] @@ at
  | ({it = ParenE _; _} as exp1)::exps2, IterT (typ1, _iter) ->
    let exp1' = lower_exp' env exp1 typ1 in
    let exp2' = lower_exp_seq env exps2 typ at in
    cons_exp exp1' exp2' @@ at
  | exp1::exps2, IterT (_, (List | List1)) ->
    let exp1' = lower_exp' env exp1 typ in
    let exp2' = lower_exp_seq env exps2 typ at in
    Il.CatE (exp1', exp2') @@ at
  | _, IterT _ ->
    error at ("sequence does not match expected iteration type `" ^
      string_of_typ typ ^ "`")

  | [], SeqT [] ->
    Il.TupE [] @@ at
  | [exp1], SeqT [typ1] -> 
    Il.TupE [lower_exp' env exp1 typ1] @@ at
  | [exp1], _ ->
    Il.TupE [lower_exp' env exp1 typ] @@ at
  | _, SeqT [typ1] ->
    Il.TupE [lower_exp' env (SeqE exps @@ at) typ1] @@ at
  | [], SeqT (typ1::typs) ->
    let exp1' = cast_exp "empty tail" env (Il.ListE [] @@ at) (SeqT [] @@ at) typ1 in
    tup_exp exp1' (lower_exp_seq env [] (SeqT typs @@ typ.at) at) @@ at
  | exp1::exps2, SeqT (typ1::typs2) ->
    let exp1' = lower_exp' env exp1 typ1 in
    tup_exp exp1' (lower_exp_seq env exps2 (SeqT typs2 @@ typ.at) at) @@ at
  | exp1::_, SeqT [] ->
    error exp1.at "unexpected element at end of sequence"

  | _, _ ->
    error at ("sequence does not match expected type `" ^
      string_of_typ typ ^ "`")
*)

and unseq_exp exp =
  match exp.it with
  | SeqE exps -> exps
  | _ -> [exp]

and tup_exp exp1' exp2' =
  match exp2'.it with
  | Il.TupE exps2' -> Il.TupE (exp1'::exps2')
  | _ -> Il.TupE [exp1'; exp2']

and untup_exp exp' =
  match exp'.it with
  | Il.TupE [exp1'] -> exp1'
  | _ -> exp'

and cons_exp exp1' exp2' =
  match exp2'.it with
  | Il.ListE exps2' -> Il.ListE (exp1' :: exps2')
  | _ -> Il.CatE (Il.ListE [exp1'] @@ exp1'.at, exp2')


and cast_exp phrase env exp' typ1 typ2 : Il.exp =
  (*
  Printf.printf "[cast %s] (%s) <: (%s)  >>  (%s) <: (%s)  eq=%b\n%!"
    (string_of_region exp.at)
    (string_of_typ typ1) (string_of_typ typ2)
    (string_of_typ (expand env typ1 @@ typ1.at))
    (string_of_typ (expand env typ2 @@ typ2.at))
    (equiv_typ env typ1 typ2);
  *)
  if equiv_typ env typ1 typ2 then exp' else
  match expand env typ1, expand env typ2 with
  | SeqT [], IterT (_typ21, Opt) ->
    Il.OptE None @@ exp'.at
  | SeqT [], IterT (_typ21, List) ->
    Il.ListE [] @@ exp'.at
  | _typ1', IterT (typ21, Opt) ->
    Il.OptE (Some (cast_exp_variant phrase env exp' typ1 typ21)) @@ exp'.at
  | _typ1', IterT (typ21, (List | List1)) ->
    Il.ListE [cast_exp_variant phrase env exp' typ1 typ21] @@ exp'.at
  | _, _ ->
    cast_exp_variant phrase env exp' typ1 typ2

and cast_exp_variant phrase env exp' typ1 typ2 : Il.exp =
  if equiv_typ env typ1 typ2 then exp' else
  if is_variant_typ env typ1 && is_variant_typ env typ2 then
    let cases1 = as_variant_typ "" env Check typ1 exp'.at in
    let cases2 = as_variant_typ "" env Check typ2 exp'.at in
    (try
      List.iter (fun (atom, typs1, _) ->
        let typs2 = find_case cases2 atom typ1.at in
        (* Shallow subtyping on variants *)
        if List.length typs1 <> List.length typs2
        || not (List.for_all2 Eq.eq_typ typs1 typs2) then
          error exp'.at ("type mismatch for case `" ^ string_of_atom atom ^ "`")
      ) cases1
    with Error (_, msg) ->
      error exp'.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
        "does not match expected type `" ^ string_of_typ typ2 ^ "`, " ^ msg)
    );
    Il.SubE (exp', lower_typ env typ1, lower_typ env typ2) @@ exp'.at
  else
    error exp'.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ typ2 ^ "`")


(* Definitions *)

let make_binds env free at =
  List.map (fun id' ->
    let id = id' @@ at in
    (id, lower_typ env (find "variable" env.vars (prefix_id id)))
  ) (Set.elements free)


let lower_prem env prem : Il.premise =
  match prem.it with
  | RulePr (id, exp, iter_opt) ->
    let typ, _ = find "relation" env.rels id in
    let exp' = lower_exp env exp typ in
    let iter_opt' = Option.map (lower_iter env) iter_opt in
    Il.RulePr (id, exp', iter_opt') @@ prem.at
  | IffPr (exp, iter_opt) ->
    let exp' = lower_exp env exp (BoolT @@ exp.at) in
    let iter_opt' = Option.map (lower_iter env) iter_opt in
    Il.IffPr (exp', iter_opt') @@ prem.at
  | ElsePr ->
    Il.ElsePr @@ prem.at


let infer_def env def =
  match def.it with
  | SynD (id, deftyp, _) ->
    let fwd_deftyp =
      match deftyp.it with AliasT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax" env.typs id fwd_deftyp
  | _ -> ()

let lower_def env def : Il.def list =
  match def.it with
  | SynD (id, deftyp, hints) ->
    let deftyp' = lower_deftyp env deftyp in
    env.typs <- rebind "syntax" env.typs id deftyp;
    env.vars <- bind "variable" env.vars id (VarT id @@ id.at);
    [Il.SynD (id, deftyp', lower_hints hints) @@ def.at]
  | RelD (id, typ, hints) ->
    let typ' = lower_typ env typ in
    env.rels <- bind "relation" env.rels id (typ, []);
    [Il.RelD (id, typ', [], lower_hints hints) @@ def.at]
  | RuleD (id1, id2, exp, prems) ->
    let typ, rules' = find "relation" env.rels id1 in
    let exp' = lower_exp env exp typ in
    let prems' = List.map (lower_prem env) prems in
    let free =
      Free.(Set.union (free_exp exp).varid (free_list free_prem prems).varid) in
    let binds' = make_binds env free def.at in
    let rule' = Il.RuleD (id2, binds', exp', prems') @@ def.at in
    env.rels <- rebind "relation" env.rels id1 (typ, rule'::rules');
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
    [Il.DecD (id, typ1', typ2', [], lower_hints hints) @@ def.at]
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
    let clause' = Il.DefD (binds', exp1', exp2', premo') @@ def.at in
    env.defs <- rebind "definition" env.defs id (typ1, typ2, clause'::clauses');
    []

let populate_def env def' : Il.def =
  match def'.it with
  | Il.SynD _ ->
    def'
  | Il.RelD (id, typ', [], hints') ->
    let _, rules' = find "relation" env.rels id in
    Il.RelD (id, typ', rules', hints') @@ def'.at
  | Il.DecD (id, typ1', typ2', [], hints') ->
    let _, _, clauses' = find "function" env.defs id in
    Il.DecD (id, typ1', typ2', clauses', hints') @@ def'.at
  | _ ->
    assert false


(* Scripts *)

let origins i (map : int Map.t ref) (set : Il_free.Set.t) =
  Il_free.Set.iter (fun id -> map := Map.add id i !map) set

let deps (map : int Map.t) (set : Il_free.Set.t) : int array =
  Array.map (fun id -> Map.find id map) (Array.of_seq (Il_free.Set.to_seq set))

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
  let open Il_free in
  let defa = Array.of_list defs' in
  let map_synid = ref Map.empty in
  let map_relid = ref Map.empty in
  let map_defid = ref Map.empty in
  let frees = Array.map Il_free.free_def defa in
  let bounds = Array.map Il_free.bound_def defa in
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
    | [def'] when not (Il_free.subset bounds.(i) frees.(i)) -> def'
    | defs'' -> Il.RecD defs'' @@ Source.over_region (List.map at defs'')
  ) sccs

let lower defs : Il.script =
  let env = new_env () in
  List.iter (infer_def env) defs;
  let defs' = List.concat_map (lower_def env) defs in
  let defs' = List.map (populate_def env) defs' in
  recursify_defs defs'
