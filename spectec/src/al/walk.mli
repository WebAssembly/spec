open Ast

type config = {
  pre_instr: instr -> instr list;
  post_instr: instr -> instr list;
  stop_cond_instr: instr -> bool;

  pre_cond: cond -> cond;
  post_cond: cond -> cond;
  stop_cond_cond: cond -> bool;

  pre_expr: expr -> expr;
  post_expr: expr -> expr;
  stop_cond_expr: expr -> bool;
}

val default_config : config
val walk : config -> algorithm -> algorithm
val walk_instr : config -> instr -> instr list
val walk_expr : config -> expr -> expr
