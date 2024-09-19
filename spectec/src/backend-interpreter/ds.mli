open Al.Ast

module Env : Map.S with type key = string

val bound_rule : string -> bool
val bound_func : string -> bool
val lookup_algo : string -> algorithm

type env = value Env.t
val lookup_env : string -> env -> value
val lookup_env_opt : string -> env -> value option

module Store : sig
  val get : unit -> value
  val access : string -> value
end

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
  type mode =
    (* Al context *)
    | Al of string * arg list * instr list * env
    (* Wasm context *)
    | Wasm of int
    (* Special context for enter/execute *)
    | Enter of string * instr list * env
    | Execute of value
    (* Return register *)
    | Return of value
  val al : string * arg list * instr list * env -> mode
  val wasm : int -> mode
  val enter : string * instr list * env -> mode
  val execute : value -> mode
  val return : value -> mode
  type t = mode list
  val string_of_context : mode -> string
  val tl : t -> t
  val is_reducible : t -> bool
  val can_tail_call : instr -> bool
  val get_name : t -> string
  val add_instrs : instr list -> t -> t
  val set_env : env -> t -> t
  val get_env : t -> env
  val update_env : string -> value -> t -> t
  val get_return_value : t -> value option
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

  val get_top_context : unit -> value option
  val get_current_frame : unit -> value
  val get_current_label : unit -> value
  val get_module_instance : unit -> value

  val get_value_stack : unit -> value list
  val pop_value_stack : unit -> value list
  val push_value : value -> unit
  val pop_value : unit -> value

  val pop_instr : unit -> value
end

val init : algorithm list -> unit
