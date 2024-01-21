open Al.Ast

module Env : Map.S with type key = string

val bound_rule : string -> bool
val bound_func : string -> bool
val lookup_algo : string -> algorithm

val get_store : unit -> store

type env = value Env.t
val lookup_env : string -> env -> value
val add_store : env -> env

module Info : sig
  type info = { algo_name: string; instr: instr; mutable covered: bool }
  val make_info : string -> instr -> info
  val print : unit -> unit
  val add : int -> info -> unit
  val find : int -> info
end

module Register : sig
  val add : string -> value -> unit
  val add_with_var : Reference_interpreter.Script.var option -> value -> unit
  val find : string -> value
  val get_module_name : Reference_interpreter.Script.var option -> string
end

module AlContext : sig
  type return_value = 
    | Bot
    | None
    | Some of value 
  type t = string * env * return_value * int

  val context_stack_length : int ref
  val create_context : string -> t
  val init_context : unit -> unit
  val push_context : t -> unit
  val pop_context : unit -> t
  val get_context : unit -> t
  val get_name : unit -> string

  val string_of_return_value : return_value -> string
  val string_of_context : t -> string
  val string_of_context_stack : unit -> string

  val set_env : env -> unit
  val update_env : string -> value -> unit
  val get_env : unit -> env

  val set_return_value : value -> unit
  val set_return : unit -> unit
  val get_return_value : unit -> return_value

  val get_depth : unit -> int
  val increase_depth : unit -> unit
  val decrease_depth : unit -> unit
end

module WasmContext : sig
  type t = value * value list * value list
  val get_context : unit -> t
  val get_nth_context : int -> t
  val init_context : unit -> unit
  val push_context : t -> unit
  val pop_context : unit -> t

  val string_of_context : t -> string 
  val string_of_context_stack : unit -> string

  val get_current_context : unit -> value
  val get_current_frame : unit -> value
  val get_module_instance : unit -> value
  val get_current_label : unit -> value

  val get_value_stack : unit -> value list
  val push_value : value -> unit
  val pop_value : unit -> value
  
  val pop_instr : unit -> value
end

val init : algorithm list -> unit
