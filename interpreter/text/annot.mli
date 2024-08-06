type annot = annot' Source.phrase
and annot' = {name : Ast.name; items : item list}

and item = item' Source.phrase
and item' =
  | Atom of string
  | Var of string
  | String of string
  | Nat of string
  | Int of string
  | Float of string
  | Parens of item list
  | Annot of annot

module NameMap : Map.S with type key = Ast.name
type map = annot list NameMap.t

val reset : unit -> unit
val record : annot -> unit

val get : Source.region -> map
val get_all : unit -> map

val get_source : unit -> string
val extend_source : string -> unit
