exception Utf8

val decode : string -> int list (* raises Utf8 *)
val encode : int list -> string (* raises Utf8 *)
