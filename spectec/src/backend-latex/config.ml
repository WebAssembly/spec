type config =
  {
    (* Spacing for display math *)
    display : bool;

    (* Generate ids as macro calls `\id` instead of `\mathit{id}` *)
    macros_for_ids : bool;

    (* Generate atoms as macro calls, e.g., `\vdashRelid` instead of `\vdash` *)
    macros_for_atoms : bool;

    (* Decorate grammars with l.h.s. description like "(instruction) instr ::= ..." *)
    include_grammar_desc : bool;
  }

type t = config

let default =
  { display = true;
    macros_for_ids = false;
    macros_for_atoms = false;
    include_grammar_desc = false;
  }
