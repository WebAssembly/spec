(* Positions and regions *)

type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}

val no_pos : pos
val no_region : region
val region_of_file : string -> region

val before_region : region -> region
val after_region : region -> region
val over_region : region list -> region

val string_of_pos : pos -> string
val string_of_range : pos -> pos -> string
val string_of_region : region -> string


(* Phrases *)

type ('a, 'b) note_phrase = {at : region; it : 'a; note : 'b; mark : bool}
type 'a phrase = ('a, unit) note_phrase

val ($) : 'a -> region -> 'a phrase
val ($$) : 'a -> region * 'b -> ('a, 'b) note_phrase
val (%) : region -> 'b -> region * 'b

val it : ('a, 'b) note_phrase -> 'a
val at : ('a, 'b) note_phrase -> region
val note : ('a, 'b) note_phrase -> 'b
val mark : ('a, 'b) note_phrase -> bool


(* Utilities *)

val map : ('a -> 'b) -> ('a, 'c) note_phrase -> ('b, 'c) note_phrase
