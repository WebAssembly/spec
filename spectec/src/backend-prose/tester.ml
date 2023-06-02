open Reference_interpreter
open Source
open Ast
open Al

(** flag **)
let test_name = ref ""
let root = ref ""

(** Helpers **)

let contains substring str =
  let regex = Str.regexp_string substring in
  try
    ignore (Str.search_forward regex str 0);
    true
  with Not_found ->
    false

let readdir_with_path path = Sys.readdir (Filename.concat !root path) |> Array.map (Filename.concat path)

type result =
  | Success
  | Fail
  | Ignore

let fail expected actual =
  Printf.eprintf " Fail!\n";
  Printf.eprintf " Expected: %s\n" expected;
  Printf.eprintf " Actual: %s\n\n" actual;
  let print_stack = false in
  if print_stack then
    Printf.eprintf " Stack: %s\n\n" (Print.string_of_stack !Interpreter.stack);
  Fail

let not_supported_msg = "We only support the test script with modules and assertions."

let msg_of = function Failure msg -> msg | e -> Printexc.to_string e

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

module Exports = Map.Make (String)
type exports = (store * value list) Exports.t
let exports: exports ref = ref Exports.empty

let do_invoke act = match act.it with
  | Script.Invoke (opt, name, literals) ->
    let extract_idx (export: value) =
      match export with
      | ConstructV ("EXPORT", [ StringV (export_name); ConstructV ("FUNC", [ idx ]) ])
        when export_name = Ast.string_of_name name -> Some (idx)
      | _ -> None
    in
    let module_name =
      match opt with
      | Some name -> name.it
      | None -> ""
    in

    let (sto, export) = Exports.find module_name !exports in
    let idx = List.find_map extract_idx export |> Option.get in

    let args = ListV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_value l.it)
      |> Array.of_list
    ) in
    Interpreter.cnt := 0;
    Interpreter.store := sto;
    Printf.eprintf "[Invoking %s %s...]\n%!" (string_of_name name) (Print.string_of_value args);
    Interpreter.call_algo "invocation" [idx; args]
  | Get _ -> failwith "Invalid action: Get"

let f32_pos_nan = F32.to_bits F32.pos_nan |> Int64.of_int32
let f32_neg_nan = F32.to_bits F32.neg_nan |> Int64.of_int32
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
  | ListV [|actual|], ListV [|expect|] ->
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
      ListV(expected |> List.map al_of_result |> Array.of_list)
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

let test_module module_name m =
  Interpreter.cnt := 0;
  Interpreter.init_stack();
  Interpreter.init_store();
  try
    match Interpreter.call_algo "instantiation" [ Construct.al_of_module m ] with
    | ListV l ->
        let export = Array.to_list l in
        (match module_name with
        | Some name -> exports := Exports.add name.it (!Interpreter.store, export) !exports
        | None -> ());
        exports := Exports.add "" (!Interpreter.store, export) !exports;
    | _ -> failwith "invalid exports"
  with e -> "Module Instantiation failed due to " ^ msg_of e |> failwith

let rec test_script success = function
  | [] -> ()
  (* | { it = Script.Module (_name_opt, {it = Script.Textual m; _}) }
    :: { it = Script.Register (name, idx) } :: tail ->
      test_module m *)
  | cmd :: tail ->
      begin match cmd.it with
      | Script.Module (module_name, {it = Script.Textual m; _}) -> test_module module_name m
      | Script.Module _ -> failwith "This test contains a binary module"
      | Script.Register _ -> failwith "This test contains a (register ...) command"
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
      end;
      test_script success tail

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

  let success = ref 0 in

  try

    Printf.eprintf "===========================\n\n%s\n\n" file_name;

    test_script success script;

    if total <> 0 then
      let percentage = (float_of_int !success /. float_of_int total) *. 100. in
      Printf.sprintf "%s: [%d/%d] (%.2f%%)" name !success total percentage |> print_endline;
      (!success, total, percentage)
    else
      (0, 0, 0.)
  with
  | e ->
    let msg = msg_of e in
    Printf.eprintf "[Uncaught exception] %s\n" msg;
    Printf.sprintf
      "%s: [Uncaught exception: %s]"
      name
      msg
      |> print_endline;
    if total <> 0 then
      let percentage = (float_of_int !success /. float_of_int total) *. 100. in
      (!success, total, percentage)
    else
      (0, 0, 0.)

let test_all () =
  let sample = "test-prose/sample.wast" in
  let tests = Array.append [| sample |] (readdir_with_path "test-prose/spec-test") in

  let f filename = if contains !test_name filename then
    test filename
  else
    (0, 0, 0.)
  in
  let results = (Array.map f tests) in

  let success, total, percentage, count = Array.fold_left
    (fun acc result ->
      let (success_acc, total_acc, percentage_acc, count_acc) = acc in
      let (success, total, percentage) = result in
      if (total <> 0) then
        (success_acc + success, total_acc + total, percentage_acc +. percentage, count_acc + 1)
      else
        acc)
    (0, 0, 0., 0) results
  in
  let percentage_norm = percentage /. float_of_int count in
  let percentage = (float_of_int success /. float_of_int total) *. 100. in

  Printf.sprintf "Total [%d/%d] (%.2f%%; Normalized %.2f%%)" success total percentage percentage_norm |> print_endline
