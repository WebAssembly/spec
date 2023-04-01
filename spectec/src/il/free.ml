open Util.Source
open Ast


(* Data Structure *)

module Set = Set.Make(String)

type sets = {synid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t}

let empty =
  {synid = Set.empty; relid = Set.empty; varid = Set.empty; defid = Set.empty}

let union sets1 sets2 =
  { synid = Set.union sets1.synid sets2.synid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
  }

let diff sets1 sets2 =
  { synid = Set.diff sets1.synid sets2.synid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
  }

let subset sets1 sets2 =
  Set.subset sets1.synid sets2.synid &&
  Set.subset sets1.relid sets2.relid &&
  Set.subset sets1.varid sets2.varid &&
  Set.subset sets1.defid sets2.defid


let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left union empty (map free_x xs))


(* Identifiers *)

let free_synid id = {empty with synid = Set.singleton id.it}
let free_relid id = {empty with relid = Set.singleton id.it}
let free_varid id = {empty with varid = Set.singleton id.it}
let free_defid id = {empty with defid = Set.singleton id.it}


(* Iterations *)

let rec free_iter iter =
  match iter with
  | Opt | List | List1 -> empty
  | ListN exp -> free_exp exp


(* Types *)

and free_typ typ =
  match typ.it with
  | VarT id -> free_synid id
  | BoolT | NatT | TextT -> empty
  | TupT typs -> free_list free_typ typs
  | IterT (typ1, iter) -> union (free_typ typ1) (free_iter iter)

and free_deftyp deftyp =
  match deftyp.it with
  | NotationT (_, typ) -> free_typ typ
  | StructT typfields -> free_list free_typfield typfields
  | VariantT (ids, typcases) ->
    union (free_list free_synid ids) (free_list free_typcase typcases)

and free_typfield (_, typ, _) = free_typ typ
and free_typcase (_, typ, _) = free_typ typ


(* Expressions *)

and free_exp exp =
  match exp.it with
  | VarE id -> free_varid id
  | BoolE _ | NatE _ | TextE _ -> empty
  | UnE (_, exp1) | DotE (exp1, _)
  | LenE exp1 | MixE (_, exp1) | SubE (exp1, _, _) ->
    free_exp exp1
  | BinE (_, exp1, exp2) | CmpE (_, exp1, exp2)
  | IdxE (exp1, exp2) | CompE (exp1, exp2) | CatE (exp1, exp2) ->
    free_list free_exp [exp1; exp2]
  | SliceE (exp1, exp2, exp3) -> free_list free_exp [exp1; exp2; exp3]
  | OptE expo -> free_opt free_exp expo
  | TupE exps | ListE exps ->
    free_list free_exp exps
  | UpdE (exp1, path, exp2) | ExtE (exp1, path, exp2) ->
    union (free_list free_exp [exp1; exp2]) (free_path path)
  | StrE expfields -> free_list free_expfield expfields
  | CallE (id, exp1) -> union (free_defid id) (free_exp exp1)
  | IterE (exp1, iter) -> union (free_exp exp1) (free_iter iter)
  | CaseE (_, exp1, typ) -> union (free_exp exp1) (free_typ typ)

and free_expfield (_, exp) = free_exp exp

and free_path path =
  match path.it with
  | RootP -> empty
  | IdxP (path1, exp) -> union (free_path path1) (free_exp exp)
  | DotP (path1, _) -> free_path path1


(* Definitions *)

let bound_bind (id, _typ) = free_varid id
let bound_binds binds = free_list bound_bind binds

let free_bind (_id, typ) = free_typ typ
let free_binds binds = free_list free_bind binds

let free_prem prem =
  match prem.it with
  | RulePr (id, _mixop, exp, itero) ->
    union (free_relid id) (union (free_exp exp) (free_opt free_iter itero))
  | IffPr (exp, itero) -> union (free_exp exp) (free_opt free_iter itero)
  | ElsePr -> empty

let free_rule rule =
  match rule.it with
  | RuleD (_id, binds, _mixop, exp, prems) ->
    union (free_binds binds)
      (diff
        (union (free_exp exp) (free_list free_prem prems))
        (bound_binds binds)
      )

let free_clause clause =
  match clause.it with
  | DefD (binds, exp1, exp2, prems) ->
    union (free_binds binds)
      (diff
        (union (free_list free_exp [exp1; exp2]) (free_list free_prem prems))
        (bound_binds binds)
      )

let rec free_def def =
  match def.it with
  | SynD (_id, deftyp, _hints) -> free_deftyp deftyp
  | RelD (_id, _mixop, typ, rules, _hints) ->
    union (free_typ typ) (free_list free_rule rules)
  | DecD (_id, typ1, typ2, clauses, _hints) ->
    union (union (free_typ typ1) (free_typ typ2)) (free_list free_clause clauses)
  | RecD defs -> free_list free_def defs


let rec bound_def def =
  match def.it with
  | SynD (id, _, _) -> free_synid id
  | RelD (id, _, _, _, _) -> free_relid id
  | DecD (id, _, _, _, _) -> free_defid id
  | RecD defs -> free_list bound_def defs
