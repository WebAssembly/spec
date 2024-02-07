(* Positions and regions *)

type pos = {file : string; line : int; column : int}
type region = {left : pos; right : pos}

let no_pos = {file = ""; line = 0; column = 0}
let no_region = {left = no_pos; right = no_pos}

let pos_of_file file = {no_pos with file}
let region_of_file file = {left = pos_of_file file; right = pos_of_file file}

let over_region = function
  | [] -> raise (Invalid_argument "Source.over")
  | r::rs ->
    List.fold_left (fun r1 r2 ->
      {left = min r1.left r2.left; right = max r1.right r2.right}
    ) r rs


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

type ('a, 'b) note_phrase = {at : region; it : 'a; note : 'b}
type 'a phrase = ('a, unit) note_phrase

let ($) it at = {it; at; note = ()}
let ($$) it (at, note) = {it; at; note}
let (%) at note = (at, note)

let it {it; _} = it
let at {at; _} = at
let note {note; _} = note


(* Errors *)

exception Error of region * string

let debug_errors = true

let string_of_error at msg = string_of_region at ^ ": " ^ msg

let error at category msg =
  if debug_errors then (
    let bar = String.make 80 '-' in
    Printf.eprintf "%s\n" bar;
    Printexc.(get_callstack 100 |> print_raw_backtrace stderr);
    Printf.eprintf "%s\n%!" bar;
  );
  raise (Error (at, category ^ " error: " ^ msg))

let print_error at msg = prerr_endline (string_of_error at msg)
let print_warn at msg = prerr_endline (string_of_error at ("warning: " ^ msg))
