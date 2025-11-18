include Util.Debug_log

open Print

let il_side = function `Lhs -> "L" | `Rhs -> ""
let il_id = Util.Source.it
let il_atom = string_of_atom
let il_mixop = string_of_mixop
let il_iter = string_of_iter
let il_typ = string_of_typ
let il_typfield = string_of_typfield
let il_typcase = string_of_typcase
let il_deftyp = string_of_deftyp `H
let il_exp = string_of_exp
let il_sym = string_of_sym
let il_prod = string_of_prod
let il_clause = string_of_clause
let il_prem = string_of_prem
let il_arg = string_of_arg
let il_args = string_of_args
let il_param = string_of_param
let il_params = string_of_params
let il_quants = string_of_quants
let il_def = string_of_def
let il_free s = String.concat " "
  Free.[
    set s.typid;
    set s.varid;
    set s.gramid;
    set s.defid;
  ]
let il_subst s = String.concat " "
  Subst.[
    mapping il_typ s.typid;
    mapping il_exp s.varid;
    mapping il_sym s.gramid;
    mapping il_id s.defid;
  ]
