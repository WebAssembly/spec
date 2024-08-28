open Il.Ast
open Util.Source

type partial = Partial | Total
type helper_clause = clause
type helper_def' = id * helper_clause list * partial
type helper_def = helper_def' phrase
type rule_clause = exp * exp * (prem list)
type rule_def' = string * id * rule_clause list
type rule_def = rule_def' phrase
