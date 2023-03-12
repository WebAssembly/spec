let name = "spasm"
let version = "0.1"

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]

let quote s = "\"" ^ String.escaped s ^ "\""

let argspec = Arg.align
[
  "-w", Arg.Int (fun n -> Flags.width := n),
    " configure output width (default is " ^ string_of_int !Flags.width ^ ")";
  "-v", Arg.Unit banner, " show version"
]

let error at msg =
  prerr_endline (Source.string_of_region at ^ ": " ^ msg);
  exit 1

let parse_file file =
  try
    Parse.parse_file file
  with Sys_error msg ->
    error (Source.region_of_file file) ("i/o error: " ^ msg)

let () =
  Printexc.record_backtrace true;
  try
    Arg.parse argspec add_arg usage;
    let ast = List.concat_map parse_file !args in
    Typing.check ast;
    Multiplicity.check ast
  with
  | Source.Error (at, msg) ->
    error at msg
  | exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
