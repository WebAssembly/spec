type config =
  {
    (* Generate id's as macro calls `\id` instead of `\mathit{id}` *)
    macros_for_ids : bool;

    (* Generate vdash's as macro calls `\vdashRelid` instead of `\vdash` *)
    macros_for_vdash : bool;

    (* Decorate grammars with l.h.s. description like "(instruction) instr ::= ..." *)
    include_grammar_desc : bool;
  }

type t = config

let default =
  { macros_for_ids = false;
    macros_for_vdash = false;
    include_grammar_desc = false;
  }

let latex = default

let sphinx = default
