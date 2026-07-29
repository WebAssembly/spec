type config =
  {
    (* Abort rendering if the renderer fails *)
    panic_on_error : bool;
  }

type t = config

let default = { panic_on_error = true }
