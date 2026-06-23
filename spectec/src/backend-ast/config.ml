type config =
  {
    (* Line length to assume for pretty-printing *)
    width : int;
  }

type t = config

let default = { width = 80 }
