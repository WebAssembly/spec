open Ast
open Util.Source

module Map = Map.Make(String)

let typids = ref Map.empty
let varids = ref Map.empty
let defids = ref Map.empty
let gramids = ref Map.empty

let fresh_id map s =
  if s = "_" then s else
  let i =
    match Map.find_opt s !map with
    | None -> 1
    | Some i -> i + 1
  in
  map := Map.add s i !map;
  s ^ "#" ^ string_of_int i

let refresh_id map x = fresh_id map x.it $ x.at

let fresh_typid = fresh_id typids
let fresh_varid = fresh_id varids
let fresh_defid = fresh_id defids
let fresh_gramid = fresh_id gramids

let refresh_typid = refresh_id typids
let refresh_varid = refresh_id varids
let refresh_defid = refresh_id defids
let refresh_gramid = refresh_id gramids


let refresh_quant s q =
  match q.it with
  | ExpP (x, t) ->
    let x' = refresh_varid x in
    let t' = Subst.subst_typ s t in
    let s' = Subst.add_varid s x (VarE x' $$ x.at % t') in
    s', ExpP (x', t') $ q.at
  | TypP x ->
    let x' = refresh_typid x in
    let s' = Subst.add_typid s x (VarT (x', []) $ x.at) in
    s', TypP x' $ q.at
  | DefP (x, ps, t) ->
    let x' = refresh_defid x in
    let ps', s' = Subst.subst_params s ps in
    let t' = Subst.subst_typ s' t in
    let s' = Subst.add_defid s x x' in
    s', DefP (x', ps', t') $ q.at
  | GramP (x, ps, t) ->
    let x' = refresh_gramid x in
    let ps', s' = Subst.subst_params s ps in
    let t' = Subst.subst_typ s' t in
    let s' = Subst.add_gramid s x (VarG (x', []) $ x.at) in
    s', GramP (x', ps', t') $ q.at

let refresh_quants qs =
  let s, qs' = List.fold_left_map refresh_quant Subst.empty qs in qs', s
