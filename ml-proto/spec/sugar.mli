open Ast

type labeling = labeling' Source.phrase
and labeling' = Unlabelled | Labelled

type case = case' Source.phrase
and case' = Case of var | Case_br of var

val nop : expr'
val block : labeling * expr list -> expr'
val if_else : expr * expr * expr -> expr'
val if_ : expr * expr -> expr'
val br_if : expr * var -> expr'
val loop : labeling * labeling * expr list -> expr'
val label : expr -> expr'
val br : var * expr option -> expr'
val return : var * expr option -> expr'
val tableswitch : labeling * expr * case list * case * expr list list -> expr'
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
val select : selop * expr * expr * expr -> expr'
val compare : relop * expr * expr -> expr'
val convert : cvt * expr -> expr'
val host : hostop * expr list -> expr'

val func_body : expr list -> expr'
