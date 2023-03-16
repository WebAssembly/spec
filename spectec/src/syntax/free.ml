open Ast
open Source


(* Generic *)

module Set = Set.Make(String)

let free_opt free_x xo =
  Option.value (Option.map free_x xo) ~default:Set.empty
let free_list free_x xs =
  List.fold_left Set.union Set.empty (List.map free_x xs)

let free_id id = Set.singleton id.it
let free_ignore _id = Set.empty


(* Types *)

let rec free_synid_typ typ =
  match typ.it with
  | VarT id -> free_id id
  | AtomT _ | BoolT | NatT | TextT -> Set.empty
  | ParenT typ -> free_synid_typ typ
  | SeqT typs | BrackT (_, typs) -> free_list free_synid_typ typs
  | StrT typfields -> free_list free_synid_typfield typfields
  | TupT typs -> free_list free_synid_typ typs
  | RelT (typ1, _, typ2) -> free_list free_synid_typ [typ1; typ2]
  | IterT (typ1, _) -> free_synid_typ typ1

and free_synid_typfield (_, typ, _) = free_synid_typ typ
and free_synid_typcase (_, typs, _) = free_list free_synid_typ typs

let free_synid_deftyp deftyp =
  match deftyp.it with
  | AliasT typ -> free_synid_typ typ
  | StructT typfields -> free_list free_synid_typfield typfields
  | VariantT (ids, typcases) ->
    Set.union (free_list free_id ids) (free_list free_synid_typcase typcases)


(* Expressions *)

let rec free_iter f g iter =
  match iter with
  | Opt | List | List1 -> Set.empty
  | ListN exp -> free_exp f g exp

and free_exp f g exp =
  match exp.it with
  | VarE id -> f id
  | AtomE _ | BoolE _ | NatE _ | TextE _ | HoleE -> Set.empty
  | UnE (_, exp1) | DotE (exp1, _) | LenE exp1
  | ParenE exp1 | SubE (exp1, _, _) -> free_exp f g exp1
  | BinE (exp1, _, exp2) | CmpE (exp1, _, exp2)
  | IdxE (exp1, exp2) | CommaE (exp1, exp2) | CompE (exp1, exp2)
  | RelE (exp1, _, exp2) | CatE (exp1, exp2) | FuseE (exp1, exp2) ->
    free_list (free_exp f g) [exp1; exp2]
  | SliceE (exp1, exp2, exp3) -> free_list (free_exp f g) [exp1; exp2; exp3]
  | OptE expo -> free_opt (free_exp f g) expo
  | SeqE exps | TupE exps | BrackE (_, exps) | ListE exps | CaseE (_, exps) ->
    free_list (free_exp f g) exps
  | UpdE (exp1, path, exp2) | ExtE (exp1, path, exp2) ->
    Set.union (free_list (free_exp f g) [exp1; exp2]) (free_path f g path)
  | StrE expfields -> free_list (free_expfield f g) expfields
  | CallE (id, exp1) -> Set.union (g id) (free_exp f g exp1)
  | IterE (exp1, iter) -> Set.union (free_exp f g exp1) (free_iter f g iter)

and free_expfield f g (_, exp) = free_exp f g exp

and free_path f g path =
  match path.it with
  | RootP -> Set.empty
  | IdxP (path1, exp) -> Set.union (free_path f g path1) (free_exp f g exp)
  | DotP (path1, _) -> free_path f g path1


let free_varid_iter = free_iter free_id free_ignore
let free_defid_iter = free_iter free_ignore free_id

let free_varid_exp = free_exp free_id free_ignore
let free_defid_exp = free_exp free_ignore free_id


(* Definitions *)

let free_varid_prem prem =
  match prem.it with
  | RulePr (_, exp, itero) | IffPr (exp, itero) ->
    Set.union (free_varid_exp exp) (free_opt free_varid_iter itero)
  | ElsePr -> Set.empty

let free_relid_prem prem =
  match prem.it with
  | RulePr (id, _, _) -> free_id id
  | IffPr _ | ElsePr -> Set.empty

let free_defid_prem prem =
  match prem.it with
  | RulePr (_, exp, itero) | IffPr (exp, itero) ->
    Set.union (free_defid_exp exp) (free_opt free_defid_iter itero)
  | ElsePr -> Set.empty

let free_relid_def def =
  match def.it with
  | RuleD (_id, _, _, prems) -> free_list free_relid_prem prems
  | DefD (_, _, _, premo) -> free_opt free_relid_prem premo
  | SynD _ | VarD _ | RelD _ | DecD _ -> Set.empty

let free_synid_def def =
  match def.it with
  | SynD (_, deftyp, _) -> free_synid_deftyp deftyp
  | RelD (_, typ, _) -> free_synid_typ typ
  | DecD (_, _, typ, _) -> free_synid_typ typ
  | VarD _ | RuleD _ | DefD _ -> Set.empty

let free_varid_def def =
  match def.it with
  | DecD (_, exp, _, _) -> free_varid_exp exp
  | DefD (_, exp1, exp2, premo) ->
    Set.union (free_list free_varid_exp [exp1; exp2]) (free_opt free_varid_prem premo)
  | RuleD (_, _, exp, prems) ->
    Set.union (free_varid_exp exp) (free_list free_varid_prem prems)
  | SynD _ | VarD _ | RelD _ -> Set.empty

let free_defid_def def =
  match def.it with
  | DecD (_, exp, _, _) -> free_defid_exp exp
  | DefD (_, exp1, exp2, premo) ->
    Set.union (free_list free_defid_exp [exp1; exp2]) (free_opt free_defid_prem premo)
  | RuleD (_, _, exp, prems) ->
    Set.union (free_defid_exp exp) (free_list free_defid_prem prems)
  | SynD _ | VarD _ | RelD _ -> Set.empty
