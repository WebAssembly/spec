open El.Ast


(* Configuration *)

type env
type config =
  { 
    (* Generate id's as macro calls `\id` instead of `\mathit{id}` *)
    macros_for_ids : bool;

    (* Generate vdash's as macro calls `\vdashRelid` instead of `\vdash` *)
    macros_for_vdash : bool;

    (* Decorate grammars with l.h.s. description like "(instruction) instr ::= ..." *)
    include_grammar_desc : bool;
  }

val config : config
val env : config -> env


(* Generators *)

val render_atom : env -> atom -> string
val render_typ : env -> typ -> string
val render_exp : env -> exp -> string
val render_def : env -> def -> string
val render_deftyp : env -> deftyp -> string
val render_nottyp : env -> nottyp -> string
val render_script : env -> script -> string
