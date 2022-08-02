open Types.Sem
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of var * 'inst * Ast.func
  | HostFunc of var * (value list -> value list)

let alloc x inst f = AstFunc (x, inst, f)
let alloc_host x f = HostFunc (x, f)

let type_inst_of = function
  | AstFunc (x, _, _) -> x
  | HostFunc (x, _) -> x

let type_of f = as_func_def_type (def_of (type_inst_of f))
