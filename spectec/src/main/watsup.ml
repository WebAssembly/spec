open Spectec

let name = "spasm"
let version = "0.1"

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]

let argspec = Arg.align
[
  "-w", Arg.Int (fun n -> Flags.width := n),
    " configure output width (default is " ^ string_of_int !Flags.width ^ ")";
  "-v", Arg.Unit banner, " show version"
]

let error at msg =
  prerr_endline (Source.string_of_region at ^ ": " ^ msg);
  exit 1

let trace s = Printf.printf "== %s\n%!" s

let parse_file file =
  try
    Parse.parse_file file
  with Sys_error msg ->
    error (Source.region_of_file file) ("i/o error: " ^ msg)

let () =
  Printexc.record_backtrace true;
  try
    Arg.parse argspec add_arg usage;
    trace "Parsing...";
    let script = List.concat_map parse_file !args in
    trace "Type checking...";
    Typing.check script;
    trace "Multiplicity checking...";
    Multiplicity.check script;
    trace "Recursion analysis...";
    let sccs_syn = Recursion.sccs_of_syntaxes script in
    List.iter (fun ids ->
      if List.length ids > 1 then begin
        Printf.printf "mutual syntax ";
        List.iter (fun id -> Printf.printf "%s " id.Source.it) ids;
        Printf.printf "\n%!"
      end
    ) sccs_syn;
    let sccs_rel = Recursion.sccs_of_relations script in
    List.iter (fun ids ->
      if List.length ids > 1 then begin
        Printf.printf "mutual relation ";
        List.iter (fun id -> Printf.printf "%s " id.Source.it) ids;
        Printf.printf "\n%!"
      end
    ) sccs_rel;
    trace "Elaboration...";
    let script' = Elaboration.elab script in
    trace "Validation...";
    Validation.valid script';
    Multiplicity.check script';
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
