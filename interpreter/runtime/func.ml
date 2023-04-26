open Types
open Value

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of def_type * 'inst * Ast.func
  | HostFunc of def_type * (value list -> value list)

let alloc dt inst f =
  ignore (as_func_str_type (expand_def_type dt));
  AstFunc (dt, inst, f)

let alloc_host dt f =
  ignore (as_func_str_type (expand_def_type dt));
  HostFunc (dt, f)

let type_of = function
  | AstFunc (dt, _, _) -> dt
  | HostFunc (dt, _) -> dt
