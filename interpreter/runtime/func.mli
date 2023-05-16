open Types
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of def_type * 'inst * Ast.func
  | HostFunc of def_type * (value list -> value list)

val alloc : def_type -> 'inst -> Ast.func -> 'inst func
val alloc_host : def_type -> (value list -> value list) -> 'inst func

val type_of : 'inst func -> def_type
