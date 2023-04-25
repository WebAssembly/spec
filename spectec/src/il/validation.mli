(* Main interface for validation *)
val valid : Ast.script -> unit (* raises Source.Error *)

(* Interface for passes that need type information.
   (Re-validates stuff, so maybe to be replaced with AST annotations.) *)
(* Collect global type information *)
type env
val new_env : unit -> env
val valid_defs : env -> Ast.script -> unit
(* Enter binders (stateful!) and iterexpr (returns new env) *)
val valid_binds : env -> Ast.binds -> unit
val clear_binds : env -> unit
val valid_iterexp : env -> Ast.iterexp -> env
(* Infer expression types *)
val infer_exp : env -> Ast.exp -> Ast.typ

