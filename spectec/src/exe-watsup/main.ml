open Util


(* Configuration *)

let name = "watsup"
let version = "0.3"


(* Flags and parameters *)

type target =
 | Check
 | Latex of Backend_latex.Config.config
 | Prose

let target = ref (Latex Backend_latex.Config.latex)

let log = ref false  (* log execution steps *)
let dst = ref false  (* patch files *)
let dry = ref false  (* dry run for patching *)
let warn = ref false (* warn about unused or reused splices *)

let srcs = ref []    (* src file arguments *)
let dsts = ref []    (* destination file arguments *)
let odst = ref ""    (* generation file argument *)

let print_elab_il = ref false
let print_final_il = ref false
let print_all_il = ref false

let pass_totalize = ref false
let pass_unthe = ref false
let pass_sideconditions = ref false
let pass_animate = ref false


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
  "-d", Arg.Set dry, " Dry run (when -p) ";
  "-l", Arg.Set log, " Log execution steps";
  "-w", Arg.Set warn, " Warn about unsed or multiply used splices";

  "--check", Arg.Unit (fun () -> target := Check), " Check only";
  "--latex", Arg.Unit (fun () -> target := Latex Backend_latex.Config.latex),
    " Generate Latex (default)";
  "--sphinx", Arg.Unit (fun () -> target := Latex Backend_latex.Config.sphinx),
    " Generate Latex for Sphinx";
  "--prose", Arg.Unit (fun () -> target := Prose), " Generate prose";

  "--print-il", Arg.Set print_elab_il, " Print il (after elaboration)";
  "--print-final-il", Arg.Set print_final_il, " Print final il";
  "--print-all-il", Arg.Set print_all_il, " Print il after each step";

  "--totalize", Arg.Set pass_totalize, " Run function totalization";
  "--the-elimination", Arg.Set pass_unthe, " Eliminate the ! operator in relations";
  "--sideconditions", Arg.Set pass_sideconditions, " Infer side conditoins";
  "--animate", Arg.Set pass_animate, " Animate equality conditions";

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
    log "Elaboration...";
    let il = Frontend.Elab.elab el in
    if !print_elab_il || !print_all_il then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    log "IL Validation...";
    Il.Validation.valid il;

    let il = if not !pass_totalize then il else
      ( log "Function totalization...";
        let il = Middlend.Totalize.transform il in
        if !print_all_il then
          Printf.printf "%s\n%!" (Il.Print.string_of_script il);
        log "IL Validation...";
        Il.Validation.valid il;
        il
      )
    in

    let il = if not !pass_unthe then il else
      ( log "Option projection eliminiation";
        let il = Middlend.Unthe.transform il in
        if !print_all_il then
          Printf.printf "%s\n%!" (Il.Print.string_of_script il);
        log "IL Validation...";
        Il.Validation.valid il;
        il
      )
    in

    let il = if not !pass_sideconditions then il else
      ( log "Side condition inference";
        let il = Middlend.Sideconditions.transform il in
        if !print_all_il then
          Printf.printf "%s\n%!" (Il.Print.string_of_script il);
        log "IL Validation...";
        Il.Validation.valid il;
        il
      )
    in

    let il = if not !pass_animate then il else
      ( log "Animate";
        let il = Middlend.Animate.transform il in
        if !print_all_il then
          Printf.printf "%s\n%!" (Il.Print.string_of_script il);
        log "IL Validation...";
        Il.Validation.valid il;
        il
      )
    in

    if !print_final_il && not !print_all_il then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);

    (match !target with
    | Check -> ()
    | Latex config ->
      log "Latex Generation...";
      if !odst = "" && !dsts = [] then
        print_endline (Backend_latex.Gen.gen_string el);
      if !odst <> "" then
        Backend_latex.Gen.gen_file !odst el;
      if !dsts <> [] then (
        let env = Backend_latex.Splice.(env config el) in
        List.iter (Backend_latex.Splice.splice_file ~dry:!dry env) !dsts;
        if !warn then Backend_latex.Splice.warn env;
      );
    | Prose ->
      log "Prose Generation...";
      let ir_algos = Backend_prose.Il2ir.translate il in
      List.iter
        (fun algo -> Backend_prose.Print.string_of_algorithm algo |> print_endline)
        ir_algos;
      (*log "Interpret IR...";
      let result = Backend_prose.Interpreter.interpret ir_algos in
      print_endline result*)
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
