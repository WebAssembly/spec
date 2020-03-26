open Types
open Values

type 'inst t = 'inst func
and 'inst func =
  | AstFunc of func_type * 'inst * Ast.func
  | HostFunc of func_type * (value list -> value list)
  | ClosureFunc of 'inst func * value list

let alloc ft inst f = AstFunc (ft, inst, f)
let alloc_host ft f = HostFunc (ft, f)
let alloc_closure func vs = ClosureFunc (func, vs)

let rec type_of = function
  | AstFunc (ft, _, _) -> ft
  | HostFunc (ft, _) -> ft
  | ClosureFunc (f, vs) ->
    let FuncType (ins, out) = type_of f in
    FuncType (Lib.List.drop (List.length vs) ins, out)
