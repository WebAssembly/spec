exception Code of Source.region * string

val decode : string -> string -> Ast.module_ (* raises Code *)

val decode_custom : Ast.name -> string -> string -> string list (* raises Code *)
