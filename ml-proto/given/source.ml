type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}
type 'a phrase = {at : region; it : 'a}


(* Positions and regions *)

let no_pos = {file = ""; line = 0; column = 0}
let no_region = {left = no_pos; right = no_pos}

let string_of_pos pos =
  if pos.line = -1 then
    string_of_int pos.column
  else
    string_of_int pos.line ^ "." ^ string_of_int (pos.column + 1)

let string_of_region r =
  r.left.file ^ ":" ^ string_of_pos r.left ^
  (if r.right = r.left then "" else "-" ^ string_of_pos r.right)

let before region = {left = region.left; right = region.left}
let after region = {left = region.right; right = region.right}

let rec span regions = match regions with
  | [] -> raise (Failure "span")
  | r::rs -> span' r.left r.right rs
and span' left right regions = match regions with
  | [] -> {left = left; right = right}
  | r::rs -> span' (min left r.left) (max right r.right) rs


(* Phrases *)

let (@@) phrase' region = {at = region; it = phrase'}
let (@@@) phrase' regions = phrase'@@(span regions)

let it phrase = phrase.it
let at phrase = phrase.at
let ats phrases = span (List.map at phrases)
