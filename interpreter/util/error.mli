module Make () :
sig
  exception Error of Source.region * string

  val warn : Source.region -> string -> unit
  val error : Source.region -> string -> 'a  (* raises Error *)
end

