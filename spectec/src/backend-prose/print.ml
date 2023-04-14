open Ir
open Printf

(* helper functions *)

let indent = "  "

let string_of_list stringifier left sep right = function
  | [] -> left ^ right
  | h :: t ->
      left
      ^ List.fold_left
          (fun acc elem -> acc ^ sep ^ stringifier elem)
          (stringifier h) t
      ^ right

let rec repeat str num =
  if num = 0 then ""
  else if Int.rem num 2 = 0 then repeat (str ^ str) (num / 2)
  else str ^ repeat (str ^ str) (num / 2)

(* structured stringifier *)

(* wasm type *)

let structured_string_of_wtype = function
  | I32T -> "I32T"
  | VarT s -> "VarT " ^ s

(* name *)

let rec structured_string_of_name = function
  | N s -> "N(" ^ s ^ ")"
  | SupN (n, s) -> "SupN(" ^ structured_string_of_name n ^ ", " ^ s ^ ")"
  | SubN (n, s) -> "SubN(" ^ structured_string_of_name n ^ ", " ^ s ^ ")"

(* expression *)

let rec structured_string_of_expr = function
  | ValueE (i) -> "ValueE " ^ string_of_int i
  | MinusE e -> "MinusE (" ^ structured_string_of_expr e ^ ")"
  | AddE (e1, e2) ->
      "AddE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | SubE (e1, e2) ->
      "SubE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | MulE (e1, e2) ->
      "MulE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | DivE (e1, e2) ->
      "DivE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | VecE (e1, e2) ->
      "VecE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | AppE (n, nl) ->
      "AppE (" ^
        structured_string_of_name n ^ ", " ^
        string_of_list structured_string_of_expr "[ " ", " " ]" nl ^ ")"
  | NdAppE (n, nl) ->
      "NdAppE (" ^
        structured_string_of_name n ^ ", " ^
        string_of_list structured_string_of_expr "[ " ", " " ]" nl ^ ")"
  | RangedAppE (n, e1, e2) ->
      "RangedAppE (" ^
        structured_string_of_name n ^ ", " ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | WithAppE (n, e, s) ->
      "WithAppE (" ^
        structured_string_of_name n ^ ", " ^
        structured_string_of_expr e ^ ", " ^
        s ^ ")"
  | ConcatE (e1, e2) ->
      "ConcatE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | LengthE e -> "LengthE (" ^ structured_string_of_expr e ^ ")"
  | ArityE e -> "ArityE (" ^ structured_string_of_expr e ^ ")"
  | FrameE -> "FrameE"
  | BitWidthE expr -> "BitWidthE (" ^ structured_string_of_expr expr ^ ")"
  | PropE (e, s) -> "PropE (" ^ structured_string_of_expr e ^ ", " ^ s ^ ")"
  | ListE el ->
      "ListE (" ^ string_of_list structured_string_of_expr "[" ", " "]" el ^ ")"
  | IndexAccessE (e1, e2) ->
      "IndexAccessE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | SliceAccessE (e1, e2, e3) ->
      "SliceAccessE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ", " ^
        structured_string_of_expr e3 ^ ")"
  | ForWhichE cond -> "ForWhichE (" ^ structured_string_of_cond cond ^ ")"
  | RecordE l ->
      "RecordE (" ^ string_of_list structured_string_of_field "[" ", " "]" l ^ ")"
  | PageSizeE -> "PageSizeE"
  | AfterCallE -> "AfterCallE"
  | ContE e1 -> "ContE (" ^ structured_string_of_expr e1 ^ ")"
  | LabelNthE e1 -> "LabelNthE (" ^ structured_string_of_expr e1 ^ ")"
  | LabelE (e1, e2) ->
      "LabelE (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | NameE n -> "NameE (" ^ structured_string_of_name n ^ ")"
  | ConstE (t, e) ->
      "ConstE (" ^
        structured_string_of_wtype t ^ ", " ^
        structured_string_of_expr e ^ ")"
  | RefNullE n -> "RefNullE (" ^ structured_string_of_name n ^ ")"
  | YetE s -> "YetE (" ^ s ^ ")"

and structured_string_of_field (n, e) =
  "(" ^ structured_string_of_name n ^ ", " ^ structured_string_of_expr e ^ ")"


(* condition *)

and structured_string_of_cond = function
  | NotC c -> "NotC (" ^ structured_string_of_cond c ^ ")"
  | AndC (c1, c2) ->
      "AndC (" ^
        structured_string_of_cond c1 ^ ", " ^
        structured_string_of_cond c2 ^ ")"
  | OrC (c1, c2) ->
      "OrC (" ^
        structured_string_of_cond c1 ^ ", " ^
        structured_string_of_cond c2 ^ ")"
  | EqC (e1, e2) ->
      "EqC (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | GtC (e1, e2) ->
      "GtC (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | GeC (e1, e2) ->
      "GeC (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | LtC (e1, e2) ->
      "LtC (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | LeC (e1, e2) ->
      "LeC (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | DefinedC e -> "DefinedC (" ^ structured_string_of_expr e ^ ")"
  | PartOfC el ->
      "PartOfC (" ^ string_of_list structured_string_of_expr "[" ", " "]" el ^ ")"
  | TopC s -> "TopC (" ^ s ^ ")"
  | YetC s -> "YetC (" ^ s ^ ")"

(* instruction *)

let rec structured_string_of_instr depth = function
  | IfI (c, t, e) ->
      "IfI (\n" ^ repeat indent (depth + 1) ^
        structured_string_of_cond c ^ "\n" ^ repeat indent depth ^ "then\n" ^
        structured_string_of_instrs (depth + 1) t ^ repeat indent depth ^ "else\n" ^
        structured_string_of_instrs (depth + 1) e ^ repeat indent depth ^ ")"
  | WhileI (c, il) ->
      "WhileI (\n" ^ repeat indent (depth + 1) ^
        structured_string_of_cond c ^ ":\n" ^
        structured_string_of_instrs (depth + 1) il ^ repeat indent depth ^ ")"
  | RepeatI (e, il) ->
      "RepeatI (\n" ^
        repeat indent (depth + 1) ^
        structured_string_of_expr e ^ ":\n" ^
        structured_string_of_instrs (depth + 1) il ^
        repeat indent depth ^ ")"
  | EitherI (il1, il2) ->
      "EitherI (\n" ^
        structured_string_of_instrs (depth + 1) il1 ^ repeat indent depth ^ "Or\n" ^
        structured_string_of_instrs (depth + 1) il2 ^ repeat indent depth ^ ")"
  | AssertI s -> "AssertI (" ^ s ^ ")"
  | PushI e -> "PushI (" ^ structured_string_of_expr e ^ ")"
  | PopI None -> "PopI"
  | PopI (Some e) -> "PopI (" ^ structured_string_of_expr e ^ ")"
  | LetI (n, e) ->
      "LetI (" ^ structured_string_of_expr n ^ ", " ^ structured_string_of_expr e ^ ")"
  | TrapI -> "TrapI"
  | NopI -> "NopI"
  | ReturnI -> "ReturnI"
  | InvokeI e -> "InvokeI (" ^ structured_string_of_expr e ^ ")"
  | EnterI (s, e) -> "EnterI (" ^ s ^ ", " ^ structured_string_of_expr e ^ ")"
  | ExecuteI (s, el) ->
      "ExecuteI (" ^
      s ^ ", " ^
      string_of_list structured_string_of_expr "[" ", " "]" el ^ ")"
  | ReplaceI (e1, e2) ->
      "ReplaceI (" ^
        structured_string_of_expr e1 ^ ", " ^
        structured_string_of_expr e2 ^ ")"
  | JumpI e -> "JumpI (" ^ structured_string_of_expr e ^ ")"
  | YetI s -> "YetI " ^ s

and structured_string_of_instrs depth instrs =
  List.fold_left
    (fun acc i ->
      acc ^ repeat indent depth ^ structured_string_of_instr depth i ^ "\n")
    "" instrs

let structured_string_of_program = function
  | Program (name, instrs) -> name ^ ":\n" ^ structured_string_of_instrs 1 instrs

(* IR stringifier *)

let string_of_wtype = function
  | I32T -> "i32"
  | VarT s -> s

let rec string_of_name = function
  | N s -> s
  | SupN (n, "\\ast") -> sprintf "%s*" (string_of_name n)
  | SupN (n, s) -> sprintf "%s^%s" (string_of_name n) s
  | SubN (n, s) -> sprintf "%s_%s" (string_of_name n) s

let rec string_of_expr = function
  | ValueE i -> string_of_int i
  | MinusE e ->
      sprintf "-%s" (string_of_expr e)
  | AddE (e1, e2) ->
      sprintf "(%s + %s)" (string_of_expr e1) (string_of_expr e2)
  | SubE (e1, e2) ->
      sprintf "(%s - %s)" (string_of_expr e1) (string_of_expr e2)
  | MulE (e1, e2) ->
      sprintf "(%s · %s)" (string_of_expr e1) (string_of_expr e2)
  | DivE (e1, e2) ->
      sprintf "(%s / %s)" (string_of_expr e1) (string_of_expr e2)
  | VecE (e1, e2) -> sprintf "%s^%s" (string_of_expr e1) (string_of_expr e2)
  | AppE (n, el) ->
      sprintf "$%s(%s)"
        (string_of_name n)
        (string_of_list string_of_expr "" ", " "" el)
  | NdAppE (n, el) ->
      sprintf "a possible result of computing %s(%s)"
        (string_of_name n)
        (string_of_list string_of_expr "" ", " "" el)
  | RangedAppE (n, e1, e2) ->
      sprintf "the result of computing %s(%s ... %s)"
        (string_of_name n)
        (string_of_expr e1)
        (string_of_expr e2)
  | WithAppE (n, e, s) ->
      sprintf "the result of computing %s(%s with %s)"
        (string_of_name n)
        (string_of_expr e)
        s
  | ConcatE (e1, e2) ->
      sprintf "the concatenation of the two sequences %s and %s"
        (string_of_expr e1)
        (string_of_expr e2)
  | LengthE e -> sprintf "the length of %s" (string_of_expr e)
  | ArityE e -> sprintf "the arity of %s" (string_of_expr e)
  | FrameE -> "the current frame"
  | BitWidthE e -> sprintf "the bit width of %s" (string_of_expr e)
  | PropE (e, s) -> sprintf "%s.%s" (string_of_expr e) s
  | ListE (el) -> string_of_list string_of_expr "[" ", " "]" el
  | IndexAccessE (e1, e2) -> sprintf "%s[%s]" (string_of_expr e1) (string_of_expr e2)
  | SliceAccessE (e1, e2, e3) ->
      sprintf "%s[%s : %s]" (string_of_expr e1) (string_of_expr e2) (string_of_expr e3)
  | ForWhichE c -> sprintf "the constant for which %s" (string_of_cond c)
  | RecordE (fl) ->
      let string_of_field (n, e) =
        sprintf "%s %s" (string_of_name n) (string_of_expr e) in
      sprintf "the instance { %s }"
        (string_of_list string_of_field "" ", " "" fl)
  | PageSizeE -> "the page size"
  | AfterCallE -> "the instruction after the original call that pushed the frame"
  | ContE e -> sprintf "the continuation of %s" (string_of_expr e)
  | LabelNthE e -> sprintf "the %s-th label in the stack" (string_of_expr e)
  | LabelE (e1, e2) ->
      sprintf "the label_%s{%s}" (string_of_expr e1) (string_of_expr e2)
  | NameE n -> string_of_name n
  | ConstE (t, e) ->
      sprintf "the value %s.CONST %s" (string_of_wtype t) (string_of_expr e)
  | RefNullE n -> sprintf "the value ref.null %s" (string_of_name n)
  | YetE s -> sprintf "YetE (%s)" s

and string_of_cond = function
  | NotC (EqC (e1, e2)) -> sprintf "%s is not %s" (string_of_expr e1) (string_of_expr e2)
  | NotC c -> sprintf "not %s" (string_of_cond c)
  | AndC (c1, c2) -> sprintf "%s and %s" (string_of_cond c1) (string_of_cond c2)
  | OrC (c1, c2) -> sprintf "%s or %s" (string_of_cond c1) (string_of_cond c2)
  | EqC (e1, e2) -> sprintf "%s is %s" (string_of_expr e1) (string_of_expr e2)
  | GtC (e1, e2) -> sprintf "%s > %s" (string_of_expr e1) (string_of_expr e2)
  | GeC (e1, e2) -> sprintf "%s ≥ %s" (string_of_expr e1) (string_of_expr e2)
  | LtC (e1, e2) -> sprintf "%s < %s" (string_of_expr e1) (string_of_expr e2)
  | LeC (e1, e2) -> sprintf "%s ≤ %s" (string_of_expr e1) (string_of_expr e2)
  | DefinedC e -> sprintf "%s is defined" (string_of_expr e)
  | PartOfC [e] -> sprintf "%s is part of the instruction" (string_of_expr e)
  | PartOfC [e1; e2] ->
      sprintf "%s and %s are part of the instruction"
        (string_of_expr e1)
        (string_of_expr e2)
  | PartOfC _ -> failwith "Invalid case"
  | TopC s -> sprintf "the top of the stack is %s" s 
  | YetC s -> sprintf "YetC (%s)" s

let make_index index depth =
  index := !index + 1;
  if depth = 0 then string_of_int !index ^ "."
  else if depth = 1 then Char.escaped (Char.chr (96 + !index)) ^ "."
  else if depth = 2 then "i."
  else failwith "Invalid case"

let rec string_of_instr index depth = function
  | IfI (c, il, []) ->
      sprintf "%s If %s, then:%s"
        (make_index index depth)
        (string_of_cond c)
        (string_of_instrs (depth + 1) il)
  | IfI (c, il1, il2) ->
      let if_index = (make_index index depth) in
      let else_index = (make_index index depth) in
      sprintf "%s If %s, then:%s\n%s Else:%s"
        if_index
        (string_of_cond c)
        (string_of_instrs (depth + 1) il1)
        ((repeat indent depth) ^ else_index)
        (string_of_instrs (depth + 1) il2)
  | WhileI (c, il) ->
      sprintf "%s While %s, do:%s"
        (make_index index depth)
        (string_of_cond c)
        (string_of_instrs (depth + 1) il)
  | RepeatI (e, il) ->
      sprintf "%s Repeat %s times:%s"
        (make_index index depth)
        (string_of_expr e)
        (string_of_instrs (depth + 1) il)
  | EitherI (il1, il2) ->
      let either_index = (make_index index depth) in
      let or_index = (make_index index depth) in
      sprintf "%s Either:%s\n%s Or:%s"
        either_index
        (string_of_instrs (depth + 1) il1)
        ((repeat indent depth) ^ or_index)
        (string_of_instrs (depth + 1) il2)
  | AssertI s -> sprintf "%s Assert: %s." (make_index index depth) s
  | PushI e ->
      sprintf "%s Push %s to the stack." (make_index index depth) (string_of_expr e)
  | PopI None -> sprintf "%s Pop a value from the stack." (make_index index depth)
  | PopI (Some e) ->
      sprintf "%s Pop %s from the stack." (make_index index depth) (string_of_expr e) 
  | LetI (n, e) ->
      sprintf "%s Let %s be %s."
        (make_index index depth)
        (string_of_expr n)
        (string_of_expr e)
  | TrapI -> sprintf "%s Trap." (make_index index depth)
  | NopI -> sprintf "%s Do nothing." (make_index index depth)
  | ReturnI -> sprintf "%s Return." (make_index index depth)
  | InvokeI e ->
      sprintf "%s Invoke the function instance at address %s."
        (make_index index depth)
        (string_of_expr e)
  | EnterI (s, e) ->
      sprintf "%s Enter the block %s with label %s."
        (make_index index depth)
        s
        (string_of_expr e)
  | ExecuteI (s, []) ->
      sprintf "%s Execute (%s)." (make_index index depth) s
  | ExecuteI (s, el) ->
      sprintf "%s Execute (%s %s)."
        (make_index index depth)
        s
        (string_of_list string_of_expr "" " " "" el)
  | ReplaceI (e1, e2) ->
      sprintf "%s Replace %s with %s."
        (make_index index depth)
        (string_of_expr e1)
        (string_of_expr e2)
  | JumpI e -> sprintf "%s Jump to %s." (make_index index depth) (string_of_expr e)
  | YetI s -> sprintf "%s YetI: %s." (make_index index depth) s

and string_of_instrs depth instrs =
  let index = ref 0 in
  List.fold_left
    (fun acc i -> acc ^ "\n" ^ repeat indent depth ^ string_of_instr index depth i)
    "" instrs

let string_of_program = function
  | Program (name, instrs) -> "" ^ name ^ string_of_instrs 0 instrs ^ "\n"

