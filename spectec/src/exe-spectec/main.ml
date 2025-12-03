(* Configuration *)

let name = "spectec"
let version = "0.5"


(* Flags and parameters *)

type target =
 | Check
 | Ast
 | Latex
 | Prose of bool
 | Splice of Backend_splice.Config.t
 | Interpreter of string list

type pass =
  | Sub
  | Totalize
  | Unthe
  | Sideconditions
  | TypeFamilyRemoval
  | Else
  | Undep
  | Uncaseremoval
  | AliasDemut
  | Ite

(* This list declares the intended order of passes.

Because passes have dependencies, and because some flags enable multiple
passers (--all-passes, some targets), we do _not_ want to use the order of
flags on the command line.
*)
let _skip_passes = [ Unthe ]  (* Not clear how to extend them to indexed types *)
let all_passes = [
  Ite;
  TypeFamilyRemoval;
  Undep;
  Totalize;
  Else;
  Uncaseremoval;
  Sideconditions;
  Sub;
  AliasDemut;
]

type file_kind =
  | Spec
  | Patch
  | Output

let target = ref Check
let logging = ref false    (* log execution steps *)
let in_place = ref false   (* splice patch files in place *)
let dry = ref false        (* dry run for patching *)
let warn_math = ref false  (* warn about unused or reused math splices *)
let warn_prose = ref false (* warn about unused or reused prose splices *)

let file_kind = ref Spec
let srcs = ref []    (* spec src file arguments *)
let pdsts = ref []   (* patch file arguments *)
let odsts = ref []   (* output file arguments *)

let ast_width = ref Backend_ast.Config.default.width
let latex_macros = ref false

let print_el = ref false
let print_elab_il = ref false
let print_final_il = ref false
let print_all_il = ref false
let print_all_il_to = ref ""
let print_al = ref false
let print_al_o = ref ""
let print_no_pos = ref false

module PS = Set.Make(struct type t = pass let compare = compare; end)
let selected_passes = ref (PS.empty)
let enable_pass pass = selected_passes := PS.add pass !selected_passes


let print_il il =
  Printf.printf "%s\n%!" (Il.Print.string_of_script ~suppress_pos:(!print_no_pos) il)

let print_il_to pass_name pass_count il =
  let pass_name = if pass_name = "" then "elab" else pass_name in
  let pass_name = Printf.sprintf "%02d-%s" pass_count pass_name in
  if !print_all_il_to <> "" then
    let filename = Str.replace_first (Str.regexp "%s") pass_name !print_all_il_to in
    Out_channel.with_open_text filename (fun oc ->
      Out_channel.output_string oc (Il.Print.string_of_script ~suppress_pos:(!print_no_pos) il);
      Out_channel.output_string oc "\n"
    )


(* Il pass metadata *)

let pass_flag = function
  | Sub -> "sub"
  | Totalize -> "totalize"
  | Unthe -> "the-elimination"
  | Sideconditions -> "sideconditions"
  | TypeFamilyRemoval -> "typefamily-removal"
  | AliasDemut -> "alias-demut"
  | Else -> "else"
  | Undep -> "remove-indexed-types"
  | Uncaseremoval -> "uncase-removal"
  | Ite -> "ite"

let pass_desc = function
  | Sub -> "Synthesize explicit subtype coercions"
  | Totalize -> "Run function totalization"
  | Unthe -> "Eliminate the ! operator in relations"
  | Sideconditions -> "Infer side conditions"
  | TypeFamilyRemoval -> "Transform Type families into sum types"
  | Else -> "Eliminate the otherwise premise in relations"
  | Undep -> "Transform indexed types into types with well-formedness predicates"
  | Uncaseremoval -> "Eliminate the uncase expression"
  | AliasDemut -> "Lifts type aliases out of mutual groups"
  | Ite -> "If-then-else introduction"


let run_pass : pass -> Il.Ast.script -> Il.Ast.script = function
  | Sub -> Middlend.Sub.transform
  | Totalize -> Middlend.Totalize.transform
  | Unthe -> Middlend.Unthe.transform
  | Sideconditions -> Middlend.Sideconditions.transform
  | TypeFamilyRemoval -> Middlend.Typefamilyremoval.transform
  | Else -> Middlend.Else.transform
  | Undep -> Middlend.Undep.transform
  | Uncaseremoval -> Middlend.Uncaseremoval.transform
  | AliasDemut -> Middlend.AliasDemut.transform
  | Ite -> Middlend.Ite.transform


(* Argument parsing *)

let banner () =
  print_endline (name ^ " " ^ version ^ " generator")

let usage = "Usage: " ^ name ^ " [option] [file ...] [-p file ...] [-o file ...]"

let cmd_error msg =
  flush_all ();
  prerr_endline (Sys.argv.(0) ^ ": " ^ msg);
  exit 2

let add_arg source =
  let args =
    match !file_kind with
    | Spec -> srcs
    | Patch -> pdsts
    | Output -> odsts
  in args := !args @ [source]

let pass_argspec pass : Arg.key * Arg.spec * Arg.doc =
  "--" ^ pass_flag pass, Arg.Unit (fun () -> enable_pass pass), " " ^ pass_desc pass

let argspec = Arg.align (
[
  "-v", Arg.Unit banner, " Show version";
  "-p", Arg.Unit (fun () -> file_kind := Patch), " Patch files";
  "-i", Arg.Set in_place, " Splice patch files in-place";
  "-d", Arg.Set dry, " Dry run (when -p) ";
  "-o", Arg.Unit (fun () -> file_kind := Output), " Output files";
  "-l", Arg.Set logging, " Log execution steps";
  "-ll", Arg.Set Backend_interpreter.Runner.logging, " Log interpreter execution";
  "-dl", Arg.String (fun s -> Util.Debug_log.(active := s :: !active)),
    " Debug-log function";
  "-w", Arg.Unit (fun () -> warn_math := true; warn_prose := true),
    " Warn about unused or multiply used splices";
  "--warn-math", Arg.Set warn_math,
    " Warn about unused or multiply used math splices";
  "--warn-prose", Arg.Set warn_prose,
    " Warn about unused or multiply used prose splices";

  "--check", Arg.Unit (fun () -> target := Check), " Check only (default)";
  "--ast", Arg.Unit (fun () -> target := Ast), " Generate AST";
  "--latex", Arg.Unit (fun () -> target := Latex), " Generate Latex";
  "--splice-latex", Arg.Unit (fun () -> target := Splice Backend_splice.Config.latex),
    " Splice Sphinx";
  "--splice-sphinx", Arg.Unit (fun () -> target := Splice Backend_splice.Config.sphinx),
    " Splice Sphinx";
  "--prose", Arg.Unit (fun () -> target := Prose true), " Generate prose";
  "--prose-rst", Arg.Unit (fun () -> target := Prose false), " Generate prose";
  "--interpreter", Arg.Rest_all (fun args -> target := Interpreter args),
    " Generate interpreter";
  "--debug", Arg.Unit (fun () -> Backend_interpreter.Debugger.debug := true),
    " Debug interpreter";
  "--unified-vars", Arg.Unit (fun () -> Il2al.Unify.rename := false),
    " Use unified variables (_u) in AL";
  "--ast-width", Arg.Set_int ast_width, " Line width for pretty-printing AST (default 80)";
  "--latex-macros", Arg.Set latex_macros, " Splice Latex with macro invocations";

  "--print-el", Arg.Set print_el, " Print EL";
  "--print-il", Arg.Set print_elab_il, " Print IL (after elaboration)";
  "--print-final-il", Arg.Set print_final_il, " Print final IL";
  "--print-all-il", Arg.Set print_all_il, " Print IL after each step";
  "--print-all-il-to", Arg.Set_string print_all_il_to, " Print IL after each step to file (with %s replaced by pass numer and name)";
  "--print-al", Arg.Set print_al, " Print al";
  "--print-al-o", Arg.Set_string print_al_o, " Print al with given name";
  "--print-no-pos", Arg.Set print_no_pos, " Suppress position info in output";
] @ List.map pass_argspec all_passes @ [
  "--all-passes", Arg.Unit (fun () -> List.iter enable_pass all_passes)," Run all passes";

  "--test-version", Arg.Int (fun i -> Backend_interpreter.Construct.version := i), " Wasm version to assume for tests (default: 3)";

  "-help", Arg.Unit ignore, "";
  "--help", Arg.Unit ignore, "";
] )


(* Main *)

let log s = if !logging then Printf.printf "== %s\n%!" s

let () =
  Printexc.record_backtrace true;
  let last_pass = ref "" in
  let pass_count = ref 0 in
  try
    Arg.parse argspec add_arg usage;
    log "Parsing...";
    let el = List.concat_map Frontend.Parse.parse_file !srcs in
    if !print_el then
      Printf.printf "%s\n%!" (El.Print.string_of_script el);
    log "Elaboration...";
    let il, elab_env = Frontend.Elab.elab el in
    if !print_elab_il || !print_all_il then print_il il;
    print_il_to !last_pass !pass_count il;
    log "IL Validation...";
    Il.Valid.valid il;

    (match !target with
    | Prose _ | Splice _ | Interpreter _ ->
      enable_pass Sideconditions;
    | _ when !print_al || !print_al_o <> "" ->
      enable_pass Sideconditions;
    | _ -> ()
    );

    let il =
      List.fold_left (fun il pass ->
        if not (PS.mem pass !selected_passes) then il else
        (
          last_pass := pass_flag pass;
          pass_count := !pass_count + 1;
          log ("Running pass " ^ pass_flag pass ^ "...");
          let il = run_pass pass il in
          if !print_all_il then print_il il;
          print_il_to !last_pass !pass_count il;
          log ("IL Validation after pass " ^ pass_flag pass ^ "...");
          Il.Valid.valid il;
          il
        )
      ) il all_passes
    in
    last_pass := "";

    if !print_final_il && not !print_all_il then print_il il;

    let al =
      if not !print_al && !print_al_o = "" && (!target = Check || !target = Ast || !target = Latex) then []
      else (
        log "Translating to AL...";
        let interp = match !target with
        | Interpreter _ -> true
        | _ -> false in
        Il2al.Translate.translate il interp @ Il2al.Manual.manual_algos
      )
    in

    let match_algo_name algo_name al_elt =
      algo_name = "" ||
      (match al_elt.Util.Source.it with
      | Al.Ast.RuleA (a, _, _, _) ->
        Al.Print.string_of_atom a = String.uppercase_ascii algo_name
      | Al.Ast.FuncA (id , _, _) ->
        id = String.lowercase_ascii algo_name)
    in

    if !print_al then
      Printf.printf "%s\n%!"
        (List.map Al.Print.string_of_algorithm al |> String.concat "\n")
    else if !print_al_o <> "" then
      Printf.printf "%s\n%!"
        (List.filter (match_algo_name !print_al_o) al |> List.map Al.Print.string_of_algorithm |> String.concat "\n");

    (* WIP
    log "AL Validation...";
    Al.Valid.valid al;
    *)

    (match !target with
    | Check -> ()

    | Ast ->
      log "AST Generation...";
      let config = Backend_ast.Config.{width = !ast_width} in
      (match !odsts with
      | [] ->
        Backend_ast.Print.output_script stdout config il;
        print_endline ""
      | [odst] ->
        Out_channel.with_open_text odst (fun oc ->
          Backend_ast.Print.output_script oc config il;
          Out_channel.output_string oc "\n"
        )
      | _ -> cmd_error "too many output file names"
      )

    | Latex ->
      log "Latex Generation...";
      let config =
        Backend_latex.Config.{default with macros_for_ids = !latex_macros} in
      (match !odsts with
      | [] -> print_endline (Backend_latex.Gen.gen_string config el)
      | [odst] -> Backend_latex.Gen.gen_file config odst el
      | _ -> cmd_error "too many output file names"
      )

    | Prose as_plaintext ->
      log "Prose Generation...";
      let config_latex = Backend_latex.Config.default in
      let config_prose = Backend_prose.Config.{panic_on_error = false} in
      (match !odsts with
      | [] ->
          if as_plaintext then
            Backend_prose.Gen.gen_prose el il al
            |> Backend_prose.Print.string_of_prose
            |> print_endline
          else
            print_endline (Backend_prose.Gen.gen_string config_latex config_prose el il al)
      | [odst] ->
          if as_plaintext then
            Backend_prose.Gen.gen_prose el il al
            |> Backend_prose.Print.file_of_prose odst
          else
            Backend_prose.Gen.gen_file config_latex config_prose odst el il al
      | _ -> cmd_error "too many output file names"
      )

    | Splice config ->
      if !in_place then
        odsts := !pdsts
      else
      (
        match !odsts with
        | [] -> odsts := List.map (Fun.const "") !pdsts
        | [odst] when Sys.file_exists odst && Sys.is_directory odst ->
          odsts := List.map (fun pdst -> Filename.concat odst pdst) !pdsts
        | _ when List.length !odsts = List.length !pdsts -> ()
        | _ -> cmd_error "inconsistent number of input and output file names"
      );
      log "Prose Generation...";
      let prose = Backend_prose.Gen.gen_prose el il al in
      log "Splicing...";
      let config' =
        Backend_splice.Config.{config with latex = Backend_latex.Config.{config.latex with
          macros_for_ids = !latex_macros
        }}
      in
      let env = Backend_splice.Splice.(env config' !pdsts !odsts elab_env el prose) in
      List.iter2 (Backend_splice.Splice.splice_file ~dry:!dry env) !pdsts !odsts;
      if !warn_math then Backend_splice.Splice.warn_math env;
      if !warn_prose then Backend_splice.Splice.warn_prose env;

    | Interpreter args ->
      log "Initializing interpreter...";
      Backend_interpreter.Ds.init al;
      log "Interpreting...";
      Backend_interpreter.Runner.run args
    );
    log "Complete."
  with
  | Util.Error.Error (at, msg) as exn ->
    let msg' =
      if !last_pass <> "" && String.starts_with ~prefix:"validation" msg then
        "(after pass " ^ !last_pass ^ ") " ^ msg
      else
        msg
    in
    Util.Error.print_error at msg';
    Util.Debug_log.log_exn exn;
    exit 1
  | Sys_error msg ->
    flush_all ();
    prerr_endline msg;
    exit 2
  | exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    prerr_endline "\nBacktrace:";
    Printexc.print_backtrace stderr;
    exit 2
