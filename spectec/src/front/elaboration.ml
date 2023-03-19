open Source
open Ast
open Print


(* Errors *)

let error at msg = Source.error at "type" msg


(* Environment *)

module Env = Map.Make(String)

type var_typ = typ
type syn_typ = deftyp
type rel_typ = typ
type def_typ = typ * typ

type env =
  { mutable vars : var_typ Env.t;
    mutable typs : syn_typ Env.t;
    mutable rels : rel_typ Env.t;
    mutable defs : def_typ Env.t;
  }

let fwd_deftyp id = AliasT (VarT (id @@ no_region) @@ no_region) @@ no_region
let fwd_deftyp_bad = fwd_deftyp "(undefined)"
let fwd_deftyp_ok = fwd_deftyp "(forward)"

let new_env () =
  { vars = Env.empty;
    typs = Env.empty;
    rels = Env.empty;
    defs = Env.empty;
  }

let find space env' id =
  match Env.find_opt id.it env' with
  | None -> error id.at ("undeclared " ^ space ^ " `" ^ id.it ^ "`")
  | Some t -> t

let bind space env' id typ =
  if Env.mem id.it env' then
    error id.at ("duplicate declaration for " ^ space ^ " `" ^ id.it ^ "`")
  else
    Env.add id.it typ env'

let rebind _space env' id typ =
  assert (Env.mem id.it env');
  Env.add id.it typ env'

let find_field fields atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) fields with
  | Some (_, x, _) -> x
  | None -> error at ("unbound field `" ^ string_of_atom atom ^ "`")

let find_case cases atom at =
  match List.find_opt (fun (atom', _, _) -> atom' = atom) cases with
  | Some (_, x, _) -> x
  | None -> error at ("unknown case `" ^ string_of_atom atom ^ "`")


(* Type Accessors *)

let rec expand' env = function
  | VarT id as typ' ->
    (match (find "syntax type" env.typs id).it with
    | AliasT typ1 -> expand' env typ1.it
    | StructT typfields -> StrT typfields
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
  | StrT fields1, StrT fields2 ->
    equiv_list (equiv_typfield env) fields1 fields2
  | RelT (typ11, relop1, typ12), RelT (typ21, relop2, typ22) ->
    equiv_typ env typ11 typ21 && relop1 = relop2 && equiv_typ env typ12 typ22
  | BrackT (brackop1, typs1), BrackT (brackop2, typs2) ->
    brackop1 = brackop2 && List.for_all2 (equiv_typ env) typs1 typs2
  | IterT (typ11, iter1), IterT (typ21, iter2) ->
    equiv_typ env typ11 typ21 && Eq.eq_iter iter1 iter2
  | typ1', typ2' ->
    Eq.eq_typ (typ1' @@ typ1.at) (typ2' @@ typ2.at)

and equiv_typfield env (atom1, typ1, _) (atom2, typ2, _) =
  atom1 = atom2 && equiv_typ env typ1 typ2


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


(* Atom Bindings *)

let check_atoms phrase item get_atom list at =
  let _, dups =
    List.fold_right (fun item (set, dups) ->
      let s = Print.string_of_atom (get_atom item) in
      Free.Set.(if mem s set then (set, s::dups) else (add s set, dups))
    ) list (Free.Set.empty, [])
  in
  if dups <> [] then
    error at (phrase ^ " contains duplicate " ^ item ^ "(s) `" ^
      String.concat "`, `" dups ^ "`")


(* Iteration *)

let rec elab_iter env iter : iter =
  match iter with
  | Opt | List | List1 -> iter
  | ListN exp -> ListN (elab_exp' env exp (NatT @@ exp.at))


(* Types *)

and elab_typ env typ : typ =
  match typ.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error typ.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    typ
  | AtomT _
  | BoolT
  | NatT
  | TextT ->
    typ
  | SeqT typs ->
    SeqT (List.map (elab_typ env) typs) @@ typ.at
  | StrT typfields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) typfields typ.at;
    StrT (List.map (elab_typfield env) typfields) @@ typ.at
  | ParenT typ1 ->
    elab_typ env typ1
  | TupT typs ->
    TupT (List.map (elab_typ env) typs) @@ typ.at
  | RelT (typ1, relop, typ2) ->
    RelT (elab_typ env typ1, relop, elab_typ env typ2) @@ typ.at
  | BrackT (brackop, typs) ->
    BrackT (brackop, List.map (elab_typ env) typs) @@ typ.at
  | IterT (typ1, iter) ->
    match iter with
    | List1 | ListN _ -> error typ.at "illegal iterator for types"
    | _ -> IterT (elab_typ env typ1, elab_iter env iter) @@ typ.at

and elab_deftyp env deftyp : deftyp =
  match deftyp.it with
  | AliasT typ ->
    AliasT (elab_typ env typ) @@ deftyp.at
  | StructT fields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) fields deftyp.at;
    StructT (List.map (elab_typfield env) fields) @@ deftyp.at
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let deftypI = find "syntax type" env.typs id in
      if deftypI = fwd_deftyp_ok || deftypI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (as_variant_typid "parent" env) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' deftyp.at;
    VariantT (ids, List.map (elab_typcase env) cases) @@ deftyp.at


and elab_typfield env (atom, typ, hints) : typfield =
  (atom, elab_typ env typ, hints)

and elab_typcase env (atom, typs, hints) : typcase =
  (atom, List.map (elab_typ env) typs, hints)


(* Expressions *)

and prefix_id id =
  match String.index_opt id.it '_', String.index_opt id.it '\'' with
  | None, None -> id
  | None, Some n | Some n, None -> String.sub id.it 0 n @@ id.at
  | Some n1, Some n2 -> String.sub id.it 0 (min n1 n2) @@ id.at

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
  | StrE expfields -> StrT (List.map (infer_expfield env) expfields) @@ exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    find_field typfields atom exp1.at
  | SeqE exps -> SeqT (List.map (infer_exp env) exps) @@ exp.at
  | TupE exps -> TupT (List.map (infer_exp env) exps) @@ exp.at
  | ParenE exp1 -> ParenT (infer_exp env exp1) @@ exp.at
  | CallE (id, _) -> snd (find "function" env.defs id)
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

and infer_expfield env (atom, exp) : typfield =
  (atom, infer_exp env exp, [])


and elab_exp env exp typ : exp =
  (*
  Printf.printf "[elab %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  match exp.it with
  | ParenE exp1 when is_iter_typ env typ ->
    let typ1, _ = as_iter_typ "" env Check typ exp.at in
    let exp' = elab_exp env exp1 typ1 in
    cast_exp "expression" env exp' typ1 typ
  | _ ->
    elab_exp' env exp typ

and elab_exp' env exp typ : exp =
  match exp.it with
  | AtomE atom when is_variant_typ env typ ->
    let cases = as_variant_typ "" env Check typ exp.at in
    let typs = find_case cases atom exp.at in
    let exp' = elab_exp_seq env [] (SeqT typs @@ typ.at) exp.at in
    CaseE (atom, unseq_exp exp') @@ exp.at
  | VarE _ | AtomE _ | BoolE _ | NatE _ | TextE _ ->
    let typ' = infer_exp env exp in
    cast_exp "expression" env exp typ' typ
  | UnE (unop, exp1) ->
    let typ' = infer_unop unop @@ exp.at in
    let exp1' = elab_exp env exp1 typ' in
    let exp' = UnE (unop, exp1') @@ exp.at in
    cast_exp "unary operator" env exp' typ' typ
  | BinE (exp1, binop, exp2) ->
    let typ' = infer_binop binop @@ exp.at in
    let exp1' = elab_exp env exp1 typ' in
    let exp2' = elab_exp env exp2 typ' in
    let exp' = BinE (exp1', binop, exp2') @@ exp.at in
    cast_exp "binary operator" env exp' typ' typ
  | CmpE (exp1, cmpop, exp2) ->
    let typ' =
      match infer_cmpop cmpop with
      | Some typ' -> typ' @@ exp.at
      | None -> infer_exp env exp1
    in
    let exp1' = elab_exp env exp1 typ' in
    let exp' =
      match exp2.it with
      | CmpE (exp21, _, _) ->
        let exp21' = elab_exp env exp21 typ' in
        let exp2' = elab_exp env exp2 (BoolT @@ exp2.at) in
        BinE (CmpE (exp1', cmpop, exp21') @@ exp1.at, AndOp, exp2') @@ exp.at
      | _ ->
        let exp2' = elab_exp env exp2 typ' in
        CmpE (exp1', cmpop, exp2') @@ exp.at
    in
    cast_exp "comparison operator" env exp' (BoolT @@ exp.at) typ
  | SeqE exps ->
    elab_exp_seq env exps typ exp.at
  | IdxE (exp1, exp2) ->
    let typ1 = infer_exp env exp1 in
    let typ' = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = elab_exp' env exp1 typ1 in
    let exp2' = elab_exp env exp2 (NatT @@ exp2.at) in
    let exp' = IdxE (exp1', exp2') @@ exp.at in
    cast_exp "list element" env exp' typ' typ
  | SliceE (exp1, exp2, exp3) ->
    let _typ' = as_list_typ "expression" env Check typ exp1.at in
    let exp1' = elab_exp' env exp1 typ in
    let exp2' = elab_exp env exp2 (NatT @@ exp2.at) in
    let exp3' = elab_exp env exp3 (NatT @@ exp3.at) in
    SliceE (exp1', exp2', exp3') @@ exp.at
  | UpdE (exp1, path, exp2) ->
    let exp1' = elab_exp' env exp1 typ in
    let path', typ2 = elab_path env path typ in
    let exp2' = elab_exp env exp2 typ2 in
    UpdE (exp1', path', exp2') @@ exp.at
  | ExtE (exp1, path, exp2) ->
    let exp1' = elab_exp' env exp1 typ in
    let path', typ2 = elab_path env path typ in
    let _typ21 = as_list_typ "path" env Check typ2 path.at in
    let exp2' = elab_exp env exp2 typ2 in
    ExtE (exp1', path', exp2') @@ exp.at
  | StrE expfields ->
    let typfields = as_struct_typ "record" env Check typ exp.at in
    let fields' = elab_expfields env expfields typfields exp.at in
    StrE fields' @@ exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    let exp1' = elab_exp' env exp1 typ1 in
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    let typ' = find_field typfields atom exp1.at in
    let exp' = DotE (exp1', atom) @@ exp.at in
    cast_exp "field" env exp' typ' typ
  | CommaE (exp1, exp2) ->
    let exp1' = elab_exp env exp1 typ in
    let typfields = as_struct_typ "expression" env Check typ exp1.at in
    (* TODO: this is a bit of a hack *)
    (match exp2.it with
    | SeqE ({it = AtomE atom; at} :: exps2) ->
      let _typ2 = find_field typfields atom at in
      let exp2 = match exps2 with [exp2] -> exp2 | _ -> SeqE exps2 @@ exp2.at in
      let exp2' = elab_exp' env (StrE [(atom, exp2)] @@ exp2.at) typ in
      CompE (exp1', exp2') @@ exp.at
    | _ -> failwith "unimplemented check CommaE"
    )
  | CompE (exp1, exp2) ->
    let _ = as_struct_typ "record" env Check typ exp.at in
    let exp1' = elab_exp env exp1 typ in
    let exp2' = elab_exp env exp2 typ in
    CompE (exp1', exp2') @@ exp.at
  | LenE exp1 ->
    let typ1 = infer_exp env exp1 in
    let _typ11 = as_list_typ "expression" env Infer typ1 exp1.at in
    let exp1' = elab_exp env exp1 typ1 in
    let exp' = LenE exp1' @@ exp.at in
    cast_exp "list length" env exp' (NatT @@ exp.at) typ
  | ParenE exp1 ->
    elab_exp env exp1 typ
  | TupE exps ->
    let typs = as_tup_typ "tuple" env Check typ exp.at in
    let exps' = elab_exps env exps typs exp.at in
    TupE exps' @@ exp.at
  | CallE (id, exp2) ->
    let typ2, typ' = find "function" env.defs id in
    let exp2' = elab_exp' env exp2 typ2 in
    let exp' = CallE (id, exp2') @@ exp.at in
    cast_exp "expression" env exp' typ' typ
  | RelE (exp1, relop, exp2) ->
    let typ1, typ2 = as_rel_typ relop "relation" env Check typ exp.at in
    let exp1' = elab_exp env exp1 typ1 in
    let exp2' = elab_exp env exp2 typ2 in
    RelE (exp1', relop, exp2') @@ exp.at
  | BrackE (brackop, exps) ->
    let typs = as_brack_typ brackop "bracket" env Check typ exp.at in
    let exps' = elab_exps env exps typs exp.at in
    BrackE (brackop, exps') @@ exp.at
  | IterE (exp1, iter2) ->
    let typ1, _iter = as_iter_typ "iteration" env Check typ exp.at in
    let exp1' = elab_exp' env exp1 typ1 in
    let iter2' = elab_iter env iter2 in
    IterE (exp1', iter2') @@ exp.at
  | OptE _ | ListE _ | CatE _ | CaseE _ | SubE _ -> assert false
  | HoleE -> error exp.at "misplaced hole"
  | FuseE _ -> error exp.at "misplaced token fuse"

and elab_exps env exps typs at : exp list =
  if List.length exps <> List.length typs then
    error at "arity mismatch for expression list";
  List.map2 (elab_exp env) exps typs

and elab_expfields env expfields typfields at : expfield list =
  match expfields, typfields with
  | [], [] -> []
  | (atom1, exp)::expfields', (atom2, typ, _)::typfields' when atom1 = atom2 ->
    let exp' = elab_exp' env exp typ in
    (atom1, exp') :: elab_expfields env expfields' typfields' at
  | _, (atom, typ, _)::typfields' ->
    let exp' =
      cast_exp "omitted record field" env (SeqE [] @@ at) (SeqT [] @@ at) typ in
    (atom, exp') :: elab_expfields env expfields typfields' at
  | (atom, exp)::_, [] ->
    error exp.at ("unexpected record field " ^ string_of_atom atom)

and elab_path env path typ : path * typ =
  match path.it with
  | RootP ->
    RootP @@ path.at, typ
  | IdxP (path1, exp2) ->
    let path1', typ1 = elab_path env path1 typ in
    let exp2' = elab_exp env exp2 (NatT @@ exp2.at) in
    let typ' = as_list_typ "path" env Check typ1 path1.at in
    IdxP (path1', exp2') @@ path.at, typ'
  | DotP (path1, atom) ->
    let path1', typ1 = elab_path env path1 typ in
    let typfields = as_struct_typ "path" env Check typ1 path1.at in
    DotP (path1', atom) @@ path.at, find_field typfields atom path1.at

and elab_exp_seq env exps typ at : exp =
  match exps, expand env typ with
  | {it = AtomE atom; _} :: exps, _ when is_variant_typ env typ ->
    let cases = as_variant_typ "" env Check typ at in
    let typs = find_case cases atom at in
    let exp' = elab_exp_seq env exps (SeqT typs @@ typ.at) at in
    CaseE (atom, unseq_exp exp') @@ at

  | [], IterT (_, Opt) ->
    OptE None @@ at
  | [], IterT (_, List) ->
    ListE [] @@ at
  | ({it = ParenE _; _} as exp1)::exps2, IterT (typ1, _iter) ->
    let exp1' = elab_exp' env exp1 typ1 in
    let exp2' = elab_exp_seq env exps2 typ at in
    cons_exp exp1' exp2' @@ at
  | exp1::exps2, IterT (_, (List | List1)) ->
    let exp1' = elab_exp' env exp1 typ in
    let exp2' = elab_exp_seq env exps2 typ at in
    CatE (exp1', exp2') @@ at
  | _, IterT _ ->
    error at ("sequence does not match expected iteration type `" ^
      string_of_typ typ ^ "`")

  | [], SeqT [] -> SeqE [] @@ at
  | [exp1], SeqT [typ1] -> SeqE [elab_exp' env exp1 typ1] @@ at
  | [exp1], _ -> SeqE [elab_exp' env exp1 typ] @@ at
  | _, SeqT [typ1] -> SeqE [elab_exp' env (SeqE exps @@ at) typ1] @@ at
  | [], SeqT (typ1::typs) ->
    let exp1' = cast_exp "empty tail" env (SeqE [] @@ at) (SeqT [] @@ at) typ1 in
    seq_exp exp1' (elab_exp_seq env [] (SeqT typs @@ typ.at) at) @@ at
  | exp1::exps2, SeqT (typ1::typs2) ->
    let exp1' = elab_exp' env exp1 typ1 in
    seq_exp exp1' (elab_exp_seq env exps2 (SeqT typs2 @@ typ.at) at) @@ at
  | exp1::_, SeqT [] ->
    error exp1.at "unexpected element at end of sequence"

  | _, _ ->
    error at ("sequence does not match expected type `" ^
      string_of_typ typ ^ "`")

and seq_exp exp1 exp2 =
  match exp2.it with
  | SeqE exps2 -> SeqE (exp1 :: exps2)
  | _ -> SeqE [exp1; exp2]

and unseq_exp exp =
  match exp.it with
  | SeqE exps -> exps
  | _ -> assert false

and cons_exp exp1 exp2 =
  match exp2.it with
  | ListE exps2 -> ListE (exp1 :: exps2)
  | _ -> CatE (ListE [exp1] @@ exp1.at, exp2)


and cast_exp phrase env exp typ1 typ2 : exp =
  (*
  Printf.printf "[cast %s] (%s) <: (%s)  >>  (%s) <: (%s)  eq=%b\n%!"
    (string_of_region exp.at)
    (string_of_typ typ1) (string_of_typ typ2)
    (string_of_typ (expand env typ1 @@ typ1.at))
    (string_of_typ (expand env typ2 @@ typ2.at))
    (equiv_typ env typ1 typ2);
  *)
  if equiv_typ env typ1 typ2 then exp else
  match expand env typ1, expand env typ2 with
  | SeqT [], IterT (_typ21, Opt) ->
    OptE None @@ exp.at
  | SeqT [], IterT (_typ21, List) ->
    ListE [] @@ exp.at
  | _typ1', IterT (typ21, Opt) ->
    OptE (Some (cast_exp_variant phrase env exp typ1 typ21)) @@ exp.at
  | _typ1', IterT (typ21, (List | List1)) ->
    ListE [cast_exp_variant phrase env exp typ1 typ21] @@ exp.at
  | _, _ ->
    cast_exp_variant phrase env exp typ1 typ2

and cast_exp_variant phrase env exp typ1 typ2 : exp =
  if equiv_typ env typ1 typ2 then exp else
  match expand env typ1, expand env typ2 with
  | _, _ when is_variant_typ env typ1 && is_variant_typ env typ2 ->
    let cases1 = as_variant_typ "" env Check typ1 exp.at in
    let cases2 = as_variant_typ "" env Check typ2 exp.at in
    (try
      List.iter (fun (atom, typs1, _) ->
        let typs2 = find_case cases2 atom typ1.at in
        (* Shallow subtyping on variants *)
        if List.length typs1 <> List.length typs2
        || not (List.for_all2 Eq.eq_typ typs1 typs2) then
          error exp.at ("type mismatch for case `" ^ string_of_atom atom ^ "`")
      ) cases1
    with Error (_, msg) ->
      error exp.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
        "does not match expected type `" ^ string_of_typ typ2 ^ "`, " ^ msg)
    );
    SubE (exp, typ1, typ2) @@ exp.at
  | _, _ ->
    error exp.at (phrase ^ "'s type `" ^ string_of_typ typ1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ typ2 ^ "`")


(* Definitions *)

let elab_prem env prem : premise =
  match prem.it with
  | RulePr (id, exp, iter_opt) ->
    let typ = find "relation" env.rels id in
    let exp' = elab_exp env exp typ in
    let iter_opt' = Option.map (elab_iter env) iter_opt in
    RulePr (id, exp', iter_opt') @@ prem.at
  | IffPr (exp, iter_opt) ->
    let exp' = elab_exp env exp (BoolT @@ exp.at) in
    let iter_opt' = Option.map (elab_iter env) iter_opt in
    IffPr (exp', iter_opt') @@ prem.at
  | ElsePr ->
    ElsePr @@ prem.at


let infer_def env def =
  match def.it with
  | SynD (id, deftyp, _) ->
    let fwd_deftyp =
      match deftyp.it with AliasT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax" env.typs id fwd_deftyp
  | _ -> ()

let elab_def env def : def =
  match def.it with
  | SynD (id, deftyp, hints) ->
    let deftyp' = elab_deftyp env deftyp in
    env.typs <- rebind "syntax" env.typs id deftyp';
    env.vars <- bind "variable" env.vars id (VarT id @@ id.at);
    SynD (id, deftyp', hints) @@ def.at
  | RelD (id, typ, hints) ->
    let typ' = elab_typ env typ in
    env.rels <- bind "relation" env.rels id typ';
    RelD (id, typ', hints) @@ def.at
  | RuleD (id1, id2, exp, prems) ->
    let typ = find "relation" env.rels id1 in
    let exp' = elab_exp env exp typ in
    let prems' = List.map (elab_prem env) prems in
    RuleD (id1, id2, exp', prems') @@ def.at
  | VarD (id, typ, hints) ->
    let typ' = elab_typ env typ in
    env.vars <- bind "variable" env.vars id typ';
    VarD (id, typ', hints) @@ def.at
  | DecD (id, exp1, typ2, hints) ->
    let typ1' = infer_exp env exp1 in
    let exp1' = elab_exp' env exp1 typ1' in
    let typ2' = elab_typ env typ2 in
    env.defs <- bind "function" env.defs id (typ1', typ2');
    DecD (id, exp1', typ2', hints) @@ def.at
  | DefD (id, exp1, exp2, premo) ->
    let typ1, typ2 = find "function" env.defs id in
    let exp1' = elab_exp' env exp1 typ1 in
    let exp2' = elab_exp env exp2 typ2 in
    let premo' = Option.map (elab_prem env) premo in
    let free =
      Free.(Set.elements (Set.diff (free_exp exp2).varid (free_exp exp1).varid)) in
    if free <> [] then
      error def.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" free ^ "`");
    DefD (id, exp1', exp2', premo') @@ def.at


(* Scripts *)

let elab defs =
  let env = new_env () in
  List.iter (infer_def env) defs;
  List.map (elab_def env) defs
