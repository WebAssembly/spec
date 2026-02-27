open Ds
open Al
open Al_util
open Print


type state =
  | Step of int
  | StepInstr of string * int
  | Continue of int

let debug = ref false
let break_points = ref []
let is_bp name =
  List.exists
    (fun bp -> bp = String.lowercase_ascii name || bp = String.uppercase_ascii name)
    !break_points
let state = ref (Step 1)

let help_msg =
  "
  s[tep] {number}?
    Take n steps
  si|stepinstr {number}?
    Step over n AL instructions
  c[ontinue] {number}?
    Continue until the n-th break point
  b[reak] {algorithm name}*
    Add break points
  rm|remove {algorithm name}*
    Remove break points
  bp|breakpoints
    Print all break points
  al
    Print AL context stack
  wasm
    Print Wasm context stack
  v[ar] {variable name} {field|index}*
    Print a value selected from an AL variable
  f[rame] {field|index}*
    Print a value selected from the current Wasm frame
  l[ocal] {index} {field|index}*
    Print a value selected from the current Wasm frame's locals
    (shorthand for `frame LOCALS`)
  m[odule] {field} {index}
    Print an index from the current Wasm frame's module
    (shorthand for `frame MODULE`)
  st[ore] {field|index}*
    Print a value from the Wasm store
  z|state {field|index}*
    Print a value indexed from the current Wasm frame's module
    (shorthand for the composition of module and store lookup)
  q[uit]
    Quit
  h[elp]
    Print help message
  "

let allow_command ctx =
  let is_entry name il = name |> lookup_algo |> body_of_algo = il in

  match !state with
  | Step n ->
    if n = 1 then
      true
    else
      (state := Step (n-1); false)
  | StepInstr (name, n) when name == AlContext.get_name ctx ->
    if n = 1 then
      true
    else
      (state := StepInstr (name, n-1); false)
  | Continue n ->
    (match ctx with
    | AlContext.Al (name, _, il, _, _) :: _
    when is_bp name && is_entry name il ->
      if n = 1 then
        true
      else
        (state := Continue (n-1); false)
    | _ -> false
    )
  | _ -> false

let rec access_paths paths v =
  match paths with
  | [] -> v
  | path :: t when int_of_string_opt path <> None ->
    v
    |> unwrap_listv
    |> (fun arr -> Array.get !arr (int_of_string path))
    |> access_paths t
  | path :: t ->
    v
    |> unwrap_strv
    |> List.assoc path
    |> (!)
    |> access_paths t

let access_store paths =
  Store.access (List.hd paths)
  |> access_paths (List.tl paths)

let access_frame paths =
  WasmContext.get_current_context "FRAME_"
  |> args_of_casev
  |> Fun.flip List.nth 1
  |> access_paths paths

let access_state paths =
  if List.length paths < 2 then access_frame ("MODULE" :: paths) else
  let field = List.hd paths in
  access_frame ["MODULE"; field; List.nth paths 1]
  |> unwrap_natv_to_int
  |> (fun i -> access_store (field :: string_of_int i :: Util.Lib.List.drop 2 paths))

let access_env (ctx : AlContext.t) s paths =
  match ctx with
  | (Al (_, _, _, env, _) | Enter (_, _, env)) :: _ ->
    lookup_env_opt s env |> Option.get |> access_paths paths
  | _ -> failwith "not in scope"

let print_path path =
  if int_of_string_opt path <> None then
    "[" ^ path ^ "]"
  else
    "." ^ path

let print_value access root paths =
  print_endline (
    root ^ String.concat "" (List.map print_path paths) ^
    try " = " ^ string_of_value (access paths)
    with _ -> " does not exist"
  )

let rec do_debug ctx =
  let _ = print_string "\ndebugger> " in
  read_line ()
  |> String.split_on_char ' '
  |> List.filter ((<>) "")
  |> handle_command ctx

and handle_command ctx = function
  | ("h" | "help") :: _ ->
    print_endline help_msg;
    do_debug ctx
  | ("b" | "break") :: t ->
    if t = [] then
      print_endline (String.concat " " !break_points)
    else
      break_points := !break_points @ t;
    do_debug ctx
  | ("bp" | "breakpoints") :: [] ->
    print_endline (String.concat " " !break_points);
    do_debug ctx
  | ("rm" | "remove") :: t ->
    break_points := List.filter (fun e -> not (List.mem e t)) !break_points;
    do_debug ctx
  | ("s" | "step") :: t ->
    (match t with
    | [] ->
      state := Step 1
    | [n] when int_of_string_opt n <> None ->
      state := Step (int_of_string n)
    | _ ->
      handle_command ctx ["help"]
    )
  | ("si" | "stepinstr") :: t ->
    (match ctx with
    | (AlContext.Al (name, _, il, _, _) | AlContext.Enter (name, il, _)) :: _
      when List.length il > 0 ->
      (match t with
      | [] ->
        state := StepInstr (name, 1)
      | [n] when int_of_string_opt n <> None ->
        state := StepInstr (name, int_of_string n)
      | _ ->
        handle_command ctx ["help"]
      )
    | _ ->
      handle_command ctx ("step" :: t)
    )
  | ("c" | "continue") :: t ->
    (match t with
    | [] ->
      state := Continue 1
    | [n] when int_of_string_opt n <> None ->
      state := Continue (int_of_string n)
    | _ ->
      handle_command ctx ["help"]
    )
  | "al" :: [] ->
    ctx |> List.map AlContext.string_of_context |> List.iter print_endline;
    do_debug ctx
  | "wasm" :: [] ->
    WasmContext.string_of_context_stack () |> print_endline;
    do_debug ctx
  | ("st" | "store") :: t ->
    print_value access_store "store" t;
    do_debug ctx
  | ("f" | "frame") :: t ->
    print_value access_frame "frame" t;
    do_debug ctx
  | ("l" | "local") :: t ->
    print_value access_frame "frame" ("LOCALS" :: t);
    do_debug ctx
  | ("m" | "module") :: t ->
    print_value access_frame "frame" ("MODULE" :: t);
    do_debug ctx
  | ("z" | "state") :: t ->
    print_value access_state "state" t;
    do_debug ctx
  | ("v" | "var") :: s :: t ->
    print_value (access_env ctx s) s t;
    do_debug ctx
  | ("q" | "quit") :: [] ->
    debug := false
  | _ ->
    handle_command ctx ["help"]

let run ctx =
  if !debug && allow_command ctx then do_debug ctx
