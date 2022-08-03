(* Generic Matching *)

module type Context =
sig
  type var
  type def_type
  type context
  val lookup : context -> var -> def_type
end

module Make
  (Var : Types.Var)
  (Context : Context
    with type var = Var.var
    with type def_type = Types.Make(Var).def_type
  ) :
sig
  open Types.Make (Var)
  open Context

  type assump = (var * var) list

  (* Equivalence *)

  val eq_num_type : context -> assump -> num_type -> num_type -> bool
  val eq_ref_type : context -> assump -> ref_type -> ref_type -> bool
  val eq_val_type : context -> assump -> val_type -> val_type -> bool

  val eq_result_type : context -> assump -> result_type -> result_type -> bool

  val eq_func_type : context -> assump -> func_type -> func_type -> bool
  val eq_table_type : context -> assump -> table_type -> table_type -> bool
  val eq_memory_type : context -> assump -> memory_type -> memory_type -> bool
  val eq_global_type : context -> assump -> global_type -> global_type -> bool

  val eq_extern_type : context -> assump -> extern_type -> extern_type -> bool

  val eq_def_type : context -> assump -> def_type -> def_type -> bool

  (* Subtyping *)

  val match_num_type : context -> assump -> num_type -> num_type -> bool
  val match_ref_type : context -> assump -> ref_type -> ref_type -> bool
  val match_val_type : context -> assump -> val_type -> val_type -> bool

  val match_result_type : context -> assump -> result_type -> result_type -> bool

  val match_func_type : context -> assump -> func_type -> func_type -> bool
  val match_table_type : context -> assump -> table_type -> table_type -> bool
  val match_memory_type : context -> assump -> memory_type -> memory_type -> bool
  val match_global_type : context -> assump -> global_type -> global_type -> bool

  val match_extern_type : context -> assump -> extern_type -> extern_type -> bool

  val match_def_type : context -> assump -> def_type -> def_type -> bool
end


(* Static Matching *)

module StatContext : Context
  with type var = Types.Stat.var
  with type def_type = Types.Stat.def_type
  with type context = Types.Stat.def_type list

module Stat : module type of Make (Types.StatVar) (StatContext)

include module type of Stat


(* Dynamic Matching *)

module DynContext : Context
  with type var = Types.Dyn.var
  with type def_type = Types.Dyn.def_type
  with type context = unit

module Dyn : module type of Make (Types.DynVar) (DynContext)
