open Util


(* Configuration *)

let name = "watsup"
let version = "0.4"


(* Flags and parameters *)

type target =
 | Check
 | Latex
 | Prose
 | Splice of Backend_splice.Config.config
 | Interpreter of string list

let target = ref Latex

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

let log = ref false      (* log execution steps *)
let in_place = ref false (* splice patch files in place *)
let warn = ref false     (* warn about unused or reused splices *)

type file_kind =
  | Spec
  | Patch
  | Output
let file_kind = ref Spec
let srcs = ref []    (* spec src file arguments *)
let pdsts = ref []   (* patch file arguments *)
let odsts = ref []   (* output file arguments *)

let print_el = ref false
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
  | Animate -> Il2al.Animate.transform


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
  "-i", Arg.Set in_place, " Splice patch files in-place";
  "-o", Arg.Unit (fun () -> file_kind := Output), " Output files";
  "-l", Arg.Set log, " Log execution steps";
  "-w", Arg.Set warn, " Warn about unused or multiply used splices";

  "--check", Arg.Unit (fun () -> target := Check), " Check only";
  "--latex", Arg.Unit (fun () -> target := Latex),
    " Generate Latex (default)";
  "--splice-latex", Arg.Unit (fun () -> target := Splice Backend_splice.Config.latex),
    " Splice Sphinx";
  "--splice-sphinx", Arg.Unit (fun () -> target := Splice Backend_splice.Config.sphinx),
    " Splice Sphinx";
  "--prose", Arg.Unit (fun () -> target := Prose), " Generate prose";
  "--interpreter", Arg.Rest_all (fun args -> target := Interpreter args), " Generate interpreter";

  "--print-el", Arg.Set print_el, " Print EL";
  "--print-il", Arg.Set print_elab_il, " Print IL (after elaboration)";
  "--print-final-il", Arg.Set print_final_il, " Print final IL";
  "--print-all-il", Arg.Set print_all_il, " Print IL after each step";
  "--print-al", Arg.Set print_al, " Print al";
] @ List.map pass_argspec all_passes @ [
  "--all-passes", Arg.Unit (fun () -> List.iter enable_pass all_passes)," Run all passes";

  "--test-version", Arg.Int (fun i -> Backend_interpreter.Construct.version := i), " The version of wasm, default to 3";

  "-help", Arg.Unit ignore, "";
  "--help", Arg.Unit ignore, "";
]


(* Main *)

let log s = if !log then Printf.printf "== %s\n%!" s

let () =
  Printexc.record_backtrace true;
  let last_pass = ref "" in
  try
    Arg.parse argspec add_arg usage;
    log "Parsing...";
    let el = List.concat_map Frontend.Parse.parse_file !srcs in
    if !print_el then
      Printf.printf "%s\n%!" (El.Print.string_of_script el);
    log "Elaboration...";
    let il = Frontend.Elab.elab el in
    if !print_elab_il || !print_all_il then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);
    log "IL Validation...";
    Il.Validation.valid il;


    (match !target with
    | Prose | Interpreter _ -> enable_pass Sideconditions; enable_pass Animate
    | _ -> ());

    let il =
      List.fold_left (fun il pass ->
        if not (PS.mem pass !selected_passes) then il else
        (
          last_pass := pass_flag pass;
          log ("Running pass " ^ pass_flag pass ^ "...");
          let il = run_pass pass il in
          if !print_all_il then Printf.printf "%s\n%!" (Il.Print.string_of_script il);
          log ("IL Validation after pass " ^ pass_flag pass ^ "...");
          Il.Validation.valid il;
          il
        )
      ) il all_passes
    in

    if !print_final_il && not !print_all_il then
      Printf.printf "%s\n%!" (Il.Print.string_of_script il);

    let al = if !target = Check || not (PS.mem Animate !selected_passes) then [] else (
      log "Translating to AL...";
      (Il2al.Translate.translate il @ Backend_interpreter.Manual.manual_algos)
    ) in

    if !print_al then
      Printf.printf "%s\n%!" (List.map Al.Print.string_of_algorithm al |> String.concat "\n");

    (match !target with
    | Check -> ()
    | Latex ->
      log "Latex Generation...";
      (match !odsts with
      | [] -> print_endline (Backend_latex.Gen.gen_string el)
      | odst :: _ -> Backend_latex.Gen.gen_file odst el
      )
    | Prose ->
      let prose = Backend_prose.Gen.gen_prose il al in
      print_endline "=================";
      print_endline " Generated prose ";
      print_endline "=================";
      print_endline (Backend_prose.Print.string_of_prose prose);
    | Splice config ->
      let prose = Backend_prose.Gen.gen_prose il al in
      if !in_place then odsts := !pdsts;
      odsts := !odsts @ List.init (List.length !pdsts - List.length !odsts) (fun _ -> ""); (* TODO *)
      let env = Backend_splice.Splice.(env config !pdsts !odsts el prose) in
      List.iter2 (Backend_splice.Splice.splice_file env) !pdsts !odsts;
      if !warn then Backend_splice.Splice.warn env;
    | Interpreter args ->
      log "Initializing AL interprter with generated AL...";
      Backend_interpreter.Ds.init al;
      log "Interpreting AL...";
      Backend_interpreter.Runner.run args
    );
    log "Complete."
  with
  | Source.Error (at, msg) ->
    let pass = if !last_pass = "" then "" else "(pass " ^ !last_pass ^ ") " in
    prerr_endline (Source.string_of_region at ^ ": " ^ pass ^ msg);
    exit 1
  | exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
