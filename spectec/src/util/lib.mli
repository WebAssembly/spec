(* Things that should be in the OCaml library... *)

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
end
