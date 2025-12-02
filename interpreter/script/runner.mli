module Make (Engine : Embed.Engine) :
sig
  val register_instance : Ast.name -> Engine.moduleinst -> unit
  val register_virtual : Ast.name ->
    (Ast.name -> Types.externtype -> Engine.externinst option) ->
    unit

  val run_string : string -> bool
  val run_file : string -> bool
  val run_stdin : unit -> unit
end
