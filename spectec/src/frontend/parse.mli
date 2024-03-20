val parse_typ : string -> El.Ast.typ (* raises Error.Error *)
val parse_exp : string -> El.Ast.exp (* raises Error.Error *)
val parse_script : string -> El.Ast.script (* raises Error.Error *)
val parse_file : string -> El.Ast.script (* raises Error.Error *)
