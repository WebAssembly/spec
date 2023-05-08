open Reference_interpreter

type stack_elem =
  | ValueS of Values.value
  | FrameS of Al.frame

type stack = stack_elem list

let stack: stack ref = ref []

let get_stack () = !stack

let reset_stack () = stack := []

let length () = List.length !stack

let hd () = List.hd !stack

let push_v v = stack := ValueS (v) :: !stack

let push_f f = stack := FrameS (f) :: !stack

let pop () =
  let res = List.hd !stack in
  stack := List.tl !stack;
  res

let get_current_frame () =
  let f = function FrameS _ -> true | _ -> false in
  match List.find f !stack with
    | FrameS frame -> frame
    | _ ->
        (* Due to Wasm validation, unreachable *)
        failwith "No frame"
