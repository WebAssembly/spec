open Il.Ast
open Def

type transformer = {
  transform_exp: exp -> exp;
  transform_bind: bind -> bind;
  transform_prem: prem -> prem;
  transform_iterexp: iterexp -> iterexp;
  }

val transform_exp : transformer -> exp -> exp
val transform_rule_def : transformer -> rule_def -> rule_def
val transform_helper_def : transformer -> helper_def -> helper_def
val base_transformer : transformer
