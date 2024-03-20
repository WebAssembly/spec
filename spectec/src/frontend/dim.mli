module Env : Map.S with type key = string

type env = El.Ast.iter list Env.t
type env' = Il.Ast.iter list Env.t

val check_def : El.Ast.def -> env (* raises Error.Error *)
val check_typdef : El.Ast.typ -> El.Ast.prem El.Ast.nl_list -> env
  (* raises Error.Error *)

val annot_exp : env' -> Il.Ast.exp -> Il.Ast.exp
val annot_arg : env' -> Il.Ast.arg -> Il.Ast.arg
val annot_prem : env' -> Il.Ast.prem -> Il.Ast.prem
