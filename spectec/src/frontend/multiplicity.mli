module Env : Map.S with type key = string

type env = El.Ast.iter list Env.t

val check_def : El.Ast.def -> env (* raises Source.Error *)
