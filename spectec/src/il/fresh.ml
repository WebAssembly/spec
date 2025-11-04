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
