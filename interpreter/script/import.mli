exception Unknown of Source.region * string

val link : Ast.module_ -> Instance.extern list (* raises Unknown *)

val register :
  Ast.name ->
  (Ast.name -> Types.external_type -> Instance.extern (* raise Not_found *)) ->
  unit
