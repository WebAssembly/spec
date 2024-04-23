open Script
open Source


(* Errors & Tracing *)

module Script = Error.Make ()
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
  | Eval.Exception (at, msg) -> error at "uncaught exception" msg
  | Encode.Code (at, msg) -> error at "encoding error" msg
  | Script.Error (at, msg) -> error at "script error" msg
  | IO (at, msg) -> error at "i/o error" msg
  | Assert (at, msg) -> error at "assertion failure" msg
  | Abort _ -> false

let input_script name lexbuf run =
  input_from (fun () -> Parse.Script.parse name lexbuf) run

let input_script1 name lexbuf run =
  input_from (fun () -> Parse.Script1.parse name lexbuf) run

let input_sexpr name lexbuf run =
  input_from (fun () ->
    let var_opt, def = Parse.Module.parse name lexbuf in
    [Module (var_opt, def) @@ no_region]) run

let input_binary name buf run =
  let open Source in
  input_from (fun () ->
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
    (input_sexpr_file input_script)
    (input_sexpr_file input_script)
    input_js_file
    file run

let input_string string run =
  trace ("Running (\"" ^ String.escaped string ^ "\")...");
  let lexbuf = Lexing.from_string string in
  trace "Parsing...";
  input_script "string" lexbuf run


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
    let success = input_script1 "stdin" lexbuf run in
    if not success then Lexing.flush_input lexbuf;
    if Lexing.(lexbuf.lex_curr_pos >= lexbuf.lex_buffer_len - 1) then
      continuing := false;
    loop ()
  in
  try loop () with End_of_file ->
    print_endline "";
    trace "Bye."


(* Printing *)

let indent s =
  let lines = List.filter ((<>) "") (String.split_on_char '\n' s) in
  String.concat "\n" (List.map ((^) "  ") lines) ^ "\n"

let print_module x_opt m =
  Printf.printf "module%s :\n%s%!"
    (match x_opt with None -> "" | Some x -> " " ^ x.it)
    (indent (Types.string_of_module_type (Ast.module_type_of m)))

let print_values vs =
  let ts = List.map Value.type_of_value vs in
  Printf.printf "%s : %s\n%!"
    (Value.string_of_values vs) (Types.string_of_result_type ts)

let string_of_nan = function
  | CanonicalNan -> "nan:canonical"
  | ArithmeticNan -> "nan:arithmetic"

let type_of_result r =
  let open Types in
  match r with
  | NumResult (NumPat n) -> NumT (Value.type_of_num n.it)
  | NumResult (NanPat n) -> NumT (Value.type_of_num n.it)
  | VecResult (VecPat v) -> VecT (Value.type_of_vec v)
  | RefResult (RefPat r) -> RefT (Value.type_of_ref r.it)
  | RefResult (RefTypePat t) -> RefT (NoNull, t)  (* assume closed *)
  | RefResult (NullPat) -> RefT (Null, ExternHT)

let string_of_num_pat (p : num_pat) =
  match p with
  | NumPat n -> Value.string_of_num n.it
  | NanPat nanop ->
    match nanop.it with
    | Value.I32 _ | Value.I64 _ -> assert false
    | Value.F32 n | Value.F64 n -> string_of_nan n

let string_of_vec_pat (p : vec_pat) =
  match p with
  | VecPat (Value.V128 (shape, ns)) ->
    String.concat " " (List.map string_of_num_pat ns)

let string_of_ref_pat (p : ref_pat) =
  match p with
  | RefPat r -> Value.string_of_ref r.it
  | RefTypePat t -> Types.string_of_heap_type t
  | NullPat -> "null"

let string_of_result r =
  match r with
  | NumResult np -> string_of_num_pat np
  | VecResult vp -> string_of_vec_pat vp
  | RefResult rp -> string_of_ref_pat rp

let string_of_results = function
  | [r] -> string_of_result r
  | rs -> "[" ^ String.concat " " (List.map string_of_result rs) ^ "]"

let print_results rs =
  let ts = List.map type_of_result rs in
  Printf.printf "%s : %s\n%!"
    (string_of_results rs) (Types.string_of_result_type ts)


(* Configuration *)

module Map = Map.Make(String)

let quote : script ref = ref []
let scripts : script Map.t ref = ref Map.empty
let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.module_inst Map.t ref = ref Map.empty
let registry : Instance.module_inst Map.t ref = ref Map.empty

let bind map x_opt y =
  let map' =
    match x_opt with
    | None -> !map
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

let rec run_definition def : Ast.module_ =
  match def.it with
  | Textual m -> m
  | Encoded (name, bs) ->
    trace "Decoding...";
    Decode.decode name bs
  | Quoted (_, s) ->
    trace "Parsing quote...";
    let _, def' = Parse.Module.parse_string s in
    run_definition def'

let run_action act : Value.t list =
  match act.it with
  | Invoke (x_opt, name, vs) ->
    trace ("Invoking function \"" ^ Types.string_of_name name ^ "\"...");
    let inst = lookup_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternFunc f) ->
      let Types.FuncT (ts1, _ts2) =
        Types.(as_func_str_type (expand_def_type (Func.type_of f))) in
      if List.length vs <> List.length ts1 then
        Script.error act.at "wrong number of arguments";
      List.iter2 (fun v t ->
        if not (Match.match_val_type [] (Value.type_of_value v.it) t) then
          Script.error v.at "wrong type of argument"
      ) vs ts1;
      Eval.invoke f (List.map (fun v -> v.it) vs)
    | Some _ -> Assert.error act.at "export is not a function"
    | None -> Assert.error act.at "undefined export"
    )

 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ Types.string_of_name name ^ "\"...");
    let inst = lookup_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (Instance.ExternGlobal gl) -> [Global.load gl]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let assert_nan_pat n nan =
  let open Value in
  match n, nan.it with
  | F32 z, F32 CanonicalNan -> z = F32.pos_nan || z = F32.neg_nan
  | F64 z, F64 CanonicalNan -> z = F64.pos_nan || z = F64.neg_nan
  | F32 z, F32 ArithmeticNan ->
    let pos_nan = F32.to_bits F32.pos_nan in
    Int32.logand (F32.to_bits z) pos_nan = pos_nan
  | F64 z, F64 ArithmeticNan ->
    let pos_nan = F64.to_bits F64.pos_nan in
    Int64.logand (F64.to_bits z) pos_nan = pos_nan
  | _, _ -> false

let assert_num_pat n np =
  match np with
    | NumPat n' -> n = n'.it
    | NanPat nanop -> assert_nan_pat n nanop

let assert_vec_pat v p =
  let open Value in
  match v, p with
  | V128 v, VecPat (V128 (shape, ps)) ->
    let extract = match shape with
      | V128.I8x16 () -> fun v i -> I32 (V128.I8x16.extract_lane_s i v)
      | V128.I16x8 () -> fun v i -> I32 (V128.I16x8.extract_lane_s i v)
      | V128.I32x4 () -> fun v i -> I32 (V128.I32x4.extract_lane_s i v)
      | V128.I64x2 () -> fun v i -> I64 (V128.I64x2.extract_lane_s i v)
      | V128.F32x4 () -> fun v i -> F32 (V128.F32x4.extract_lane i v)
      | V128.F64x2 () -> fun v i -> F64 (V128.F64x2.extract_lane i v)
    in
    List.for_all2 assert_num_pat
      (List.init (V128.num_lanes shape) (extract v)) ps

let assert_ref_pat r p =
  match p, r with
  | RefPat r', r -> Value.eq_ref r r'.it
  | RefTypePat Types.AnyHT, Instance.FuncRef _ -> false
  | RefTypePat Types.AnyHT, _
  | RefTypePat Types.EqHT, (I31.I31Ref _ | Aggr.StructRef _ | Aggr.ArrayRef _)
  | RefTypePat Types.I31HT, I31.I31Ref _
  | RefTypePat Types.StructHT, Aggr.StructRef _
  | RefTypePat Types.ArrayHT, Aggr.ArrayRef _ -> true
  | RefTypePat Types.FuncHT, Instance.FuncRef _
  | RefTypePat Types.ExnHT, Value.ExnRef _
  | RefTypePat Types.ExternHT, _ -> true
  | NullPat, Value.NullRef _ -> true
  | _ -> false

let assert_pat v r =
  let open Value in
  match v, r with
  | Num n, NumResult np -> assert_num_pat n np
  | Vec v, VecResult vp -> assert_vec_pat v vp
  | Ref r, RefResult rp -> assert_ref_pat r rp
  | _, _ -> false

let assert_result at got expect =
  if
    List.length got <> List.length expect ||
    List.exists2 (fun v r -> not (assert_pat v r)) got expect
  then begin
    print_string "Result: "; print_values got;
    print_string "Expect: "; print_results expect;
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

  | AssertReturn (act, rs) ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let expect_rs = List.map (fun r -> r.it) rs in
    assert_result ass.at got_vs expect_rs

  | AssertException act ->
    trace ("Asserting exception...");
    (match run_action act with
    | exception Eval.Exception (_, msg) -> ()
    | _ -> Assert.error ass.at "expected exception"
    )

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

  | Register (name, x_opt) ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      trace ("Registering module \"" ^ Types.string_of_name name ^ "\"...");
      let inst = lookup_instance x_opt cmd.at in
      registry := Map.add (Utf8.encode name) inst !registry;
      Import.register name (lookup_registry (Utf8.encode name))
    end

  | Action act ->
    quote := cmd :: !quote;
    if not !Flags.dry then begin
      let vs = run_action act in
      if vs <> [] then print_values vs
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
