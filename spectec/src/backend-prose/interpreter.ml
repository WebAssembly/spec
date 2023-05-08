open Print
open Reference_interpreter
open Source

(* AL Data Structures *)

(* Algorithm Map *)

module AlgoMapKey = struct
  type t = string
  let compare = Stdlib.compare
end

module AlgoMap = Map.Make(AlgoMapKey)

let algo_map = ref AlgoMap.empty

let to_map algos =
  let f acc algo =
    let Al.Algo (name, _, _) = algo in
    AlgoMap.add name algo acc in

  List.fold_left f AlgoMap.empty algos

(* Environmet *)

module Env = struct

  module EnvKey = struct
    type t = Al.name
    let compare a b = Stdlib.compare (string_of_name a) (string_of_name b)
  end

  module Env' = Map.Make (EnvKey)

  type t = Al.name Env'.t * Al.value

  (* Result *)
  let get_result (_, res) = res
  let set_result v (env, _) = env, v

  (* Environment API *)
  let empty = Env'.empty, Al.StringV "Undefined"
  let find key (env, _) = Env'.find key env
  let add key elem (env, res) = Env'.add key elem env, res

end



(* Helper functions *)

(* NOTE: These functions should be used only if validation ensures no failure *)

let al_value2wasm_value = function
  | Al.WasmV v -> v
  | _ -> failwith "Not a Wasm value"

let al_value2wasm_type = function
  | Al.WasmTypeV ty -> ty
  | _ -> failwith "Not a Wasm type"

let al_value2int = function
  | Al.IntV i -> i
  | _ -> failwith "Not an integer value"

let wasm_value2al_num_value v = match v with
  | Values.Num n -> 
      let n = Values.string_of_num n in
      begin match Values.type_of_value v with
        | Types.NumType I32Type
        | Types.NumType I64Type -> Al.IntV (int_of_string n)
        | Types.NumType F32Type
        | Types.NumType F64Type -> Al.FloatV (float_of_string n)
        | _ -> failwith "Not a Numtype"
      end
  | _ -> failwith "Not a Num value"

let mk_wasm_num ty i = match ty with
  | Types.NumType I32Type ->
      let num = I32.of_int_s i |> Values.I32Num.to_num in
      Values.Num (num)
  | Types.NumType I64Type ->
      let num = I64.of_int_s i |> Values.I64Num.to_num in
      Values.Num (num)
  | Types.NumType F32Type | Types.NumType F64Type ->
      (* TODO *)
      failwith "Not implemented"
  | _ -> failwith "Not a Numtype"



(* Interpreter *)

let rec dsl_function_call fname args = match fname with
  (* Numerics *)
  | Al.N name when Numerics.mem name -> Numerics.call_numerics name args
  (* Runtime *)
  | Al.N name when AlgoMap.mem name !algo_map ->
      run_algo name args |> Env.get_result
  | _ -> failwith "Invalid DSL function call"

and eval_expr env expr = match expr with
  | Al.ValueE v -> v
  | Al.AppE (fname, el) ->
      List.map (eval_expr env) el |> dsl_function_call fname
  | Al.LengthE e ->
      begin match eval_expr env e with
        | ListV (vl) -> IntV (Array.length vl)
        | _ -> failwith "Not a list" (* Due to AL validation, unreachable *)
      end
  | Al.FrameE -> FrameV (Stack.get_current_frame ())
  | Al.PropE (e, str) ->
      begin match eval_expr env e with
        | ModuleInstV m -> Al.Record.find str m
        | FrameV f -> Al.Record.find str f
        | StoreV s -> Al.Record.find str s
        | _ -> failwith "Not a record"
      end
  | Al.ListE el ->
      let vl = Array.map (eval_expr env) el in
      Al.ListV vl
  | Al.IndexAccessE (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      begin match (v1, v2) with
        | (Al.ListV l, Al.IntV n) -> Array.get l n
        | _ ->
            (* Due to AL validation unreachable *)
            Printf.sprintf "Invalid index access %s" (string_of_expr expr)
            |> failwith
      end
  | Al.NameE name -> Env.find name env
  | Al.ConstE (ty, inner_e) ->
      let i = eval_expr env inner_e |> al_value2int in
      let wasm_ty = eval_expr env ty |> al_value2wasm_type in
      Al.WasmV (mk_wasm_num wasm_ty i)
  | e -> structured_string_of_expr e |> failwith

and eval_cond env = function
  | Al.NotC c -> eval_cond env c |> not
  | Al.EqC (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      v1 = v2
  | Al.GeC (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      v1 >= v2
  | c -> structured_string_of_cond c |> failwith

and interp_instr env i =
  (*string_of_stack !stack |> print_endline;
  string_of_instr (ref 0) 0 i |> print_endline;*)
  match i with
  | Al.IfI (c, il1, il2) ->
      if eval_cond env c then
        interp_instrs env il1
      else
        interp_instrs env il2
  | Al.AssertI (_) -> env (* TODO: insert assertion *)
  | Al.PushI e ->
      let v = eval_expr env e |> al_value2wasm_value in
      Stack.push_v v;
      env
  | Al.PopI e ->
      (* due to Wasm validation *)
      assert (Stack.length () > 0);

      let h = Stack.pop () in

      begin match (h, e) with
        | (ValueS h, Al.ConstE (Al.ValueE (WasmTypeV ty'), Al.NameE name)) ->
            (* due to Wasm validation *)
            let ty = Values.type_of_value h in
            assert (ty = ty');

            let v = wasm_value2al_num_value h in
            Env.add name v env
        | (ValueS h, Al.ConstE (Al.NameE nt, Al.NameE name)) ->
            let ty = Al.WasmTypeV (Values.type_of_value h) in
            let v = wasm_value2al_num_value h in
            Env.add nt ty env |> Env.add name v
        | (ValueS h, Al.NameE (name)) ->
            Env.add name (Al.WasmV h) env
        | _ -> failwith "Invalid case"
      end
  | Al.LetI (pattern, e) ->
      let v = eval_expr env e in
      begin match pattern, v with
        | Al.ListE [|Al.NameE name|], ListV [|v|]
        | Al.NameE name, v -> Env.add name v env
        | _ ->
            string_of_instr (ref 0) 0 i
            |> Printf.sprintf "Invalid pattern: %s"
            |> failwith
      end
  | Al.NopI | Al.ReturnI None -> env
  | Al.ReturnI (Some e) ->
      let result = eval_expr env e in
      Env.set_result result env
  | Al.ReplaceI (Al.IndexAccessE (e1, e2), e3) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      let v3 = eval_expr env e3 in
      begin match v1, v2 with
        | Al.ListV l, IntV i ->
            Array.set l i v3;
            env
        | _ -> failwith "Invalid Replace instr"
      end
  | Al.PerformI e ->
      let _ = eval_expr env e in
      env
  | i -> structured_string_of_instr 0 i |> failwith

and interp_instrs env il =
  List.fold_left interp_instr env il

and interp_algo algo args =
  let Al.Algo (_, params, il) = algo in
  assert (List.length params = List.length args);

  let f acc param arg =
    let (pattern, _) = param in
    match (pattern, arg) with
      | (Al.NameE n, arg) -> Env.add n arg acc
      | _ -> failwith "Invalid destructuring assignment" in

  let init_env =
    List.fold_left2 f Env.empty params args
    |> Env.add (N "s") (Al.StoreV !Testdata.store) in

  interp_instrs init_env il



(* Search AL Algorithm *)

and extract_data_of_wasm_instruction winstr = match winstr.it with
  | Ast.Nop -> "nop", []
  | Ast.Drop -> "drop", []
  | Ast.Binary (Values.I32 Ast.I32Op.Add) ->
      "binop", [Al.WasmTypeV (Types.NumType Types.I32Type); Al.StringV "Add"]
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      "testop", [Al.WasmTypeV (Types.NumType Types.I32Type); Al.StringV "Eqz"]
  | Ast.Compare (Values.F32 Ast.F32Op.Gt) ->
      "relop", [Al.WasmTypeV (Types.NumType Types.F32Type); Al.StringV "Gt"]
  | Ast.Compare (Values.I32 Ast.I32Op.GtS) ->
      "relop", [Al.WasmTypeV (Types.NumType Types.I32Type); Al.StringV "GtS"]
  | Ast.Select None -> "select", [Al.StringV "TODO: None"]
  | Ast.LocalGet i32 ->
      let n = Int32.to_int i32.it in
      "local.get", [Al.IntV n]
  | Ast.LocalSet i32 ->
      let n = Int32.to_int i32.it in
      "local.set", [Al.IntV n]
  | Ast.GlobalGet i32 ->
      let n = Int32.to_int i32.it in
      "global.get", [Al.IntV n]
  | Ast.GlobalSet i32 ->
      let n = Int32.to_int i32.it in
      "global.set", [Al.IntV n]
  | Ast.TableGet i32 ->
      let n = Int32.to_int i32.it in
      "table.get", [Al.IntV n]
  | _ -> failwith "Not implemented"

and run_algo name args =
  let algo = AlgoMap.find name !algo_map in
  interp_algo algo args

let run_wasm_instr winstr = match winstr.it with
  | Ast.Const num -> Stack.push_v (Values.Num num.it)
  | Ast.RefNull ref -> Stack.push_v (Values.Ref (Values.NullRef ref))
  | _ ->
      let (name, args) = extract_data_of_wasm_instruction winstr in
      let _env = run_algo name args in
      ()

let run winstrs = List.iter run_wasm_instr winstrs



(* Test Interpreter *)

let test test_case =
  (* Print test name *)
  let (name, ast, expected_result) = test_case in
  print_endline name;

  (* Initialize *)
  Stack.reset_stack ();
  Testdata.get_frame_data () |> Stack.push_f;
  Testdata.store := Testdata.get_store_data ();

  (* Execute *)
  run ast;

  (* Check *)
  let actual_result = Stack.hd () |> string_of_stack_elem in
  if actual_result = expected_result then
    print_endline "Ok\n"
  else
    "Fail!\n" ^ string_of_stack (Stack.get_stack ()) |> print_endline

(* Entry *)

let interpret algos =
  algo_map := to_map algos;

  List.iter test Testdata.test_cases
