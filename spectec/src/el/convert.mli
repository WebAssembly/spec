open Ast

val filter_nl : 'a nl_list -> 'a list
val iter_nl_list : ('a -> unit) -> 'a nl_list -> unit
val map_nl_list : ('a -> 'b) -> 'a nl_list -> 'b nl_list
val map_filter_nl_list : ('a -> 'b) -> 'a nl_list -> 'b list

val typ_of_exp : exp -> typ (* raises Source.Error *)
val exp_of_typ : typ -> exp (* raises Source.Error *)
val sym_of_exp : exp -> sym (* raises Source.Error *)
val exp_of_sym : sym -> exp (* raises Source.Error *)
val arg_of_exp : exp -> arg (* raises Source.Error *)
val exp_of_arg : arg -> exp (* raises Source.Error *)
val param_of_arg : arg -> param (* raises Source.Error *)
