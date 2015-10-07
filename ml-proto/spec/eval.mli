(*
 * (c) 2015 Andreas Rossberg
 *)

type instance
type value = Values.value
type import = value list -> value option
type host_params = {page_size : Memory.size}

val init : Ast.module_ -> import list -> host_params -> instance
val invoke : instance -> string -> value list -> value option
  (* raise Error.Error *)

(* This function is not part of the spec. *)
val host_eval : Ast.expr -> value option (* raise Error.Error *)
