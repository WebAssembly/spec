open Util

let name = "watsup"
let version = "0.2"

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]
let out_arg = ref ""

let argspec = Arg.align
[
  "-v", Arg.Unit banner, " Show version";
  "-o", Arg.String (fun s -> out_arg := s), " Generate file";
  "-help", Arg.Unit ignore, "";
  "--help", Arg.Unit ignore, "";
]

let error at msg =
  prerr_endline (Source.string_of_region at ^ ": " ^ msg);
  exit 1

let trace s = if !out_arg = "" then Printf.printf "== %s\n%!" s

let write_out latex =
  let oc = open_out !out_arg in
  Fun.protect (fun () -> output_string oc latex)
    ~finally:(fun () -> close_out oc)


let parse_file file =
  try
    Frontend.Parse.parse_file file
  with Sys_error msg ->
    error (Source.region_of_file file) ("i/o error: " ^ msg)

let () =
  Printexc.record_backtrace true;
  try
    Arg.parse argspec add_arg usage;
    trace "Parsing...";
    let el = List.concat_map parse_file !args in
    trace "Multiplicity checking...";
    Frontend.Multiplicity.check el;
    trace "Elaboration...";
    let il = Frontend.Elab.elab el in
    trace "Printing...";
    if !out_arg = "" then Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    trace "IL Validation...";
    Il.Validation.valid il;
    trace "Latex Generation...";
    let latex = Backend_latex.Render.(render_script (env config) el) in
    if !out_arg = "" then
      print_endline latex
    else
      write_out latex;
    trace "Complete."
  with
  | Source.Error (at, msg) ->
    error at msg
  | exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
