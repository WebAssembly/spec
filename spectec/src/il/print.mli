open Ast

val string_of_id : id -> string
val string_of_atom : atom -> string
val string_of_unop : unop -> string
val string_of_binop : binop -> string
val string_of_cmpop : cmpop -> string
val string_of_mixop : mixop -> string
val string_of_iter : iter -> string
val string_of_iterexp : iterexp -> string
val string_of_numtyp : numtyp -> string
val string_of_typ : typ -> string
val string_of_typ_name : typ -> string
val string_of_exp : exp -> string
val string_of_path : path -> string
val string_of_sym : sym -> string
val string_of_prem : prem -> string
val string_of_arg : arg -> string
val string_of_args : arg list -> string
val string_of_param : param -> string
val string_of_params : param list -> string
val string_of_quant : quant -> string
val string_of_quants : quant list -> string
val string_of_typfield : ?layout: [`H | `V] -> typfield -> string
val string_of_typcase : ?layout: [`H | `V] -> typcase -> string
val string_of_deftyp : ?layout: [`H | `V] -> deftyp -> string
val string_of_def : ?suppress_pos: bool -> def -> string
val string_of_rule : ?suppress_pos: bool -> rule -> string
val string_of_prod : ?suppress_pos: bool -> prod -> string
val string_of_inst : ?suppress_pos: bool -> id -> inst -> string
val string_of_clause : ?suppress_pos: bool -> id -> clause -> string
val string_of_script : ?suppress_pos: bool -> script -> string

val print_notes : bool ref
