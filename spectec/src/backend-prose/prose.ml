(* Currently, the prose directly borrows some structures of AL.
   Perhaps this should be improved later *)

type cmpop = Eq | Ne | Lt | Gt | Le | Ge

(* TODO: perhaps rename to `stmt`, to avoid confusion with Wasm *)
type instr =
| LetI of Al.Ast.expr * Al.Ast.expr
| CmpI of Al.Ast.expr * cmpop * Al.Ast.expr
| MustValidI of Al.Ast.expr * Al.Ast.expr * Al.Ast.expr option
| MustMatchI of Al.Ast.expr * Al.Ast.expr
| IsValidI of Al.Ast.expr option
| IfI of Al.Ast.expr * instr list
| ForallI of Al.Ast.expr * Al.Ast.expr * instr list
| EquivI of Al.Ast.expr * Al.Ast.expr
| YetI of string

(* TODO: perhaps rename to avoid name clash *)
type def =
| Pred of Al.Ast.atom * Al.Ast.expr list * instr list
| Algo of Al.Ast.algorithm

type prose = def list
