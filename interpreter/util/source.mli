type loc = {file : string; line : int; column : int}
type region = {left : loc; right : loc}
type 'a phrase = {at : region; it : 'a}

val no_loc : loc
val no_region : region
val all_region : string -> region

val string_of_loc : loc -> string
val string_of_region : region -> string

val (@@) : 'a -> region -> 'a phrase
val it : 'a phrase -> 'a
val at : 'a phrase -> region
