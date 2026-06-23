val gen_prose : El.Ast.script -> Il.Ast.script -> Al.Ast.script -> Prose.prose
val gen_string : Backend_latex.Config.config -> Config.config -> El.Ast.script -> Il.Ast.script -> Al.Ast.script -> string
val gen_file : Backend_latex.Config.config -> Config.config -> string -> El.Ast.script -> Il.Ast.script -> Al.Ast.script -> unit
