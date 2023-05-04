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
  let empty =
    let env = Env'.add (N "s") Al.StoreV Env'.empty in
    env, Al.StringV "Undefined"
  let find key (env, _) = Env'.find key env
  let add key elem (env, res) = Env'.add key elem env, res

end



(* Wasm Data Structures *)

let stack: Al.stack ref = ref []

let store: Al.store ref = ref { Al.global = []; Al.table = [] }

(* Stack Helper functions *)

let reset_stack () = stack := []

let push_v v = stack := Al.ValueS (v) :: !stack

let push_f f = stack := Al.FrameS (f) :: !stack

let pop () =
  let res = List.hd !stack in
  stack := List.tl !stack;
  res

let get_current_frame () =
  let f = function Al.FrameS _ -> true | _ -> false in
  match List.find f !stack with
    | Al.FrameS frame -> frame
    | _ ->
        (* Due to Wasm validation, unreachable *)
        failwith "No frame"

(* Store Helper *)

let set_store s = store := s



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

let access_field v s = match v, s with
  (* Frame *)
  | Al.FrameV f, "LOCAL" ->
      let l =
        Array.map (fun w -> Al.ValueE (Al.WasmV w)) f.local
        |> Stdlib.Array.to_list in
      Al.ListE l
  | Al.FrameV f, "MODULE" ->
      Al.ValueE (ModuleInstV f.moduleinst)
  (* Module instance *)
  | Al.ModuleInstV m, "GLOBAL" ->
      let l = List.map (fun a -> Al.ValueE a) m.globaladdr in
      Al.ListE l
  | Al.ModuleInstV m, "TABLE" ->
      let l = List.map (fun a -> Al.ValueE a) m.globaladdr in
      Al.ListE l
  (* Store *)
  | Al.StoreV, "GLOBAL" ->
      let l = List.map (fun w -> Al.ValueE (Al.WasmV w)) !store.global in
      Al.ListE l
  | Al.StoreV, "TABLE" ->
      let wrap_list wl = Al.ListE (List.map (fun w -> Al.ValueE (Al.WasmV w)) wl) in
      let l = List.map wrap_list !store.table in
      Al.ListE l
  | v, x ->
      Printf.sprintf "Invalid field access %s.%s" (string_of_value v) x
      |> failwith



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
        | ListV (vl) -> IntV (List.length vl)
        | _ -> failwith "Not a list" (* Due to AL validation, unreachable *)
      end
  | Al.FrameE -> FrameV (get_current_frame ())
  | Al.PropE (e, s) ->
      let v = eval_expr env e in
      access_field v s |> eval_expr env
  | Al.ListE el ->
      let vl = List.map (eval_expr env) el in
      Al.ListV vl
  | Al.IndexAccessE (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      begin match (v1, v2) with
        | (Al.ListV l, Al.IntV n) -> List.nth l n
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
      push_v v;
      env
  | Al.PopI e ->
      (* due to Wasm validation *)
      assert (List.length !stack > 0);

      let h = pop () in

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
        | Al.ListE [Al.NameE name], ListV [v]
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
  | Al.ReplaceI (Al.IndexAccessE (Al.PropE (e1, "LOCAL"), e2), e3) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      let v3 = eval_expr env e3 in
      begin match v1, v2, v3 with
        | Al.FrameV f, IntV i, WasmV v ->
            Array.set f.local i v;
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
  let init_env = List.fold_left2 f Env.empty params args in

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
  | Ast.TableGet i32 ->
      let n = Int32.to_int i32.it in
      "table.get", [Al.IntV n]
  | _ -> failwith "Not implemented"

and run_algo name args =
  let algo = AlgoMap.find name !algo_map in
  interp_algo algo args

let run_wasm_instr winstr = match winstr.it with
  | Ast.Const num -> push_v (Values.Num num.it)
  | Ast.RefNull ref -> push_v (Values.Ref (Values.NullRef ref))
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
  reset_stack ();
  push_f Testdata.initial_frame;
  set_store Testdata.initial_store;

  (* Execute *)
  run ast;

  (* Check *)
  let actual_result = List.hd !stack |> string_of_stack_elem in
  if actual_result = expected_result then
    print_endline "Ok\n"
  else
    "Fail!\n" ^ string_of_stack !stack |> print_endline

(* Entry *)

let interpret algos =
  algo_map := to_map algos;

  List.iter test Testdata.test_cases
