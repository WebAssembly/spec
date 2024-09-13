include Util.Debug_log

open Print

let il_side = function `Lhs -> "L" | `Rhs -> ""
let il_id = Util.Source.it
let il_atom = string_of_atom
let il_mixop = string_of_mixop
let il_iter = string_of_iter
let il_typ = string_of_typ
let il_deftyp = string_of_deftyp `H
let il_exp = string_of_exp
let il_sym = string_of_sym
let il_prem = string_of_prem
let il_arg = string_of_arg
let il_bind = string_of_bind
let il_param = string_of_param
let il_args = list il_arg
let il_binds = string_of_binds
let il_params = list il_param
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
