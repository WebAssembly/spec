open El.Ast


(* Generators *)

val render_atom : Config.t -> atom -> string
val render_typ : Config.t -> typ -> string
val render_exp : Config.t -> exp -> string
val render_def : Config.t -> def -> string
val render_defs : Config.t -> def list -> string
val render_deftyp : Config.t -> deftyp -> string
val render_nottyp : Config.t -> nottyp -> string
val render_script : Config.t -> script -> string
