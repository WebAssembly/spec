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
  type ctx =
    (* Top level context *)
    | Return of value option
    (* Al context *)
    | Al of string * instr list * env * value option * int
    (* Wasm context *)
    | Wasm of int
    (* Special context for preparing execute *)
    | Execute of value
  type t = ctx list
  val empty : t
  val is_empty : t -> bool
  val pop_context : t -> t
  val get_name : t -> string
  val add_instrs : instr list -> t -> t
  val set_env : env -> t -> t
  val get_env : t -> env
  val update_env : string -> value -> t -> t
  val get_return_value : t -> value option
  val set_return_value : value -> t -> t
  val increase_depth : t -> t
  val decrease_depth : t -> t
end

module WasmContext : sig
  type t = value * value list * value list
  val get_context : unit -> t
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
