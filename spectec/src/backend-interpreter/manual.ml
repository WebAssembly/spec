open Al.Ast

let exec_expr_const =
  let instrs = IterE (NameE "instr", ["instr"], List) in
  let result = NameE "val" in

  FuncA (
    "exec_expr_const",
    [instrs],
    [
      ExecuteSeqI instrs;
      PopI result;
      ReturnI (Some (result))
    ]
  )

(* Helper for the manual array_new.data algorithm *)

let group_bytes_by =
  let n = NameE "n" in
  let n' = NameE "n'" in

  let bytes_ = IterE (NameE "byte", ["byte"], List) in
  let bytes_left = ListE [AccessE (bytes_, SliceP (NumE 0L, n))] in
  let bytes_right = AppE 
    (
      "group_bytes_by", 
      [ n; AccessE (bytes_, SliceP (n, BinopE (Sub, n', n))) ]
    ) 
  in

  FuncA (
    "group_bytes_by",
    [n; bytes_],
    [
      LetI (n', LengthE bytes_);
      IfI (
        CompareC (Ge, n', n),
        [ ReturnI (Some (ConcatE (bytes_left, bytes_right))) ],
        []
      );
      ReturnI (Some (ListE []));
    ]
  )

let manual_algos =
  [exec_expr_const; group_bytes_by] |> List.map Transpile.app_remover
