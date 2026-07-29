val output_typ : out_channel -> Config.t -> Il.Ast.typ -> unit
val output_exp : out_channel -> Config.t -> Il.Ast.exp -> unit
val output_def : out_channel -> Config.t -> Il.Ast.def -> unit
val output_script : out_channel -> Config.t -> Il.Ast.script -> unit

val string_of_typ : Config.t -> Il.Ast.typ -> string
val string_of_exp : Config.t -> Il.Ast.exp -> string
val string_of_def : Config.t -> Il.Ast.def -> string
val string_of_script : Config.t -> Il.Ast.script -> string
