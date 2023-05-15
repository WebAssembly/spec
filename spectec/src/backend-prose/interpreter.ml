open Print
open Reference_interpreter
open Source
open Al

(* AL Data Structures *)

(* Algorithm Map *)

module AlgoMapKey = struct
  type t = string

  let compare = Stdlib.compare
end

module AlgoMap = Map.Make (AlgoMapKey)

let algo_map = ref AlgoMap.empty

let to_map algos =
  let f acc algo =
    let (Algo (name, _, _)) = algo in
    AlgoMap.add name algo acc
  in

  List.fold_left f AlgoMap.empty algos

(* Environmet *)

module Env = struct
  module EnvKey = struct
    type t = name

    let compare a b = Stdlib.compare (string_of_name a) (string_of_name b)
  end

  module Env' = Map.Make (EnvKey)

  type t = name Env'.t * value

  (* Result *)
  let get_result (_, res) = res
  let set_result v (env, _) = (env, v)

  (* Printer *)
  let string_of_env env =
    Print.string_of_list
      (fun (k, v) -> Print.string_of_name k ^ ": " ^ Print.string_of_value v)
      "\n{" ",\n  " "\n}" (Env'.bindings env)

  (* Environment API *)
  let empty = (Env'.empty, StringV "Undefined")

  let find key (env, _) =
    try Env'.find key env
    with Not_found ->
      Printf.sprintf "The key '%s' is not in the map: %s."
        (Print.string_of_name key) (string_of_env env)
      |> print_endline;
      raise Not_found

  let add key elem (env, res) = (Env'.add key elem env, res)
end

let stack : stack ref = ref []
let push v = stack := v :: !stack

let pop () =
  let res = List.hd !stack in
  stack := List.tl !stack;
  res

let get_current_label () =
  match List.find_map (function LabelV l -> Some l | _ -> None) !stack with
  | Some label -> label
  | None -> failwith "No label" (* Due to Wasm validation, unreachable *)

let get_current_frame () =
  match List.find_map (function FrameV f -> Some f | _ -> None) !stack with
  | Some frame -> frame
  | None -> failwith "No frame" (* Due to Wasm validation, unreachable *)

let store : store ref = ref Record.empty

(* Evaluation Context *)

exception ExitCont

(* Helper functions *)

let array_to_list a = Array.fold_right List.cons a []

(* NOTE: These functions should be used only if validation ensures no failure *)

let al_value2wasm_type = function
  | WasmTypeV ty -> ty
  | _ -> failwith "Not a Wasm type"

let al_value2int = function IntV i -> i | _ -> failwith "Not an integer value"

(* Interpreter *)

let rec dsl_function_call fname args =
  match fname with
  (* Numerics *)
  | N name when Numerics.mem name -> Numerics.call_numerics name args
  (* Module & Runtime *)
  | N name when AlgoMap.mem name !algo_map ->
      call_algo name args |> Env.get_result
  | _ -> failwith "Invalid DSL function call"

and eval_expr env expr =
  match expr with
  | ValueE v -> v
  | AppE (fname, el) -> List.map (eval_expr env) el |> dsl_function_call fname
  | MapE (fname, [ e ], _) -> (
      (* TODO: handle cases where more than 1 arguments *)
      match eval_expr env e with
      | ListV vs ->
          ListV (Array.map (fun v -> dsl_function_call fname [ v ]) vs)
      | _ ->
          Print.string_of_expr e ^ " is not iterable."
          |> failwith (* Due to WASM validation, unreachable *))
  | LengthE e -> (
      match eval_expr env e with
      | ListV vl -> IntV (Array.length vl)
      | _ -> failwith "Not a list" (* Due to AL validation, unreachable *))
  | ArityE e -> (
      match eval_expr env e with
      | LabelV (n, _) -> IntV n
      | _ -> failwith "Not a label" (* Due to AL validation, unreachable *))
  | GetCurLabelE -> LabelV (get_current_label ())
  | GetCurFrameE -> FrameV (get_current_frame ())
  | FrameE (e1, e2) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | IntV n, RecordV r -> FrameV (n, r)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid frame: " ^ string_of_expr expr |> failwith)
  | PropE (e, str) -> (
      match eval_expr env e with
      | ModuleInstV m -> Record.find str m
      | FrameV (_, r) -> Record.find str r
      | StoreV s -> Record.find str s
      | _ -> failwith "Not a record")
  | ConcatE (e1, e2) -> (
      match (eval_expr env e1, eval_expr env e2) with
      | ListV v1, ListV v2 -> ListV (Array.append v1 v2)
      | _ -> failwith "Not a list")
  | ListE el -> ListV (Array.map (eval_expr env) el)
  | IndexAccessE (e1, e2) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | ListV l, IntV n -> Array.get l n
      | _ ->
          (* Due to AL validation unreachable *)
          Printf.sprintf "Invalid index access %s" (string_of_expr expr)
          |> failwith)
  | LabelE (e1, e2) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      match (v1, v2) with
      | IntV n, ListV vs -> LabelV (n, array_to_list vs)
      | _ ->
          (* Due to AL validation unreachable *)
          "Invalid Label: " ^ string_of_expr expr |> failwith)
  | WasmInstrE (s, el) -> WasmInstrV (s, List.map (eval_expr env) el)
  | NameE name | IterE (name, _) -> Env.find name env
  | ConstE (ty, inner_e) ->
      let v = eval_expr env inner_e in
      let wasm_ty = eval_expr env ty in
      WasmInstrV ("const", [ wasm_ty; v ])
  | RecordE r -> RecordV (Record.map (eval_expr env) r)
  | ContE e -> (
      let v = eval_expr env e in
      match v with
      | LabelV (_, vs) -> ListV (Array.of_list vs)
      | _ -> failwith "Not a label")
  | e -> structured_string_of_expr e |> failwith

and eval_cond env cond =
  let do_binop e1 binop e2 =
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    binop v1 v2
  in
  match cond with
  | NotC c -> eval_cond env c |> not
  | EqC (e1, e2) -> do_binop e1 ( = ) e2
  | LtC (e1, e2) -> do_binop e1 ( < ) e2
  | LeC (e1, e2) -> do_binop e1 ( <= ) e2
  | GtC (e1, e2) -> do_binop e1 ( > ) e2
  | GeC (e1, e2) -> do_binop e1 ( >= ) e2
  | TopC "value" -> (
      match !stack with
      | [] -> false
      | h :: _ -> ( match h with WasmInstrV _ -> true | _ -> false))
  | c -> structured_string_of_cond c |> failwith

and interp_instr env i =
  (* string_of_stack !stack |> print_endline; *)
  (* structured_string_of_instr 0 i |> print_endline; *)
  (* string_of_instr (ref 0) 0 i |> print_endline; *)
  match i with
  | IfI (c, il1, il2) ->
      if eval_cond env c then interp_instrs env il1 else interp_instrs env il2
  | WhileI (c, il) ->
      (* TODO: this is a recursive implementation of while *)
      if eval_cond env c then interp_instr (interp_instrs env il) i else env
  | AssertI _ -> env (* TODO: insert assertion *)
  | PushI e ->
      (match eval_expr env e with
      | ListV vs -> Array.iter push vs
      | v -> push v);
      env
  | PopI e -> (
      match e with
      | IterE (name, ListN n) -> (
          match Env.find n env with
          | IntV k ->
              let vs = List.rev (List.init k (fun _ -> pop ())) in
              Env.add name (ListV (Array.of_list vs)) env
          | _ -> failwith "Invalid pop")
      | _ -> (
          (* due to Wasm validation *)
          let h = pop () in

          match (h, e) with
          | WasmInstrV ("const", [ ty; v ]), ConstE (ValueE ty', NameE name) ->
              assert (ty = ty');
              Env.add name v env
          | WasmInstrV ("const", [ ty; v ]), ConstE (NameE nt, NameE name) ->
              env |> Env.add nt ty |> Env.add name v
          | h, NameE name -> Env.add name h env
          | _ -> failwith "Invalid pop"))
  | LetI (pattern, e) -> (
      let v = eval_expr env e in
      match (pattern, v) with
      | IterE (name, ListN n), ListV vs ->
          env |> Env.add name v |> Env.add n (IntV (Array.length vs))
      | NameE name, v
      | ListE [| NameE name |], ListV [| v |]
      | IterE (name, _), v ->
          Env.add name v env
      | PairE (NameE n1, NameE n2), PairV (v1, v2)
      | ArrowE (NameE n1, NameE n2), ArrowV (v1, v2) ->
          env |> Env.add n1 v1 |> Env.add n2 v2
      | ConstructE (lhs_tag, ps), ConstructV (rhs_tag, vs)
        when lhs_tag = rhs_tag ->
          List.fold_left2
            (fun env p v ->
              match p with
              | NameE n | IterE (n, _) -> Env.add n v env
              | _ ->
                  string_of_instr (ref 0) 0 i
                  |> Printf.sprintf "Invalid destructuring assignment: %s"
                  |> failwith)
            env ps vs
      | _ ->
          string_of_instr (ref 0) 0 i
          |> Printf.sprintf "Invalid assignment: %s"
          |> failwith)
  | NopI | ReturnI None -> env
  | ReturnI (Some e) ->
      let result = eval_expr env e in
      Env.set_result result env
  | ReplaceI (IndexAccessE (e1, e2), e3) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      let v3 = eval_expr env e3 in
      match (v1, v2) with
      | ListV l, IntV i ->
          Array.set l i v3;
          env
      | _ -> failwith "Invalid Replace instr")
  | PerformI e ->
      eval_expr env e |> ignore;
      env
  | ExecuteI e ->
      eval_expr env e |> execute_wasm_instr;
      env
  | JumpI e ->
      (match eval_expr env e with
      | ListV vl -> vl |> array_to_list |> execute_wasm_instrs
      | _ -> "Not a list of Wasm Instruction" |> failwith);
      (match e with ContE _ -> raise ExitCont | _ -> ());
      env
  | ExitI _ ->
      let rec pop_while pred =
        let top = pop () in
        if pred top then top :: pop_while pred else []
      in
      let vals = pop_while (function WasmInstrV _ -> true | _ -> false) in
      vals |> List.rev |> List.iter push;
      env
  | i -> structured_string_of_instr 0 i |> failwith

and interp_instrs env il = List.fold_left interp_instr env il

and interp_algo algo args =
  let (Algo (_, params, il)) = algo in
  assert (List.length params = List.length args);

  let f acc param arg =
    let pattern, _ = param in
    match (pattern, arg) with
    | NameE n, arg -> Env.add n arg acc
    | _ -> failwith "Invalid destructuring assignment"
  in

  let init_env =
    List.fold_left2 f Env.empty params args
    |> Env.add (N "s") (StoreV !Testdata.store)
  in

  interp_instrs init_env il

(* Search AL Algorithm *)

and wasm_num2al_value n =
  let s = Values.string_of_num n in
  let t = Values.type_of_num n in
  match t with
  | I32Type | I64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); IntV (int_of_string s) ])
  | F32Type | F64Type ->
      WasmInstrV ("const", [ WasmTypeV (NumType t); FloatV (float_of_string s) ])

and call_algo name args =
  let algo = AlgoMap.find name !algo_map in
  interp_algo algo args

and execute_wasm_instr winstr =
  match winstr with
  | WasmInstrV ("const", _) | WasmInstrV ("ref.null", _) -> push winstr
  | WasmInstrV (name, args) -> call_algo name args |> ignore
  | _ -> failwith (string_of_value winstr ^ "is not a wasm instruction")

and execute_wasm_instrs winstrs =
  try List.iter execute_wasm_instr winstrs with ExitCont -> () | _ -> ()

(* TODO *)
let execute wmodule =

  (* Instantiation *)
  let instantiation_result =
    call_algo "instantiation" [ RecordV Record.empty; wmodule ] |> Env.get_result
  in
  let store, modinst =
    match instantiation_result with
    | PairV (StoreV s, ModuleInstV m) -> (s, m)
    | v ->
        string_of_value v
        |> Printf.sprintf "Invalid instantiation result: %s"
        |> failwith
  in

  (* Invocation *)
  let invocation_result =
    call_algo "invocation" [ StoreV store; ModuleInstV modinst ]
    |> Env.get_result
  in
  string_of_value invocation_result |> print_endline

let wasm_instr2al_value winstr =
  let f_i32 f i32 = WasmInstrV (f, [ IntV (Int32.to_int i32.it) ]) in

  match winstr.it with
  (* wasm values *)
  | Ast.Const num -> wasm_num2al_value num.it
  | Ast.RefNull t -> WasmInstrV ("ref.null", [ WasmTypeV (RefType t) ])
  (* wasm instructions *)
  | Ast.Nop -> WasmInstrV ("nop", [])
  | Ast.Drop -> WasmInstrV ("drop", [])
  | Ast.Binary (Values.I32 Ast.I32Op.Add) ->
      WasmInstrV
        ("binop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "Add" ])
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      WasmInstrV
        ("testop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "Eqz" ])
  | Ast.Compare (Values.F32 Ast.F32Op.Gt) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.F32Type); StringV "Gt" ])
  | Ast.Compare (Values.I32 Ast.I32Op.GtS) ->
      WasmInstrV
        ("relop", [ WasmTypeV (Types.NumType Types.I32Type); StringV "GtS" ])
  | Ast.Select None -> WasmInstrV ("select", [ StringV "TODO: None" ])
  | Ast.LocalGet i32 -> f_i32 "local.get" i32
  | Ast.LocalSet i32 -> f_i32 "local.set" i32
  | Ast.LocalTee i32 -> f_i32 "local.tee" i32
  | Ast.GlobalGet i32 -> f_i32 "global.get" i32
  | Ast.GlobalSet i32 -> f_i32 "global.set" i32
  | Ast.TableGet i32 -> f_i32 "table.get" i32
  | Ast.Call i32 -> f_i32 "call" i32
  | _ -> failwith "Not implemented"

(* Test Interpreter *)

let wasm_func2al wasm_module wasm_func =
  let { it = Types.FuncType (vtl1, vtl2); _ } =
    Int32.to_int wasm_func.it.Ast.ftype.it
    |> List.nth wasm_module.it.Ast.types
  in

  let to_al ty = WasmTypeV ty in
  let ftype =
    ArrowV (
      ListV (List.map to_al vtl1 |> Array.of_list),
      ListV (List.map to_al vtl2 |> Array.of_list)
    ) in

  ConstructV ("FUNC", [ftype])

let wasm_module2al wasm_module =
  let func_list =
    List.map (wasm_func2al wasm_module) wasm_module.it.funcs
    |> Array.of_list
    in
  ConstructV ("MODULE", [ListV func_list])

let test_module testcase =
  let (_, wasm_module, _) = testcase in
  let module_construct = wasm_module2al wasm_module in

  (* Execute *)
  execute module_construct

let test name ast expected_result =
  (* Print test name *)
  print_endline name;

  (* Initialize *)
  stack := [];
  Testdata.get_frame_data () |> push;
  Testdata.store := Testdata.get_store_data ();

  try
    (* Execute *)
    execute_wasm_instrs ast;

    (* Check *)
    let actual_result = List.hd !stack |> Testdata.string_of_result in
    if actual_result = expected_result then print_endline "Ok\n"
    else
      "Fail!\n" ^ "Expected: " ^ expected_result ^ "\n" ^ "Actual: "
      ^ actual_result ^ "\n" ^ string_of_stack !stack
      |> print_endline
  with e -> print_endline ("Fail!(" ^ Printexc.to_string e ^ ")\n")

let test_reference testcase =
  let name, raw_ast, expected_result = testcase in
  let ast = List.map wasm_instr2al_value raw_ast in
  test name ast expected_result

let test_wasm_value testcase =
  let name, ast, expected_result = testcase in
  test name ast expected_result

(* Entry *)

let interpret algos =
  let test_module_semantics = false in

  algo_map := to_map algos;
  algo_map :=
    List.fold_left
      (fun acc algo ->
        let (Algo (name, _, _)) = algo in
        AlgoMap.add name algo acc)
      !algo_map Manual.manual_algos;

  if test_module_semantics then List.iter test_module Testdata.module_testcases
  else (
    List.iter test_reference Testdata.testcases_reference;
    List.iter test_wasm_value Testdata.testcases_wasm_value)
