(* Raises Error.Error.
   `~elab` defaults to false. If true, it updates the type annotations in the input Ast.
*)
val valid : ?elab:bool -> Ast.script -> unit
