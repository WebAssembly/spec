(* Currently, the prose directly borrows some structures of AL.
   Perhaps this should be improved later *)

type cmpop = Eq | Ne | Lt | Gt | Le | Ge

type expr = Al.Ast.expr

(* TODO: perhaps rename to `stmt`, to avoid confusion with Wasm *)
type instr =
| LetI of expr * expr
| CmpI of expr * cmpop * expr
| MemI of expr * expr
| IsValidI of expr option * expr * expr option
| MatchesI of expr * expr
| IfI of expr * instr list
| ForallI of (expr * expr) list * instr list
| EquivI of expr * expr
| EitherI of instr list list
| YetI of string

(* TODO: perhaps rename to avoid name clash *)
type def =
| Iff of string * Al.Ast.expr * instr * instr list
| Algo of Al.Ast.algorithm

type prose = def list
