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
  h
  help: print help message
  b {algorithm name}*
  break {algorithm name}*: add break points
  rm {algorithm name}*
  remove {algorithm name}*: remove break points
  bp
  breakpoints: print all break points
  s {number}?
  step {number}?: take n steps
  si {number}?
  stepinstr {number}?: step n AL instructions
  c {number}?
  continue {number}?: continue steps until meet n break points
  al: print al context stack
  wasm: print wasm context stack
  store {field} {index}: print a value in store
  lookup {variable name}: lookup the variable
  q
  quit: quit
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
    | AlContext.Al (name, _, il, _) :: _
    when is_bp name && is_entry name il ->
      if n = 1 then
        true
      else
        (state := Continue (n-1); false)
    | _ -> false
    )
  | _ -> false

let rec do_debug ctx =
  let _ = print_string "\ndebugger> " in
  read_line ()
  |> String.split_on_char ' '
  |> handle_command ctx;
and handle_command ctx = function
  | ("h" | "help") :: _ ->
    print_endline help_msg;
    do_debug ctx
  | ("b" | "break") :: t -> break_points := !break_points @ t; do_debug ctx
  | ("rm" | "remove") :: t ->
    break_points := List.filter (fun e -> not (List.mem e t)) !break_points;
    do_debug ctx
  | ("bp" | "breakpoints") :: _ ->
    print_endline (String.concat " " !break_points);
    do_debug ctx
  | ("s" | "step") :: t ->
    (match t with
    | n :: _ when Option.is_some (int_of_string_opt n) ->
      state := Step (int_of_string n)
    | _ ->
      state := Step 1
    )
  | ("si" | "stepinstr") :: t ->
    (match ctx with
    | (AlContext.Al (name, _, il, _) | AlContext.Enter (name, il, _)) :: _
    when List.length il > 0 ->
      (match t with
      | n :: _ when Option.is_some (int_of_string_opt n) ->
        state := StepInstr (name, int_of_string n)
      | _ ->
        state := StepInstr (name, 1)
      )
    | _ ->
      handle_command ctx ("step" :: t)
    )
  | ("c" | "continue") :: t ->
    (match t with
    | n :: _ when Option.is_some (int_of_string_opt n) ->
      state := Continue (int_of_string n)
    | _ ->
      state := Continue 1
    )
  | "al" :: _ ->
    ctx
    |> List.map AlContext.string_of_context
    |> List.iter print_endline;
    do_debug ctx
  | "wasm" :: _ ->
    WasmContext.string_of_context_stack () |> print_endline;
    do_debug ctx
  | "store" :: field :: n :: _ ->
    (try
      let idx = int_of_string n in
      Store.access field
      |> unwrap_listv
      |> (!)
      |> (fun arr -> Array.get arr idx)
      |> string_of_value
      |> print_endline;
    with _ -> ()
    );
    do_debug ctx
  | "lookup" :: s :: _ ->
    (match ctx with
    | (Al (_, _, _, env) | Enter (_, _, env)) :: _ ->
      lookup_env_opt s env
      |> Option.map string_of_value
      |> Option.iter print_endline;
    | _ -> ()
    );
    do_debug ctx
  | ("q" | "quit") :: _ -> debug := false
  | _ -> do_debug ctx

let run ctx =

  if !debug && allow_command ctx then do_debug ctx
