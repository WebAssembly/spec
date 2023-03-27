open Util

let name = "watsup"
let version = "0.2"

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...] [-p file ...]"

let config = ref Backend_latex.Config.latex
let dst = ref false
let srcs = ref []
let dsts = ref []
let odst = ref ""

let add_arg source =
  let args = if !dst then dsts else srcs in args := !args @ [source]

let argspec = Arg.align
[
  "-v", Arg.Unit banner, " Show version";
  "-o", Arg.String (fun s -> odst := s), " Generate file";
  "-p", Arg.Set dst, " Patch files";
  "--latex", Arg.Unit (fun () -> config := Backend_latex.Config.latex),
    " Use Latex settings (default)";
  "--sphinx", Arg.Unit (fun () -> config := Backend_latex.Config.sphinx),
    " Use Sphinx settings";
  "-help", Arg.Unit ignore, "";
  "--help", Arg.Unit ignore, "";
]

let error at msg =
  prerr_endline (Source.string_of_region at ^ ": " ^ msg);
  exit 1

let trace s = if !odst = "" then Printf.printf "== %s\n%!" s

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
    let el = List.concat_map parse_file !srcs in
    trace "Multiplicity checking...";
    Frontend.Multiplicity.check el;
    trace "Elaboration...";
    let il = Frontend.Elab.elab el in
    trace "Printing...";
    if !odst = "" && !dsts = [] then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    trace "IL Validation...";
    Il.Validation.valid il;
    trace "Latex Generation...";
    if !odst = "" && !dsts = [] then
      print_endline (Backend_latex.Gen.gen_string el);
    if !odst <> "" then
      Backend_latex.Gen.gen_file !odst el;
    let env = Backend_latex.Splice.(env !config el) in
    List.iter (Backend_latex.Splice.splice_file env) !dsts;
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
