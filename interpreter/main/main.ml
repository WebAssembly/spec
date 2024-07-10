let name = "wasm"
let version = "3.0.0"

let all_handlers = [
  (module Handler_custom : Custom.Handler);
  (module Handler_name : Custom.Handler);
]

let configure custom_handlers =
  Import.register (Utf8.decode "spectest") Spectest.lookup;
  Import.register (Utf8.decode "env") Env.lookup;
  List.iter Custom.register custom_handlers

let banner () =
  print_endline (name ^ " " ^ version ^ " reference interpreter")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]

let customs = ref []
let add_custom name =
  let n = Utf8.decode name in
  match List.find_opt (fun (module H : Custom.Handler) -> n = H.name) all_handlers with
  | Some h -> customs := !customs @ [h]
  | None ->
    prerr_endline ("option -c: unknown custom section \"" ^ name ^ "\"");
    exit 1

let quote s = "\"" ^ String.escaped s ^ "\""

let argspec = Arg.align
[
  "-", Arg.Set Flags.interactive,
    " run interactively (default if no files given)";
  "-e", Arg.String add_arg, " evaluate string";
  "-i", Arg.String (fun file -> add_arg ("(input " ^ quote file ^ ")")),
    " read script from file";
  "-o", Arg.String (fun file -> add_arg ("(output " ^ quote file ^ ")")),
    " write module to file";
  "-b", Arg.Int (fun n -> Flags.budget := n),
    " configure call depth budget (default is " ^ string_of_int !Flags.budget ^ ")";
  "-w", Arg.Int (fun n -> Flags.width := n),
    " configure output width (default is " ^ string_of_int !Flags.width ^ ")";
  "-c", Arg.String add_custom,
    " recognize custom section";
  "-ca", Arg.Unit (fun () -> customs := all_handlers),
    " recognize all known custom section";
  "-cr", Arg.Set Flags.custom_reject,
    " reject unrecognized custom sections";
  "-s", Arg.Set Flags.print_sig, " show module signatures";
  "-u", Arg.Set Flags.unchecked, " unchecked, do not perform validation";
  "-j", Arg.Clear Flags.harness, " exclude harness for JS conversion";
  "-d", Arg.Set Flags.dry, " dry, do not run program";
  "-t", Arg.Set Flags.trace, " trace execution";
  "-v", Arg.Unit banner, " show version"
]

let () =
  Printexc.record_backtrace true;
  try
    Arg.parse argspec
      (fun file -> add_arg ("(input " ^ quote file ^ ")")) usage;
    configure !customs;
    List.iter (fun arg -> if not (Run.run_string arg) then exit 1) !args;
    if !args = [] then Flags.interactive := true;
    if !Flags.interactive then begin
      Flags.print_sig := true;
      banner ();
      Run.run_stdin ()
    end
  with exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
