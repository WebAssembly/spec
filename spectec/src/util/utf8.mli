type codepoint = int
type unicode = codepoint list

exception Utf8

val decode : string -> unicode (* raises Utf8 *)
val encode : unicode -> string (* raises Utf8 *)
