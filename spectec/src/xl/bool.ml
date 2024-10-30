type unop = [`NotOp]
type binop = [`AndOp | `OrOp | `ImplOp | `EquivOp]
type cmpop = [`EqOp | `NeOp]

let to_string = string_of_bool

let string_of_unop = function
  | `NotOp -> "~"

let string_of_binop = function
  | `AndOp -> "/\\"
  | `OrOp -> "\\/"
  | `ImplOp -> "=>"
  | `EquivOp -> "<=>"

let string_of_cmpop = function
  | `EqOp -> "="
  | `NeOp -> "=/="

let un (op : unop) b : bool =
  match op with
  | `NotOp -> not b

let bin (op : binop) b1 b2 : bool =
  match op with
  | `AndOp -> b1 && b2
  | `OrOp -> b1 || b2
  | `ImplOp -> not b1 || b2
  | `EquivOp -> b1 = b2

let bin_partial (op : binop) arg1 arg2 of_ to_ : 'a option =
  match op, of_ arg1, of_ arg2 with
  | op, Some b1, Some b2 -> Some (to_ (bin op b1 b2))
  | `AndOp, Some b1, None -> Some (if b1 then arg2 else arg1)
  | `AndOp, None, Some b2 -> Some (if b2 then arg1 else arg2)
  | `OrOp, Some b1, None -> Some (if b1 then arg1 else arg2)
  | `OrOp, None, Some b2 -> Some (if b2 then arg2 else arg1)
  | `ImplOp, Some b1, None -> Some (if b1 then arg2 else to_ true)
  | `ImplOp, None, Some b2 -> if b2 then Some arg2 else None
  | `EquivOp, Some b1, None -> if b1 then Some arg2 else None
  | `EquivOp, None, Some b2 -> if b2 then Some arg1 else None
  | _, None, None -> None

let cmp (op : cmpop) x1 x2 : bool =
  match op with
  | `EqOp -> x1 = x2
  | `NeOp -> x1 <> x2
