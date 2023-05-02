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
  Ast.Compare (Values.I32 Ast.I32Op.GtS) |> to_phrase
]

let nop = [
  Ast.Const (Values.I64 (i64 42) |> to_phrase) |> to_phrase;
  Ast.Nop |> to_phrase
]

let drop = [
  Ast.Const (Values.F64 (f64 3.0) |> to_phrase) |> to_phrase;
  Ast.Const (Values.F64 (f64 5.0) |> to_phrase) |> to_phrase;
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

let wasm_value2int = function
  | Values.Num n -> Values.string_of_num n |> int_of_string
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
  | (Al.N "testop", [Al.NameE N "testop"; _; arg]) ->
      let v = eval_expr env arg |> al_value2int in
      v = 0 |> Bool.to_int
  (* TODO: handle non-deterministic *)
  | _ -> string_of_name fname |> failwith

and eval_expr env e = match e with
  (* TODO: extend function application *)
  | Al.AppE (fname, el) -> Al.IntV (try_numerics env fname el)
  | Al.NameE name -> Env.find name env
  | Al.ConstE (ty, inner_e) ->
      let i = eval_expr env inner_e |> al_value2int in
      let wasm_ty = eval_expr env ty |> al_value2wasm_type in
      Al.WasmV (mk_wasm_num wasm_ty i)
  | e -> structured_string_of_expr e |> failwith

let eval_cond _ = function
  | c -> structured_string_of_cond c |> failwith

let rec interp_instr env i = match (i, !st_ref) with
  | (Al.IfI (c, il1, il2), _) ->
      if eval_cond env c
      then interp_instrs env il1
      else interp_instrs env il2
  | (Al.AssertI (_), _) -> env (* TODO: insert assertion *)
  | (Al.PushI e, st) ->
      let v = eval_expr env e |> al_value2wasm_value in
      st_ref := v :: st;
      env
  | (Al.PopI (Al.ConstE (Al.WasmTypeVarE nt, Al.NameE name)), h :: t) ->
      st_ref := t;

      let ty = Values.type_of_value h in
      Env.add_type nt ty env |> Env.add name (Al.IntV (wasm_value2int h))
  | (Al.LetI (Al.NameE (name), e), _) ->
      Env.add name (eval_expr env e) env
  | _ -> structured_string_of_instr 0 i |> failwith

and interp_instrs env il =
  List.fold_left interp_instr env il

let interp_algo algo =
  let Al.Algo (_, _params, il) = algo in
  interp_instrs Env.empty il



(* Search AL algorithm to run *)

module AlgoMapKey =
  struct
    type t = string
    let compare = Stdlib.compare
  end

module AlgoMap = Map.Make(AlgoMapKey)

let to_map algos =
  let f acc algo =
    let Al.Algo (name, _params, _) = algo in
    AlgoMap.add name algo acc in

  List.fold_left f AlgoMap.empty algos

let get_algo_name winstr = match winstr.it with
  | Ast.Test (_) -> "testop"
  | _ -> failwith "Not implemented"

let run_algo algos winstr = match winstr.it with
  | Ast.Const num -> st_ref := Values.Num (num.it) :: !st_ref
  | _ ->
      let algo_name = get_algo_name winstr in
      let _env = AlgoMap.find algo_name algos |> interp_algo in
      ()



(* Entry *)
let interpret algos =
  let algo_map = to_map algos in
  List.iter (run_algo algo_map) testop;
  Values.string_of_values !st_ref
