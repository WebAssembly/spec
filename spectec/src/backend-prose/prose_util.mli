module Map : Map.S with type key = string

type hintenv

val hintenv : hintenv
val init_hintenv : El.Ast.def list -> unit
val find_relation : string -> El.Ast.def option
val extract_desc : Il.Ast.typ -> string
val alternate : 'a list -> 'a list -> 'a list
val apply_prose_hint : string -> string list -> string
val string_of_stack_prefix : Al.Ast.expr -> string
