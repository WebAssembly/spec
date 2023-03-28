open Util


(* Configuration *)

let name = "watsup"
let version = "0.3"


(* Flags and parameters *)

let config = ref Backend_latex.Config.latex

let log = ref false  (* log execution steps *)
let dst = ref false  (* patch files *)
let dry = ref false  (* dry run for patching *)
let warn = ref false (* warn about unused or reused splices *)

let srcs = ref []    (* src file arguments *)
let dsts = ref []    (* destination file arguments *)
let odst = ref ""    (* generation file argument *)


(* Argument parsing *)

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...] [-p file ...]"

let add_arg source =
  let args = if !dst then dsts else srcs in args := !args @ [source]

let argspec = Arg.align
[
  "-v", Arg.Unit banner, " Show version";
  "-o", Arg.String (fun s -> odst := s), " Generate file";
  "-p", Arg.Set dst, " Patch files";
  "-d", Arg.Set dry, " Dry run";
  "-l", Arg.Set log, " Log execution steps";
  "-w", Arg.Set warn, " Warn about unsed or multiply used splices";
  "--latex", Arg.Unit (fun () -> config := Backend_latex.Config.latex),
    " Use Latex settings (default)";
  "--sphinx", Arg.Unit (fun () -> config := Backend_latex.Config.sphinx),
    " Use Sphinx settings";
  "-help", Arg.Unit ignore, "";
  "--help", Arg.Unit ignore, "";
]


(* Main *)

let log s = if !log then Printf.printf "== %s\n%!" s

let () =
  Printexc.record_backtrace true;
  try
    Arg.parse argspec add_arg usage;
    log "Parsing...";
    let el = List.concat_map Frontend.Parse.parse_file !srcs in
    log "Multiplicity checking...";
    Frontend.Multiplicity.check el;
    log "Elaboration...";
    let il = Frontend.Elab.elab el in
    if !odst = "" && !dsts = [] then (
      log "Printing...";
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    );
    log "IL Validation...";
    Il.Validation.valid il;
    log "Latex Generation...";
    if !odst = "" && !dsts = [] then
      print_endline (Backend_latex.Gen.gen_string el);
    if !odst <> "" then
      Backend_latex.Gen.gen_file !odst el;
    if !dsts <> [] then (
      let env = Backend_latex.Splice.(env !config el) in
      List.iter (Backend_latex.Splice.splice_file ~dry:!dry env) !dsts;
      if !warn then Backend_latex.Splice.warn env;
    );
    log "Complete."
  with
  | Source.Error (at, msg) ->
    prerr_endline (Source.string_of_region at ^ ": " ^ msg);
    exit 1
  | exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
