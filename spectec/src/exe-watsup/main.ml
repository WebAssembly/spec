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

type pass =
  | Sub
  | Totalize
  | Unthe
  | Wild
  | Sideconditions
  | Animate

(* This list declares the intended order of passes.

Because passes have dependencies, and because some flags enable multiple
passers (--all-passes, some targets), we do _not_ want to use the order of
flags on the command line.
*)
let all_passes = [ Sub; Totalize; Unthe; Wild; Sideconditions; Animate ]

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

module PS = Set.Make(struct type t = pass let compare = compare; end)
let selected_passes = ref (PS.empty)
let enable_pass pass = selected_passes := PS.add pass !selected_passes

(* Il pass metadata *)

let pass_flag = function
  | Sub -> "sub"
  | Totalize -> "totalize"
  | Unthe -> "the-elimination"
  | Wild -> "wildcards"
  | Sideconditions -> "sideconditions"
  | Animate -> "animate"

let pass_desc = function
  | Sub -> "Synthesize explicit subtype coercions"
  | Totalize -> "Run function totalization"
  | Unthe -> "Eliminate the ! operator in relations"
  | Wild -> "Eliminate wildcards and equivalent expressions"
  | Sideconditions -> "Infer side conditions"
  | Animate -> "Animate equality conditions"

let run_pass : pass -> Il.Ast.script -> Il.Ast.script = function
  | Sub -> Middlend.Sub.transform
  | Totalize -> Middlend.Totalize.transform
  | Unthe -> Middlend.Unthe.transform
  | Wild -> Middlend.Wild.transform
  | Sideconditions -> Middlend.Sideconditions.transform
  | Animate -> Middlend.Animate.transform

(* Argument parsing *)

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...] [-p file ...]"

let add_arg source =
  let args = if !dst then dsts else srcs in args := !args @ [source]

let pass_argspec pass : Arg.key * Arg.spec * Arg.doc =
  "--" ^ pass_flag pass, Arg.Unit (fun () -> enable_pass pass), " " ^ pass_desc pass

let argspec = Arg.align
[
  "-v", Arg.Unit banner, " Show version";
  "-o", Arg.String (fun s -> odst := s), " Generate file";
  "-p", Arg.Set dst, " Patch files";
  "-d", Arg.Set dry, " Dry run (when -p) ";
  "-l", Arg.Set log, " Log execution steps";
  "-w", Arg.Set warn, " Warn about unused or multiply used splices";

  "--check", Arg.Unit (fun () -> target := Check), " Check only";
  "--latex", Arg.Unit (fun () -> target := Latex Backend_latex.Config.latex),
    " Generate Latex (default)";
  "--sphinx", Arg.Unit (fun () -> target := Latex Backend_latex.Config.sphinx),
    " Generate Latex for Sphinx";
  "--prose", Arg.Unit (fun () -> target := Prose), " Generate prose";

  "--print-il", Arg.Set print_elab_il, " Print il (after elaboration)";
  "--print-final-il", Arg.Set print_final_il, " Print final il";
  "--print-all-il", Arg.Set print_all_il, " Print il after each step";
] @ List.map pass_argspec all_passes @ [
  "--all-passes", Arg.Unit (fun () -> List.iter enable_pass all_passes)," Run all passes";

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
      let ir = true in
      if ir then
        let program = Backend_prose.Il2ir.translate il in
        List.map Backend_prose.Print.string_of_program program
        |> List.iter print_endline
      else (
        let prose = Backend_prose.Translate.translate el in
        print_endline prose
      )
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
