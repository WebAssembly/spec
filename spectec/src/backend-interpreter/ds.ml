open Al
open Ast
open Print
open Construct
open Util.Source
open Util.Record

(* Program *)

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

let lookup name =
  if RuleMap.mem name !rule_map then
    RuleMap.find name !rule_map
  else if FuncMap.mem name !func_map then
    FuncMap.find name !func_map
  else failwith ("Algorithm not found: " ^ name)


(* Info *)

type info = { algo_name: string; instr: instr; mutable covered: bool }
module InfoMap = struct include Map.Make (Int)
  type t = int * info

  let make_info algo_name instr =
    { algo_name; instr; covered = false }

  let uncovered =
    filter (fun _ info -> not info.covered)

  let rec partition_by_algo info_map =
    match choose_opt info_map with
    | None -> []
    | Some (_, info) ->
      let f _ v = v.algo_name = info.algo_name in
      let im1, im2 = partition f info_map in
      im1 :: partition_by_algo im2

  let print info_map =
    partition_by_algo info_map
    |> List.iter
      (fun im ->
        let _, v = choose im in
        Printf.printf "\n[%s]\n" v.algo_name;
        iter
          (fun _ v' ->
            Al.Print.string_of_instr v'.instr
            |> print_endline)
          im)
end

let info_map = ref InfoMap.empty


(* Store *)

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

  let add_store = add "s" (Ast.StoreV store)
end

type env = value Env.t

(* AL Context *)

module AL_Context = struct
  (* TODO: Change name *)
  type return_value =
    | Bot
    | None
    | Some of value

  type t = string * return_value * int

  let context_stack: t list ref = ref []
  let context_stack_length = ref 0

  let create_context name = (name, Bot, 0)

  let init_context () =
    context_stack := [];
    context_stack_length := 0

  let push_context ctx =
    context_stack := ctx :: !context_stack;
    context_stack_length := 1 + !context_stack_length

  let pop_context () =
    context_stack_length := !context_stack_length - 1;
    match !context_stack with
    | h :: t -> context_stack := t; h
    | _ -> failwith "AL context stack underflow"

  let get_context () =
    match !context_stack with
    | h :: _ -> h
    | _ -> failwith "AL context stack underflow"

  let get_name () =
    let name, _, _ = get_context () in
    name

  (* Print *)

  let string_of_return_value = function
    | Bot -> "⊥"
    | None -> "None"
    | Some v -> string_of_value v

  let string_of_context ctx =
    let name, return_value, depth = ctx in
    Printf.sprintf "(%s, %s, %s)"
      name
      (string_of_return_value return_value)
      (string_of_int depth)

  let string_of_context_stack () =
    List.fold_left
      (fun acc ctx -> (string_of_context ctx) ^ " :: " ^ acc)
      "[]" !context_stack

  (* Return value *)
  let set_return_value v =
    let name, return_value, depth = pop_context () in
    assert (return_value = Bot);
    push_context (name, Some v, depth)

  let set_return () =
    let name, return_value, depth = pop_context () in
    assert (return_value = Bot);
    push_context (name, None, depth)

  let get_return_value () =
    let _, return_value, _ = get_context () in
    return_value

  (* Depth *)

  let get_depth () =
    let _, _, depth = get_context () in
    depth

  let increase_depth () =
    let name, return_value, depth = pop_context () in
    push_context (name, return_value, depth + 1)

  let rec decrease_depth () =
    let name, return_value, depth = pop_context () in
    if depth > 0 then
      push_context (name, return_value, depth - 1)
    else (
      decrease_depth ();
      push_context (name, return_value, depth)
    )

end

(* Wasm Context *)

module WasmContext = struct
  type t = value * value list * value list

  let top_level_context = TextV "TopLevelContexet", [], []
  let context_stack: t list ref = ref [top_level_context]

  let get_context () =
    match !context_stack with
    | h :: _ -> h
    | _ -> failwith "Wasm context stack underflow"

  let get_nth_context n =
    match List.nth_opt !context_stack n with
    | Some ctx -> ctx
    | None -> failwith "Wasm context stack underflow"

  let init_context () = context_stack := [top_level_context]

  let push_context ctx = context_stack := ctx :: !context_stack

  let pop_context () =
    match !context_stack with
    | h :: t -> context_stack := t; h
    | _ -> failwith "Wasm context stack underflow"

  (* Print *)

  let string_of_context ctx =
    let v, vs, vs_instr = ctx in
    Printf.sprintf "(%s, %s, %s)"
      (string_of_value v)
      (string_of_value (listV vs))
      (string_of_value (listV vs_instr))

  let string_of_context_stack () =
    List.fold_left
      (fun acc ctx -> (string_of_context ctx) ^ " :: " ^ acc)
      "[]" !context_stack

  (* Context *)
  let get_current_context () =
    let ctx, _, _ = get_context () in
    ctx

  let get_current_frame () =
    let rec get_current_frame' n =
      match get_nth_context n with
      | (FrameV _ as f, _, _) -> f
      | _ -> get_current_frame' (n+1)
    in
    get_current_frame' 0

  let get_module_instance () =
    match get_current_frame () with
    | FrameV (_, mm) -> mm
    | _ -> failwith "Invalid frame"

  let get_current_label () =
    let rec get_current_label' n =
      match get_nth_context n with
      | (LabelV _ as l, _, _) -> l
      | _ -> get_current_label' (n+1)
    in
    get_current_label' 0

  (* Value stack *)

  let is_value = function
    | CaseV ("CONST", _) -> true
    | CaseV ("VVCONST", _) -> true
    | CaseV (ref, _)
      when String.starts_with ~prefix:"REF." ref -> true
    | _ -> false

  let get_value_stack () =
    let _, vs, _ = get_context () in
    vs

  let push_value v =
    let v_ctx, vs, vs_instr = pop_context () in
    if is_value v then
      push_context (v_ctx, v :: vs, vs_instr)
    else
      string_of_value v
      |> Printf.sprintf "%s is not a Wasm value"
      |> failwith

  let pop_value () =
    let v_ctx, vs, vs_instr = pop_context () in
    match vs with
    | h :: t -> push_context (v_ctx, t, vs_instr); h
    | _ -> failwith "Wasm value stack underflow"

  (* Instr stack *)

  let pop_instr () =
    let v_ctx, vs, vs_instr = pop_context () in
    match vs_instr with
    | h :: t -> push_context (v_ctx, vs, t); h
    | _ -> failwith "Wasm instr stack underflow"
end

(* Initialization *)

let init algos =

  (* Initialize info_map *)

  let init_info algo =
    let algo_name = get_name algo in
    let config = {
      Walk.default_config with pre_instr =
        (fun i ->
          let info = InfoMap.make_info algo_name i in
          info_map := InfoMap.add i.note info !info_map;
          [i])
    } in
    Walk.walk config algo
  in
  List.map init_info algos |> ignore;

  (* Initialize algo_map *)

  let rmap, fmap = to_map algos in
  rule_map := rmap;
  func_map := fmap;

  (* Initialize store *)
  store :=
    Record.empty
    |> Record.add "FUNC" (listV [])
    |> Record.add "GLOBAL" (listV [])
    |> Record.add "TABLE" (listV [])
    |> Record.add "MEM" (listV [])
    |> Record.add "ELEM" (listV [])
    |> Record.add "DATA" (listV [])
    |> Record.add "STRUCT" (listV [])
    |> Record.add "ARRAY" (listV [])
