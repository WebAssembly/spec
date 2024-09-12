open Ast

type unit_walker = {
  walk_algo: unit_walker -> algorithm -> unit;
  walk_instr: unit_walker -> instr -> unit;
  walk_expr: unit_walker -> expr -> unit;
  walk_path: unit_walker -> path -> unit;
  walk_iter: unit_walker -> iter -> unit;
  walk_arg: unit_walker -> arg -> unit;
}
type walker = {
  walk_algo: walker -> algorithm -> algorithm;
  walk_instr: walker -> instr -> instr;
  walk_expr: walker -> expr -> expr;
  walk_path: walker -> path -> path;
  walk_iter: walker -> iter -> iter;
  walk_arg: walker -> arg -> arg;
}
val base_unit_walker : unit_walker
val base_walker : walker

(* TODO: remove walker below *)

type config = {
  pre_instr: instr -> instr list;
  post_instr: instr -> instr list;
  stop_cond_instr: instr -> bool;

  pre_expr: expr -> expr;
  post_expr: expr -> expr;
  stop_cond_expr: expr -> bool;
}
val default_config : config
val walk : config -> algorithm -> algorithm
val walk_instr : config -> instr -> instr list
val walk_instrs : config -> instr list -> instr list
val walk_expr : config -> expr -> expr
val walk_path : config -> path -> path
val walk_arg : config -> arg -> arg
