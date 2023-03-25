open El.Ast


(* Generators *)

type env
val empty_env : env

val render_atom : env -> atom -> string
val render_typ : env -> typ -> string
val render_exp : env -> exp -> string
val render_def : env -> def -> string
val render_deftyp : env -> deftyp -> string
val render_nottyp : env -> nottyp -> string
val render_script : script -> string


(* Flags *)

(* Generate id's as macro calls `\id` instead of `\mathit{id}` *)
val flag_macros_for_ids : bool ref

(* Generate vdash's as macro calls `\vdashRelid` instead of `\vdash` *)
val flag_macros_for_vdash : bool ref

(* Decorate grammars with l.h.s. description like "(instruction) instr ::= ..." *)
val flag_include_grammar_desc : bool ref
