exception Utf8

val decode : string -> int list (* raises UTf8 *)
val encode : int list -> string (* raises Utf8 *)
