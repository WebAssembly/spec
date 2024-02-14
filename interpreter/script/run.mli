exception Abort of Source.region * string
exception Assert of Source.region * string
exception IO of Source.region * string

val trace : string -> unit

val run_string : string -> bool
val run_file : string -> bool
val run_stdin : unit -> unit

val assert_result : Source.region ->
  Value.value list -> Script.result list -> unit (* raises Assert *)
val assert_message : Source.region ->
  string -> string -> string -> unit (* raises Assert *)
