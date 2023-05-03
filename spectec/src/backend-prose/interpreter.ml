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



(* Wasm Data Structures *)

(* Stack *)

type stack_elem =
  | ValueS of Values.value
  | FrameS of Al.frame

type stack = stack_elem list

let stack: stack ref = ref []

(* Store *)

type store = { global: Values.value list }

let store: store ref = ref { global = [] }



(* Helper functions *)

(* NOTE: These functions should be used only if validation ensures no failure *)

let get_current_frame () =
  let f = function FrameS _ -> true | _ -> false in
  match List.find f !stack with
    | FrameS frame -> frame
    | _ -> failwith "No frame"

let al_value2wasm_value = function
  | Al.WasmV v -> v
  | _ -> failwith "Not a Wasm value"

let al_value2wasm_type = function
  | Al.WasmTypeV ty -> ty
  | _ -> failwith "Not a Wasm type"

let al_value2int = function
  | Al.IntV i -> i
  | _ -> failwith "Not an integer value"

let al_value2float = function
  | Al.FloatV f -> f
  | _ -> failwith "Not a float value"

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

let access_field v s = match (v, s) with
  | (Al.FrameV f, "LOCAL") ->
      let l = List.map (fun w -> Al.ValueE (Al.WasmV w)) f.local in
      Al.ListE l
  | _ -> failwith "Invalid field access"



(* Interpreter *)

let rec dsl_function_call env fname args = match (fname, args) with
  (* Numerics *)
  | (Al.N "testop", [op; _; e]) ->
      let v = eval_expr env e |> al_value2int in
      begin match eval_expr env op with
        | Al.StringV "Eqz" ->
            let i = v = 0 |> Bool.to_int in
            Al.IntV i
        | _ -> failwith "Invalid testop"
      end
  | (Al.N "relop", [op; _; e1; e2]) ->
      let v1 = eval_expr env e1 |> al_value2float in
      let v2 = eval_expr env e2 |> al_value2float in
      begin match eval_expr env op with
        | Al.StringV "Gt" ->
            let i = v1 > v2 |> Bool.to_int in
            Al.IntV i
        | _ -> failwith "Invalid relop"
      end
  (* Runtime *)
  | (Al.N name, args) ->
      List.map (eval_expr env) args
      |> run_algo name
      |> Env.get_result
  | _ -> failwith "Invalid DSL function call"

and eval_expr env expr = match expr with
  | Al.ValueE v -> v
  | Al.AppE (fname, el) -> dsl_function_call env fname el
  | Al.FrameE -> FrameV (get_current_frame ())
  | Al.NameE name -> Env.find name env
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
            Printf.sprintf "Invalid index access %s" (Print.string_of_expr expr)
            |> failwith
      end
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
  | c -> structured_string_of_cond c |> failwith

and interp_instr env = function
  | Al.IfI (c, il1, il2) ->
      if eval_cond env c then
        interp_instrs env il1
      else
        interp_instrs env il2
  | Al.AssertI (_) -> env (* TODO: insert assertion *)
  | Al.PushI e ->
      let v = eval_expr env e |> al_value2wasm_value in
      stack := (ValueS v) :: !stack;
      env
  | Al.PopI e ->
      (* due to Wasm validation *)
      assert (List.length !stack > 0);

      let h = List.hd !stack in
      stack := List.tl !stack;

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
  | Al.LetI (Al.NameE (name), e) ->
      Env.add name (eval_expr env e) env
  | Al.NopI | Al.ReturnI None -> env
  | Al.ReturnI (Some e)->
      let result = eval_expr env e in
      Env.set_result result env
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
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      "testop", [Al.WasmTypeV (Types.NumType Types.I32Type); Al.StringV "Eqz"]
  | Ast.Compare (Values.F32 Ast.F32Op.Gt) ->
      "relop", [Al.WasmTypeV (Types.NumType Types.F32Type); Al.StringV "Gt"]
  | Ast.Select None -> "select", [Al.StringV "TODO: None"]
  | Ast.LocalGet i32 ->
      let n = Int32.to_int i32.it in
      "local.get", [Al.IntV n]
  | Ast.GlobalGet i32 ->
      let n = Int32.to_int i32.it in
      "global.get", [Al.IntV n]
  | _ -> failwith "Not implemented"

and run_algo name args =
  let algo = AlgoMap.find name !algo_map in
  interp_algo algo args

let run_wasm_instr winstr = match winstr.it with
  | Ast.Const num -> stack := ValueS (Values.Num (num.it)) :: !stack
  | Ast.RefNull ref -> stack := ValueS (Values.Ref (Values.NullRef ref)) :: !stack
  | _ ->
      let (name, args) = extract_data_of_wasm_instruction winstr in
      let _env = run_algo name args in
      ()

let run winstrs = List.iter run_wasm_instr winstrs



(* Hardcoded Data *)

let to_phrase x = (@@) x no_region
let i32 = I32.of_int_s
let i64 = I64.of_int_s
let f32 = F32.of_float
let f64 = F64.of_float

(* Hardcoded Frame *)

let initial_frame = { Al.local = [
  Values.Num (Values.I32 (i32 3));
  Values.Num (Values.I32 (i32 0));
  Values.Num (Values.I32 (i32 7))
] }

(* Hardcoded Wasm Instructions *)

let testop = "testop", [
  Operators.i32_const (i32 0 |> to_phrase);
  Operators.i32_eqz
], "1"

let relop = "relop", [
  Operators.f32_const (f32 1.4142135 |> to_phrase);
  Operators.f32_const (f32 3.1415926 |> to_phrase);
  Operators.f32_gt
], "0"

let nop = "nop", [
  Operators.i64_const (i64 0 |> to_phrase);
  Operators.nop
], "0"

let drop = "drop", [
  Operators.f64_const (f64 3.1 |> to_phrase);
  Operators.f64_const (f64 5.2 |> to_phrase);
  Operators.drop
], "3.100_000_000_000_000_1"

let select = "select", [
  Operators.f64_const (f64 Float.max_float |> to_phrase);
  Operators.ref_null Types.FuncRefType;
  Operators.i32_const (i32 0 |> to_phrase);
  Operators.select None
], "null"

let local_get = "local_get", [
  Operators.local_get (i32 2 |> to_phrase)
], "7"

let global_get = "global_get", [
  Operators.global_get (i32 1 |> to_phrase)
], "5"

let test_cases =
  [ testop; relop; nop; drop; select; local_get(*; global_get*) ]



(* Stack Stringifier *)

let string_of_stack_elem e = match e with
  | ValueS v -> Values.string_of_value v
  | FrameS f -> Print.string_of_frame f

let string_of_stack st =
  let f acc e = acc ^ string_of_stack_elem e ^ "\n" in
  List.fold_left f "[Stack]\n" st


  
(* Test Interpreter *)

let init_stack () = stack := FrameS initial_frame :: []

let test test_case =
  (* Print test name *)
  let (name, ast, expected_result) = test_case in
  print_endline name;

  (* Initialize *)
  init_stack ();

  (* Execute *)
  List.map to_phrase ast |> run;

  (* Check *)
  let actual_result = List.hd !stack |> string_of_stack_elem in
  if actual_result = expected_result then
    print_endline "Ok\n"
  else
    "Fail!\n" ^ string_of_stack !stack |> print_endline

let interpret algos =
  algo_map := to_map algos;

  (* Test all asts *)
  List.iter test test_cases
