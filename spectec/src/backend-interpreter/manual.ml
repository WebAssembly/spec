open Al.Ast

let exec_expr_const =
  let instrs = IterE (VarE "instr", ["instr"], List) in
  let result = VarE "val" in

  FuncA (
    "exec_expr_const",
    [instrs],
    [
      ExecuteSeqI instrs;
      PopI result;
      ReturnI (Some (result))
    ]
  )

let manual_algos =
  [exec_expr_const]
