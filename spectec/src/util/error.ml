open Source

exception Error of region * string

let debug_errors = false

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

let print_yet at category msg =
  (string_of_region at ^ ": ") ^ (category ^ ": Yet " ^ msg)
  |> print_endline
