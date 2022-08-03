open Types.Dyn
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of var * 'inst * Ast.func
  | HostFunc of var * (value list -> value list)

val alloc : var -> 'inst -> Ast.func -> 'inst func
val alloc_host : var -> (value list -> value list) -> 'inst func

val type_of : 'inst func -> func_type
val type_inst_of : 'inst func -> var
