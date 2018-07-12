exception Utf8

val decode : string -> int list (* raise UTf8 *)
val encode : int list -> string (* raise Utf8 *)
