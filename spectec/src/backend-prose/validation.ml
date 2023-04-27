open Ir
open Reference_interpreter

(* Data Structures *)
module Env =
  struct
    module ValueTypeEnvKey =
      struct
        type t = name
        let compare a b = Stdlib.compare (Print.string_of_name a) (Print.string_of_name b)
      end
    module TypeEnvKey =
      struct
        type t = string
        let compare = Stdlib.compare
      end

    module ValueTypeEnv = Map.Make(ValueTypeEnvKey)
    module TypeEnv = Map.Make(TypeEnvKey)

    type t = (ir_type ValueTypeEnv.t) * (Types.value_type TypeEnv.t)

    let empty = (ValueTypeEnv.empty, TypeEnv.empty)

    (* Value env api *)
    let find key (value_env, _) =
      try ValueTypeEnv.find key value_env with
        | Not_found ->
            Printf.sprintf "Not found: %s" (Print.structured_string_of_name key)
            |> failwith
    let add key elem (value_env, type_env) =
      (ValueTypeEnv.add key elem value_env, type_env)

    (* Type env api *)
    let find_type key (_, type_env) = TypeEnv.find key type_env
    let add_type key elem (value_env, type_env) =
      (value_env, TypeEnv.add key elem type_env)
  end


let failmsg e ty1 ty2 =
  Printf.sprintf "%s: %s is not subtype of %s"
    (Print.structured_string_of_expr e)
    (Print.string_of_ir_type ty1)
    (Print.string_of_ir_type ty2)
    |> failwith

(* `ty1` <: `ty2` *)
let subtype e ty1 ty2 = match (ty1, ty2) with
  | (_, TopT) -> ()
  | (WasmValueT _, WasmValueTopT) -> ()
  | (ty1, ty2) when ty1 = ty2 -> ()
  | _ -> failmsg e ty1 ty2

let rec type_of_expr env expr = match expr with
  | ValueE _ -> IntT
  | MinusE e ->
      let ty = type_of_expr env e in
      subtype expr ty IntT;
      IntT
  | AddE (e1, e2) | SubE (e1, e2) | MulE (e1, e2) | DivE (e1, e2) ->
      let ty1 = type_of_expr env e1 in
      subtype e1 ty1 IntT;
      let ty2 = type_of_expr env e2 in
      subtype e2 ty2 IntT;
      IntT
  | AppE (_, el) ->
      let _ = List.map (type_of_expr env) el in
      TopT
  | ListE ([]) -> EmptyListT
  | NameE (n) -> Env.find n env
  | ConstE (_, _) -> WasmValueT (NumType I32Type)
  | LengthE e ->
      (* TODO: check sup? *)
      let _ = type_of_expr env e in
      IntT
  | _ -> Print.structured_string_of_expr expr |> failwith

and valid_cond env cond = match cond with
  | NotC c -> valid_cond env c
  | AndC (c1, c2) ->
      valid_cond env c1;
      valid_cond env c2;
  | OrC (c1, c2) ->
      valid_cond env c1;
      valid_cond env c2;
  | EqC (e1, e2) ->
      let _ = type_of_expr env e1 in
      let _ = type_of_expr env e2 in
      ()
  | GtC (e1, e2) ->
      let _ = type_of_expr env e1 in
      let _ = type_of_expr env e2 in
      ()
  | GeC (e1, e2) ->
      let _ = type_of_expr env e1 in
      let _ = type_of_expr env e2 in
      ()
  | LtC (e1, e2) ->
      let _ = type_of_expr env e1 in
      let _ = type_of_expr env e2 in
      ()
  | LeC (e1, e2) ->
      let _ = type_of_expr env e1 in
      let _ = type_of_expr env e2 in
      ()
  | DefinedC e ->
      let _ = type_of_expr env e in
      ()
  | PartOfC el ->
      let _ = List.map (type_of_expr env) el in
      ()
  | TopC _ | YetC _ -> ()

let rec valid_instr env instr = match instr with
  | IfI (c, il1, il2) ->
      valid_cond env c;
      let _ = valid_instrs env il1 in
      let _ = valid_instrs env il2 in
      env
  | OtherwiseI il ->
      let _ = valid_instrs env il in
      env
  | EitherI (il1, il2) ->
      let _ = valid_instrs env il1 in
      let _ = valid_instrs env il2 in
      env
  | AssertI _ -> env
  | PushI e ->
      let ty = type_of_expr env e in
      subtype e ty WasmValueTopT;
      env
  | PopI (ConstE (_, NameE name)) ->
      Env.add name IntT env
  | PopI (NameE n) ->
      Env.add n WasmValueTopT env
  | LetI (NameE (name), e) | LetI (ListE ([NameE (name)]), e) ->
      Env.add name (type_of_expr env e) env
  | LetI (RefNullE _, _) -> env
  | TrapI | NopI -> env
  | PerformI (AppE (n, el)) ->
      let _ = type_of_expr env (AppE (n, el)) in
      env
  | ExecuteI (_, el) ->
      let _ = List.map (type_of_expr env) el in
      env
  | _ -> Print.structured_string_of_instr 0 instr |> failwith

and valid_instrs env instrs =
  List.fold_left valid_instr env instrs



let total = ref 0
let fail = ref 0

let numerics =
  ["unop"; "binop"; "testop"; "relop"]

let init_env = function
  | name when List.mem name numerics ->
      Env.add (N name) IntT Env.empty
      |> Env.add (N "nt") TopT
  | _ ->
      Env.empty
      |> Env.add (N "bt") TopT
      |> Env.add (N "l") TopT
      |> Env.add (N "x") TopT
      |> Env.add (N "y") TopT
      |> Env.add (N "z") TopT

let valid_algo algo =
  try (
    total := !total + 1;
    let Algo (name, instrs) = algo in
    print_endline "";
    print_endline name;
    let env = init_env name in
    let _ = valid_instrs env instrs in
    print_endline "Ok"
  ) with
  | err ->
      fail := !fail + 1;
      Printexc.to_string err |> print_endline

let valid ir =
  List.iter valid_algo ir;
  Printf.sprintf "Pass/Total: [%d/%d]" (!total - !fail) !total |> print_endline
