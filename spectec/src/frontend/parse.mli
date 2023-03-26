val parse_exp : string -> El.Ast.exp (* raises Source.Error *)
val parse_script : string -> El.Ast.script (* raises Source.Error *)
val parse_file : string -> El.Ast.script (* raises Source.Error *)
