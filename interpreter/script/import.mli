exception Unknown of Source.region * string

val link : Ast.module_ -> Instance.extern list (* raises Unknown *)

val register :
  Ast.name ->
  (Ast.name -> Types.externtype -> Instance.extern (* raises Not_found *)) ->
  unit
