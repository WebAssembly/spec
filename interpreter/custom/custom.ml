(* Raw custom section *)

type section_kind =
  | Custom
  | Type
  | Import
  | Func
  | Table
  | Memory
  | Global
  | Export
  | Start
  | Elem
  | DataCount
  | Code
  | Data
  | Tag

type place =
  | Before of section_kind
  | After of section_kind

type custom = custom' Source.phrase
and custom' =
{
  name : Ast.name;
  content : string;
  place : place;
}


let first = Type
let last = Data

let compare_place pl1 pl2 =
  match pl1, pl2 with
  | Before s1, Before s2
  | After s1, After s2 -> compare s1 s2
  | Before s1, After s2 -> if s1 = s2 then -1 else compare s1 s2
  | After s1, Before s2 -> if s1 = s2 then +1 else compare s1 s2


(* Handlers *)

exception Code of Source.region * string
exception Syntax of Source.region * string
exception Invalid of Source.region * string

module type Handler =
sig
  type format'
  type format = format' Source.phrase
  val name : Ast.name
  val place : format -> place
  val decode : Ast.module_ -> string -> custom -> format (* raise Code *)
  val encode : Ast.module_ -> string -> format -> custom
  val parse : Ast.module_ -> string -> Annot.annot list -> format list (* raise Syntax *)
  val arrange : Ast.module_ -> Sexpr.sexpr -> format -> Sexpr.sexpr
  val check : Ast.module_ -> format -> unit (* raise Invalid *)
end

module type Section =
sig
  module Handler : Handler
  val it : Handler.format
end

type section = (module Section)

let compare_section (module S1 : Section) (module S2 : Section) =
  match compare_place (S1.Handler.place S1.it) (S2.Handler.place S2.it) with
  | 0 -> compare S1.it.Source.at S2.it.Source.at
  | n -> n


(* Handler registry *)

module Registry = Map.Make(struct type t = Ast.name let compare = compare end)

let registry = ref Registry.empty

let register (module H : Handler) =
  registry := Registry.add H.name (module H : Handler) !registry

let handler (name : Ast.name) : (module Handler) option =
  Registry.find_opt name !registry
