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

let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left union empty (map free_x xs))

let free_nl_elem free_x = function Nl -> empty | Elem x -> free_x x
let free_nl_list free_x xs = List.(fold_left union empty (map (free_nl_elem free_x) xs))


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
  | ParenT typ1 -> free_typ typ1
  | TupT typs -> free_list free_typ typs
  | IterT (typ1, iter) -> union (free_typ typ1) (free_iter iter)
  | AtomT _ -> empty
  | SeqT typs -> free_list free_typ typs
  | InfixT (typ1, _, typ2) -> free_list free_typ [typ1; typ2]
  | BrackT (_, typ1) -> free_typ typ1

and free_deftyp deftyp =
  match deftyp.it with
  | NotationT typ -> free_typ typ
  | StructT typfields -> free_nl_list free_typfield typfields
  | VariantT (_, ids, typcases, _) ->
    union (free_nl_list free_synid ids) (free_nl_list free_typcase typcases)

and free_typfield (_, typ, _) = free_typ typ
and free_typcase (_, typs, _) = free_list free_typ typs


(* Expressions *)

and free_exp exp =
  match exp.it with
  | VarE id -> free_varid id
  | AtomE _ | BoolE _ | NatE _ | TextE _ | EpsE | HoleE _ -> empty
  | UnE (_, exp1) | DotE (exp1, _) | LenE exp1
  | ParenE (exp1, _) | BrackE (_, exp1) -> free_exp exp1
  | BinE (exp1, _, exp2) | CmpE (exp1, _, exp2)
  | IdxE (exp1, exp2) | CommaE (exp1, exp2) | CompE (exp1, exp2)
  | InfixE (exp1, _, exp2) | FuseE (exp1, exp2) ->
    free_list free_exp [exp1; exp2]
  | SliceE (exp1, exp2, exp3) -> free_list free_exp [exp1; exp2; exp3]
  | SeqE exps | TupE exps -> free_list free_exp exps
  | UpdE (exp1, path, exp2) | ExtE (exp1, path, exp2) ->
    union (free_list free_exp [exp1; exp2]) (free_path path)
  | StrE expfields -> free_nl_list free_expfield expfields
  | CallE (id, exp1) -> union (free_defid id) (free_exp exp1)
  | IterE (exp1, iter) -> union (free_exp exp1) (free_iter iter)

and free_expfield (_, exp) = free_exp exp

and free_path path =
  match path.it with
  | RootP -> empty
  | IdxP (path1, exp) -> union (free_path path1) (free_exp exp)
  | DotP (path1, _) -> free_path path1


(* Definitions *)

let free_prem prem =
  match prem.it with
  | RulePr (id, exp, itero) ->
    union (free_relid id) (union (free_exp exp) (free_opt free_iter itero))
  | IfPr (exp, itero) -> union (free_exp exp) (free_opt free_iter itero)
  | ElsePr -> empty

let free_def def =
  match def.it with
  | SynD (_id1, _id2, deftyp, _hints) -> free_deftyp deftyp
  | VarD _ | SepD -> empty
  | RelD (_id, typ, _hints) -> free_typ typ
  | RuleD (id1, _id2, exp, prems) ->
    union (free_relid id1) (union (free_exp exp) (free_nl_list free_prem prems))
  | DecD (_id, exp, typ, _hints) -> union (free_exp exp) (free_typ typ)
  | DefD (id, exp1, exp2, prems) ->
    union
      (union (free_defid id) (free_exp exp1))
      (union (free_exp exp2) (free_nl_list free_prem prems))
