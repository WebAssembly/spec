exception Abort of Source.region * string
exception Assert of Source.region * string
exception IO of Source.region * string

val trace : string -> unit

val run_string : string -> bool
val run_file : string -> bool
val run_stdin : unit -> unit
