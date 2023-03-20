(* Positions and regions *)

type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}

val no_pos : pos
val no_region : region
val region_of_file : string -> region

val over_region : region list -> region

val string_of_pos : pos -> string
val string_of_region : region -> string


(* Phrases *)

type 'a phrase = {at : region; it : 'a}

val (@@) : 'a -> region -> 'a phrase
val it : 'a phrase -> 'a
val at : 'a phrase -> region


(* Errors *)

exception Error of region * string

val error : region -> string -> string -> 'a
