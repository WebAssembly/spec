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
(*
  "-w", Arg.Int (fun n -> Flags.width := n),
    " Configure output width (default is " ^ string_of_int !Flags.width ^ ")";
*)
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
(*
    trace "Type checking...";
    Typing.check script;
*)
    trace "Multiplicity checking...";
    Frontend.Multiplicity.check el;
(*
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
    let sccs_def = Recursion.sccs_of_definitions script in
    List.iter (fun ids ->
      if List.length ids > 1 then begin
        Printf.printf "mutual def ";
        List.iter (fun id -> Printf.printf "$%s " id.Source.it) ids;
        Printf.printf "\n%!"
      end
    ) sccs_def;
    trace "Elaboration...";
    let el = Elaboration.elab script in
    trace "Validation...";
    El.Validation.valid el;
    Multiplicity.check el;
*)
    trace "Lowering...";
    let il = Frontend.Lower.lower el in
    trace "Printing...";
    if !out_arg = "" then Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    trace "IL Validation...";
    Il.Validation.valid il;
    trace "Latex Generation...";
    let latex = Backend_latex.Render.render_script el in
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
