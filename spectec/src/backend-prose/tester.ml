open Reference_interpreter
open Source
open Ast
open Al

(** flag **)
let test_name = ref ""
let root = ref ""

(** Helpers **)

let contains str substring =
  let regex = Str.regexp_string substring in
  try
    ignore (Str.search_forward regex str 0);
    true
  with Not_found ->
    false

let readdir_with_path path =
  Sys.readdir (Filename.concat !root path)
  |> Array.map (Filename.concat path)
  |> Array.to_list

type result =
  | Success
  | Fail
  | Ignore

let fail expected actual =
  Printf.eprintf " Fail!\n";
  Printf.eprintf " Expected: %s\n" expected;
  Printf.eprintf " Actual  : %s\n\n" actual;
  let print_stack = false in
  if print_stack then
    Printf.eprintf " Stack: %s\n\n" (Print.string_of_stack !Interpreter.stack);
  Fail

let not_supported_msg = "We only support the test script with modules and assertions."

let msg_of = function Failure msg -> msg | e -> Printexc.to_string e

let time f =
  let start_time = Sys.time() in
  f();
  Sys.time() -. start_time

(* string -> Script.script *)
let file_to_script file_name =
  let file_path = Filename.concat !root file_name in
  let lexbuf = Lexing.from_channel (open_in file_path) in
  Parse.parse file_path lexbuf Parse.Script

let canonical_nan t = singleton (t ^ ".NaN(canonical)")
let arithmetic_nan t = singleton (t ^ ".NaN(arithmetic)")
let al_of_result result = match result.it with
  | Script.NumResult (Script.NumPat n) -> Construct.al_of_value (Values.Num n.it)
  | Script.NumResult (Script.NanPat {it = (Values.F32 Script.CanonicalNan); _}) -> canonical_nan "F32"
  | Script.NumResult (Script.NanPat {it = (Values.F64 Script.CanonicalNan); _}) -> canonical_nan "F64"
  | Script.NumResult (Script.NanPat {it = (Values.F32 Script.ArithmeticNan); _}) -> arithmetic_nan "F32"
  | Script.NumResult (Script.NanPat {it = (Values.F64 Script.ArithmeticNan); _}) -> arithmetic_nan "F64"
  | Script.RefResult (Script.RefPat r) -> Construct.al_of_value (Values.Ref r.it)
  | _ -> StringV "TODO"

(** End of helpers **)

type export = store * value array

module Register = Map.Make (String)
type register = export Register.t
let register: register ref = ref Register.empty

let builtin =

  let initial_store: value list Record.t =
    Record.empty
    |> Record.add "FUNC" []
    |> Record.add "GLOBAL" []
    |> Record.add "TABLE" []
    |> Record.add "MEM" []
    |> Record.add "ELEM" []
    |> Record.add "DATA" [] in

  (* Builtin functions *)
  let funcs = [
    "print", [];
    "print_i32", [ "I32" ];
    "print_i64", [ "I64" ];
    "print_f32", [ "F32" ];
    "print_f64", [ "F64" ];
    "print_i32_f32", [ "I32"; "F32" ];
    "print_f64_f64", [ "F64"; "F64" ];
    "global_i32", [];
    "global_i64", [];
    "global_f32", [];
    "global_f64", [];
    "table", [];
    "memory", [];
  ] in

  let f1 (name, type_tags) (sto, extern) =

    let code = ConstructV (String.uppercase_ascii name, []) in
    let ptype = List.map (fun tag -> ConstructV (tag, [])) type_tags in
    let ftype = ArrowV (listV ptype, listV []) in

    (* Update Store *)
    let new_funcinsts =
      PairV (
        RecordV Record.empty,
        ConstructV ("FUNC", [ ftype; listV []; listV [ code ] ])
      ) :: Record.find "FUNC" sto
    in
    let new_sto = Record.add "FUNC" new_funcinsts sto in

    (* Generate ExternFunc *)
    let addr = Record.find "FUNC" sto |> List.length |> Int64.of_int in
    let new_extern =
      ConstructV ("EXPORT", [ StringV name; ConstructV ("FUNC", [ NumV addr ]) ])
    in

    (new_sto, new_extern :: extern)
  in

  let (sto, extern) = List.fold_right f1 funcs (initial_store, []) in

  Record.map (fun l -> listV l) sto, extern |> Array.of_list


let latest = "__latest__"
let get_module_name = function
  | Some name -> name.it
  | None -> latest
let find_export = function
  | "spectest" -> builtin
  | name -> Register.find name !register

let extract_idx_of tag name (export: value) =
  match export with
  | ConstructV ("EXPORT", [ StringV (export_name); ConstructV (export_tag, [ idx ]) ])
    when export_name = Ast.string_of_name name && export_tag = tag -> Some (idx)
  | _ -> None

let do_invoke act = match act.it with
  | Script.Invoke (module_name_opt, name, literals) ->
    let module_name = get_module_name module_name_opt in
    let (sto, exports) = find_export module_name in
    let idx = Array.find_map (extract_idx_of "FUNC" name) exports |> Option.get in

    let args = listV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_value l.it)
    ) in
    Interpreter.cnt := 0;
    Interpreter.wcnt := 0;
    Interpreter.init_stack();
    Interpreter.store := sto;
    Printf.eprintf "[Invoking %s %s...]\n" (string_of_name name) (Print.string_of_value args);
    Interpreter.call_algo "invocation" [idx; args]
  | Get (module_name_opt, name) ->
    let module_name = get_module_name module_name_opt in
    let (sto, exports) = find_export module_name in
    let idx = Array.find_map (extract_idx_of "GLOBAL" name) exports |> Option.get in
    let globals = (Record.find "GLOBAL" sto) in

    Printf.eprintf "[Getting %s...]\n" (string_of_name name);
    let got = Array.get (Interpreter.value_to_array globals) (Interpreter.value_to_int idx) in
    listV [ got ]

let f32_pos_nan = F32.to_bits F32.pos_nan |> Int64.of_int32
let f32_neg_nan = F32.to_bits F32.neg_nan |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let f64_pos_nan = F64.to_bits F64.pos_nan
let f64_neg_nan = F64.to_bits F64.neg_nan

let is_canonical_nan t v =
  v = canonical_nan t || match v with
  | ConstructV ("CONST", [ConstructV (t', []); NumV bits]) when t = t' ->
    t = "F32" && (bits = f32_pos_nan || bits = f32_neg_nan)
    ||
    t = "F64" && (bits = f64_pos_nan || bits = f64_neg_nan)
  | _ -> false

let is_arithmetic_nan t v =
  v = arithmetic_nan t || match v with
  | ConstructV ("CONST", [ConstructV (t', []); NumV bits]) when t = t' ->
    t = "F32" && Int64.logand bits f32_pos_nan = f32_pos_nan
    ||
    t = "F64" && Int64.logand bits f64_pos_nan = f64_pos_nan
  | _ -> false

let assert_nan actuals expects =
  match actuals, expects with
  | ListV {contents = [|actual|]}, ListV {contents = [|expect|]} ->
    is_canonical_nan "F32" expect && is_canonical_nan "F32" actual
    || is_canonical_nan "F64" expect && is_canonical_nan "F64" actual
    || is_arithmetic_nan "F32" expect && is_arithmetic_nan "F32" actual
    || is_arithmetic_nan "F64" expect && is_arithmetic_nan "F64" actual
  | _ -> false

let assert_return actual expect =
  if actual = expect || assert_nan actual expect then
    Success
  else
    fail (Print.string_of_value expect) (Print.string_of_value actual)

let test_assertion assertion =
  match assertion.it with
  | Script.AssertReturn (invoke, expected) ->
    let result = try do_invoke invoke with e -> StringV (msg_of e) in
    let expected_result = try
      listV (expected |> List.map al_of_result)
    with
      e -> StringV ("Failed during al_of_result: " ^ msg_of e) in
    assert_return result expected_result
  | Script.AssertTrap (invoke, _msg) ->
    begin try
      let result = do_invoke invoke in
      fail "Trap" (Print.string_of_value result)
    with
      | Exception.Trap -> Success
      | e -> fail "Trap" (Printexc.to_string e)
    end
  | _ -> Ignore (* ignore other kinds of assertions *)

(* Note: this function mutates `Interpreter.store` *)
let get_externval module_used = function
  | ConstructV ("IMPORT", [ StringV import_module_name; StringV extern_name; _ty ]) ->

      let s, export = find_export import_module_name in

      (* Update store *)
      if List.mem import_module_name !module_used |> not then (
        Interpreter.add_store s;
        module_used := import_module_name :: !module_used
      );

      (* Get extern *)
      let f =
        function
          | ConstructV ("EXPORT", [ StringV export_name; _ ])
            when export_name = extern_name -> true
          | _ -> false
      in
      Array.find_opt f export |> Option.get
  | _ -> failwith "Invalid import"

let get_externvals = function
  | ConstructV ("MODULE", ListV imports :: _) ->
      let module_used = ref [] in
      ListV (Array.map (get_externval module_used) !imports |> ref)
  | _ -> failwith "Invalid module"

let test_module module_name m =

  (* Initialize *)
  Interpreter.cnt := 0;
  Interpreter.wcnt := 0;
  Interpreter.init_stack();
  Interpreter.init_store();

  try

    (* Construct module and extern *)
    let al_module = Construct.al_of_module m in
    let externvals = get_externvals al_module in

    (* Instantiate and store exports *)
    match Interpreter.call_algo "instantiation" [ al_module ; externvals ] with
    | ListV l ->
        let export = !l in
        (match module_name with
        | Some name ->
            register := Register.add name.it (!Interpreter.store, export) !register
        | None -> ());
        register := Register.add latest (!Interpreter.store, export) !register;
    | _ -> failwith "invalid exports"
  with e -> "Module Instantiation failed due to " ^ msg_of e |> failwith

let test_cmd success cmd =
  match cmd.it with
  | Script.Module (module_name, {it = Script.Textual m; _}) -> test_module module_name m
  | Script.Module _ -> failwith "This test contains a binary module"
  | Script.Register (name, module_name_opt) ->
      let s = Ast.string_of_name name in
      let module_name = match module_name_opt with
        | Some s -> s.it
        | None -> latest
      in
      let export = find_export module_name in
      register := Register.add s export !register
  | Script.Action a -> (
    try do_invoke a |> ignore with
    | e -> "Direct invocation failed due to " ^ msg_of e |> failwith
  )
  | Script.Assertion a ->
      begin match test_assertion a with
        | Success -> success := !success + 1
        | _ -> ()
      end
  | Script.Meta _ -> failwith not_supported_msg

(** Entry **)
let test file_name =

  let start_idx = String.rindex file_name '/' + 1 in
  let length = String.length file_name - start_idx in
  let name = String.sub file_name start_idx length in

  let script = file_to_script file_name in
  let total = script |> List.filter (fun x -> match x.it with
    | Script.Assertion {it = Script.AssertReturn _; _}
    | Script.Assertion {it = Script.AssertTrap _ ; _}-> true
    | _ -> false
  ) |> List.length in

  if (contains file_name !test_name) && (total > 0) then
    let success = ref 0 in
    Printf.printf "%s: %!" name;
    Printf.eprintf "===========================\n\n%s\n\n" file_name;

    let took = time (fun () ->
      try
        List.iter (test_cmd success) script;
      with
      | e ->
        let msg = msg_of e in
        Printf.eprintf "[Uncaught exception] %s, " msg;
        Printf.printf
          "[Uncaught exception: %s] "
          msg
    ) in

    Printf.eprintf "%s took %f ms.\n" name (took *. 1000.);
    let percentage = (float_of_int !success /. float_of_int total) *. 100. in
    Printf.printf "[%d/%d] (%.2f%%)\n" !success total percentage;
    Some (!success, total, percentage)
  else
    None

let test_all () =
  let sample = "test-prose/sample.wast" in
  let tests = sample :: (readdir_with_path "test-prose/spec-test") in

  let results = List.filter_map test tests in

  let success, total, percentage = List.fold_left
    (fun acc result ->
      let (success_acc, total_acc, percentage_acc) = acc in
      let (success, total, percentage) = result in
      (success_acc + success, total_acc + total, percentage_acc +. percentage))
    (0, 0, 0.) results
  in
  let percentage_all = (float_of_int success /. float_of_int total) *. 100. in
  let percentage_norm = percentage /. float_of_int (List.length results) in

  Printf.printf "Total [%d/%d] (%.2f%%; Normalized %.2f%%)\n" success total percentage_all percentage_norm
