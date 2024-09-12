(* Currently, the prose directly borrows some structures of AL.
   Perhaps this should be improved later *)

type cmpop = Eq | Ne | Lt | Gt | Le | Ge

type expr = Al.Ast.expr

type stmt =
| LetS of expr * expr
| CondS of expr
| CmpS of expr * cmpop * expr
| IsValidS of expr option * expr * expr list
| MatchesS of expr * expr
| IsConstS of expr option * expr
| IsDefinedS of expr
| IfS of expr * stmt list
| ForallS of (expr * expr) list * stmt list
| EitherS of stmt list list
(* TODO: Merge others statements into RelS *)
| RelS of string * expr list
| YetS of string

type def =
| RuleD of Al.Ast.anchor * Al.Ast.expr * stmt * stmt list
| AlgoD of Al.Ast.algorithm

type prose = def list
