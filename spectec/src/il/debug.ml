include Util.Debug_log

open Print

let il_mixop = string_of_mixop
let il_iter = string_of_iter
let il_typ = string_of_typ
let il_deftyp = string_of_deftyp `H
let il_exp = string_of_exp
let il_arg = string_of_arg
let il_param = string_of_param
let il_args = list il_arg
let il_params = list il_param
let il_def = string_of_def
let il_subst s = String.concat " "
  Subst.[mapping il_typ s.typid; mapping il_exp s.varid]
