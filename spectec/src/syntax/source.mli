type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}
type 'a phrase = {at : region; it : 'a}

exception Error of region * string

val no_pos : pos
val no_region : region

val region_of_file : string -> region

val string_of_pos : pos -> string
val string_of_region : region -> string

val (@@) : 'a -> region -> 'a phrase
val it : 'a phrase -> 'a
val at : 'a phrase -> region

val error : region -> string -> string -> 'a
