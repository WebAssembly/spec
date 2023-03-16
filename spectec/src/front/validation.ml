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

let new_env () =
  { vars = Env.empty;
    typs = Env.empty;
    rels = Env.empty;
    defs = Env.empty;
  }

let fwd_deftyp id = AliasT (VarT (id @@ no_region) @@ no_region) @@ no_region
let fwd_deftyp_bad = fwd_deftyp "(undefined)"
let fwd_deftyp_ok = fwd_deftyp "(forward)"

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

let match_iter iter1 iter2 =
  iter2 = List || Eq.eq_iter iter1 iter2

let as_iter_typ iter phrase env dir typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, iter2) when match_iter iter iter2 -> typ1
  | _ -> as_error at phrase dir typ ("(_)" ^ string_of_iter iter)

let as_list_typ phrase env dir typ at : typ =
  match expand' env typ.it with
  | IterT (typ1, (List | List1 | ListN _)) -> typ1
  | _ -> as_error at phrase dir typ "(_)*"

let as_seq_typ phrase env dir typ at : typ list =
  match expand_singular' env typ.it with
  | SeqT typs -> typs
  | _ -> as_error at phrase dir typ "(_ ... _)"

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

let equiv_typ env typ1 typ2 at =
  if not (equiv_typ env typ1 typ2) then
    error at ("expression's type `" ^ string_of_typ typ1 ^ "` " ^
      "does not match expected type `" ^ string_of_typ typ2 ^ "`")


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

let valid_list valid_x_y env xs ys at =
  if List.length xs <> List.length ys then
    error at ("arity mismatch for expression list");
  List.iter2 (valid_x_y env) xs ys


let rec valid_iter env iter =
  match iter with
  | Opt | List | List1 -> ()
  | ListN exp -> valid_exp env exp (NatT @@ exp.at)


(* Types *)

and valid_typ env typ =
  match typ.it with
  | VarT id ->
    if find "syntax type" env.typs id = fwd_deftyp_bad then
      error typ.at ("invalid forward reference to syntax type `" ^ id.it ^ "`")
  | AtomT _
  | BoolT
  | NatT
  | TextT ->
    ()
  | SeqT typs ->
    List.iter (valid_typ env) typs
  | StrT typfields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) typfields typ.at;
    List.iter (valid_typfield env) typfields
  | ParenT typ1 ->
    valid_typ env typ1
  | TupT typs ->
    List.iter (valid_typ env) typs
  | RelT (typ1, _relop, typ2) ->
    valid_typ env typ1; valid_typ env typ2
  | BrackT (_brackop, typs) ->
    List.iter (valid_typ env) typs
  | IterT (typ1, iter) ->
    match iter with
    | ListN exp -> error exp.at "definite iterator not allowed in type"
    | _ -> valid_typ env typ1; valid_iter env iter

and valid_deftyp env deftyp =
  match deftyp.it with
  | AliasT typ ->
    valid_typ env typ
  | StructT fields ->
    check_atoms "record" "field" (fun (atom, _, _) -> atom) fields deftyp.at;
    List.iter (valid_typfield env) fields
  | VariantT (ids, cases) ->
    List.iter (fun id ->
      let deftypI = find "syntax type" env.typs id in
      if deftypI = fwd_deftyp_ok || deftypI = fwd_deftyp_bad then
        error id.at ("invalid forward reference to syntax type `" ^ id.it ^ "`");
    ) ids;
    let casess = List.map (as_variant_typid "parent" env) ids in
    let cases' = List.flatten (cases::casess) in
    check_atoms "variant" "case" (fun (atom, _, _) -> atom) cases' deftyp.at;
    List.iter (valid_typcase env) cases

and valid_typfield env (_atom, typ, _hints) = valid_typ env typ
and valid_typcase env (_atom, typs, _hints) = List.iter (valid_typ env) typs


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
  | ParenE exp1 -> infer_exp env exp1
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


and valid_exp env exp typ =
  (*
  Printf.printf "[valid %s] %s  :  %s\n%!"
    (string_of_region exp.at) (string_of_exp exp) (string_of_typ typ);
  *)
  match exp.it with
  | VarE _ | AtomE _ | BoolE _ | NatE _ | TextE _ ->
    let typ' = infer_exp env exp in
    equiv_typ env typ' typ exp.at
  | UnE (unop, exp1) ->
    let typ' = infer_unop unop @@ exp.at in
    valid_exp env exp1 typ';
    equiv_typ env typ' typ exp.at
  | BinE (exp1, binop, exp2) ->
    let typ' = infer_binop binop @@ exp.at in
    valid_exp env exp1 typ';
    valid_exp env exp2 typ';
    equiv_typ env typ' typ exp.at
  | CmpE (exp1, cmpop, exp2) ->
    let typ' =
      match infer_cmpop cmpop with
      | Some typ' -> typ' @@ exp.at
      | None -> infer_exp env exp1
    in
    valid_exp env exp1 typ';
    valid_exp env exp2 typ';
    equiv_typ env (BoolT @@ exp.at) typ exp.at
  | SeqE exps ->
    let typs = as_seq_typ "sequence" env Check typ exp.at in
    valid_list valid_exp env exps typs exp.at
  | IdxE (exp1, exp2) ->
    let typ1 = infer_exp env exp1 in
    let typ' = as_list_typ "expression" env Infer typ1 exp1.at in
    valid_exp env exp1 typ1;
    valid_exp env exp2 (NatT @@ exp2.at);
    equiv_typ env typ' typ exp.at
  | SliceE (exp1, exp2, exp3) ->
    let _typ' = as_list_typ "expression" env Check typ exp1.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 (NatT @@ exp2.at);
    valid_exp env exp3 (NatT @@ exp3.at)
  | UpdE (exp1, path, exp2) ->
    valid_exp env exp1 typ;
    let typ2 = valid_path env path typ in
    valid_exp env exp2 typ2
  | ExtE (exp1, path, exp2) ->
    valid_exp env exp1 typ;
    let typ2 = valid_path env path typ in
    let _typ21 = as_list_typ "path" env Check typ2 path.at in
    valid_exp env exp2 typ2
  | StrE expfields ->
    let typfields = as_struct_typ "record" env Check typ exp.at in
    valid_list valid_expfield env expfields typfields exp.at
  | DotE (exp1, atom) ->
    let typ1 = infer_exp env exp1 in
    valid_exp env exp1 typ1;
    let typfields = as_struct_typ "expression" env Infer typ1 exp1.at in
    let typ' = find_field typfields atom exp1.at in
    equiv_typ env typ' typ exp.at
  | CommaE (_exp1, _exp2) ->
    error exp.at "invalid use of comma expression"
  | CompE (exp1, exp2) ->
    let _ = as_struct_typ "record" env Check typ exp.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 typ
  | LenE exp1 ->
    let typ1 = infer_exp env exp1 in
    let _typ11 = as_list_typ "expression" env Infer typ1 exp1.at in
    valid_exp env exp1 typ1;
    equiv_typ env (NatT @@ exp.at) typ exp.at
  | ParenE exp1 ->
    valid_exp env exp1 typ
  | TupE exps ->
    let typs = as_tup_typ "tuple" env Check typ exp.at in
    valid_list valid_exp env exps typs exp.at
  | CallE (id, exp2) ->
    let typ2, typ' = find "function" env.defs id in
    valid_exp env exp2 typ2;
    equiv_typ env typ' typ exp.at
  | RelE (exp1, relop, exp2) ->
    let typ1, typ2 = as_rel_typ relop "relation" env Check typ exp.at in
    valid_exp env exp1 typ1;
    valid_exp env exp2 typ2
  | BrackE (brackop, exps) ->
    let typs = as_brack_typ brackop "bracket" env Check typ exp.at in
    valid_list valid_exp env exps typs exp.at
  | IterE (exp1, iter) ->
    valid_iter env iter;
    let typ1 = as_iter_typ iter "iteration" env Check typ exp.at in
    valid_exp env exp1 typ1
  | OptE expo ->
    let typ1 = as_iter_typ Opt "option" env Check typ exp.at in
    Option.iter (fun exp1 -> valid_exp env exp1 typ1) expo
  | ListE exps ->
    let typ1 = as_iter_typ List "list" env Check typ exp.at in
    List.iter (fun expI -> valid_exp env expI typ1) exps
  | CatE (exp1, exp2) ->
    let _typ1 = as_iter_typ List "list" env Check typ exp.at in
    valid_exp env exp1 typ;
    valid_exp env exp2 typ
  | CaseE (atom, exps) ->
    let cases = as_variant_typ "" env Check typ exp.at in
    let typs = find_case cases atom exp.at in
    valid_list valid_exp env exps typs exp.at
  | SubE (exp1, typ1, typ2) ->
    valid_typ env typ1;
    valid_typ env typ2;
    valid_exp env exp1 typ1;
    equiv_typ env typ2 typ exp.at
  | HoleE -> error exp.at "misplaced hole"
  | FuseE _ -> error exp.at "misplaced token fuse"

and valid_expfield env (atom1, exp) (atom2, typ, _) =
  if atom1 <> atom2 then error exp.at "unepxected record field";
  valid_exp env exp typ

and valid_path env path typ : typ =
  match path.it with
  | RootP -> typ
  | IdxP (path1, exp2) ->
    let typ1 = valid_path env path1 typ in
    valid_exp env exp2 (NatT @@ exp2.at);
    as_list_typ "path" env Check typ1 path1.at
  | DotP (path1, atom) ->
    let typ1 = valid_path env path1 typ in
    let typfields = as_struct_typ "path" env Check typ1 path1.at in
    find_field typfields atom path1.at


(* Definitions *)

let valid_prem env prem =
  match prem.it with
  | RulePr (id, exp, iter_opt) ->
    valid_exp env exp (find "relation" env.rels id);
    Option.iter (valid_iter env) iter_opt
  | IffPr (exp, iter_opt) ->
    valid_exp env exp (BoolT @@ exp.at);
    Option.iter (valid_iter env) iter_opt
  | ElsePr ->
    ()


let infer_def env def =
  match def.it with
  | SynD (id, deftyp, _) ->
    let fwd_deftyp =
      match deftyp.it with AliasT _ -> fwd_deftyp_bad | _ -> fwd_deftyp_ok in
    env.typs <- bind "syntax" env.typs id fwd_deftyp
  | _ -> ()

let valid_def env def =
  match def.it with
  | SynD (id, deftyp, _hints) ->
    valid_deftyp env deftyp;
    env.typs <- rebind "syntax" env.typs id deftyp;
    env.vars <- bind "variable" env.vars id (VarT id @@ id.at)
  | RelD (id, typ, _hints) ->
    valid_typ env typ;
    env.rels <- bind "relation" env.rels id typ
  | RuleD (id, _ids, exp, prems) ->
    valid_exp env exp (find "relation" env.rels id);
    List.iter (valid_prem env) prems
  | VarD (id, typ, _hints) ->
    valid_typ env typ;
    env.vars <- bind "variable" env.vars id typ
  | DecD (id, exp1, typ2, _hints) ->
    let typ1 = infer_exp env exp1 in
    valid_exp env exp1 typ1;
    valid_typ env typ2;
    env.defs <- bind "function" env.defs id (typ1, typ2)
  | DefD (id, exp1, exp2, premo) ->
    let typ1, typ2 = find "function" env.defs id in
    valid_exp env exp1 typ1;
    valid_exp env exp2 typ2;
    Option.iter (valid_prem env) premo;
    let free = Free.(Set.elements (Set.diff (free_exp exp2) (free_exp exp1))) in
    if free <> [] then
      error def.at ("definition contains unbound variable(s) `" ^
        String.concat "`, `" free ^ "`")


(* Scripts *)

let valid defs =
  let env = new_env () in
  List.iter (infer_def env) defs;
  List.iter (valid_def env) defs
