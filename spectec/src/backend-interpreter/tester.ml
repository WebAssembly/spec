open Reference_interpreter
open Script
open Source
open Al.Ast

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
  |> List.filter (String.ends_with ~suffix:".wast")

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
    Printf.eprintf " Stack: %s\n\n" (Ds.WasmContext.string_of_context_stack ());
  Fail

let not_supported_msg = "We only support the test script with modules and assertions."

let msg_of = function
| Failure msg -> msg
| e -> Printexc.to_string e
  (* ^ " " *)
  (* ^ (String.split_on_char '\n' (Printexc.get_backtrace() ) |> List.filteri (fun i _ -> i < 2) |> String.concat "\n" ) *)

let time f =
  let start_time = Sys.time() in
  f();
  Sys.time() -. start_time

(* string -> Script.script *)
let file_to_script file_name =
  let file_path = Filename.concat !root file_name in
  let lexbuf = Lexing.from_channel (open_in file_path) in
  Parse.parse file_path lexbuf Parse.Script

(** End of helpers **)

module Register = Map.Make (String)
type register = value Register.t
let register: register ref = ref Register.empty

let builtin () =

  let initial_store: (string, value list) record =
    Record.empty
    |> Record.add "FUNC" []
    |> Record.add "GLOBAL" []
    |> Record.add "TABLE" []
    |> Record.add "MEM" []
    |> Record.add "ELEM" []
    |> Record.add "DATA" [] in

  (* TODO : Change this into host fnuction instance, instead of current normal function instance *)
  let create_func_inst (name, type_tags) =
    let winstr_tag = String.uppercase_ascii name in
    let code = singleton winstr_tag in
    let ptype = List.map singleton type_tags in
    let ftype = ConstructV ("FUNC", [ ArrowV (listV ptype, listV []) ]) in
    let dt =
      ConstructV ("DEF", [
        ConstructV ("REC", [
          [ ConstructV ("SUBD", [OptV (Some (singleton "FINAL")); [] |> listV; ftype]) ] |> listV
        ]); NumV 0L
      ]) in
    name, RecordV [
      "TYPE", dt |> ref;
      "MODULE", ref (RecordV Record.empty); (* dummy module *)
      "CODE", ref (ConstructV ("FUNC", [ ftype; listV []; listV [ code ] ]))
    ] in

  let create_global_inst t v = RecordV [
    "TYPE", t |> ref;
    "VALUE", v |> ref
  ] in

  let create_table_inst t elems = RecordV [
    "TYPE", t |> ref;
    "ELEM", elems |> ref
  ] in

  let create_mem_inst t bytes_ = RecordV [
    "TYPE", t |> ref;
    "DATA", bytes_ |> ref
  ] in

  (* Builtin functions *)
  let funcs = List.rev [
    ("print", []) |> create_func_inst;
    ("print_i32", [ "I32" ]) |> create_func_inst;
    ("print_i64", [ "I64" ]) |> create_func_inst;
    ("print_f32", [ "F32" ]) |> create_func_inst;
    ("print_f64", [ "F64" ]) |> create_func_inst;
    ("print_i32_f32", [ "I32"; "F32" ]) |> create_func_inst;
    ("print_f64_f64", [ "F64"; "F64" ]) |> create_func_inst
  ] in
  (* Builtin globals *)
  let globals = List.rev [
    "global_i32", 666   |> I32.of_int_u |> Numerics.i32_to_const |> create_global_inst (StringV "global_type");
    "global_i64", 666   |> I64.of_int_u |> Numerics.i64_to_const |> create_global_inst (StringV "global_type");
    "global_f32", 666.6 |> F32.of_float |> Numerics.f32_to_const |> create_global_inst (StringV "global_type");
    "global_f64", 666.6 |> F64.of_float |> Numerics.f64_to_const |> create_global_inst (StringV "global_type");
  ] in
  (* Builtin tables *)
  let nulls = List.init 10 (fun _ -> ConstructV ("REF.NULL", [ singleton "FUNCREF" ])) in
  let tables = [
    "table",
    listV nulls
    |> create_table_inst (PairV (PairV (NumV 10L, NumV 20L), singleton "FUNCREF"));
  ] in
  (* Builtin memories *)
  let zeros = List.init 0x10000 (fun _ -> NumV 0L) in
  let memories = [
    "memory",
    listV zeros
  |> create_mem_inst (ConstructV ("I8", [ PairV (NumV 1L, NumV 2L) ]));
  ] in

  let append kind (name, inst) (sto, extern) =
    (* Update Store *)
    let insts = Record.find kind sto in
    let new_sto = Record.add kind (insts @ [inst]) sto in


    (* Generate ExternFunc *)
    let addr = List.length insts |> Int64.of_int in
    let new_extern =
      RecordV [ "NAME", ref (StringV name); "VALUE", ref (ConstructV (kind, [ NumV addr ])) ]
    in

    (new_sto, new_extern :: extern) in

  (* (sto, extern) -> (new_sto, new_extern) *)
  let append_funcs = List.fold_right (append "FUNC") funcs in
  let append_globals = List.fold_right (append "GLOBAL") globals in
  let append_tables = List.fold_right (append "TABLE") tables in
  let append_memories = List.fold_right (append "MEM") memories in

  let (sto, extern) = (initial_store, [])
    |> append_funcs
    |> append_globals
    |> append_tables
    |> append_memories in

  let wraped_store = Record.map listV sto in
  let module_inst =
    Record.empty
    |> Record.add "FUNC" (listV [])
    |> Record.add "GLOBAL" (listV [])
    |> Record.add "TABLE" (listV [])
    |> Record.add "MEM" (listV [])
    |> Record.add "ELEM" (listV [])
    |> Record.add "DATA" (listV [])
    |> Record.add "EXPORT" (listV extern)
  in

  wraped_store, RecordV module_inst


let latest = ""
let get_module_name = function
  | Some name -> name.it
  | None -> latest
let find_module_inst name = Register.find name !register
let find_export name =
    match find_module_inst name with
    | RecordV r ->
        begin match Record.find "EXPORT" r with
        | ListV exs -> !exs
        | _ -> failwith "Invaild module inst"
        end
    | _ -> failwith "Invalid module inst"

let extract_addr_of tag name (export: value) =
  match export with
  | RecordV [ "NAME", { contents = StringV (export_name) }; "VALUE", { contents = ConstructV (export_tag, [ addr ]) } ]
    when export_name = Utf8.encode name && export_tag = tag -> Some (addr)
  | _ -> None

let do_invoke act = match act.it with
  | Script.Invoke (module_name_opt, name, literals) ->
    let module_name = get_module_name module_name_opt in
    let module_inst = find_module_inst module_name in
    let export_insts = match module_inst with
    | RecordV r ->
        begin match Record.find "EXPORT" r with
        | ListV exs -> !exs
        | _ -> failwith "Invaild module inst"
        end
    | _ -> failwith "Invalid module inst"
    in

    let funcaddr = Array.find_map (extract_addr_of "FUNC" name) export_insts |> Option.get in

    let args = listV (
      literals
      |> List.map (fun (l: Script.literal) -> Construct.al_of_value l.it)
    ) in
    Printf.eprintf "[Invoking %s %s...]\n" (Utf8.encode name) (Al.Print.string_of_value args);

    Interpreter.invocation [funcaddr; args]
  | Get (module_name_opt, name) ->
    let module_name = get_module_name module_name_opt in
    let exports = find_export module_name in

    let addr = Array.find_map (extract_addr_of "GLOBAL" name) exports |> Option.get in
    let globals = (Record.find "GLOBAL" !Ds.store) in

    Printf.eprintf "[Getting %s...]\n" (Utf8.encode name);
    let got =
      match Array.get (Interpreter.value_to_array globals) (Interpreter.value_to_int addr) with
      | RecordV r -> Record.find "VALUE" r
      | _ -> failwith "Not a Record"
    in
    listV [ got ]



(* Check invocation result *)

let f32_pos_nan = F32.to_bits F32.pos_nan |> Int64.of_int32
let f32_neg_nan = F32.to_bits F32.neg_nan |> Int64.of_int32 |> Int64.logand 0x0000_0000_ffff_ffffL
let f64_pos_nan = F64.to_bits F64.pos_nan
let f64_neg_nan = F64.to_bits F64.neg_nan

let check_nanop no actual =
  match actual with
  | ConstructV ("CONST", [ConstructV (t, []); NumV bits]) ->
    begin match no.it with
    | Reference_interpreter.Value.F32 Script.CanonicalNan ->
      t = "F32" && (bits = f32_pos_nan || bits = f32_neg_nan)
    | Reference_interpreter.Value.F64 Script.CanonicalNan ->
      t = "F64" && (bits = f64_pos_nan || bits = f64_neg_nan)
    | Reference_interpreter.Value.F32 Script.ArithmeticNan ->
      t = "F32" && Int64.logand bits f32_pos_nan = f32_pos_nan
    | Reference_interpreter.Value.F64 Script.ArithmeticNan ->
      t = "F64" && Int64.logand bits f64_pos_nan = f64_pos_nan
    | _ -> failwith "NaN of int is not defined"
    end
  | _ -> false

let check_reftype expected = function
  | ConstructV (tag, _) ->
    begin match expected, tag with
    | Types.AnyHT, "REF.FUNC_ADDR" -> false
    | Types.ExternHT, ref
    | Types.AnyHT, ref when String.starts_with ~prefix:"REF" ref -> true
    | Types.EqHT, ("REF.I31_NUM" | "REF.STRUCT_ADDR" | "REF.ARRAY_ADDR")
    | Types.I31HT, "REF.I31_NUM"
    | Types.StructHT, "REF.STRUCT_ADDR"
    | Types.ArrayHT, "REF.ARRAY_ADDR"
    | Types.FuncHT, "REF.FUNC_ADDR" -> true
    | _ -> false
    end
  | _ -> false

let check_null = function
  | ConstructV ("REF.NULL", _) -> true
  | _ -> false

let check expected actual =
  match expected.it with
  | NumResult (NumPat n) -> Construct.al_of_num n.it = actual
  | NumResult (NanPat no) -> check_nanop no actual
  | RefResult (RefPat r) -> Construct.al_of_ref r.it = actual
  | RefResult (RefTypePat ht) -> check_reftype ht actual
  | RefResult NullPat -> check_null actual
  | VecResult _ -> failwith "VecResult not implemented"

let get_externval = function
  | ConstructV ("IMPORT", [ StringV import_module_name; StringV extern_name; _ty ]) ->

      let export = find_export import_module_name in

      (* Get extern *)
      let is_matching_export export =
        match export with
        | RecordV [ "NAME", { contents = StringV export_name }; "VALUE", value ]
          when export_name = extern_name -> Some !value
        | _ -> None
      in
      Array.find_map is_matching_export export |> Option.get
  | v ->
    Al.Print.string_of_value v
    |> Printf.sprintf "Invalid import: %s"
    |> failwith

let get_externvals = function
  | ConstructV ("MODULE", _ :: (ListV imports) :: _) ->
      ListV (Array.map get_externval !imports |> ref)
  | _ -> failwith "Invalid module"

let extract_module def = match def.it with
  | Script.Textual m -> m
  | Script.Encoded (name, bs) ->
    Decode.decode name bs
  | Script.Quoted (_, s) ->
    Parse.string_to_module s

let test_assertion assertion =
  match assertion.it with
  | Script.AssertReturn (invoke, expected) ->

    let fail_with =
      List.map (fun r -> r.it) expected
      |> Run.string_of_results
      |> fail
    in

    begin try
      (* Invoke *)
      match do_invoke invoke with
      | ListV arr ->
        let actual = Array.to_list !arr in
        assert (List.length actual = List.length expected);
        if List.for_all2 check expected actual then
          Success
        else
          listV actual |> Al.Print.string_of_value |> fail_with
      | v ->
        Al.Print.string_of_value v
        |> Printf.sprintf "Invalid result: %s"
        |> failwith
    with e -> msg_of e |> fail_with
    end
  | Script.AssertTrap (invoke, msg) ->
    let expected = "Trap due to " ^ msg in
    begin try
      let result = do_invoke invoke in
      fail expected (Al.Print.string_of_value result)
    with
      | Exception.Trap -> Success
      | e -> fail expected (Printexc.to_string e)
    end
  | Script.AssertUninstantiable (def, msg) ->
    let expected = "Module instantiation failure due to " ^ msg in
    begin try
      let al_module = Construct.al_of_module (extract_module def) in
      let externvals = get_externvals al_module in
      Printf.eprintf "[Trying instantiating module...]\n";
      Interpreter.instantiation [ al_module ; externvals ] |> ignore;

      fail expected"Module instantiation success"
    with
      | Exception.Trap -> Success
      | e -> fail expected (Printexc.to_string e)
    end
  | _ -> Ignore (* ignore other kinds of assertions *)

let test_module module_name m =

  (* Initialize *)

  try

    (* Construct module and extern *)
    let al_module = Construct.al_of_module m in
    let externvals = get_externvals al_module in

    (* Instantiate and store exports *)
    Printf.eprintf "[Instantiating module...]\n";
    let module_inst = Interpreter.instantiation [ al_module ; externvals ] in

    (* Store module instance in the register *)
    (match module_name with
    | Some name ->
        register := Register.add name.it module_inst !register
    | None -> ());
    register := Register.add latest module_inst !register;
  with e -> "Module Instantiation failed due to " ^ msg_of e |> failwith

let test_cmd success cmd =
  match cmd.it with
  | Script.Module (module_name, def) -> test_module module_name (extract_module def)
  | Script.Register (name, module_name_opt) ->
      let s = Utf8.encode name in
      let module_name = match module_name_opt with
        | Some s -> s.it
        | None -> latest
      in
      let module_inst = find_module_inst module_name in
      register := Register.add s module_inst !register
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

(* Intialize store and registered modules *)
let init_tester () =
  let builtin_inst = builtin() in
  Ds.store := fst builtin_inst;
  register := Register.add "spectest" (snd builtin_inst) Register.empty

(** Entry **)
let test file_name =
  init_tester ();
  let start_idx = String.rindex file_name '/' + 1 in
  let length = String.length file_name - start_idx in
  let name = String.sub file_name start_idx length in

  let script = file_to_script file_name in
  let total = script |> List.filter (fun x -> match x.it with
    | Script.Assertion {it = Script.AssertReturn _; _}
    | Script.Assertion {it = Script.AssertTrap _ ; _}
    | Script.Assertion {it = Script.AssertUninstantiable _ ; _}-> true
    | _ -> false
  ) |> List.length in

  if (contains file_name !test_name) && (total > 0) then
    let success = ref 0 in
    Printf.printf "===== %s =====\n%!" name;
    Printf.eprintf "===========================\n\n%s\n\n" file_name;

    let took = time (fun () ->
      try
        List.iter (test_cmd success) script;
      with
      | e ->
        let msg = msg_of e in
        Printf.eprintf "[Uncaught exception] %s, " msg;
        Printf.printf
          "- Uncaught exception: %s\n"
          msg
    ) in

    Printf.eprintf "%s took %f ms.\n" name (took *. 1000.);
    let percentage = (float_of_int !success /. float_of_int total) *. 100. in
    Printf.printf "- %d/%d (%.2f%%)\n\n" !success total percentage;
    Some (!success, total, percentage, took)
  else
    None

let test_all () =
  let sample = "test-interpreter/sample.wast" in
  let tests =  [ sample ]
    @ (readdir_with_path "test-interpreter/spec-test")
    @ (readdir_with_path "test-interpreter/spec-test/gc")
    @ (readdir_with_path "test-interpreter/spec-test/tail-call")
    @ (readdir_with_path "test-interpreter/spec-test/function-references")
  in

  let results = List.filter_map test tests in

  let success, total, percentage, time = List.fold_left
    (fun acc result ->
      let (success_acc, total_acc, percentage_acc, time_acc) = acc in
      let (success, total, percentage, time) = result in
      (success_acc + success, total_acc + total, percentage_acc +. percentage, time_acc +. time))
    (0, 0, 0., 0.) results
  in
  let percentage_all = (float_of_int success /. float_of_int total) *. 100. in
  let percentage_norm = percentage /. float_of_int (List.length results) in

  Printf.printf "Total [%d/%d] (%.2f%%; Normalized %.2f%%)\n" success total percentage_all percentage_norm;
  Printf.eprintf "Took %f ms.\n" (time *. 1000.);
