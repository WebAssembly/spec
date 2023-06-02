open Al
open Printf

(* helper functions *)

let indent = "  "

let string_of_opt prefix stringifier suffix = function
  | None -> ""
  | Some x -> prefix ^ stringifier x ^ suffix

let string_of_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      let limit = 16 in
      let is_long = List.length t > limit in
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) (List.filteri (fun i _ -> i <= limit) t)
      ^ (if is_long then (sep ^ "...") else "")
      ^ right

let string_of_array stringifier left sep right a =
  Array.to_list a |> string_of_list stringifier left sep right

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

(* AL stringifier *)

let rec string_of_al_type = function
  | WasmValueT _ -> "WasmValueT"
  | WasmValueTopT -> "WasmValueTopT"
  | EmptyListT -> "EmptyListT"
  | ListT ty -> "ListT (" ^ string_of_al_type ty ^ ")"
  | StringT -> "StringT"
  | IntT -> "IntT"
  | AddrT -> "AddrT"
  | FrameT -> "FrameT"
  | StoreT -> "StoreT"
  | StateT -> "StateT"
  | FunT (params, res) ->
      sprintf "[%s] -> %s"
        (List.fold_left
           (fun acc ty -> acc ^ string_of_al_type ty ^ ", ")
           "" params)
        (string_of_al_type res)
  | TopT -> "TopT"

let rec string_of_name = function
  | N s -> s
  | SubN (n, s) -> sprintf "%s_%s" (string_of_name n) s

let string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN name -> "^" ^ string_of_name name

let string_of_iters iters = List.map string_of_iter iters |> List.fold_left (^) ""

let depth = ref 0
let rec string_of_record r =
  let base_indent = repeat indent !depth in
  depth := !depth + 1;
  let str = Al.Record.fold
    (fun k v acc -> acc ^ base_indent ^ indent ^ k ^ ": " ^ string_of_value !v ^ ";\n")
    r (base_indent ^ "{\n")
  ^ (base_indent ^ "}") in
  depth := !depth - 1;
  str

and string_of_frame (_, f) = string_of_record f

and string_of_stack st =
  let f acc e = acc ^ string_of_value e ^ "\n" in
  List.fold_left f "[Stack]\n" st

and string_of_value = function
  | LabelV (v1, v2) ->
      sprintf "Label_%s %s" (string_of_value v1) (string_of_value v2)
  | FrameV (v1, v2) -> sprintf "(Frame %s %s)" (string_of_value v1) (string_of_value v2)
  | StoreV _ -> "StoreV"
  | ListV lv -> string_of_array string_of_value "[" ", " "]" lv
  | NumV n -> Int64.to_string n
  | StringV s -> s
  | PairV (v1, v2) -> "(" ^ string_of_value v1 ^ ", " ^ string_of_value v2 ^ ")"
  | ArrowV (v1, v2) -> "[" ^ string_of_value v1 ^ "]->[" ^ string_of_value v2 ^ "]"
  | ConstructV ("CONST", hd::tl) -> "(" ^ string_of_value hd ^ ".CONST" ^ string_of_list string_of_value " " " " "" tl ^ ")"
  | ConstructV (s, []) -> s
  | ConstructV (s, vl) -> "(" ^ s ^ string_of_list string_of_value " " " " "" vl ^ ")"
  | RecordV r -> string_of_record r
  | OptV (Some e) -> "?(" ^ string_of_value e ^ ")"
  | OptV None -> "?()"

let string_of_expr_binop = function
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "·"
  | Div -> "/"
  | Exp -> "^"

let string_of_cond_binop = function
  | And -> "and"
  | Or -> "or"
  | Impl -> "=>"
  | Equiv -> "<=>"

let string_of_compare_op = function
  | Eq -> "is"
  | Ne -> "is not"
  | Gt -> ">"
  | Ge -> "≥"
  | Lt -> "<"
  | Le -> "≤"


let rec string_of_record_expr r =
  Al.Record.fold
    (fun k v acc -> acc ^ k ^ ": " ^ string_of_expr !v ^ "; ")
    r "{ "
  ^ "}"

and string_of_expr = function
  | NumE i -> Int64.to_string i
  | StringE s -> s
  | MinusE e -> sprintf "-%s" (string_of_expr e)
  | BinopE (op, e1, e2) ->
      sprintf "(%s %s %s)" (string_of_expr e1) (string_of_expr_binop op) (string_of_expr e2)
  | PairE (e1, e2) -> sprintf "(%s, %s)" (string_of_expr e1) (string_of_expr e2)
  | AppE (n, el) ->
      sprintf "$%s(%s)" (string_of_name n)
        (string_of_list string_of_expr "" ", " "" el)
  | MapE (n, el, iters) ->
      sprintf "$%s(%s)%s" (string_of_name n)
        (string_of_list string_of_expr "" ", " "" el)
        (string_of_iters iters)
  | ConcatE (e1, e2) ->
      sprintf "%s ++ %s" (string_of_expr e1) (string_of_expr e2)
  | LengthE e -> sprintf "|%s|" (string_of_expr e)
  | ArityE e -> sprintf "the arity of %s" (string_of_expr e)
  | GetCurLabelE -> "the current label"
  | GetCurFrameE -> "the current frame"
  | FrameE (e1, e2) ->
      sprintf "the activation of %s with arity %s" (string_of_expr e2)
        (string_of_expr e1)
  | ListE el -> string_of_array string_of_expr "[" ", " "]" el
  | ListFillE (e1, e2) -> string_of_expr e1 ^ "^" ^ string_of_expr e2
  | AccessE (e, p) -> sprintf "%s%s" (string_of_expr e) (string_of_path p)
  | RecordE r -> string_of_record_expr r
  | ContE e -> sprintf "the continuation of %s" (string_of_expr e)
  | LabelE (e1, e2) ->
      sprintf "the label_%s{%s}" (string_of_expr e1) (string_of_expr e2)
  | NameE (n, iters) -> string_of_name n ^ string_of_iters iters
  | ArrowE (e1, e2) ->
    (match e1 with ListE _ -> string_of_expr e1 | _ -> "[" ^ string_of_expr e1 ^ "]" )
    ^ "->"
    ^ (match e2 with ListE _ -> string_of_expr e2 | _ -> "[" ^ string_of_expr e2 ^ "]" )
  | ConstructE ("CONST", hd::tl) -> "(" ^ string_of_expr hd ^ ".CONST" ^ string_of_list string_of_expr " " " " "" tl ^ ")"
  | ConstructE (s, []) -> s
  | ConstructE (s, el) -> "(" ^ s ^ string_of_list string_of_expr " " " " "" el ^ ")"
  | OptE (Some e) -> "?(" ^ string_of_expr e ^ ")"
  | OptE None -> "?()"
  | YetE s -> sprintf "YetE (%s)" s

and string_of_path = function
  | IndexP e -> sprintf "[%s]" (string_of_expr e)
  | SliceP (e1, e2) ->
      sprintf "[%s : %s]" (string_of_expr e1) (string_of_expr e2)
  | DotP s -> sprintf ".%s" s

and string_of_cond = function
  | NotC (IsCaseOfC (e, c)) ->
      sprintf "%s is not of the case %s" (string_of_expr e) c
  | NotC (IsDefinedC e) ->
      sprintf "%s is not defined" (string_of_expr e)
  | NotC c -> sprintf "not %s" (string_of_cond c)
  | BinopC (op, c1, c2) ->
      sprintf "%s %s %s" (string_of_cond c1) (string_of_cond_binop op) (string_of_cond c2)
  | CompareC (op, e1, e2) ->
      sprintf "%s %s %s" (string_of_expr e1) (string_of_compare_op op) (string_of_expr e2)
  | IsDefinedC e -> sprintf "%s is defined" (string_of_expr e)
  | IsCaseOfC (e, c) -> sprintf "%s is of the case %s" (string_of_expr e) c
  | IsTopC s -> sprintf "the top of the stack is %s" s
  | YetC s -> sprintf "YetC (%s)" s

let make_index index depth =
  index := !index + 1;

  let num_idx = string_of_int !index in
  let alp_idx = Char.escaped (Char.chr (96 + !index)) in

  match depth mod 4 with
  | 0 -> num_idx ^ "."
  | 1 -> alp_idx ^ "."
  | 2 -> num_idx ^ ")"
  | 3 -> alp_idx ^ ")"
  | _ -> assert false

let rec string_of_instr index depth = function
  | IfI (c, il, []) ->
      sprintf "%s If %s, then:%s" (make_index index depth) (string_of_cond c)
        (string_of_instrs (depth + 1) il)
  | IfI (c, il1, [ IfI (inner_c, inner_il1, []) ]) ->
      let if_index = make_index index depth in
      let else_if_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s"
        if_index
        (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (string_of_cond inner_c)
        (string_of_instrs (depth + 1) inner_il1)
  | IfI (c, il1, [ IfI (inner_c, inner_il1, inner_il2) ]) ->
      let if_index = make_index index depth in
      let else_if_index = make_index index depth in
      let else_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else if %s, then:%s\n%s Else:%s"
        if_index
        (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_if_index)
        (string_of_cond inner_c)
        (string_of_instrs (depth + 1) inner_il1)
        (repeat indent depth ^ else_index)
        (string_of_instrs (depth + 1) inner_il2)
  | IfI (c, il1, il2) ->
      let if_index = make_index index depth in
      let else_index = make_index index depth in
      sprintf "%s If %s, then:%s\n%s Else:%s" if_index (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ else_index)
        (string_of_instrs (depth + 1) il2)
  | OtherwiseI il ->
      sprintf "%s Otherwise:%s" (make_index index depth)
        (string_of_instrs (depth + 1) il)
  | WhileI (c, il) ->
      sprintf "%s While %s, do:%s" (make_index index depth) (string_of_cond c)
        (string_of_instrs (depth + 1) il)
  | EitherI (il1, il2) ->
      let either_index = make_index index depth in
      let or_index = make_index index depth in
      sprintf "%s Either:%s\n%s Or:%s" either_index
        (string_of_instrs (depth + 1) il1)
        (repeat indent depth ^ or_index)
        (string_of_instrs (depth + 1) il2)
  | ForI (e, il) ->
      sprintf "%s For i in range |%s|:%s" (make_index index depth)
        (string_of_expr e)
        (string_of_instrs (depth + 1) il)
  | ForeachI (e1, e2, il) ->
      sprintf "%s Foreach %s in %s:%s" (make_index index depth)
        (string_of_expr e1)
        (string_of_expr e2)
        (string_of_instrs (depth + 1) il)
  | AssertI s -> sprintf "%s Assert: %s." (make_index index depth) s
  | PushI e ->
      sprintf "%s Push %s to the stack." (make_index index depth)
        (string_of_expr e)
  | PopI e ->
      sprintf "%s Pop %s from the stack." (make_index index depth)
        (string_of_expr e)
  | PopAllI e ->
      sprintf "%s Pop all values %s from the stack." (make_index index depth)
        (string_of_expr e)
  | LetI (n, e) ->
      sprintf "%s Let %s be %s." (make_index index depth) (string_of_expr n)
        (string_of_expr e)
  | TrapI -> sprintf "%s Trap." (make_index index depth)
  | NopI -> sprintf "%s Do nothing." (make_index index depth)
  | ReturnI e_opt ->
      sprintf "%s Return%s." (make_index index depth)
        (string_of_opt " " string_of_expr "" e_opt)
  | EnterI (e1, e2) ->
      sprintf "%s Enter %s with label %s." (make_index index depth)
        (string_of_expr e1) (string_of_expr e2)
  | ExecuteI e ->
      sprintf "%s Execute %s." (make_index index depth) (string_of_expr e)
  | ExecuteSeqI e ->
      sprintf "%s Execute the sequence (%s)." (make_index index depth) (string_of_expr e)
  | JumpI e ->
      sprintf "%s Jump to %s." (make_index index depth) (string_of_expr e)
  | PerformI e ->
      sprintf "%s Perform %s." (make_index index depth) (string_of_expr e)
  | ExitNormalI _ | ExitAbruptI _ -> make_index index depth ^ " Exit current context."
  | ReplaceI (e1, p, e2) ->
      sprintf "%s Replace %s%s with %s." (make_index index depth)
        (string_of_expr e1) (string_of_path p) (string_of_expr e2)
  | AppendI (e1, p, e2) ->
      sprintf "%s Append %s to the %s%s." (make_index index depth)
        (string_of_expr e2) (string_of_expr e1) (string_of_path p)
  | AppendListI (e1, p, e2) ->
      sprintf "%s Append the sequence %s to the %s%s." (make_index index depth)
        (string_of_expr e2) (string_of_expr e1) (string_of_path p)
  | ValidI (e1, e2, eo) ->
      sprintf "%s Under the context %s, %s must be valid%s." (make_index index depth)
        (string_of_expr e1)
        (string_of_expr e2)
        (string_of_opt " with type " string_of_expr "" eo)
  | IsValidI e_opt ->
      sprintf "%s The instruction is valid%s." (make_index index depth)
        (string_of_opt " with type " string_of_expr "" e_opt)
  | YetI s -> sprintf "%s YetI: %s." (make_index index depth) s

and string_of_instrs depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun acc i ->
      acc ^ "\n" ^ repeat indent depth ^ string_of_instr index depth i)
    "" instrs

let string_of_algorithm = function
  | Algo (name, params, instrs) ->
      name
      ^ List.fold_left
          (fun acc (p, _t) -> acc ^ " " ^ string_of_expr p)
          "" params
      ^ string_of_instrs 0 instrs ^ "\n"

open Reference_interpreter

let string_of_winstr (winstr : Ast.instr) =
  let num (x : Ast.var) = x.it |> I32.to_string_u in
  match winstr.it with
  | Ast.Unreachable -> "unreachable"
  | Ast.Nop -> "nop"
  | Ast.Drop -> "drop"
  | Ast.Select None -> "select"
  | Ast.Select (Some []) -> "select ()"
  | Ast.Select (Some _) -> "select (...)"
  | Ast.Block _ -> "block ..."
  | Ast.Loop _ -> "loop ..."
  | Ast.If _ -> "if ..."
  | Ast.Br x -> "br " ^ num x
  | Ast.BrIf x -> "br_if " ^ num x
  | Ast.BrTable _ -> "br_table ..."
  | Ast.Return -> "return"
  | Ast.Call x -> "call " ^ num x
  | Ast.CallIndirect (x, y) -> "call_indirect " ^ num x ^ " " ^ num y
  | Ast.LocalGet x -> "local.get " ^ num x
  | Ast.LocalSet x -> "local.set " ^ num x
  | Ast.LocalTee x -> "local.tee " ^ num x
  | Ast.GlobalGet x -> "global.get " ^ num x
  | Ast.GlobalSet x -> "global.set " ^ num x
  | Ast.TableGet x -> "table.get " ^ num x
  | Ast.TableSet x -> "table.set " ^ num x
  | Ast.TableSize x -> "table.size " ^ num x
  | Ast.TableGrow x -> "table.grow " ^ num x
  | Ast.TableFill x -> "table.fill " ^ num x
  | Ast.TableCopy (x, y) -> "table.copy " ^ num x ^ " " ^ num y
  | Ast.TableInit (x, y) -> "table.init " ^ num x ^ " " ^ num y
  | Ast.ElemDrop x -> "elem.drop " ^ num x
  | Ast.Load _ -> "load"
  | Ast.Store _ -> "store"
  | Ast.VecLoad _ -> "vecload"
  | Ast.VecStore _ -> "vecstroe"
  | Ast.VecLoadLane _ -> "vecloadlane"
  | Ast.VecStoreLane _ -> "vecstorelane"
  | Ast.MemorySize -> "memory.size"
  | Ast.MemoryGrow -> "memory.grow"
  | Ast.MemoryFill -> "memory.fill"
  | Ast.MemoryCopy -> "memory.copy"
  | Ast.MemoryInit x -> "memory.init " ^ num x
  | Ast.DataDrop x -> "data.drop " ^ num x
  | Ast.RefNull _ -> "ref.null ..."
  | Ast.RefIsNull -> "ref.is_null"
  | Ast.RefFunc x -> "ref.func " ^ num x
  | Ast.Const _ -> "const ..."
  | Ast.Test _ -> "test"
  | Ast.Compare _ -> "relop"
  | Ast.Unary _ -> "unary"
  | Ast.Binary _ -> "binary"
  | Ast.Convert _ -> "convert"
  | Ast.VecConst _ -> "vec_const"
  | Ast.VecTest _ -> "vec_test"
  | Ast.VecUnary _ -> "vec_unop"
  | Ast.VecBinary _ -> "vec_binop"
  | Ast.VecCompare _ -> "vec_relop"
  | Ast.VecConvert _ -> "vec_cvtop"
  | Ast.VecShift _ -> "vec_shiftop"
  | Ast.VecBitmask _ -> "vec_bitmaskop"
  | Ast.VecTestBits _ -> "vec_vtestop"
  | Ast.VecUnaryBits _ -> "vec_vunop"
  | Ast.VecBinaryBits _ -> "vec_vbinop"
  | Ast.VecTernaryBits _ -> "vec_vternop"
  | Ast.VecSplat _ -> "vec_splatop"
  | Ast.VecExtract _ -> "vec_extractop"
  | Ast.VecReplace _ -> "vec_replaceop"

(* structured stringifier *)

(* wasm type *)

let structured_string_of_al_type = function
  | WasmValueT _ -> "WasmValueT(_)" (* TODO *)
  | WasmValueTopT -> "WasmValueTopT"
  | EmptyListT -> "EmptyListT"
  | ListT _ -> "ListT(_)" (* TODO *)
  | FunT _ -> "FunT(_)" (* TODO *)
  | IntT -> "IntT"
  | AddrT -> "AddrT"
  | StringT -> "StringT"
  | FrameT -> "FrameT"
  | StoreT -> "StoreT"
  | StateT -> "StateT"
  | TopT -> "TopT"

(* name *)

let rec structured_string_of_name = function
  | N s -> "N(" ^ s ^ ")"
  | SubN (n, s) -> "SubN(" ^ structured_string_of_name n ^ ", " ^ s ^ ")"

(* iter *)

let structured_string_of_iter = function
  | Opt -> "?"
  | List -> "*"
  | List1 -> "+"
  | ListN name -> structured_string_of_name name

(* expression *)

let rec structured_string_of_value = function
  | LabelV (v1, v2) -> "LabelV (" ^ structured_string_of_value v1 ^ "," ^ structured_string_of_value v2 ^ ")"
  | FrameV _ -> "FrameV (TODO)"
  | StoreV _ -> "StoreV"
  | ListV _ -> "ListV"
  | NumV n -> "NumV (" ^ Int64.to_string n ^ ")"
  | StringV s -> "StringV (" ^ s ^ ")"
  | PairV (v1, v2) ->
      "PairV("
      ^ structured_string_of_value v1
      ^ ", "
      ^ structured_string_of_value v2
      ^ ")"
  | ArrowV (v1, v2) ->
      "ArrowV("
      ^ structured_string_of_value v1
      ^ ", "
      ^ structured_string_of_value v2
      ^ ")"
  | ConstructV (s, vl) ->
      "ConstructV(" ^ s ^ ", "
      ^ string_of_list structured_string_of_value "[" ", " "]" vl
      ^ ")"
  | RecordV _r -> "RecordV (TODO)"
  | OptV o -> "OptV " ^ string_of_opt "(" structured_string_of_value ")" o

let rec structured_string_of_expr = function
  | NumE i -> Int64.to_string i
  | StringE s -> s
  | MinusE e -> "MinusE (" ^ structured_string_of_expr e ^ ")"
  | BinopE (op, e1, e2) ->
      "BinopE ("
      ^ string_of_expr_binop op
      ^ ", "
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | PairE (e1, e2) ->
      "PairE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | AppE (n, nl) ->
      "AppE ("
      ^ structured_string_of_name n
      ^ ", "
      ^ string_of_list structured_string_of_expr "[ " ", " " ]" nl
      ^ ")"
  | MapE (n, nl, iters) ->
      "MapE ("
      ^ structured_string_of_name n
      ^ ", "
      ^ string_of_list structured_string_of_expr "[ " ", " " ]" nl
      ^ ", "
      ^ string_of_iters iters
      ^ ")"
  | ConcatE (e1, e2) ->
      "ConcatE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | LengthE e -> "LengthE (" ^ structured_string_of_expr e ^ ")"
  | ArityE e -> "ArityE (" ^ structured_string_of_expr e ^ ")"
  | GetCurLabelE -> "GetCurLabelE"
  | GetCurFrameE -> "GetCurFrameE"
  | FrameE _ -> "FrameE TODO"
  | ListE el ->
      "ListE ("
      ^ string_of_array structured_string_of_expr "[" ", " "]" el
      ^ ")"
  | ListFillE (e1, e2) ->
      "ListFillE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | AccessE (e, p) ->
      "AccessE ("
      ^ structured_string_of_expr e
      ^ ", "
      ^ structured_string_of_path p
      ^ ")"
  | RecordE _ -> "RecordE (TODO)"
  | ContE e1 -> "ContE (" ^ structured_string_of_expr e1 ^ ")"
  | LabelE (e1, e2) ->
      "LabelE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | NameE (n, iters) ->
      "NameE ("
      ^ structured_string_of_name n
      ^
      ", "
      ^ string_of_iters iters
      ^ ")"
  | ArrowE (e1, e2) ->
      "ArrowE ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | ConstructE (s, el) ->
      "ConstructE (" ^ s ^ ", "
      ^ string_of_list structured_string_of_expr "[" ", " "]" el
      ^ ")"
  | OptE o -> "OptE " ^ string_of_opt "(" structured_string_of_expr ")" o
  | YetE s -> "YetE (" ^ s ^ ")"

and structured_string_of_field (n, e) =
  "(" ^ n ^ ", " ^ structured_string_of_expr e ^ ")"

(* path*)

and structured_string_of_path = function
  | IndexP e -> sprintf "IndexP(%s)" (structured_string_of_expr e)
  | SliceP (e1, e2) ->
      sprintf "SliceP(%s,%s)"
        (structured_string_of_expr e1)
        (structured_string_of_expr e2)
  | DotP s -> sprintf "DotP(%s)" s

(* condition *)

and structured_string_of_cond = function
  | NotC c -> "NotC (" ^ structured_string_of_cond c ^ ")"
  | BinopC (op, c1, c2) ->
      "BinopC ("
      ^ string_of_cond_binop op
      ^ ", "
      ^ structured_string_of_cond c1
      ^ ", "
      ^ structured_string_of_cond c2
      ^ ")"
  | CompareC (op, e1, e2) ->
      "CompareC ("
      ^ string_of_compare_op op
      ^ ", "
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | IsDefinedC e -> "DefinedC (" ^ structured_string_of_expr e ^ ")"
  | IsCaseOfC (e, c) -> "CaseOfC (" ^ structured_string_of_expr e ^ ", " ^ c ^ ")"
  | IsTopC s -> "TopC (" ^ s ^ ")"
  | YetC s -> "YetC (" ^ s ^ ")"

(* instruction *)

let rec structured_string_of_instr depth = function
  | IfI (c, t, e) ->
      "IfI (\n"
      ^ repeat indent (depth + 1)
      ^ structured_string_of_cond c
      ^ "\n" ^ repeat indent depth ^ "then\n"
      ^ structured_string_of_instrs (depth + 1) t
      ^ repeat indent depth ^ "else\n"
      ^ structured_string_of_instrs (depth + 1) e
      ^ repeat indent depth ^ ")"
  | OtherwiseI b ->
      "OtherwiseI (\n"
      ^ structured_string_of_instrs (depth + 1) b
      ^ repeat indent depth ^ ")"
  | WhileI (c, il) ->
      "WhileI (\n"
      ^ repeat indent (depth + 1)
      ^ structured_string_of_cond c
      ^ ":\n"
      ^ structured_string_of_instrs (depth + 1) il
      ^ repeat indent depth ^ ")"
  | EitherI (il1, il2) ->
      "EitherI (\n"
      ^ structured_string_of_instrs (depth + 1) il1
      ^ repeat indent depth ^ "Or\n"
      ^ structured_string_of_instrs (depth + 1) il2
      ^ repeat indent depth ^ ")"
  | ForI (e, il) ->
      "ForI (\n"
      ^ repeat indent (depth + 1)
      ^ structured_string_of_expr e
      ^ ":\n"
      ^ structured_string_of_instrs (depth + 1) il
      ^ repeat indent depth ^ ")"
  | ForeachI (e1, e2, il) ->
      "ForeachI (\n"
      ^ repeat indent (depth + 1)
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ":\n"
      ^ structured_string_of_instrs (depth + 1) il
      ^ repeat indent depth ^ ")"
  | AssertI s -> "AssertI (" ^ s ^ ")"
  | PushI e -> "PushI (" ^ structured_string_of_expr e ^ ")"
  | PopI e -> "PopI (" ^ structured_string_of_expr e ^ ")"
  | PopAllI e -> "PopAllI (" ^ structured_string_of_expr e ^ ")"
  | LetI (n, e) ->
      "LetI ("
      ^ structured_string_of_expr n
      ^ ", "
      ^ structured_string_of_expr e
      ^ ")"
  | TrapI -> "TrapI"
  | NopI -> "NopI"
  | ReturnI e_opt ->
      "ReturnI" ^ string_of_opt " (" structured_string_of_expr ")" e_opt
  | EnterI (e1, e2) ->
      "EnterI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | ExecuteI e -> "ExecuteI (" ^ structured_string_of_expr e ^ ")"
  | ExecuteSeqI e -> "ExecuteSeqI (" ^ structured_string_of_expr e ^ ")"
  | JumpI e -> "JumpI (" ^ structured_string_of_expr e ^ ")"
  | PerformI e -> "PerformI (" ^ structured_string_of_expr e ^ ")"
  | ExitNormalI n -> "ExitNormalI (" ^ structured_string_of_name n ^ ")"
  | ExitAbruptI n -> "ExitAbruptI (" ^ structured_string_of_name n ^ ")"
  | ReplaceI (e1, p, e2) ->
      "ReplaceI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_path p
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | AppendI (e1, p, e2) ->
      "AppendI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_path p
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | AppendListI (e1, p, e2) ->
      "AppendListI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_path p
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ")"
  | ValidI (e1, e2, eo) ->
      "ValidI ("
      ^ structured_string_of_expr e1
      ^ ", "
      ^ structured_string_of_expr e2
      ^ ", "
      ^ "(" ^ string_of_opt "" structured_string_of_expr "" eo ^ ")"
      ^ ")"
  | IsValidI e_opt ->
      "IsValidI" ^ string_of_opt " (" structured_string_of_expr ")" e_opt
  | YetI s -> "YetI " ^ s

and structured_string_of_instrs depth instrs =
  List.fold_left
    (fun acc i ->
      acc ^ repeat indent depth ^ structured_string_of_instr depth i ^ "\n")
    "" instrs

let structured_string_of_algorithm = function
  | Algo (name, params, instrs) ->
      name
      ^ List.fold_left
          (fun acc (p, t) ->
            acc ^ " "
            ^ structured_string_of_expr p
            ^ ":"
            ^ structured_string_of_al_type t)
          "" params
      ^ ":\n"
      ^ structured_string_of_instrs 1 instrs
