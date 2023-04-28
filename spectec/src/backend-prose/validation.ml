open Al
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

    type t = (al_type ValueTypeEnv.t) * (Types.value_type TypeEnv.t)

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


let failmsg ty1 ty2 =
  Printf.sprintf "%s is not subtype of %s"
    (Print.string_of_al_type ty1)
    (Print.string_of_al_type ty2)
    |> failwith

let signature_of = function
  | "unop" -> ([StringT; TopT; IntT], ListT IntT)
  | "binop" -> ([StringT; TopT; IntT; IntT], ListT IntT)
  | "testop" -> ([StringT; TopT; IntT], IntT)
  | "relop" -> ([StringT; TopT; IntT; IntT], IntT)
  | "cvtop" -> ([TopT; StringT; TopT; ListT TopT; IntT], ListT IntT)
  | "funcaddr" -> ([StateT], ListT AddrT)
  | "local" -> ([StateT; IntT], WasmValueTopT)
  | "global" -> ([StateT; IntT], WasmValueTopT)
  (* instance *)
  | "table" -> ([StateT; IntT], ListT WasmValueTopT)
  | "elem" -> ([StateT; IntT], ListT WasmValueTopT)
  | "mem" -> ([StateT; IntT], ListT IntT)
  | "data" -> ([StateT; IntT], ListT IntT)
  | "funcinst" -> ([StateT], TopT)
  (* state *)
  | "with_global" -> ([StateT; IntT; WasmValueTopT], StateT)
  | "with_local" -> ([StateT; IntT; WasmValueTopT], StateT)
  | "with_table" -> ([StateT; IntT; IntT; WasmValueTopT], StateT)
  | "with_tableext" -> ([StateT; IntT; WasmValueTopT], StateT)
  | "with_elem" -> ([StateT; IntT; ListT WasmValueTopT], StateT)
  | "with_memext" -> ([StateT; IntT; ListT IntT], StateT)
  | "with_data" -> ([StateT; IntT; ListT IntT], StateT)
  | name -> failwith ("Unknwon function name: " ^ name)

(* `ty1` <: `ty2` *)
let subtype ty1 ty2 = match (ty1, ty2) with
  | (_, TopT) -> ()
  | (ListT _, ListT TopT) -> ()
  | (EmptyListT, ListT _) -> ()
  | (WasmValueT _, WasmValueTopT) -> ()
  | (ty1, ty2) when ty1 = ty2 -> ()
  | _ -> failmsg ty1 ty2

let rec typeof env expr = match expr with
  | ValueE _ -> IntT
  | MinusE e ->
      let ty = typeof env e in
      subtype ty IntT;
      IntT
  | AddE (e1, e2) | SubE (e1, e2) | MulE (e1, e2) | DivE (e1, e2) ->
      let ty1 = typeof env e1 in
      subtype ty1 IntT;
      let ty2 = typeof env e2 in
      subtype ty2 IntT;
      IntT
  | AppE (N n, el) ->
      let (param_type, result_type) = signature_of n in
      let args_type = List.map (typeof env) el in
      List.iter2 subtype args_type param_type;
      result_type
  | IterE (n, _) ->
      Env.find n env
  | ListE ([]) -> EmptyListT
  | IndexAccessE (e1, e2) ->
      let ty1 = typeof env e1 in
      subtype ty1 (ListT (TopT));
      let ty2 = typeof env e2 in
      subtype ty2 (IntT);
      begin match ty1 with
        | ListT ty -> ty
        | _ -> failwith "Unreachable"
      end
  | NameE (n) -> Env.find n env
  | RefFuncAddrE e ->
      let ty = typeof env e in
      subtype ty AddrT;
      WasmValueTopT
  | ConstE (_, _) -> WasmValueT (NumType I32Type)
  | LengthE e ->
      let _ty = typeof env e in
      (* subtype ty (ListT (TopT)); *)
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
      let _ = typeof env e1 in
      let _ = typeof env e2 in
      ()
  | GtC (e1, e2) ->
      let _ = typeof env e1 in
      let _ = typeof env e2 in
      ()
  | GeC (e1, e2) ->
      let _ = typeof env e1 in
      let _ = typeof env e2 in
      ()
  | LtC (e1, e2) ->
      let _ = typeof env e1 in
      let _ = typeof env e2 in
      ()
  | LeC (e1, e2) ->
      let _ = typeof env e1 in
      let _ = typeof env e2 in
      ()
  | DefinedC e ->
      let _ = typeof env e in
      ()
  | PartOfC el ->
      let _ = List.map (typeof env) el in
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
      let ty = typeof env e in
      (match ty with ListT ty | ty -> subtype ty WasmValueTopT);
      env
  | PopI (ConstE (_, NameE name)) ->
      Env.add name IntT env
  | PopI (NameE n) ->
      Env.add n WasmValueTopT env
  | PopI (IterE (name, _)) ->
      Env.add name (ListT WasmValueTopT) env
  | LetI (NameE (name), e) | LetI (ListE ([NameE (name)]), e) ->
      Env.add name (typeof env e) env
  | LetI (RefNullE _, _) -> env
  | TrapI | NopI -> env
  | PerformI (AppE (n, el)) ->
      let ty = typeof env (AppE (n, el)) in
      subtype ty StateT;
      env
  | ExecuteI (_, el) ->
      let _ = List.map (typeof env) el in
      env
  | _ -> Print.structured_string_of_instr 0 instr |> failwith

and valid_instrs env instrs =
  List.fold_left valid_instr env instrs



let total = ref 0
let fail = ref 0

let init_env params =
  List.fold_left (fun acc (n, ty) -> Env.add n ty acc) Env.empty params
  |> Env.add (N "z") StateT

let valid_algo algo =
  try (
    total := !total + 1;
    let Algo (name, params, instrs) = algo in
    print_endline "";
    print_endline name;

    let env = init_env params in
    (* List.iter (fun (n, ty) ->
      Printf.sprintf "%s -> %s, " (Print.string_of_name n) (Print.string_of_al_type ty) |> print_endline)
      params;
    print_endline "";*)

    let _ = valid_instrs env instrs in
    print_endline "Ok"
  ) with
  | err ->
      fail := !fail + 1;
      Printexc.to_string err |> print_endline

let valid al =
  List.iter valid_algo al;
  Printf.sprintf "\nPass/Total: [%d/%d]" (!total - !fail) !total |> print_endline
