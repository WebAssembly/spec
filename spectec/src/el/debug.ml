include Util.Debug_log

open Print

let el_id = Util.Source.it
let el_atom = string_of_atom
let el_iter = string_of_iter
let el_typ = string_of_typ
let el_typfield = string_of_typfield
let el_exp = string_of_exp
let el_expfield = string_of_expfield
let el_sym = string_of_sym
let el_prem = string_of_prem
let el_arg = string_of_arg
let el_param = string_of_param
let el_args = list el_arg
let el_params = list el_param
let el_def = string_of_def

let nl_list f xs = list f (Convert.filter_nl xs)

let el_free s = String.concat " "
  Free.[
    set s.typid;
    set s.varid;
    set s.gramid;
    set s.defid;
  ]
let el_subst s = String.concat " "
  Subst.[
    mapping el_typ s.typid;
    mapping el_exp s.varid;
    mapping el_sym s.gramid;
    mapping el_id s.defid;
  ]
