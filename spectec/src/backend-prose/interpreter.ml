open Print
open Reference_interpreter
open Source

(* Hardcoded Wasm AST *)
let to_phrase x = (@@) x no_region
let i32 = I32.of_int_s
let i64 = I64.of_int_s
let f32 = F32.of_float
let f64 = F64.of_float

let testop = [
  Ast.Const (Values.I32 I32.zero |> to_phrase) |> to_phrase;
  Ast.Test (Values.I32 Ast.I32Op.Eqz) |> to_phrase
]

let relop = [
  Ast.Const (Values.F32 (f32 1.4142135) |> to_phrase) |> to_phrase;
  Ast.Const (Values.F32 (f32 3.1415926) |> to_phrase) |> to_phrase;
  Ast.Compare (Values.F32 Ast.F32Op.Gt) |> to_phrase
]

let nop = [
  Ast.Const (Values.I64 (i64 42) |> to_phrase) |> to_phrase;
  Ast.Nop |> to_phrase
]

let drop = [
  Ast.Const (Values.F64 (f64 3.1) |> to_phrase) |> to_phrase;
  Ast.Const (Values.F64 (f64 5.2) |> to_phrase) |> to_phrase;
  Ast.Drop |> to_phrase
]

let ref_is_null = [
  Ast.RefNull Types.ExternRefType |> to_phrase;
  Ast.RefIsNull |> to_phrase
]

let select = [
  Ast.Const (Values.F64 (f64 Float.max_float) |> to_phrase) |> to_phrase;
  Ast.RefNull Types.FuncRefType |> to_phrase;
  Ast.Const (Values.I32 (I32.of_int_s 0) |> to_phrase) |> to_phrase;
  Ast.Select None |> to_phrase
]



(* Data Structures *)
module Env =
  struct
    module ValueEnvKey =
      struct
        type t = Al.name
        let compare a b = Stdlib.compare (string_of_name a) (string_of_name b)
      end
    module TypeEnvKey =
      struct
        type t = string
        let compare = Stdlib.compare
      end

    module ValueEnv = Map.Make(ValueEnvKey)
    module TypeEnv = Map.Make(TypeEnvKey)

    type t = (Al.value ValueEnv.t) * (Types.value_type TypeEnv.t)

    let empty = (ValueEnv.empty, TypeEnv.empty)

    (* Value env api *)
    let find key (value_env, _) = ValueEnv.find key value_env
    let add key elem (value_env, type_env) =
      (ValueEnv.add key elem value_env, type_env)

    (* Type env api *)
    let find_type key (_, type_env) = TypeEnv.find key type_env
    let add_type key elem (value_env, type_env) =
      (value_env, TypeEnv.add key elem type_env)
  end

type stack = Values.value list

let st_ref: stack ref = ref []



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



(* Interpreter *)
let rec try_numerics env fname args = match (fname, args) with
  | (Al.N "testop", [op; _; e]) ->
      let v = eval_expr env e |> al_value2int in
      begin match eval_expr env op with
        | Al.StringV "Eqz" -> v = 0 |> Bool.to_int
        | _ -> failwith "Invalid testop"
      end
  | (Al.N "relop", [op; _; e1; e2]) ->
      let v1 = eval_expr env e1 |> al_value2float in
      let v2 = eval_expr env e2 |> al_value2float in
      begin match eval_expr env op with
        | Al.StringV "Gt" -> v1 > v2 |> Bool.to_int
        | _ -> failwith "Invalid relop"
      end
  (* TODO: handle non-deterministic *)
  | _ -> string_of_name fname |> failwith

and eval_expr env = function
  (* TODO: extend function application *)
  | Al.ValueE v -> v
  | Al.AppE (fname, el) -> Al.IntV (try_numerics env fname el)
  | Al.NameE name -> Env.find name env
  | Al.ConstE (ty, inner_e) ->
      let i = eval_expr env inner_e |> al_value2int in
      let wasm_ty = eval_expr env ty |> al_value2wasm_type in
      Al.WasmV (mk_wasm_num wasm_ty i)
  | e -> structured_string_of_expr e |> failwith

let rec eval_cond env = function
  | Al.NotC c -> eval_cond env c |> not
  | Al.EqC (e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      v1 = v2
  | c -> structured_string_of_cond c |> failwith

let rec interp_instr env = function
  | Al.IfI (c, il1, il2) ->
      if eval_cond env c
      then interp_instrs env il1
      else interp_instrs env il2
  | Al.AssertI (_) -> env (* TODO: insert assertion *)
  | Al.PushI e ->
      let v = eval_expr env e |> al_value2wasm_value in
      st_ref := v :: !st_ref;
      env
  | Al.PopI (Al.ConstE (Al.ValueE (WasmTypeV ty'), Al.NameE name)) ->
      (* Due to Wasm validation *)
      assert (List.length !st_ref > 0);

      let h = List.hd !st_ref in
      st_ref := List.tl !st_ref;

      let ty = Values.type_of_value h in
      assert (ty = ty');
      let v = wasm_value2al_num_value h in
      Env.add name v env
  | Al.PopI (Al.ConstE (Al.WasmTypeVarE nt, Al.NameE name)) ->
      (* Due to Wasm validation *)
      assert (List.length !st_ref > 0);

      let h = List.hd !st_ref in
      st_ref := List.tl !st_ref;

      let ty = Values.type_of_value h in
      let v = wasm_value2al_num_value h in
      Env.add_type nt ty env |> Env.add name v
  | Al.PopI (Al.NameE (name)) -> 
      (* Due to Wasm validation *)
      assert (List.length !st_ref > 0);

      let h = List.hd !st_ref in
      st_ref := List.tl !st_ref;

      Env.add name (Al.WasmV h) env
  | Al.LetI (Al.NameE (name), e) ->
      Env.add name (eval_expr env e) env
  | Al.NopI -> env
  | i -> structured_string_of_instr 0 i |> failwith

and interp_instrs env il =
  List.fold_left interp_instr env il



(* Algo Map *)

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

(* Search AL algorithm to run *)

let algo_name_of winstr = match winstr.it with
  | Ast.Test _ -> "testop"
  | Ast.Compare _ -> "relop"
  | Ast.Nop -> "nop"
  | Ast.Drop -> "drop"
  | Ast.Select _ -> "select"
  | _ -> failwith "Not implemented"

let init_env params winstr = match (params, winstr.it) with
  | ([(_ty, _); (op, _)], Ast.Test (Values.I32 Ast.I32Op.Eqz)) ->
      Env.add op (Al.StringV "Eqz") Env.empty
  | ([(ty, _); (op, _)], Ast.Compare (Values.F32 Ast.F32Op.Gt)) ->
      Env.empty
      |> Env.add ty (Al.WasmTypeV (Types.NumType Types.F32Type))
      |> Env.add op (Al.StringV "Gt")
  | (_, Ast.Select None) -> Env.empty
  | ([], _) -> Env.empty
  | _ -> failwith "Not implemented"

let run_wasm_instr winstr = match winstr.it with
  | Ast.Const num -> st_ref := Values.Num (num.it) :: !st_ref
  | Ast.RefNull ref -> st_ref := Values.Ref (Values.NullRef ref) :: !st_ref
  | _ ->
      let algo_name = algo_name_of winstr in
      let Al.Algo (_, params, il) = AlgoMap.find algo_name !algo_map in
      let env = init_env params winstr in
      let _result_env = interp_instrs env il in
      ()

let run winstrs = List.iter run_wasm_instr winstrs



(* Entry *)
let interpret algos =
  algo_map := to_map algos;
  run testop;
  Values.string_of_values !st_ref
