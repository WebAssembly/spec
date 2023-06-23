(* Currnetly, the prose directly borrows some structures of AL.
   Perhaps this should be improved later *)

type cmpop = Eq | Ne | Lt | Gt | Le | Ge

type instr = 
| LetI of Al.Ast.expr * Al.Ast.expr
| CmpI of Al.Ast.expr * cmpop * Al.Ast.expr
| MustValidI of Al.Ast.expr * Al.Ast.expr * Al.Ast.expr option
| MustMatchI of Al.Ast.expr * Al.Ast.expr
| IsValidI of Al.Ast.expr option
| ForallI of string * instr list
| EquivI of Al.Ast.cond * Al.Ast.cond
| YetI of string

type def =
| Pred of string * Al.Ast.expr list * instr list
| Algo of Al.Ast.algorithm

type prose = def list
