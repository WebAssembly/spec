module Make (Engine : Engine.Engine) :
sig
  exception Abort of Source.region * string
  exception Assert of Source.region * string
  exception IO of Source.region * string

  val trace : string -> unit

  val register_instance : Ast.name -> Engine.moduleinst -> unit
  val register_virtual : Ast.name ->
    (Ast.name -> Types.externtype -> Engine.externinst option) ->
    unit

  val run_string : string -> bool
  val run_file : string -> bool
  val run_stdin : unit -> unit
end
