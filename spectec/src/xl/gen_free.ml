open Util.Source


(* Data Structure *)

module Set = Set.Make(String)

type id = string phrase

type sets =
  {typid : Set.t; relid : Set.t; varid : Set.t; defid : Set.t; gramid : Set.t}

let empty =
  { typid = Set.empty;
    relid = Set.empty;
    varid = Set.empty;
    defid = Set.empty;
    gramid = Set.empty
  }

let union sets1 sets2 =
  { typid = Set.union sets1.typid sets2.typid;
    relid = Set.union sets1.relid sets2.relid;
    varid = Set.union sets1.varid sets2.varid;
    defid = Set.union sets1.defid sets2.defid;
    gramid = Set.union sets1.gramid sets2.gramid;
  }

let inter sets1 sets2 =
  { typid = Set.inter sets1.typid sets2.typid;
    gramid = Set.inter sets1.gramid sets2.gramid;
    relid = Set.inter sets1.relid sets2.relid;
    varid = Set.inter sets1.varid sets2.varid;
    defid = Set.inter sets1.defid sets2.defid;
  }

let diff sets1 sets2 =
  { typid = Set.diff sets1.typid sets2.typid;
    relid = Set.diff sets1.relid sets2.relid;
    varid = Set.diff sets1.varid sets2.varid;
    defid = Set.diff sets1.defid sets2.defid;
    gramid = Set.diff sets1.gramid sets2.gramid;
  }

let ( ++ ) = union
let ( ** ) = inter
let ( -- ) = diff

let subset sets1 sets2 =
  Set.subset sets1.typid sets2.typid &&
  Set.subset sets1.relid sets2.relid &&
  Set.subset sets1.varid sets2.varid &&
  Set.subset sets1.defid sets2.defid &&
  Set.subset sets1.gramid sets2.gramid

let disjoint sets1 sets2 =
  Set.disjoint sets1.typid sets2.typid &&
  Set.disjoint sets1.relid sets2.relid &&
  Set.disjoint sets1.varid sets2.varid &&
  Set.disjoint sets1.defid sets2.defid &&
  Set.disjoint sets1.gramid sets2.gramid


(* Identifiers *)

let free_typid x = {empty with typid = Set.singleton x.it}
let free_relid x = {empty with relid = Set.singleton x.it}
let free_varid x = {empty with varid = Set.singleton x.it}
let free_defid x = {empty with defid = Set.singleton x.it}
let free_gramid x = {empty with gramid = Set.singleton x.it}

let bound_typid x = if x.it = "_" then empty else free_typid x
let bound_relid x = if x.it = "_" then empty else free_relid x
let bound_varid x = if x.it = "_" then empty else free_varid x
let bound_defid x = if x.it = "_" then empty else free_defid x
let bound_gramid x = if x.it = "_" then empty else free_gramid x


(* Aggregates *)

let free_empty _ = empty
let free_pair free_x free_y (x, y) = free_x x ++ free_y y
let free_opt free_x xo = Option.(value (map free_x xo) ~default:empty)
let free_list free_x xs = List.(fold_left (++) empty (map free_x xs))

let rec free_list_dep free_x bound_x = function
  | [] -> empty
  | x::xs -> free_x x ++ (free_list_dep free_x bound_x xs -- bound_x x)

let bound_list = free_list
