type config =
  {
    (* Generate macro definitions in a separate file *)
    macros: bool;
  }

type t = config

let default = { macros = false; }

let latex = default

let sphinx = default
