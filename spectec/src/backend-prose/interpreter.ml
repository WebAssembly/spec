open Print
open Reference_interpreter
open Source

(* helper function *)
let (@) x = (@@) x no_region

(* Hardcoded Wasm AST *)
let ast: Ast.instr list = [
  Ast.Const (Values.I32 I32.zero |> (@)) |> (@);
  Ast.Test (Values.I32 Ast.I32Op.Eqz) |> (@)
]

module EnvKey =
  struct
    type t = Ir.name
    let compare a b =
      Stdlib.compare
        (string_of_name a)
        (string_of_name b)
  end

module Env = Map.Make(EnvKey)

type stack = Ir.value list

let rec try_numerics (st, env) fname args = match (fname, args) with
  | (Ir.N "testop", [Ir.NameE N "testop"; _type_expr; arg]) ->
      (* TODO: consider type *)
      Some (Ir.BoolV (eval_expr (st, env) arg = Ir.IV 0))
  | _ -> string_of_name fname |> failwith

and eval_expr (st, env) e = match e with
  | Ir.AppE (fname, el) ->
      begin match try_numerics (st, env) fname el with
        | Some v -> v
        | None -> structured_string_of_expr e |> failwith
      end
  | Ir.NameE name -> Env.find name env
  | Ir.ConstE (_, e) -> eval_expr (st, env) e
  | _ -> structured_string_of_expr e |> failwith

let eval_cond _ c = match c with
  | _ -> structured_string_of_cond c |> failwith

let rec interp_instr (st, env) i = match (i, st) with
  | (Ir.IfI (c, il1, il2), _) ->
      if eval_cond (st, env) c
      then interp_instrs (st, env) il1
      else interp_instrs (st, env) il2
  | (Ir.AssertI (_), _) -> (st, env) (* TODO: insert assertion *)
  | (Ir.PushI e, _) ->
      let v = eval_expr (st, env) e in
      (v :: st, env)
  | (Ir.PopI (Some (Ir.ConstE (Ir.VarT _, Ir.NameE name))), h :: t) ->
      (* TODO: consider type *)
      (t, Env.add name h env)
  | (Ir.LetI (Ir.NameE (name), e), _) ->
      let new_env = Env.add name (eval_expr (st, env) e) env in
      (st, new_env)
  | _ -> structured_string_of_instr 0 i |> failwith

and interp_instrs stenv il =
  List.fold_left (fun acc i -> interp_instr acc i) stenv il

let interp_prog stenv prog =
  let Ir.Program (_, il) = prog in
  interp_instrs stenv il

let call_algo programs (st, env) winstr = match winstr.it with
  | Ast.Const ({ it = Values.I32 n; _ }) -> (Ir.IV (I32.to_int_s n) :: st, env)
  | Ast.Test (Values.I32 Ast.I32Op.Eqz) ->
      programs
      |> List.find (function | Ir.Program ("testop", _) -> true | _ -> false)
      |> interp_prog (st, env)
  | _ -> failwith ""

let interpret programs =
  let (result_st, _) =
    List.fold_left
      (fun acc winstr -> call_algo programs acc winstr)
      ([], Env.empty)
      ast in
  match result_st with
    | [Ir.IV n] -> n
    | [Ir.BoolV n] -> if n then 1 else 0
    | _ -> failwith ""
