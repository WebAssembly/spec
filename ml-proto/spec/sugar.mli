open Ast

type labeling = labeling' Source.phrase
and labeling' = Unlabelled | Labelled

val nop : expr'
val block : labeling * expr list -> expr'
val if_else : expr * expr * expr -> expr'
val if_ : expr * expr -> expr'
val br_if : expr * var -> expr'
val loop : labeling * labeling * expr list -> expr'
val label : expr -> expr'
val br : var * expr option -> expr'
val return : var * expr option -> expr'
val tableswitch : labeling * expr * (case' * bool) Source.phrase list -> expr'
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

val case : I32.t * expr list -> case' * bool
val case_br : I32.t * var -> case' * bool
val default : expr list -> case' * bool
val default_br : var -> case' * bool

val func_body : expr list -> expr'
