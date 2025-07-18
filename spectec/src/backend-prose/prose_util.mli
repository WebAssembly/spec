module Map : Map.S with type key = string

type hintenv

val hintenv : hintenv
val init_hintenv : El.Ast.def list -> unit
val find_relation : string -> El.Ast.def option
val find_hint : string -> string -> El.Ast.exp option
val unwrap_itert : Il.Ast.typ -> Il.Ast.typ * int
val extract_desc : Al.Ast.expr -> (string * string) option
val alternate : 'a list -> 'a list -> 'a list
val apply_prose_hint : string -> string list -> string
val string_of_stack_prefix : Al.Ast.expr -> string
val find_case_typ : string -> Xl.Atom.atom -> El.Ast.typ
val extract_case_hint : Il.Ast.typ -> Xl.Mixop.mixop -> string option
val extract_call_hint : string -> string option
