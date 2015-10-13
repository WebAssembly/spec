open Ast

type labeling = labeling' Source.phrase
and labeling' = Unlabelled | Labelled

val nop : expr'
val block : labeling * expr list -> expr'
val if_ : expr * expr * expr option -> expr'
val loop : labeling * labeling * expr list -> expr'
val label : expr -> expr'
val break : var * expr option -> expr'
val return : var * expr option -> expr'
val switch : labeling * value_type * expr * case list * expr -> expr'
val br_if : var * expr * expr option -> expr'
val br_switch : value_type * expr * var * (Values.value Source.phrase * var) list * expr option -> expr'
val call : var * expr list -> expr'
val call_import : var * expr list -> expr'
val call_indirect : var * expr * expr list -> expr'
val get_local : var -> expr'
val set_local : var * expr -> expr'
val load : memop * expr -> expr'
val store : memop * expr * expr -> expr'
val load_extend : extop * expr -> expr'
val store_wrap : wrapop * expr * expr -> expr'
val const : literal -> expr'
val unary : unop * expr -> expr'
val binary : binop * expr * expr -> expr'
val compare : relop * expr * expr -> expr'
val convert : cvt * expr -> expr'
val host : hostop * expr list -> expr'

val case : literal * (expr list * bool) option -> case'

val func_body : expr list -> expr'
