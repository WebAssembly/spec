type config =
  {
    (* Generate macros *)
    macros: bool;
  }

let default = { macros = false; }

let latex = default

let sphinx = default
