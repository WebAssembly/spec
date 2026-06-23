type sexpr = Atom of string | Node of string * sexpr list

val output : out_channel -> int -> sexpr -> unit
val print : int -> sexpr -> unit
val to_string : int -> sexpr -> string
