exception Error of Source.region * string

val error : Source.region -> string -> string -> 'a
val error_no_region : string -> string -> 'a

val print_error : Source.region -> string -> unit
val print_warn : Source.region -> string -> unit
