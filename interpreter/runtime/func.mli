open Types
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of sem_var * 'inst * Ast.func
  | HostFunc of sem_var * (value list -> value list)

val alloc : sem_var -> 'inst -> Ast.func -> 'inst func
val alloc_host : sem_var -> (value list -> value list) -> 'inst func

val type_of : 'inst func -> func_type
val type_inst_of : 'inst func -> sem_var
