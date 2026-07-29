type loc = {file : string; line : int; column : int}
type region = {left : loc; right : loc}
type 'a phrase = {at : region; it : 'a}

let (@@) x region = {it = x; at = region}
let it phrase = phrase.it
let at phrase = phrase.at


(* Positions and regions *)

let no_loc = {file = ""; line = 0; column = 0}
let no_region = {left = no_loc; right = no_loc}
let all_region file =
  { left = {file; line = 0; column = 0};
    right = {file; line = Int.max_int; column = Int.max_int}
  }

let string_of_loc loc =
  if loc.line = -1 then
    Printf.sprintf "0x%x" loc.column
  else
    string_of_int loc.line ^ "." ^ string_of_int (loc.column + 1)

let string_of_region r =
  r.left.file ^ ":" ^ string_of_loc r.left ^
  (if r.right = r.left then "" else "-" ^ string_of_loc r.right)
