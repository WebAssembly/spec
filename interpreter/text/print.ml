let instr oc width e = Sexpr.output oc width (Arrange.instr e)
let func oc width f = Sexpr.output oc width (Arrange.func f)
let module_ oc width m = Sexpr.output oc width (Arrange.module_ m)
let script oc width mode s =
  List.iter (Sexpr.output oc width) (Arrange.script mode s)
