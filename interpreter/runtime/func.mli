open Types
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of type_addr * 'inst * Ast.func
  | HostFunc of type_addr * (value list -> value list)

val alloc : type_addr -> 'inst -> Ast.func -> 'inst func
val alloc_host : type_addr -> (value list -> value list) -> 'inst func

val type_of : 'inst func -> func_type
val type_inst_of : 'inst func -> type_addr
