type config =
  {
    (* Spacing for display math *)
    display : bool;

    (* Generate ids and atoms as macro calls `\id` instead of `\mathit|rm|sf|tt{id}` *)
    macros_for_ids : bool;

    (* Decorate grammars with l.h.s. description like "(instruction) instr ::= ..." *)
    include_grammar_desc : bool;
  }

type t = config

let default =
  { display = true;
    macros_for_ids = false;
    include_grammar_desc = false;
  }
