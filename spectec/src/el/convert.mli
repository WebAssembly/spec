open Ast

val filter_nl : 'a nl_list -> 'a list
val filter_nl_list : ('a -> bool) -> 'a nl_list -> 'a nl_list
val forall_nl_list : ('a -> bool) -> 'a nl_list -> bool
val exists_nl_list : ('a -> bool) -> 'a nl_list -> bool
val find_nl_list : ('a -> bool) -> 'a nl_list -> 'a option
val iter_nl_list : ('a -> unit) -> 'a nl_list -> unit
val map_nl_list : ('a -> 'b) -> 'a nl_list -> 'b nl_list
val map_filter_nl_list : ('a -> 'b) -> 'a nl_list -> 'b list
val concat_map_nl_list : ('a -> 'b nl_list) -> 'a nl_list -> 'b nl_list
val concat_map_filter_nl_list : ('a -> 'b list) -> 'a nl_list -> 'b list

val typ_of_varid : id -> typ
val varid_of_typ : typ -> id

val typ_of_exp : exp -> typ (* raises Source.Error *)
val exp_of_typ : typ -> exp (* raises Source.Error *)
val sym_of_exp : exp -> sym (* raises Source.Error *)
val exp_of_sym : sym -> exp (* raises Source.Error *)
val arg_of_exp : exp -> arg (* raises Source.Error *)
val exp_of_arg : arg -> exp (* raises Source.Error *)
val param_of_arg : arg -> param (* raises Source.Error *)
val arg_of_param : param -> arg (* raises Source.Error *)

val strip_var_suffix : id -> id
