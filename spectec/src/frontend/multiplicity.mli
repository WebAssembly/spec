module Env : Map.S with type key = string

type env = El.Ast.iter list Env.t
type env' = Il.Ast.iter list Env.t

val check_def : El.Ast.def -> env (* raises Source.Error *)
val check_typdef : El.Ast.typ list -> El.Ast.premise El.Ast.nl_list -> env
  (* raises Source.Error *)

val annot_exp : env' -> Il.Ast.exp -> Il.Ast.exp
val annot_prem : env' -> Il.Ast.premise -> Il.Ast.premise
