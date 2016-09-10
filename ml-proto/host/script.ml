open Source
open Instance


(* Script representation *)

type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Binary of string

type action = action' Source.phrase
and action' =
  | Invoke of var option * string * Ast.literal list
  | Get of var option * string

type assertion = assertion' Source.phrase
and assertion' =
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertReturn of action * Ast.literal list
  | AssertReturnNaN of action
  | AssertTrap of action * string

type command = command' Source.phrase
and command' =
  | Script of var option * script
  | Module of var option * definition
  | Register of string * var option
  | Action of action
  | Assertion of assertion
  | Input of string
  | Output of var option * string option

and script = command list


(* JS conversion *)

let hex n =
  assert (0 <= n && n < 16);
  if n < 10
  then Char.chr (n + Char.code '0')
  else Char.chr (n - 10 + Char.code 'a')

let js_of_bytes s =
  let buf = Buffer.create (4 * String.length s) in
  for i = 0 to String.length s - 1 do
    Buffer.add_string buf "\\x";
    Buffer.add_char buf (hex (Char.code s.[i] / 16));
    Buffer.add_char buf (hex (Char.code s.[i] mod 16));
  done;
  "\"" ^ Buffer.contents buf ^ "\""

let js_of_literal lit =
  match lit.it with
  | Values.I32 i -> I32.to_string i
  | Values.I64 i -> I64.to_string i  (* TODO *)
  | Values.F32 z -> F32.to_string z
  | Values.F64 z -> F64.to_string z

let js_of_var_opt = function
  | None -> "$$"
  | Some x -> x.it

let js_of_def def =
  let bs =
    match def.it with
    | Textual m -> Encode.encode m
    | Binary bs -> bs
  in js_of_bytes bs

let js_of_action act =
  match act.it with
  | Invoke (x_opt, name, lits) ->
    js_of_var_opt x_opt ^ ".export[\"" ^ name ^ "\"]" ^
      "(" ^ String.concat ", " (List.map js_of_literal lits) ^ ")"
  | Get (x_opt, name) ->
    js_of_var_opt x_opt ^ ".export[\"" ^ name ^ "\"]"

let js_of_assertion ass =
  match ass.it with
  | AssertInvalid (def, _) ->
    "assert_invalid(" ^ js_of_def def ^ ")"
  | AssertUnlinkable (def, _) ->
    "assert_unlinkable(" ^ js_of_def def ^ ")"
  | AssertReturn (act, lits) ->
    "assert_return(() => " ^ js_of_action act ^ ", " ^
      String.concat ", " (List.map js_of_literal lits) ^ ")"
  | AssertReturnNaN act ->
    "assert_return_nan(() => " ^ js_of_action act ^ ")"
  | AssertTrap (act, _) ->
    "assert_trap(() => " ^ js_of_action act ^ ")"

let js_of_cmd cmd =
  match cmd.it with
  | Module (x_opt, def) ->
    (if x_opt <> None then "let " else "") ^
    js_of_var_opt x_opt ^ " = module(" ^ js_of_def def ^ ");\n"
  | Register (name, x_opt) ->
    "register(" ^ name ^ ", " ^ js_of_var_opt x_opt ^ ")\n"
  | Action act ->
    js_of_action act ^ ";\n"
  | Assertion ass ->
    js_of_assertion ass ^ ";\n"
  | Script _ | Input _ | Output _ -> assert false

let js_of_script script =
  Js.js_prefix ^ String.concat "" (List.map js_of_cmd script)


(* Errors *)

module Abort = Error.Make ()
module Syntax = Error.Make ()
module Assert = Error.Make ()
module IO = Error.Make ()

exception Abort = Abort.Error
exception Syntax = Syntax.Error
exception Assert = Assert.Error
exception IO = IO.Error


(* Configuration *)

module Map = Map.Make(String)

let quote : script ref = ref []
let registry : Instance.instance Map.t ref = ref Map.empty

let lookup module_name item_name _t =
  match Instance.export (Map.find module_name !registry) item_name with
  | Some ext -> ext
  | None -> raise Not_found

let scripts : script Map.t ref = ref Map.empty
let modules : Ast.module_ Map.t ref = ref Map.empty
let instances : Instance.instance Map.t ref = ref Map.empty

let last_script : script option ref = ref None
let last_module : Ast.module_ option ref = ref None
let last_instance : Instance.instance option ref = ref None

let bind map x_opt y =
  match x_opt with
  | None -> ()
  | Some x -> map := Map.add x.it y !map

let get_script x_opt at =
  match x_opt, !last_script with
  | None, Some m -> m
  | None, None -> raise (Eval.Crash (at, "no script defined"))
  | Some x, _ ->
    try Map.find x.it !scripts with Not_found ->
      raise (Eval.Crash (x.at, "unknown script " ^ x.it))

let get_module x_opt at =
  match x_opt, !last_module with
  | None, Some m -> m
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !modules with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))

let get_instance x_opt at =
  match x_opt, !last_instance with
  | None, Some inst -> inst
  | None, None -> raise (Eval.Crash (at, "no module defined"))
  | Some x, _ ->
    try Map.find x.it !instances with Not_found ->
      raise (Eval.Crash (x.at, "unknown module " ^ x.it))


(* Input & Output *)

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let input_file = ref (fun _ -> assert false)

let binary_ext = "wasm"
let sexpr_ext = "wast"
let js_ext = "js"

let dispatch_file_ext on_binary on_sexpr on_js file =
  if Filename.check_suffix file binary_ext then
    on_binary file
  else if Filename.check_suffix file sexpr_ext then
    on_sexpr file
  else if Filename.check_suffix file js_ext then
    on_js file
  else
    raise (Sys_error (file ^ ": Unrecognized file type"))

let create_binary_file file m script =
  trace ("Encoding (" ^ file ^ ")...");
  let s = Encode.encode m in
  let oc = open_out_bin file in
  try
    trace "Writing...";
    output_string oc s;
    close_out oc
  with exn -> close_out oc; raise exn

let create_sexpr_file file m script =
  trace ("Formatting (" ^ file ^ ")...");
  let sexpr = Arrange.module_ m in
  let oc = open_out file in
  try
    trace "Writing...";
    Sexpr.output oc !Flags.width sexpr;
    close_out oc
  with exn -> close_out oc; raise exn

let create_js_file file m script =
  trace ("Converting (" ^ file ^ ")...");
  let js = js_of_script script in
  let oc = open_out file in
  try
    trace "Writing...";
    output_string oc js;
    close_out oc
  with exn -> close_out oc; raise exn

let output_file =
  dispatch_file_ext create_binary_file create_sexpr_file create_js_file

let output_stdout m =
  trace "Formatting...";
  let sexpr = Arrange.module_ m in
  trace "Printing...";
  Sexpr.output stdout !Flags.width sexpr


(* Quoting *)

let quote_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs

let rec quote_cmd cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    let save_quote = !quote in
    quote := [];
    quote_script script;
    let script' = List.rev !quote in
    last_script := Some script';
    bind scripts x_opt script';
    quote := !quote @ save_quote

  | Module (x_opt, def) ->
    let m = quote_def def in
    last_script := Some [cmd];
    last_module := Some m;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    quote := cmd :: !quote

  | Register _
  | Action _
  | Assertion _ ->
    quote := cmd :: !quote

  | Input file ->
    (try if not (!input_file file quote_script) then
      Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, Some file) ->
    (try output_file file (get_module x_opt cmd.at) (get_script x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and quote_script cmds =
  let save_scripts = !scripts in
  List.iter quote_cmd cmds;
  scripts := save_scripts


(* Running *)

let run_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs

let run_action act =
  match act.it with
  | Invoke (x_opt, name, es) ->
    trace ("Invoking function \"" ^ name ^ "\"...");
    let inst = get_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (ExternalFunc f) -> Eval.invoke f (List.map it es)
    | Some _ -> Assert.error act.at "export is not a function"
    | None -> Assert.error act.at "undefined export"
    )

 | Get (x_opt, name) ->
    trace ("Getting global \"" ^ name ^ "\"...");
    let inst = get_instance x_opt act.at in
    (match Instance.export inst name with
    | Some (ExternalGlobal v) -> [v]
    | Some _ -> Assert.error act.at "export is not a global"
    | None -> Assert.error act.at "undefined export"
    )

let run_assertion ass =
  match ass.it with
  | AssertInvalid (def, re) ->
    trace "Asserting invalid...";
    (match
      let m = run_def def in
      Check.check_module m
    with
    | exception (Decode.Code (_, msg) | Check.Invalid (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong validation error"
      end
    | _ ->
      Assert.error ass.at "expected validation error"
    )

  | AssertUnlinkable (def, re) ->
    trace "Asserting unlinkable...";
    let m = run_def def in
    if not !Flags.unchecked then Check.check_module m;
    (match
      let imports = Import.link m in
      ignore (Eval.init m imports)
    with
    | exception (Import.Unknown (_, msg) | Eval.Link (_, msg)) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong linking error"
      end
    | _ ->
      Assert.error ass.at "expected linking error"
    )

  | AssertReturn (act, es) ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    let expect_vs = List.map it es in
    if got_vs <> expect_vs then begin
      print_string "Result: "; Print.print_result got_vs;
      print_string "Expect: "; Print.print_result expect_vs;
      Assert.error ass.at "wrong return values"
    end

  | AssertReturnNaN act ->
    trace ("Asserting return...");
    let got_vs = run_action act in
    if
      match got_vs with
      | [Values.F32 got_f32] ->
        got_f32 <> F32.pos_nan && got_f32 <> F32.neg_nan
      | [Values.F64 got_f64] ->
        got_f64 <> F64.pos_nan && got_f64 <> F64.neg_nan
      | _ -> true
    then begin
      print_string "Result: "; Print.print_result got_vs;
      print_string "Expect: "; print_endline "nan";
      Assert.error ass.at "wrong return value"
    end

  | AssertTrap (act, re) ->
    trace ("Asserting trap...");
    (match run_action act with
    | exception Eval.Trap (_, msg) ->
      if not (Str.string_match (Str.regexp re) msg 0) then begin
        print_endline ("Result: \"" ^ msg ^ "\"");
        print_endline ("Expect: \"" ^ re ^ "\"");
        Assert.error ass.at "wrong runtime trap"
      end
    | _ ->
      Assert.error ass.at "expected runtime trap"
    )

let rec run_cmd cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    assert (!quote = []);
    quote_script script;
    let script' = List.rev !quote in
    quote := [];
    last_script := Some script';
    bind scripts x_opt script'

  | Module (x_opt, def) ->
    let m = run_def def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    trace "Initializing...";
    let imports = Import.link m in
    let inst = Eval.init m imports in
    last_script := Some [cmd];
    last_module := Some m;
    last_instance := Some inst;
    bind scripts x_opt [cmd];
    bind modules x_opt m;
    bind instances x_opt inst

  | Register (name, x_opt) ->
    trace ("Registering module \"" ^ name ^ "\"...");
    let inst = get_instance x_opt cmd.at in
    registry := Map.add name inst !registry;
    Import.register name (lookup name)

  | Action act ->
    let vs = run_action act in
    if vs <> [] then Print.print_result vs

  | Assertion ass ->
    run_assertion ass

  | Input file ->
    (try if not (!input_file file run_script) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, Some file) ->
    (try output_file file (get_module x_opt cmd.at) (get_script x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Output (x_opt, None) ->
    (try output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

and run_script script =
  List.iter run_cmd script


(* Dry run *)

let dry_def def =
  match def.it with
  | Textual m -> m
  | Binary bs ->
    trace "Decoding...";
    Decode.decode "binary" bs

let rec dry_cmd cmd =
  match cmd.it with
  | Script (x_opt, script) ->
    assert (!quote = []);
    quote_script script;
    let script' = List.rev !quote in
    quote := [];
    last_script := Some script';
    bind scripts x_opt script'

  | Module (x_opt, def) ->
    let m = dry_def def in
    if not !Flags.unchecked then begin
      trace "Checking...";
      Check.check_module m;
      if !Flags.print_sig then begin
        trace "Signature:";
        Print.print_module_sig m
      end
    end;
    last_script := Some [cmd];
    last_module := Some m;
    bind scripts x_opt [cmd];
    bind modules x_opt m

  | Input file ->
    (try if not (!input_file file dry_script) then Abort.error cmd.at "aborting"
    with Sys_error msg -> IO.error cmd.at msg)
  | Output (x_opt, Some file) ->
    (try output_file file (get_module x_opt cmd.at) (get_script x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)
  | Output (x_opt, None) ->
    (try output_stdout (get_module x_opt cmd.at)
    with Sys_error msg -> IO.error cmd.at msg)

  | Register _
  | Action _
  | Assertion _ -> ()

and dry_script script =
  List.iter dry_cmd script

let run script =
  (if !Flags.dry then dry_script else run_script) script
