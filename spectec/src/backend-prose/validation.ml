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
    let find key (value_env, _) = ValueTypeEnv.find key value_env
    let add key elem (value_env, type_env) =
      (ValueTypeEnv.add key elem value_env, type_env)

    (* Type env api *)
    let find_type key (_, type_env) = TypeEnv.find key type_env
    let add_type key elem (value_env, type_env) =
      (value_env, TypeEnv.add key elem type_env)
  end

type stack = ir_type list

let st_ref = ref []


(* `ty1` <: `ty2` *)
let subtype ty1 ty2 = match (ty1, ty2) with
  | (BotT, _) -> true
  | (WasmValueT _, WasmValueTopT) -> true
  | (ty1, ty2) when ty1 = ty2 -> true
  | _ -> false

let rec type_of_expr env expr = match expr with
  | ValueE _ -> IntT
  | MinusE e ->
      let ty = type_of_expr env e in
      assert (subtype ty IntT);
      IntT
  | AddE (e1, e2) | SubE (e1, e2) | MulE (e1, e2) | DivE (e1, e2) ->
      let ty1 = type_of_expr env e1 in
      assert (subtype ty1 IntT);
      let ty2 = type_of_expr env e2 in
      assert (subtype ty2 IntT);
      IntT
  | ConstE (_, _) -> WasmValueT (NumType I32Type)
  | _ -> BotT

and valid_cond _ _ = ()

let rec valid_instr env instr = match (instr, !st_ref) with
  | (IfI (c, il1, il2), _) ->
      valid_cond env c;
      let _ = valid_instrs env il1 in
      let _ = valid_instrs env il2 in
      env
  | (OtherwiseI il, _) ->
      let _ = valid_instrs env il in
      env
  | (EitherI (il1, il2), _) ->
      let _ = valid_instrs env il1 in
      let _ = valid_instrs env il2 in
      env
  | (AssertI _, _) -> env
  | (PushI e, _) ->
      let ty = type_of_expr env e in
      assert (subtype ty WasmValueTopT);
      st_ref := ty :: !st_ref;
      env
  | (PopI (ConstE (VarTE _, NameE name)), h :: t) ->
      st_ref := t;
      assert (subtype h (WasmValueT (NumType I32Type)));

      Env.add name IntT env
  | (LetI (NameE (name), e), _) ->
      Env.add name (type_of_expr env e) env
  | _ -> env

and valid_instrs env instrs =
  List.fold_left valid_instr env instrs

let valid_algo algo =
  let Algo (_name, instrs) = algo in
  let _ = valid_instrs Env.empty instrs in
  ()

let valid ir =
  List.iter valid_algo ir
