(*
 * (c) 2015 Andreas Rossberg
 *)

type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}
type 'a phrase = {at : region; it : 'a}

val no_pos : pos
val no_region : region

val string_of_pos : pos -> string
val string_of_region : region -> string

val before : region -> region
val after : region -> region
val span : region list -> region

val (@@) : 'a -> region -> 'a phrase
val (@@@) : 'a -> region list -> 'a phrase

val it : 'a phrase -> 'a
val ito : 'a phrase option -> 'a option
val at : 'a phrase -> region
val ats : 'a phrase list -> region
