open Ds
open Al
open Al_util
open Print


type state =
  | Step
  | StepOut of string
  | Continue
  | Quit

let debug = ref false
let break_points = ref []
let state = ref Step
let command_cnt = ref 0
let try_command () =
  let cnt = !command_cnt in
  if cnt > 0 then command_cnt := cnt - 1;
  !command_cnt = 0

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
  stepinstr {number}?: step n instructions in AL algorithm ...!
  c {number}?
  continue {number}?: continue steps until meet n break points
  al: print al context stack
  wasm: print wasm context stack
  lookup {variable name}: lookup the variable
  q
  quit: quit
  "

let run ctx =
  let allow_command () =
    match !state with
    | Step -> try_command ()
    | StepOut name when name == AlContext.get_name ctx ->
      try_command ()
    | Continue ->
      (match ctx with
      | AlContext.Al (name, il, _) :: _
      | AlContext.Enter (name, il, _) :: _
      when List.mem name !break_points ->
        if name |> lookup_algo |> body_of_algo = il then
          try_command ()
        else
          false
      | _ -> false
      )
    | Quit -> false
    | _ -> false
  in

  let rec do_debug () =
    let _ = print_string "$" in
    match String.split_on_char ' ' (read_line ()) with
    | ("h" | "help") :: _ ->
      print_endline help_msg
    | ("b" | "break") :: t -> break_points := !break_points @ t; do_debug ()
    | ("rm" | "remove") :: t ->
      break_points := List.filter (fun e -> not (List.mem e t)) !break_points;
      do_debug ()
    | ("bp" | "breakpoints") :: _ ->
      print_endline (String.concat " " !break_points);
      do_debug ()
    | ("s" | "step") :: t ->
      state := Step;
      (match t with
      | n :: _ when Option.is_some (int_of_string_opt n) ->
        command_cnt := int_of_string n
      | _ -> ()
      )
    | ("si" | "stepinstr") :: t ->
      (match ctx with
      | (AlContext.Al (name, _, _) | AlContext.Enter (name, _, _)) :: _ ->
        state := StepOut name;
        (match t with
        | n :: _ when Option.is_some (int_of_string_opt n) ->
          command_cnt := int_of_string n
        | _ -> ()
        )
      | _ -> do_debug ()
      )
    | ("c" | "continue") :: t ->
      state := Continue;
      (match t with
      | n :: _ when Option.is_some (int_of_string_opt n) ->
        command_cnt := int_of_string n
      | _ -> ()
      )
    | "al" :: _ ->
      ctx
      |> List.map AlContext.string_of_context
      |> List.iter print_endline;
      do_debug ()
    | "wasm" :: _ ->
      WasmContext.string_of_context_stack () |> print_endline;
      do_debug ()
    | "lookup" :: s :: _ ->
      (match ctx with
      | (Al (_, _, env) | Enter (_, _, env)) :: _ ->
        lookup_env_opt s env
        |> Option.map string_of_value
        |> Option.iter print_endline;
        do_debug ()
      | _ -> ()
      )
    | ("q" | "quit") :: _ -> state := Quit
    | _ -> ()
  in

  if !debug && allow_command () then do_debug ()
