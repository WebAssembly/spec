open Script
open Source

(* Errors & Tracing *)

module Abort = Error.Make ()
module Assert = Error.Make ()
module IO = Error.Make ()

exception Abort = Abort.Error
exception Assert = Assert.Error
exception IO = IO.Error

let trace name = if !Flags.trace then print_endline ("-- " ^ name)


(* File types *)

let binary_ext = "wasm"
let sexpr_ext = "wat"
let script_binary_ext = "bin.wast"
let script_ext = "wast"
let js_ext = "js"

let dispatch_file_ext on_binary on_sexpr on_script_binary on_script on_js file =
  if Filename.check_suffix file binary_ext then
    on_binary file
  else if Filename.check_suffix file sexpr_ext then
    on_sexpr file
  else if Filename.check_suffix file script_binary_ext then
    on_script_binary file
  else if Filename.check_suffix file script_ext then
    on_script file
  else if Filename.check_suffix file js_ext then
    on_js file
  else
    raise (Sys_error (file ^ ": unrecognized file type"))


(* Output *)

let create_binary_file file _ get_module =
  trace ("Encoding (" ^ file ^ ")...");
  let s = Encode.encode (get_module ()) in
  let oc = open_out_bin file in
  try
    trace "Writing...";
    output_string oc s;
    close_out oc
  with exn -> close_out oc; raise exn

let create_sexpr_file file _ get_module =
  trace ("Writing (" ^ file ^ ")...");
  let oc = open_out file in
  try
    Print.module_ oc !Flags.width (get_module ());
    close_out oc
  with exn -> close_out oc; raise exn

let create_script_file mode file get_script _ =
  trace ("Writing (" ^ file ^ ")...");
  let oc = open_out file in
  try
    Print.script oc !Flags.width mode (get_script ());
    close_out oc
  with exn -> close_out oc; raise exn

let create_js_file file get_script _ =
  trace ("Converting (" ^ file ^ ")...");
  let js = Js.of_script (get_script ()) in
  let oc = open_out file in
  try
    trace "Writing...";
    output_string oc js;
    close_out oc
  with exn -> close_out oc; raise exn

let output_file =
  dispatch_file_ext
    create_binary_file
    create_sexpr_file
    (create_script_file `Binary)
    (create_script_file `Textual)
    create_js_file

let output_stdout get_module =
  trace "Printing...";
  Print.module_ stdout !Flags.width (get_module ())


(* Input *)

let error at category msg =
  trace ("Error: ");
  prerr_endline (Source.string_of_region at ^ ": " ^ category ^ ": " ^ msg);
  false

let input_from get_script run =
  try
    let script = get_script () in
    trace "Running...";
    run script;
    true
  with
  | Decode.Code (at, msg) -> error at "decoding error" msg
  | Parse.Syntax (at, msg) -> error at "syntax error" msg
  | Valid.Invalid (at, msg) -> error at "invalid module" msg
  | Import.Unknown (at, msg) -> error at "link failure" msg
  | Eval.Link (at, msg) -> error at "link failure" msg
  | Eval.Trap (at, msg) -> error at "runtime trap" msg
  | Eval.Exhaustion (at, msg) -> error at "resource exhaustion" msg
  | Eval.Crash (at, msg) -> error at "runtime crash" msg
  | Encode.Code (at, msg) -> error at "encoding error" msg
  | IO (at, msg) -> error at "i/o error" msg
  | Assert (at, msg) -> error at "assertion failure" msg
  | Abort _ -> false

let input_script start name lexbuf run =
  input_from (fun _ -> Parse.parse name lexbuf start) run

let input_sexpr name lexbuf run =
  input_from (fun _ ->
    let var_opt, def = Parse.parse name lexbuf Parse.Module in
    [Module (var_opt, def) @@ no_region]) run

let input_binary name buf run =
  let open Source in
  input_from (fun _ ->
    [Module (None, Encoded (name, buf) @@ no_region) @@ no_region]) run

let input_sexpr_file input file run =
  trace ("Loading (" ^ file ^ ")...");
  let ic = open_in file in
  try
    let lexbuf = Lexing.from_channel ic in
    trace "Parsing...";
    let success = input file lexbuf run in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let input_binary_file file run =
  trace ("Loading (" ^ file ^ ")...");
  let ic = open_in_bin file in
  try
    let len = in_channel_length ic in
    let buf = Bytes.make len '\x00' in
    really_input ic buf 0 len;
    trace "Decoding...";
    let success = input_binary file (Bytes.to_string buf) run in
    close_in ic;
    success
  with exn -> close_in ic; raise exn

let input_js_file file run =
  raise (Sys_error (file ^ ": unrecognized input file type"))

let input_file file run =
  dispatch_file_ext
    input_binary_file
    (input_sexpr_file input_sexpr)
    (input_sexpr_file (input_script Parse.Script))
    (input_sexpr_file (input_script Parse.Script))
    input_js_file
    file run

let input_string string run =
  trace ("Running (\"" ^ String.escaped string ^ "\")...");
  let lexbuf = Lexing.from_string string in
  trace "Parsing...";
  input_script Parse.Script "string" lexbuf run


(* Interactive *)

let continuing = ref false

let lexbuf_stdin buf len =
  let prompt = if !continuing then "  " else "> " in
  print_string prompt; flush_all ();
  continuing := true;
  let rec loop i =
    if i = len then i else
    let ch = input_char stdin in
    Bytes.set buf i ch;
    if ch = '\n' then i + 1 else loop (i + 1)
  in
  let n = loop 0 in
  if n = 1 then continuing := false else trace "Parsing...";
  n

let input_stdin run =
  let lexbuf = Lexing.from_function lexbuf_stdin in
  let rec loop () =
    let success = input_script Parse.Script1 "stdin" lexbuf run in
    if not success then Lexing.flush_input lexbuf;
    if Lexing.(lexbuf.lex_curr_pos >= lexbuf.lex_buffer_len - 1) then
      continuing := false;
    loop ()
  in
  try loop () with End_of_file ->
    print_endline "";
    trace "Bye."


(* Printing *)

let print_import m im =
  let open Types in
  let category, annotation =
    match Ast.import_type m im with
    | ExternalFuncType t -> "func", string_of_func_type t
    | ExternalTableType t -> "table", string_of_table_type t
    | ExternalMemoryType t -> "memory", string_of_memory_type t
    | ExternalGlobalType t -> "global", string_of_global_type t
  in
  Printf.printf "  import %s \"%s\" \"%s\" : %s\n"
    category (Ast.string_of_name im.it.Ast.module_name)
      (Ast.string_of_name im.it.Ast.item_name) annotation

let print_export m ex =
  let open Types in
  let category, annotation =
    match Ast.export_type m ex with
    | ExternalFuncType t -> "func", string_of_func_type t
    | ExternalTableType t -> "table", string_of_table_type t
    | ExternalMemoryType t -> "memory", string_of_memory_type t
    | ExternalGlobalType t -> "global", string_of_global_type t
  in
  Printf.printf "  export %s \"%s\" : %s\n"
    category (Ast.string_of_name ex.it.Ast.name) annotation

let print_module x_opt m =
  Printf.printf "module%s :\n"
    (match x_opt with None -> "" | Some x -> " " ^ x.it);
  List.iter (print_import m) m.it.Ast.imports;
  List.iter (print_export m) m.it.Ast.exports;
  flush_all ()

let print_result vs =
  let ts = List.map Values.type_of vs in
  Printf.printf "%s : %s\n"
    (Values.string_of_values vs) (Types.string_of_value_types ts);
  flush_all ()


(* Configuration *)

module Map = Map.Make(String)

let quote : script ref = ref []
let scripts : script Map.t ref = ref Map.empty
let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.instance Map.t ref = ref Map.empty
let registry : Instance.instance Map.t ref = ref Map.empty

let anon = ref 0

let bind map x_opt y =
  let map' =
    match x_opt with
    | None -> incr anon; Map.add ("anon_" ^ string_of_int !anon) y !map
    | Some x -> Map.add x.it y !map
  in map := Map.add "" y map'

let lookup category map x_opt at =
  let key = match x_opt with None -> "" | Some x -> x.it in
  try Map.find key !map with Not_found ->
    IO.error at
      (if key = "" then "no " ^ category ^ " defined"
       else "unknown " ^ category ^ " " ^ key)

let lookup_script = lookup "script" scripts
let lookup_module = lookup "module" modules
let lookup_instance = lookup "module" instances

let lookup_registry module_name item_name _t =
  match Instance.export (Map.find module_name !registry) item_name with
  | Some ext -> ext
  | None -> raise Not_found


(* Running *)

let rec run_definition def =
  match def.it with
  | Textual m -> m
  | Encoded (name, bs) ->
    trace "Decoding...";
    Decode.decode name bs
  | Quoted (_, s) ->
    trace "Parsing quote...";
    let def' = Parse.string_to_module s in
    run_definition def'

let values_from_arr arr start len =
  let res = ref [] in
  for i = 0 to len-1 do
    res := arr.(start+i) :: !res
  done;
  List.rev !res

let task_number = ref 0

let terminate str =
  let res = Bytes.make 256 (Char.chr 0) in
  for i = 0 to String.length str-1 do
    Bytes.set res i str.[i]
  done;
  (* prerr_endline ("Hashing " ^ str ^ Mproof.to_hex (Mbinary.string_to_root res)); *)
  res

let hash_file fname =
  let ch = open_in_bin fname in
  let sz = in_channel_length ch in
  let dta = Bytes.create sz in
  really_input ch dta 0 sz;
  close_in ch;
  Printf.printf "{\"size\": %i, \"root\": %s}\n" sz (Mproof.to_hex (Mbinary.bytes_to_root dta));
  exit 0

let add_input vm i fname =
  let open Mrun in
  vm.input.file_name.(i) <- terminate fname;
  let fname = if !Flags.input_out then fname ^ ".out" else fname in
  let ch = open_in_bin fname in
  let sz = in_channel_length ch in
  vm.input.file_size.(i) <- sz;
  let dta = Bytes.create sz in
  really_input ch dta 0 sz;
  close_in ch;
  vm.input.file_data.(i) <- dta;
  trace ("Added file " ^ fname ^ ", " ^ string_of_int sz ^ " bytes")

let output_files vm =
  let open Mrun in
  for i = 0 to Array.length vm.input.file_name - 1 do
    let fname = Mbinary.string_from_bytes vm.input.file_name.(i) in
    if String.length fname > 0 then begin
      let ch = open_out_bin (fname ^ ".out") in
      output ch vm.input.file_data.(i) 0 vm.input.file_size.(i);
      close_out ch
    end
  done

let do_output_file vm i =
  let open Mrun in
  let fname = Mbinary.string_from_bytes vm.input.file_name.(i) in
  let sz = vm.input.file_size.(i) in
  let dta = vm.input.file_data.(i) in
  if String.length fname > 0 then begin
      Printf.printf "{\"size\": %i, \"root\": %s, \"name\": \"%s\", \"data\": \"%s\"}\n" sz
         (Mproof.to_hex (Mbinary.bytes_to_root dta))
         (String.escaped fname)
         (String.escaped (Bytes.to_string dta));
  end

let print_file_names vm =
  let open Mrun in
  let res = ref [] in
  for i = 0 to Array.length vm.input.file_name - 1 do
    if vm.input.file_size.(i) > 0 then begin
      res := ("\"" ^ Mbinary.string_from_bytes vm.input.file_name.(i) ^ ".out\"") :: !res
    end
  done;
  "[" ^ String.concat "," !res ^ "]"

let (@) a b = List.rev_append (List.rev a) b

let setup_vm inst mdle func vs =
(*  prerr_endline "Setting up"; *)
  let open Merkle in
  let open Values in
  let init =
    try Merkle.make_args mdle inst (["/home/truebit/program.wasm"] @ List.rev !Flags.arguments)
    with Not_found -> if !Flags.run_wasm then [PUSH (I32 0l); PUSH (I32 0l)] else [] in
  let table_init = Mrun.init_calltable mdle inst in
  let init2 = Merkle.init_system mdle inst in
(*  prerr_endline "Compiling"; *)
  let cxx_init = Merkle.make_cxx_init mdle inst in
  let g_init = Mrun.setup_globals mdle inst in
  let mem_init = Mrun.init_memory mdle inst in
  trace ("Initing " ^ string_of_int (List.length mem_init));
  let inits = vm_init mdle @ table_init@mem_init@g_init@init2@init@cxx_init in
  trace "Compiling";
  let code, f_resolve = Merkle.compile_test mdle func vs (inits) inst in
  trace "Compiled";
  let vm = Mrun.create_vm code in
  Mrun.setup_memory vm mdle inst;
  Mrun.setup_calltable vm mdle inst f_resolve (List.length (vm_init mdle));
  List.iteri (add_input vm) !Flags.input_files;
(*  prerr_endline "Initialized"; *)
  vm

let handle_exit vm =
  let open Mrun in
  let vm = vm in
  ( if !task_number - 1 = !Flags.case then match !Flags.output_file_proof with
    | Some x ->
       let loc = Mproof.find_file vm x in
       Printf.printf "{\"vm\": %s, \"loc\": %s}\n" (Mproof.vm_to_string (Mbinary.vm_to_bin vm)) (Mproof.loc_to_string loc)
    | None -> () );
  if !task_number - 1 = !Flags.case && !Flags.output_all_file_proofs then begin
       let lst = Mproof.find_files vm in
       let print_file (p1, p2, idx, fname) = Printf.sprintf "{\"data\": %s, \"name\": %s, \"loc\": %i, \"file\": \"%s\"}\n" (Mproof.list_to_string p1) (Mproof.list_to_string p2) idx fname in
       Printf.printf "[%s]\n" (String.concat ", " (List.map print_file lst))
  end;
  if  !task_number - 1 = !Flags.case then output_files vm;
  if !task_number = !Flags.case + 1 && !Flags.result then Printf.printf "{\"result\": %s, \"steps\": %i}\n" (Mproof.to_hex (Mbinary.hash_vm vm)) vm.step;
  if !task_number = !Flags.case + 1 && !Flags.output_proof then begin
     let vm_bin = Mbinary.vm_to_bin vm in
      Printf.printf "{\"vm\": %s, \"hash\": %s, \"steps\": %i, \"files\": %s}\n" (Mproof.vm_to_string vm_bin) (Mproof.to_hex (Mbinary.hash_io_bin vm_bin)) vm.step (print_file_names vm)
  end

let run_test inst mdle func vs =
  let open Mrun in
  let vm = setup_vm inst mdle func vs in
  if !task_number = !Flags.case && !Flags.init then
    ( let vm_bin = Mbinary.vm_to_bin vm in
      Printf.printf "{\"vm\": %s, \"hash\": %s}\n" (Mproof.vm_to_string vm_bin) (Mproof.to_hex (Mbinary.hash_vm_bin vm_bin)) );
  if !task_number = !Flags.case && !Flags.input_proof then
    ( let vm_bin = Mbinary.vm_to_bin vm in
      Printf.printf "{\"vm\": %s, \"hash\": %s}\n" (Mproof.vm_to_string vm_bin) (Mproof.to_hex (Mbinary.hash_io_bin vm_bin));
      exit 0 );
  if !task_number = !Flags.case && !Flags.input_all_file_proofs then begin
       let lst = Mproof.find_files vm in
       let print_file (p1, p2, idx, fname) = Printf.sprintf "{\"data\": %s, \"name\": %s, \"loc\": %i, \"file\": \"%s\"}\n" (Mproof.list_to_string p1) (Mproof.list_to_string p2) idx fname in
       Printf.printf "[%s]\n" (String.concat ", " (List.map print_file lst));
       exit 0
  end;
  if !task_number = !Flags.case && !Flags.init_vm then Printf.printf "%s\n" (Mproof.whole_vm_to_string vm);
  ( if !task_number = !Flags.case then match !Flags.input_file_proof with
  | Some x ->
    let vm_bin = Mbinary.vm_to_bin vm in
    let loc = Mproof.find_file vm x in
    Printf.printf "{\"hash\": %s, \"vm\": %s, \"loc\": %s}\n" (Mproof.to_hex (Mbinary.hash_vm_bin vm_bin)) (Mproof.vm_to_string vm_bin) (Mproof.loc_to_string loc)
  | None -> () );
  incr task_number;
(*  if !Flags.trace then Printf.printf "%s\n" (Mproof.vm_to_string (Mbinary.vm_to_bin vm)); *)
  try begin
    (* while true do Mrun.vm_step vm done; *)
    while true do
      let i = vm.step in
      if !Flags.trace_stack then begin
        trace (stack_to_string vm 10);
        (* trace (string_of_int i ^ ": " ^ Mproof.to_hex (Mbinary.hash_stack vm.stack)) *)
      end;
      (* if i > 560019251 then begin  Flags.trace := true end; *)
      if i = !Flags.trace_from then Flags.trace := true;
      if !Flags.trace (* || i mod 1000000 = 0 *) then begin
        (* trace (string_of_int vm.pc ^ ": " ^ trace_step vm); *)
        Printf.printf "Step %d, stack ptr %d, PC %d: %s\n" i vm.stack_ptr vm.pc (trace_step vm);
      end;
      if i = !Flags.location && !task_number - 1 = !Flags.case then Printf.printf "%s\n" (Mproof.to_hex (Mbinary.hash_vm vm));
      if i = !Flags.checkfinal && !task_number - 1 = !Flags.case then Mproof.print_fetch (Mproof.make_fetch_code vm);
      if i = !Flags.output_file_at && !task_number - 1 = !Flags.case then do_output_file vm !Flags.output_file_number;
      if i = !Flags.checkerror && !task_number - 1 = !Flags.case then Mproof.micro_step_states vm
      else if i = !Flags.checkstep && !task_number - 1 = !Flags.case then begin
         let proof =
           if i = !Flags.insert_error && !task_number - 1 = !Flags.case then Mproof.micro_step_proofs_with_error vm
           else Mproof.micro_step_proofs vm in
         Mproof.check_proof proof
      end else ( test_errors vm ; Mrun.vm_step vm );
      ( if i = !Flags.insert_error && !task_number - 1 = !Flags.case then Mrun.set_input_name vm 1023 10 (Values.I32 1l) ); 
      vm.step <- vm.step + 1;
      (* if i mod 10000000 = 0 then prerr_endline "."; *)
      (* test_errors vm *)
    done;
    raise (Failure "takes too long")
  end
  with VmTrap -> (* check stack pointer, get values *)
    handle_exit vm;
    values_from_arr vm.stack 0 vm.stack_ptr
   | a ->
   (* Print error result *)
    if !Flags.debug_error then begin
      prerr_endline ("Error at step " ^ string_of_int vm.step);
      prerr_endline (stack_to_string vm 10);
      prerr_endline (string_of_int vm.pc ^ ": " ^ trace_clean vm);
      prerr_endline (string_of_int vm.pc ^ ": " ^ trace_step vm);
      vm.pc <- vm.pc - 1;
      prerr_endline (string_of_int vm.pc ^ ": " ^ trace_step vm);
      test_errors vm;
    end;
    vm.pc <- magic_pc;
    handle_exit vm;
   ( match a with
   | Numeric_error.IntegerOverflow -> raise (Eval.Trap (no_region, "integer overflow"))
   | Numeric_error.InvalidConversionToInteger -> raise (Eval.Trap (no_region, "invalid conversion to integer"))
   | Numeric_error.IntegerDivideByZero -> raise (Eval.Trap (no_region, "integer divide by zero"))
   | a -> raise a )

let run_test_micro inst mdle func vs =
  let open Mrun in
  let vm = setup_vm inst mdle func vs in
  try begin
    for i = 0 to 100000000 do
      ignore i;
      (* if !Flags.trace_stack then trace (stack_to_string vm); *)
      trace (string_of_int vm.pc ^ ": " ^ trace_step vm);
      Mrun.micro_step vm;
      test_errors vm
    done;
    raise (Failure "takes too long")
  end
  with VmTrap -> (* check stack pointer, get values *)
(*    trace (Printexc.to_string a);
    Printexc.print_backtrace stderr; *)
    values_from_arr vm.stack 0 vm.stack_ptr

let run_action act =
  match act.it with
  | Invoke (x_opt, name, vs) ->
    trace ("Invoking function \"" ^ Ast.string_of_name name ^ "\"...");
    if !Flags.microstep then begin
      let inst = lookup_instance x_opt act.at in
      ( match Instance.export inst name with
      | Some (Instance.ExternalFunc (Instance.AstFunc (_, func))) ->
        run_test_micro inst inst.Instance.module_.it func (List.map (fun v -> v.it) vs)
      | Some _ -> Assert.error act.at "export is not a function"
      | None -> Assert.error act.at "undefined export" )
    end else
    if !Flags.merkle then begin
      let inst = lookup_instance x_opt act.at in
      ( match Instance.export inst name with
      | Some (Instance.ExternalFunc (Instance.AstFunc (_, func))) ->
        run_test inst inst.Instance.module_.it func (List.map (fun v -> v.it) vs)
      | Some _ -> Assert.error act.at "export is not a function"
      | None -> Assert.error act.at "undefined export" )
    end else
    begin
      let inst = lookup_instance x_opt act.at in
      (match Instance.export inst name with
      | Some (Instance.ExternalFunc f) ->
        Eval.invoke f (List.map (fun v -> v.it) vs)
      | Some _ -> Assert.error act.at "export is not a function"
      | None -> Assert.error act.at "undefined export"
      )
    end
 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ Ast.string_of_name name ^ "\"...");
    let inst = lookup_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternalGlobal v) -> [v]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let assert_result at correct got print_expect expect =
  if not correct then begin
    print_string "Result: "; print_result got;
    print_string "Expect: "; print_expect expect;
    Assert.error at "wrong return values"
  end

let assert_message at name msg re =
  if
    String.length msg < String.length re ||
    String.sub msg 0 (String.length re) <> re
  then begin
    print_endline ("Result: \"" ^ msg ^ "\"");
    print_endline ("Expect: \"" ^ re ^ "\"");
    Assert.error at ("wrong " ^ name ^ " error")
  end


let run_assertion ass =
  match ass.it with
  | AssertMalformed (def, re) ->
    trace "Asserting malformed...";
    (match ignore (run_definition def) with
    | exception Decode.Code (_, msg) -> assert_message ass.at "decoding" msg re
    | exception Parse.Syntax (_, msg) -> assert_message ass.at "parsing" msg re
    | _ -> Assert.error ass.at "expected decoding/parsing error"
    )

  | AssertInvalid (def, re) ->
    trace "Asserting invalid...";
    (match
      let m = run_definition def in
      Valid.check_module m
    with
    | exception Valid.Invalid (_, msg) ->
      assert_message ass.at "validation" msg re
    | _ -> Assert.error ass.at "expected validation error"
    )

  | AssertUnlinkable (def, re) ->
    trace "Asserting unlinkable...";
    let m = run_definition def in
    if not !Flags.unchecked then Valid.check_module m;
    (match
      let imports = Import.link m in
      ignore (Eval.init m imports)
    with
    | exception (Import.Unknown (_, msg) | Eval.Link (_, msg)) ->
      assert_message ass.at "linking" msg re
    | _ -> Assert.error ass.at "expected linking error"
    )

  | AssertUninstantiable (def, re) ->
    trace "Asserting trap...";
    let m = run_definition def in
    if not !Flags.unchecked then Valid.check_module m;
    (match
      let imports = Import.link m in
      ignore (Eval.init m imports)
    with
    | exception Eval.Trap (_, msg) ->
      assert_message ass.at "instantiation" msg re
    | _ -> Assert.error ass.at "expected instantiation error"
    )

  | AssertReturn (act, vs) ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let expect_vs = List.map (fun v -> v.it) vs in
    assert_result ass.at (got_vs = expect_vs) got_vs print_result expect_vs

  | AssertReturnCanonicalNaN act ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let is_canonical_nan =
      match got_vs with
      | [Values.F32 got_f32] -> got_f32 = F32.pos_nan || got_f32 = F32.neg_nan
      | [Values.F64 got_f64] -> got_f64 = F64.pos_nan || got_f64 = F64.neg_nan
      | _ -> false
    in assert_result ass.at is_canonical_nan got_vs print_endline "nan"

  | AssertReturnArithmeticNaN act ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let is_arithmetic_nan =
      match got_vs with
      | [Values.F32 got_f32] ->
        let pos_nan = F32.to_bits F32.pos_nan in
        Int32.logand (F32.to_bits got_f32) pos_nan = pos_nan
      | [Values.F64 got_f64] ->
        let pos_nan = F64.to_bits F64.pos_nan in
        Int64.logand (F64.to_bits got_f64) pos_nan = pos_nan
      | _ -> false
    in assert_result ass.at is_arithmetic_nan got_vs print_endline "nan"

  | AssertTrap (act, re) ->
    trace ("Asserting trap...");
    (match run_action act with
    | exception Eval.Trap (_, msg) -> assert_message ass.at "runtime" msg re
    | _ -> Assert.error ass.at "expected runtime error"
    )

  | AssertExhaustion (act, re) ->
    trace ("Asserting exhaustion...");
    (match run_action act with
    | exception Eval.Exhaustion (_, msg) ->
      assert_message ass.at "exhaustion" msg re
    | _ -> Assert.error ass.at "expected exhaustion error"
    )

let rec run_command cmd =
  match cmd.it with
  | Module (x_opt, def) ->
    quote := cmd :: !quote;
    let m = run_definition def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Valid.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        print_module x_opt m
      end
    end;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    if not !Flags.dry then begin
      trace "Initializing...";
      let imports = Import.link m in
      let inst = Eval.init m imports in
      bind instances x_opt inst
    end
  | Merkle _ -> () (* remove this *)

  | Register (name, x_opt) ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      trace ("Registering module \"" ^ Ast.string_of_name name ^ "\"...");
      let inst = lookup_instance x_opt cmd.at in
      registry := Map.add (Utf8.encode name) inst !registry;
      Import.register name (lookup_registry (Utf8.encode name))
    end

  | Action act ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
       ignore (run_action act)
(*      let vs = run_action act in
      if vs <> [] then print_result vs *)
    end

  | Assertion ass ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      run_assertion ass
    end

  | Meta cmd ->
    run_meta cmd

and run_meta cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    run_quote_script script;
    bind scripts x_opt (lookup_script None cmd.at)

  | Input (x_opt, file) ->
    (try if not (input_file file run_quote_script) then
      Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg);
    bind scripts x_opt (lookup_script None cmd.at);
    if x_opt <> None then begin
      bind modules x_opt (lookup_module None cmd.at);
      if not !Flags.dry then begin
        bind instances x_opt (lookup_instance None cmd.at)
      end
    end

  | Output (x_opt, Some file) ->
    (try
      output_file file
        (fun () -> lookup_script x_opt cmd.at)
        (fun () -> lookup_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (fun () -> lookup_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and run_script script =
  List.iter run_command script

and run_quote_script script =
  let save_quote = !quote in
  quote := [];
  (try run_script script with exn -> quote := save_quote; raise exn);
  bind scripts None (List.rev !quote);
  quote := !quote @ save_quote

let run_file file = input_file file run_script
let run_string string = input_string string run_script
let run_stdin () = input_stdin run_script
