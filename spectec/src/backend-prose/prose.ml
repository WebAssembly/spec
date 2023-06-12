open Backend_interpreter

(* Currnetly, the prose directly borrows some structures of AL.
   Perhaps this should be improved later *)

type cmpop = Eq | Ne | Lt | Gt | Le | Ge

type instr = 
| LetI of Al.expr * Al.expr
| CmpI of Al.expr * cmpop * Al.expr
| MustValidI of Al.expr * Al.expr * Al.expr option
| MustMatchI of Al.expr * Al.expr
| IsValidI of Al.expr option
| ForallI of string * instr list
| YetI of string

type def =
| Pred of string * Al.expr list * instr list
| Algo of Al.algorithm

type prose = def list
