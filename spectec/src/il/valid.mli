val valid : Ast.script -> unit (* raises Error.Error *)

val annotate : Ast.script -> unit
val annotate_lhs_exp : Env.t -> Ast.exp -> Ast.typ option -> Env.t
val annotate_rhs_exp : Env.t -> Ast.exp -> Ast.typ option -> Env.t

(* (Re)Annotate the AST with the types inferred from running the validator.
 *
 * Notes:
 * - Validation is bidirectional type-checking. If the optional type is given,
 *   annotation starts off in checking mode, otherwise in inference mode.
 * - Not all node types can be fully inferred. The types of CaseE and StrE
 *   have to be pre-populated if in inference position. Same for TupE, unless
 *   a transparent type with no dependencies is desired.
 * - In checking position, the expression may contain variables that are not
 *   bound in the input environment. Their expected type is then recorded in
 *   the output environment.
 * - These functions use global side state and hence are not reentrant.
 *)
