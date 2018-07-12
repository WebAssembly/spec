
let name = "wasm"
let version = "1.0"

let load_lookup fn =
  let open Yojson.Basic in
  let data = from_channel (open_in fn) in
  let lst = Util.to_assoc data in
  let res = Hashtbl.create 100 in
  List.iter (fun (a,b) -> Hashtbl.add res a (Util.to_string b); prerr_endline (a ^ ": " ^ Util.to_string b)) lst;
  res

let add_custom_judge str =
  match String.split_on_char ',' str with
  | [num; symbol; command] ->
    let num = int_of_string num in
    Hashtbl.add Merkle.custom_calls symbol num;
    if num < 100 then begin
       Hashtbl.add Mrun.custom_lookup num (load_lookup command)
    end
    else Hashtbl.add Mrun.custom_command num command
  | _ -> prerr_endline "bad format for custom judge"

let configure () =
  Import.register (Utf8.decode "spectest") Spectest.lookup;
  Import.register (Utf8.decode "input") Input.lookup;
  Import.register (Utf8.decode "global") Global.lookup;
  Import.register (Utf8.decode "global.Math") Global.lookup_math;
  Import.register (Utf8.decode "asm2wasm") Global.lookup_asm2wasm;
  Import.register (Utf8.decode "env") Env.lookup

let banner () =
  print_endline (name ^ " " ^ version ^ " reference interpreter")

let usage = "Usage: " ^ name ^ " [option] [file ...]"

let args = ref []
let add_arg source = args := !args @ [source]

let quote s = "\"" ^ String.escaped s ^ "\""

let merge_mode = ref false
let float_mode = ref false
let globals_file = ref None
let init_code = ref None
let shift_mem_mode : int option ref = ref None
let print_imports = ref false
let do_compile = ref false
let run_inited : string option ref = ref None
let underscore_mode = ref false
let counter_mode = ref false
let test_counter_mode = ref false
let handle_nan_mode = ref false

let critical_mode = ref false
let buildstack_mode = ref false
let elim_globals_mode = ref false

let export_global_mode : int option ref = ref None

let export_name = ref "DEFAULT_NAME"

let argspec = Arg.align
[
  "-", Arg.Set Flags.interactive,
    " run interactively (default if no files given)";
  "-e", Arg.String add_arg, " evaluate string";
  "-i", Arg.String (fun file -> add_arg ("(input " ^ quote file ^ ")")),
    " read script from file";
  "-o", Arg.String (fun file -> add_arg ("(output " ^ quote file ^ ")")),
    " write module to file";
  "-w", Arg.Int (fun n -> Flags.width := n),
    " configure output width (default is 80)";
  "-s", Arg.Set Flags.print_sig, " show module signatures";
  "-u", Arg.Set Flags.unchecked, " unchecked, do not perform validation";
  "-h", Arg.Clear Flags.harness, " exclude harness for JS conversion";
  "-d", Arg.Set Flags.dry, " dry, do not run program";
  "-t", Arg.Set Flags.trace, " trace execution";
  "-v", Arg.Unit banner, " show version";

  "-critical", Arg.Set critical_mode, " find the critical path to step";
  "-build-stack", Arg.Set buildstack_mode, " build the stack for critical path";
  "-elim-globals", Arg.Set elim_globals_mode, " change global variables to memory accesses";
  
  "-merge", Arg.Set merge_mode, " merge files";
  "-int-float", Arg.Set float_mode, " replace float operations with integer operations";
  "-export-global", Arg.Int (fun i -> export_global_mode := Some i), " export a global variable";
  "-name", Arg.String (fun s -> export_name := s), " name of element to export";

  "-shift-mem", Arg.Int (fun x -> shift_mem_mode := Some x), " shift memory by an offset";
  "-underscore", Arg.Set underscore_mode, " add underscores to all of the names";
  "-counter", Arg.Set counter_mode, " add a counter variable to the file";
  "-test-counter", Arg.Set test_counter_mode, " add a counter variable to the file (new test version)";
  "-handle-nan", Arg.Set handle_nan_mode, " canonize floating point values to remove non-determinism";
  "-add-globals", Arg.String (fun s -> globals_file := Some s), " add globals to the module";
  "-init-code", Arg.String (fun s -> add_arg ("(input " ^ quote s ^ ")") ; init_code := Some s), " output initial code for a wasm file";
  "-imports", Arg.Set print_imports, " print imports from the wasm file";
  "-compile", Arg.Set do_compile, " Compiles wasm file to C";
  "-hash-file", Arg.String Run.hash_file, " return the root hash of a file";
  "-gas-limit", Arg.String (fun str -> Flags.gas_limit := Int64.of_string str), " set gas limit. Use with flag -add-globals";

  "-trace-from", Arg.Int (fun n -> Flags.trace_from := n), " start tracing from a step";
  "-trace-stack", Arg.Set Flags.trace_stack, " trace execution stack";
  "-debug-error", Arg.Set Flags.debug_error, " try to find out why the interpreter failed";
  "-m", Arg.Set Flags.merkle, " merkle proof mode";
  "-asmjs", Arg.Set Flags.asmjs, " pre-processing for asm.js";
  "-micro", Arg.Set Flags.microstep, " merkle proof mode (microsteps)";
  "-init", Arg.Set Flags.init, " output initial state hash of a test case";
  "-init-vm", Arg.Set Flags.init_vm, " output initial vm of a test case";
  "-result", Arg.Set Flags.result, " output final state hash of a test case and the number of steps";
  "-case", Arg.Int (fun n -> Flags.case := n), " for which test case the hash or proofs will be generated";
  "-location", Arg.Int (fun n -> Flags.location := n), " for which step the hash will be generated";
  "-step", Arg.Int (fun n -> Flags.checkstep := n), " for which step the proofs will be generated";
  "-error-step", Arg.Int (fun n -> Flags.checkerror := n), " for which step the intermediate state will be generated";
  "-final", Arg.Int (fun n -> Flags.checkfinal := n), " generate finality proof for the specified step";
  "-insert-error", Arg.Int (fun n -> Flags.insert_error := n), " insert a simple error so that verifier and solver will disagree";
  "-memory-size", Arg.Int (fun sz -> Flags.memory_size := sz), " how deep the merkle tree for memory should be. Default 16";
  "-memory-offset", Arg.Int (fun sz -> Flags.memory_offset := sz), " memory offset for stubs";
  "-table-size", Arg.Int (fun sz -> Flags.table_size := sz), " how deep the merkle tree for the call table should be. Default 8";
  "-globals-size", Arg.Int (fun sz -> Flags.globals_size := sz), " how deep the merkle tree for the globals table have. Default 8";
  "-stack-size", Arg.Int (fun sz -> Flags.stack_size := sz), " how deep the merkle tree for the stack have. Default 14";
  "-call-stack-size", Arg.Int (fun sz -> Flags.call_size := sz), " how deep the merkle tree for the call stack have. Default 10";
(*  "-run-inited", Arg.String (fun file -> run_inited := Some file), "run pre-initialized code from a file."; *)
  "-wasm", Arg.String (fun file ->
    add_arg ("(input " ^ quote file ^ ")");
    Flags.run_wasm := true;
    Flags.case := 0;
    add_arg "(invoke \"_main\")"), " run main function from this file";
  "-file", Arg.String (fun file -> Flags.input_files := file :: !Flags.input_files), " add a file to the VM file system";
  "-arg", Arg.String (fun file -> Flags.arguments := file :: !Flags.arguments), " add command line argument to the VM";
  "-input-proof", Arg.String (fun file -> Flags.input_file_proof := Some file), " output proof that an input file is in the initial state";
  "-output-proof", Arg.String (fun file -> Flags.output_file_proof := Some file), " output proof that an output file is in the final state";
  "-output-proofs", Arg.Set Flags.output_all_file_proofs, " output proofs for all output files that are in the final state";
  "-input-proofs", Arg.Set Flags.input_all_file_proofs, " input proofs for all output files that are in the final state";
  "-input", Arg.Set Flags.input_proof, " output information about input";
  "-input2", Arg.Set Flags.input_out, " output information about input";
  "-output", Arg.Set Flags.output_proof, " output information about output";
  "-sbrk-offset", Arg.Int (fun n -> Flags.sbrk_offset := Int32.of_int n), " memory offset used by sbrk";
  "-output-step", Arg.Int (fun x -> Flags.output_file_at := x), " for which step the file will be output";
  "-output-file", Arg.Int (fun x -> Flags.output_file_number := x), " which file will be output at the given step";
  
  "-custom", Arg.String add_custom_judge, " Add custom judge. Format: num,symbol,judge";
]

let () =
  Printexc.record_backtrace true;
  try
    configure ();
    Arg.parse argspec
      (fun file -> add_arg ("(input " ^ quote file ^ ")")) usage;
    List.iter (fun arg -> if not (Run.run_string arg) then exit 1) !args;
    let lst = ref [] in
    Run.Map.iter (fun a b -> if a <> "" then lst := b :: !lst) !Run.modules;
    if !merge_mode then begin
      Run.trace ("Going to merge");
      match !lst with
      | a::b::_ ->
        Run.trace "found modules";
        let merged = Merge.merge b a in
        Run.create_binary_file "merge.wasm" () (fun () -> merged)
      | _ -> ()
    end;
    ( match !globals_file, !lst with
    | Some fn, m :: _ ->
      let m = Addglobals.add_globals m fn in
      Run.create_binary_file "globals.wasm" () (fun () -> m)
    | _ -> () );
    ( match !export_global_mode, !lst with
    | Some num, m :: _ ->
      let m = Addglobals.export_global m num (!export_name) in
      Run.create_binary_file "exported.wasm" () (fun () -> m)
    | _ -> () );
    ( match !elim_globals_mode, !lst with
    | true, m :: _ ->
      let m = Elimglobals.process m in
      Run.create_sexpr_file "eglobals.wast" () (fun () -> m);
      Run.create_binary_file "eglobals.wasm" () (fun () -> m)
    | _ -> () );
    ( match !critical_mode, !lst with
    | true, m :: _ ->
      let m = Critical.process m in
      Run.create_sexpr_file "critical.wast" () (fun () -> m);
      Run.create_binary_file "critical.wasm" () (fun () -> m)
    | _ -> () );
    ( match !buildstack_mode, !lst with
    | true, m :: _ ->
      let m = Buildstack.process m in
      Run.create_sexpr_file "buildstack.wast" () (fun () -> m);
      Run.create_binary_file "buildstack.wasm" () (fun () -> m)
    | _ -> () );
    ( match !float_mode, !lst with
    | true, a :: b :: _ ->
      let m = Intfloat.process a b in
      Run.create_sexpr_file "intfloat.wast" () (fun () -> m);
      Run.create_binary_file "intfloat.wasm" () (fun () -> m)
    | _ -> () );
    ( match !shift_mem_mode, !lst with
    | Some num, m :: _ ->
      let m = Shiftmem.process m num in
      Run.create_binary_file "shiftmem.wasm" () (fun () -> m)
    | _ -> () );
    ( match !underscore_mode, !lst with
    | true, m :: _ ->
      let m = Underscore.process m in
      Run.create_binary_file "underscore.wasm" () (fun () -> m)
    | _ -> () );
    ( match !counter_mode, !lst with
    | true, m :: _ ->
      let m = Counter.process m in
      Run.create_binary_file "counter.wasm" () (fun () -> m)
    | _ -> () );
    ( match !test_counter_mode, !lst with
    | true, m :: _ ->
      let m = Evallocation.process m in
      Run.create_binary_file "counter.wasm" () (fun () -> m)
    | _ -> () );
    ( match !handle_nan_mode, !lst with
    | true, m :: _ ->
      let m = Handlenan.process m in
      Run.create_binary_file "nan.wasm" () (fun () -> m)
    | _ -> () );
    ( match !init_code, !lst with
    | Some fn, m :: _ ->
      let open Source in
      let open Mrun in
      let inst = Run.lookup_instance None no_region in
      ( match Instance.export inst (Utf8.decode "_main") with
      | Some (Instance.ExternalFunc (Instance.AstFunc (_, func))) ->
        let vm = Run.setup_vm inst inst.Instance.module_.it func [] in
        let oc = open_out_bin "decoded.bin" in
        for i = 0 to Array.length vm.code - 1 do
          let inst = vm.code.(i) in
          output_bytes oc (Bytes.of_string (Mbinary.microp_word (get_code inst)))
        done;
        close_out oc
      | _ -> () )
    | _ -> () );
(*    ( match !run_inited with
    | Some file ->
       let ic = open_in file in
       let len = in_channel_length ic in
       let str = really_input_string ic len in
       (* blah, cannot actually execute it *)
       ()
    | None -> () ); *)
    ( match !do_compile, !lst with
    | true, m :: _ ->
      let open Source in
      let open Mrun in
      let inst = Run.lookup_instance None no_region in
      ( match Instance.export inst (Utf8.decode "_main") with
      | Some (Instance.ExternalFunc (Instance.AstFunc (_, func))) ->
        let vm = Run.setup_vm inst inst.Instance.module_.it func [] in
        print_string (Compiler.compile_all vm.code)
      | _ -> () )
    | _ -> () );
    ( match !print_imports, !lst with
    | true, m :: _ ->
      let open Source in
      let open Ast in
      let lst = Merkle.func_imports m in
      let import_name n = "[\"" ^ Utf8.encode n.it.module_name ^ "\",\"" ^ Utf8.encode n.it.item_name ^ "\"]" in
      Printf.printf "[%s]\n" (String.concat ", " (List.map import_name lst))
    | _ -> () );
    if !args = [] then Flags.interactive := true;
    if !Flags.interactive then begin
      Flags.print_sig := true;
      banner ();
      Run.run_stdin ()
    end
  with exn ->
    flush_all ();
    prerr_endline (Sys.argv.(0) ^ ": uncaught exception " ^ Printexc.to_string exn);
    Printexc.print_backtrace stderr;
    exit 2


