exception Unknown of Source.region * string

val link : Kernel.module_ -> Eval.import list (* raises Unknown *)
val register: string -> (string -> Types.func_type -> Eval.import) -> unit
