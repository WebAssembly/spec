let name = "Wasm-" ^ Printf.sprintf "0x%02lx" Encode.version
let version = "0.4"

let configure () =
  Import.register "spectest" Spectest.lookup;
  Import.register "env" Env.lookup

let banner () =
  print_endline (name ^ " " ^ version ^ " spec interpreter")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]

let argspec = Arg.align
[
  "-", Arg.Set Flags.interactive,
    " run interactively (default if no files given)";
  "-e", Arg.String add_arg, " evaluate string";
  "-i", Arg.String (fun file -> add_arg ("(input \"" ^ file ^ "\")")),
    " read script from file";
  "-o", Arg.String (fun file -> add_arg ("(output \"" ^ file ^ "\")")),
    " write module to file";
  "-w", Arg.Int (fun n -> Flags.width := n),
    " configure output width (default is 80)";
  "-s", Arg.Set Flags.print_sig, " show module signatures";
  "-u", Arg.Set Flags.unchecked, " unchecked, do not perform validation";
  "-d", Arg.Set Flags.dry, " dry, do not run program";
  "-t", Arg.Set Flags.trace, " trace execution";
  "-v", Arg.Unit banner, " show version"
]

let () =
  Printexc.record_backtrace true;
  try
    configure ();
    Arg.parse argspec (fun file -> add_arg ("(input \"" ^ file ^ "\")")) usage;
    List.iter (fun arg -> if not (Run.run_string arg) then exit 1) !args;
    if !Flags.interactive || !args = [] then begin
      banner ();
      Run.run_stdin ()
    end
  with exn ->
    flush_all ();
    prerr_endline
      (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2
