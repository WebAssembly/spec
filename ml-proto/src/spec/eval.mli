(*
 * (c) 2015 Andreas Rossberg
 *)

type instance
type value = Values.value
type import = value list -> value option
type host_params = {page_size : Memory.size}

val init : Ast.modul -> import list -> host_params -> instance
val invoke : instance -> string -> value list -> value option
  (* raise Error.Error *)
val eval : Ast.expr -> value option (* raise Error.Error *)
val memory_for_module : instance -> Memory.t
