open Al.Ast

let exec_expr_const =
  let instrs = IterE (NameE (N "instr"), [N "instr"], List) in
  let result = NameE (N "val") in

  Algo (
    "exec_expr_const", DecN,
    [instrs],
    [
      ExecuteSeqI instrs;
      PopI result;
      ReturnI (Some (result))
    ]
  )

let manual_algos =
  [exec_expr_const] |> List.map Transpile.app_remover
