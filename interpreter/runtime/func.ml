open Types
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of type_addr * 'inst * Ast.func
  | HostFunc of type_addr * (value list -> value list)

let alloc x inst f = AstFunc (x, inst, f)
let alloc_host x f = HostFunc (x, f)

let type_inst_of = function
  | AstFunc (x, _, _) -> x
  | HostFunc (x, _) -> x

let type_of f = as_func_str_type (expand_ctx_type (def_of (type_inst_of f)))
