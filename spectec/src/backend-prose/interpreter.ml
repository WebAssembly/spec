open Print
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
  let empty =
    (Env'.add (N "s") (StoreV Testdata.store) Env'.empty, StringV "Undefined")

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
  | _ ->
      failwith "Invalid DSL function call"

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
      try
        match eval_expr env e with
        | ListV vl -> IntV (Array.length vl)
        | _ -> failwith "Not a list" (* Due to AL validation, unreachable *)
      with
        | Not_found -> IntV 0)
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
  | ConcatE (e1, e2) -> (
      match (eval_expr env e1, eval_expr env e2) with
      | ListV v1, ListV v2 -> ListV (Array.append v1 v2)
      | _ -> failwith "Not a list")
  | ListE el -> ListV (Array.map (eval_expr env) el)
  | ListFillE (e1, e2) -> (
      match (eval_expr env e1, eval_expr env e2) with
      | v, IntV n -> ListV (Array.make n v)
      | _ -> failwith "Not an Int")
  | AccessE (e, p) -> begin match p with
      | IndexP e' ->
        let v1 = eval_expr env e in
        let v2 = eval_expr env e' in
        begin match (v1, v2) with
        | ListV l, IntV n -> Array.get l n
        | _ ->
            (* Due to AL validation unreachable *)
            Printf.sprintf "Invalid index access %s" (string_of_expr expr)
            |> failwith
        end
      | SliceP (e1, e2) ->
        let v = eval_expr env e in
        let v1 = eval_expr env e1 in
        let v2 = eval_expr env e2 in
        begin match (v, v1, v2) with
        | ListV l, IntV n1, IntV n2 -> ListV (Array.sub l n1 n2)
        | _ ->
            (* Due to AL validation unreachable *)
            Printf.sprintf "Invalid slice access %s" (string_of_expr expr)
            |> failwith
        end
      | DotP str -> begin match eval_expr env e with
        | ModuleInstV m -> Record.find str m
        | FrameV (_, r) -> Record.find str r
        | StoreV s -> Record.find str !s
        | _ -> failwith "Not a record"
        end
      end
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
  | PairE (e1, e2) -> PairV (eval_expr env e1, eval_expr env e2)
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
  | ForI (e, il) ->
      (match eval_expr env (LengthE e) with
        | IntV n ->
            for i = 0 to n-1 do
              let new_env = Env.add (N "i") (IntV i) env in
              interp_instrs new_env il |> ignore
            done;
            env
        | _ -> failwith "Unreachable")
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
  | PopAllI e -> (
    match e with
    | IterE (name, List) -> 
      let rec pop_value vs = (match !stack with
      | h :: _  -> (match h with
        | WasmInstrV ("const", _) -> pop_value (pop () :: vs)
        | _ -> vs)
      | _ -> vs) 
      in
      let vs = pop_value [] in
      Env.add name (ListV (Array.of_list vs)) env
    | _ -> failwith "Invalid pop")
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
              match p, v with
              | NameE n, v | IterE (n, _), v -> Env.add n v env
              | PairE (NameE n1, NameE n2), PairV (v1, v2) ->
                  env |> Env.add n1 v1 |> Env.add n2 v2
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
  | ReplaceI (e1, IndexP e2, e3) -> (
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      let v3 = eval_expr env e3 in
      match (v1, v2) with
      | ListV l, IntV i ->
          Array.set l i v3;
          env
      | _ -> failwith "Invalid Replace instr")
  (* TODO *)
  | ReplaceI (_, _, e) ->
      (match Record.find "FUNC" !Testdata.store with
      | ListV l ->
          eval_expr env e |> Array.set l 0;
          env
      | _ -> failwith "TODO")
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
  | AppendI (e1, e2, s) ->
      let v1 = eval_expr env e1 in
      (match eval_expr env e2 with
      | StoreV ref when Record.mem s !ref |> not ->
          ref := Record.add s (ListV [| v1 |]) !ref
      | StoreV ref ->
          let a = match Record.find s !ref with
            | ListV l -> l
            | _ -> failwith "Unreachable" in
          let appended_result = ListV (Array.append a [| v1 |]) in
          ref := Record.add s appended_result !ref
      | v -> string_of_value v |> Printf.sprintf "Append %s" |> failwith);
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

  let init_env = List.fold_left2 f Env.empty params args in

  interp_instrs init_env il



(* Search AL Algorithm *)

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

let execute wmodule =

  (* Instantiation *)
  call_algo "instantiation" [ wmodule ] |> Env.get_result |> ignore;

  (* Invocation *)
  call_algo "invocation" [ IntV 0 ] |> ignore



(* Test interpreter *)

let check expected_result =
    let actual_result = List.hd !stack |> Testdata.string_of_result in
    if actual_result = expected_result then print_endline "Ok\n"
    else
      "Fail!\n" ^ "Expected: " ^ expected_result ^ "\n" ^ "Actual: "
      ^ actual_result ^ "\n" ^ string_of_stack !stack
      |> print_endline

let test_module () =

  print_endline "** Test module **\n";

  (* Construct Al *)
  let f (name, raw, res) = (name, Construct.al_of_wasm_module raw, res) in
  let al_testcases = List.map f Testdata.testcases_module in

  (* test *)
  let test_module (name, wmodule, res) =

    (* Print test name *)
    print_endline name;

    (* Initialize *)
    stack := [];
    Testdata.store := Record.empty;

    (* Execute *)
    try execute wmodule; check res with
    | e -> print_endline ("Fail!(" ^ Printexc.to_string e ^ ")\n") in

  List.iter test_module al_testcases

let test_instrs () =

  print_endline "** Test instrs **\n";

  (* Construct Al *)
  let f (name, raw, res) = (name, Construct.al_of_wasm_instrs [] raw, res) in
  let al_testcases =
    List.map f Testdata.testcases_reference @ Testdata.testcases_wasm_value in

  (* test *)
  let test_instr (name, winstrs, res) =

    (* Print test name *)
    print_endline name;

    (* Initialize *)
    stack := [];
    Testdata.get_frame_data () |> push;
    Testdata.store := Testdata.get_store_data ();

    (* execute *)
    try execute_wasm_instrs winstrs; check res with
    | e -> print_endline ("Fail!(" ^ Printexc.to_string e ^ ")\n") in

  List.iter test_instr al_testcases

(* Entry *)

let interpret algos =

  algo_map := to_map algos;

  (* Add manual algorithms *)
  print_endline "** Manual algorithms **\n";

  algo_map :=
    List.fold_left
      (fun acc algo ->
        string_of_algorithm algo |> print_endline;
        let (Algo (name, _, _)) = algo in
        AlgoMap.add name algo acc)
      !algo_map Manual.manual_algos;

  (* Test instrs *)
  test_instrs ();

  (* Test module *)
  test_module ()
