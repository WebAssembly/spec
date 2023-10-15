open Al
open Ast

module RuleMap = Map.Make (String)
type rule_map = algorithm RuleMap.t ref

module FuncMap = Map.Make (String)
type func_map = algorithm FuncMap.t ref

let rule_map: rule_map = ref RuleMap.empty

let func_map: func_map = ref FuncMap.empty

let to_map algos =
  let f acc algo =
    let rmap, fmap = acc in
    match algo with
    | RuleA ((name, _), _, _) -> (RuleMap.add name algo rmap, fmap)
    | FuncA (name, _, _) -> (rmap, FuncMap.add name algo fmap)
  in
  List.fold_left f (RuleMap.empty, FuncMap.empty) algos

let init algos = 
  let rmap, fmap = to_map algos in
  rule_map := rmap;
  func_map := fmap

let lookup name =
  if RuleMap.mem name !rule_map then
    RuleMap.find name !rule_map
  else if FuncMap.mem name !func_map then
    FuncMap.find name !func_map
  else failwith ("Algorithm not found: " ^ name)


let store : store ref = ref Record.empty

(* Environmet *)

module Env = struct include Map.Make (String)

  (* Printer *)
  let string_of_env env =
    Print.string_of_list
      (fun (k, v) ->
        k ^ ": " ^ Print.string_of_value v)
      "\n{" ",\n  " "\n}"
      (bindings env)

  (* Environment API *)
  let find key env =
    try find key env
    with Not_found ->
      Printf.sprintf "The key '%s' is not in the map: %s."
        key (string_of_env env)
      |> prerr_endline;
      raise Not_found

  let add_store = add "s" (Ast.StoreV Interpreter.store)
end

type env = value Env.t

(* AL Context *)
module AL_Context = struct
  type return_value =
    | Bot
    | None
    | Some of value

  type t = env * return_value * int

  let context_stack: t list ref = ref []

  let push_context ctx = context_stack := ctx :: !context_stack

  let pop_context () =
    match !context_stack with
    | h :: t -> context_stack := t; h
    | _ -> failwith "AL context stack underflow"

  let get_context () =
    match !context_stack with
    | h :: _ -> h
    | _ -> failwith "AL context stack underflow"

  (* Depth *)

  let rec decrease_depth () =
    let env, return_value, depth = pop_context () in
    if depth > 0 then
      push_context (env, return_value, depth - 1)
    else
      decrease_depth ();
      push_context (env, return_value, depth)

end

(* Wasm Context *)
module WasmContext = struct
  type t = value * value list * value list

  let context_stack: t list ref = ref []

  let get_context () =
    match !context_stack with
    | h :: _ -> h
    | _ -> failwith "Wasm context stack underflow"

  let push_context ctx = context_stack := ctx :: !context_stack

  let pop_context () =
    match !context_stack with
    | h :: t -> context_stack := t; h
    | _ -> failwith "AL context stack underflow"

  (* Value stack *)

  let get_value_stack () =
    let _, vs, _ = get_context () in
    vs

  let push_value v =
    let v_ctx, vs, vs_instr = pop_context () in
    push_context (v_ctx, v :: vs, vs_instr)

  let pop_value () =
    let v_ctx, vs, vs_instr = pop_context () in
    match vs with
    | h :: t -> push_context (v_ctx, t, vs_instr); h
    | _ -> failwith "Wasm value stack underflow"
end
