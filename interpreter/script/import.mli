exception Unknown of Source.region * string

val link : Ast.module_ -> Instance.extern list (* raises Unknown *)

val register :
  Ast.name ->
  (Ast.name -> Types.extern_type -> Instance.extern (* raises Not_found *)) ->
  unit
