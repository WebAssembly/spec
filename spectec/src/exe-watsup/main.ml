open Util


(* Configuration *)

let name = "watsup"
let version = "0.3"


(* Flags and parameters *)

type target =
 | Check
 | Latex
 | Prose
 | Splice of Backend_latex.Config.config
 | Interpreter

let target = ref Latex

type pass =
  | Sub
  | Totalize
  | Unthe
  | Sideconditions
  | Animate

(* This list declares the intended order of passes.

Because passes have dependencies, and because some flags enable multiple
passers (--all-passes, some targets), we do _not_ want to use the order of
flags on the command line.
*)
let all_passes = [ Sub; Totalize; Unthe; Sideconditions; Animate ]

let log = ref false  (* log execution steps *)
let warn = ref false (* warn about unused or reused splices *)

type file_kind =
  | Spec
  | Patch
  | Output
let file_kind = ref Spec
let srcs = ref []    (* spec src file arguments *)
let pdsts = ref []   (* patch file arguments *)
let odsts = ref []   (* output file arguments *)

let print_elab_il = ref false
let print_final_il = ref false
let print_all_il = ref false
let print_al = ref false

module PS = Set.Make(struct type t = pass let compare = compare; end)
let selected_passes = ref (PS.empty)
let enable_pass pass = selected_passes := PS.add pass !selected_passes

(* Il pass metadata *)

let pass_flag = function
  | Sub -> "sub"
  | Totalize -> "totalize"
  | Unthe -> "the-elimination"
  | Sideconditions -> "sideconditions"
  | Animate -> "animate"

let pass_desc = function
  | Sub -> "Synthesize explicit subtype coercions"
  | Totalize -> "Run function totalization"
  | Unthe -> "Eliminate the ! operator in relations"
  | Sideconditions -> "Infer side conditions"
  | Animate -> "Animate equality conditions"

let run_pass : pass -> Il.Ast.script -> Il.Ast.script = function
  | Sub -> Middlend.Sub.transform
  | Totalize -> Middlend.Totalize.transform
  | Unthe -> Middlend.Unthe.transform
  | Sideconditions -> Middlend.Sideconditions.transform
  | Animate -> Middlend.Animate.transform

(* Argument parsing *)

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...] [-p file ...] [-o file ...]"

let add_arg source =
  let args = match !file_kind with
  | Spec -> srcs
  | Patch -> pdsts
  | Output -> odsts in
  args := !args @ [source]

let pass_argspec pass : Arg.key * Arg.spec * Arg.doc =
  "--" ^ pass_flag pass, Arg.Unit (fun () -> enable_pass pass), " " ^ pass_desc pass

let argspec = Arg.align
[
  "-v", Arg.Unit banner, " Show version";
  "-p", Arg.Unit (fun () -> file_kind := Patch), " Patch files";
  "-o", Arg.Unit (fun () -> file_kind := Output), " Output files";
  "-l", Arg.Set log, " Log execution steps";
  "-w", Arg.Set warn, " Warn about unused or multiply used splices";

  "--check", Arg.Unit (fun () -> target := Check), " Check only";
  "--latex", Arg.Unit (fun () -> target := Latex),
    " Generate Latex (default)";
  "--splice-latex", Arg.Unit (fun () -> target := Splice Backend_latex.Config.latex),
    " Splice Sphinx";
  "--splice-sphinx", Arg.Unit (fun () -> target := Splice Backend_latex.Config.sphinx),
    " Splice Sphinx";
  "--prose", Arg.Unit (fun () -> target := Prose), " Generate prose";
  "--interpreter", Arg.Unit (fun () -> target := Interpreter), " Generate interpreter";

  "--print-il", Arg.Set print_elab_il, " Print il (after elaboration)";
  "--print-final-il", Arg.Set print_final_il, " Print final il";
  "--print-all-il", Arg.Set print_all_il, " Print il after each step";
  "--print-al", Arg.Set print_al, " Print al";
] @ List.map pass_argspec all_passes @ [
  "--all-passes", Arg.Unit (fun () -> List.iter enable_pass all_passes)," Run all passes";

  "--root", Arg.String (fun s -> Backend_interpreter.Tester.root := s), " Set the root of watsup. Defaults to current directory";
  "--test-interpreter", Arg.String (fun s -> Backend_interpreter.Tester.test_name := s), " The name of .wast test file for interpreter";

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

    let il = List.fold_left (fun il pass ->
      if PS.mem pass !selected_passes
      then (
        log ("Running pass " ^ pass_flag pass);
        let il = run_pass pass il in
        if !print_all_il then Printf.printf "%s\n%!" (Il.Print.string_of_script il);
        log "IL Validation...";
        Il.Validation.valid il;
        il
      ) else il
    ) il all_passes in

    if !print_final_il && not !print_all_il then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);

    (match !target with
    | Check -> ()
    | Latex ->
      log "Latex Generation...";
      (match !odsts with
      | [] -> print_endline (Backend_latex.Gen.gen_string el)
      | odst :: _ -> Backend_latex.Gen.gen_file odst el
      )
    | Prose ->
      if not (PS.mem Animate !selected_passes) then
        failwith "Prose generatiron requires `--animate` flag."
      else
      log "Translating to AL...";
      let al =
        Backend_interpreter.Translate.translate il
        @ Backend_interpreter.Manual.manual_algos in
      (*log "AL Validation...";
      Backend_interpreter.Validation.valid al;*)
      let prose = Backend_prose.Gen.gen_prose il al in
      print_endline "=================";
      print_endline " Generated prose ";
      print_endline "=================";
      print_endline (Backend_prose.Print.string_of_prose prose);
    | Splice config ->
        let _al = if not (PS.mem Animate !selected_passes) then [] else
          Backend_interpreter.Translate.translate il
          @ Backend_interpreter.Manual.manual_algos in
        let env = Backend_splice.Splice.(env config el) in
        odsts := !odsts @ List.init (List.length !pdsts - List.length !odsts) (fun _ -> "");
        List.iter2 (Backend_splice.Splice.splice_file env) !pdsts !odsts;
        if !warn then Backend_splice.Splice.warn env;
    | Interpreter ->
      if not (PS.mem Animate !selected_passes) then
        failwith "Interpreter generatiron requires `--animate` flag."
      else
      log "Translating to AL...";
      let al =
        Backend_interpreter.Translate.translate il
        @ Backend_interpreter.Manual.manual_algos in
      if !print_al then
        List.iter (fun algo -> Al.Print.string_of_algorithm algo |> print_endline) al;
      (*log "AL Validation...";
      Backend_interpreter.Validation.valid al;*)
      log "Initializing AL interprter with generated AL...";
      Backend_interpreter.Interpreter.init al;
      log "Interpreting AL...";
      Backend_interpreter.Tester.test_all ()
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
