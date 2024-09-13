module Env : Map.S with type key = string

type env = El.Ast.iter list Env.t
type env' = Il.Ast.iter list Env.t

val annot_varid : Il.Ast.id -> Il.Ast.iter list -> Il.Ast.id

val check_def : El.Ast.def -> env (* raises Error.Error *)
val check_prod : El.Ast.prod -> env (* raises Error.Error *)
val check_typdef : El.Ast.typ -> El.Ast.prem El.Ast.nl_list -> env
  (* raises Error.Error *)

val annot_iter : env' -> Il.Ast.iter -> Il.Ast.iter
val annot_exp : env' -> Il.Ast.exp -> Il.Ast.exp
val annot_sym : env' -> Il.Ast.sym -> Il.Ast.sym
val annot_arg : env' -> Il.Ast.arg -> Il.Ast.arg
val annot_prem : env' -> Il.Ast.prem -> Il.Ast.prem
