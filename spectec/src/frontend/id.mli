(* Expression splicing depends on identifier status not being reset between parses,
 * hence its stored here.
*)

val is_var : string -> bool
val make_var : string -> unit

val enter_scope : unit -> unit
val exit_scope : unit -> unit

val reset : unit -> unit
