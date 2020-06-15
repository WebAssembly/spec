exception Unknown of Source.region * string

val link : Ast.module_ -> Instance.extern list (* raises Unknown *)

val register :
  string ->
  (string -> Types.external_type -> Instance.extern (* raise Not_found *)) ->
  unit
