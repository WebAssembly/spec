open Print
open Reference_interpreter
open Source

(* Hardcoded Wasm AST *)
let mk_phrase x = (@@) x no_region
let ast: Ast.instr list = [
  Ast.Const (Values.I32 I32.zero |> mk_phrase) |> mk_phrase;
  Ast.Test (Values.I32 Ast.I32Op.Eqz) |> mk_phrase
]



(* Data Structures *)
module EnvKey =
  struct
    type t = Ir.name
    let compare a b =
      Stdlib.compare
        (string_of_name a)
        (string_of_name b)
  end

(* Ir.name -> Ir.value *)
(* TODO: extends environment *)
module Env = Map.Make(EnvKey)

type stack = Values.value list

let st_ref: stack ref = ref []



(* Helper functions *)

(* NOTE: These functions should be used only if validation ensures no failure *)
let ir_value2wasm_value = function
  | Ir.WasmV v -> v
  | _ -> failwith "Not a Wasm value"

let ir_value2int = function
  | Ir.IntV i -> i
  | _ -> failwith "Not an integer value"



(* Interpreter *)
(* TODO: handle non-deterministic *)
let rec try_numerics env fname args = match (fname, args) with
  | (Ir.N "testop", [Ir.NameE N "testop"; _; arg]) ->
      let v = eval_expr env arg |> ir_value2wasm_value in
      (* hack to check eqz *)
      Values.string_of_value v = "0" |> Bool.to_int
  | _ -> string_of_name fname |> failwith

and eval_expr env e: Ir.value = match e with
  (* TODO: handle other function application *)
  | Ir.AppE (fname, el) -> Ir.IntV (try_numerics env fname el)
  | Ir.NameE name -> Env.find name env
  | Ir.ConstE (_, inner_e) ->
      (* TODO: handle type *)
      let i = eval_expr env inner_e |> ir_value2int in
      Ir.WasmV (Values.Num (I32.of_int_s i |> Values.I32Num.to_num))
  | e -> structured_string_of_expr e |> failwith

let eval_cond _ = function
  | c -> structured_string_of_cond c |> failwith

let rec interp_instr env i = match (i, !st_ref) with
  | (Ir.IfI (c, il1, il2), _) ->
      if eval_cond env c
      then interp_instrs env il1
      else interp_instrs env il2
  | (Ir.AssertI (_), _) -> env (* TODO: insert assertion *)
  | (Ir.PushI e, st) ->
      let v = eval_expr env e |> ir_value2wasm_value in
      st_ref := v :: st;
      env
  | (Ir.PopI (Some (Ir.ConstE (Ir.VarT _, Ir.NameE name))), h :: t) ->
      (* TODO: handle type *)
      st_ref := t;
      Env.add name (Ir.WasmV h) env
  | (Ir.LetI (Ir.NameE (name), e), _) ->
      Env.add name (eval_expr env e) env
  | _ -> structured_string_of_instr 0 i |> failwith

and interp_instrs env il =
  List.fold_left interp_instr env il

let interp_prog prog =
  let Ir.Program (_, il) = prog in
  interp_instrs Env.empty il



(* Search IR program to run *)
let call_algo programs winstr = match winstr.it with
  | Ast.Const num -> st_ref := Values.Num (num.it) :: !st_ref
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      let _ = programs
        |> List.find (function | Ir.Program ("testop", _) -> true | _ -> false)
        |> interp_prog in
      ()
  | _ -> failwith ""

let interpret programs =
  List.iter (call_algo programs) ast;
  Values.string_of_values !st_ref
