type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}
type 'a phrase = {at : region; it : 'a}


(* Positions and regions *)

let no_pos = {file = ""; line = 0; column = 0}
let no_region = {left = no_pos; right = no_pos}

let pos_of_file file = {no_pos with file}
let region_of_file file = {left = pos_of_file file; right = pos_of_file file}

let string_of_pos pos =
  if pos.line = -1 then
    Printf.sprintf "0x%x" pos.column
  else
    string_of_int pos.line ^ "." ^ string_of_int (pos.column + 1)

let string_of_region r =
  if r = region_of_file r.left.file then
    r.left.file
  else
    r.left.file ^ ":" ^ string_of_pos r.left ^
    (if r.left = r.right then "" else "-" ^ string_of_pos r.right)


(* Phrases *)

let (@@) x region = {it = x; at = region}

let it {it; at = _} = it
let at {at; it = _} = at


(* Errors *)

exception Error of region * string

let error at category msg = raise (Error (at, category ^ " error: " ^ msg))
