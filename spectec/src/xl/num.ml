type nat = Z.t
type int = Z.t
type rat = Q.t
type real = float

type num =
  | Nat of nat
  | Int of int
  | Rat of rat
  | Real of real

type typ = NatT | IntT | RatT | RealT

type unop = [`PlusOp | `MinusOp]
type binop = [`AddOp | `SubOp | `MulOp | `DivOp | `ModOp | `PowOp]
type cmpop = [`LtOp | `GtOp | `LeOp | `GeOp]


let to_string = function
  | Nat n -> Z.to_string n
  | Int i -> (if i >= Z.zero then "+" else "-") ^ Z.to_string (Z.abs i)
  | Rat q -> Z.to_string (Q.num q) ^ "/" ^ Z.to_string (Q.den q)
  | Real r -> Printf.sprintf "%.17g" r

let string_of_typ = function
  | NatT -> "Nat"
  | IntT -> "Int"
  | RatT -> "Rat"
  | RealT -> "Real"

let string_of_unop = function
  | `PlusOp -> "+"
  | `MinusOp -> "-"

let string_of_binop = function
  | `AddOp -> "+"
  | `SubOp -> "-"
  | `MulOp -> "*"
  | `DivOp -> "/"
  | `ModOp -> "\\"
  | `PowOp -> "^"

let string_of_cmpop = function
  | `LtOp -> "<"
  | `GtOp -> ">"
  | `LeOp -> "<="
  | `GeOp -> ">="


let to_typ = function
  | Nat _ -> NatT
  | Int _ -> IntT
  | Rat _ -> RatT
  | Real _ -> RealT

let typ_unop op t1 t2 : bool =
	match op with
  | `PlusOp | `MinusOp -> t1 = t2 && t1 >= IntT

let typ_binop op t1 t2 t3 : bool =
	match op with
  | `AddOp | `MulOp -> t1 = t2 && t1 = t3
  | `SubOp -> t1 = t2 && t1 >= IntT
  | `DivOp -> t1 = t2 && t1 >= RatT
  | `ModOp -> t1 = t2 && t1 <= IntT
  | `PowOp -> t1 = t3 && (t2 = NatT || t2 = IntT && t1 >= RatT)


let rec cvt typ num : num option =
	let ( let* ) = Option.bind in
  match num, typ with
  | Nat _, NatT -> Some num
  | Nat n, IntT -> Some (Int n)
  | Nat n, RatT -> Some (Rat (Q.of_bigint n))
  | Nat n, RealT -> Some (Real (Z.to_float n))
  | Int i, NatT -> if Z.sign i >= 0 then Some (Nat i) else None
  | Int _, IntT -> Some num
  | Int i, RatT -> Some (Rat (Q.of_bigint i))
  | Int i, RealT -> Some (Real (Z.to_float i))
  | Rat _, NatT -> let* num' = cvt IntT num in cvt typ num'
  | Rat q, IntT -> if Q.den q = Z.one then Some (Int (Q.num q)) else None
  | Rat _, RatT -> Some num
  | Rat q, RealT -> Some (Real (Q.to_float q))
  | Real _, (NatT | IntT) -> let* num' = cvt RatT num in cvt typ num'
  | Real r, RatT -> Some (Rat (Q.of_float r))
  | Real _, RealT -> Some num

let adjust num1 num2 : num * num =
	match num1, num2 with
  | Real _, _ -> num1, Option.get (cvt RealT num2)
  | _, Real _ -> Option.get (cvt RealT num1), num2
  | Rat _, _ -> num1, Option.get (cvt RatT num2)
  | _, Rat _ -> Option.get (cvt RatT num1), num2
  | Int _, _ -> num1, Option.get (cvt IntT num2)
  | _, Int _ -> Option.get (cvt IntT num1), num2
  | Nat _, Nat _ -> num1, num2


let un (op : unop) num : num option =
  Util.Debug_log.(log "xl.num.un"
    (fun _ -> string_of_unop op ^ " " ^ to_string num)
    (function None -> "?" | Some num -> to_string num)
  ) @@ fun _ ->
	match op, num with
  | (`PlusOp | `MinusOp), Nat _ -> None
  | `PlusOp, (Int _ | Rat _ | Real _) -> Some num
  | `MinusOp, Int n -> Some (Int (Z.neg n))
  | `MinusOp, Rat q -> Some (Rat (Q.neg q))
  | `MinusOp, Real r -> Some (Real (-. r))

let rec bin (op : binop) num1 num2 : num option =
  Util.Debug_log.(log "xl.num.bin"
    (fun _ -> to_string num1 ^ " " ^ string_of_binop op ^ " " ^ to_string num2)
    (function None -> "?" | Some num -> to_string num)
  ) @@ fun _ ->
	match op, num1, num2 with
  | `AddOp, Nat n1, Nat n2 -> Some (Nat Z.(n1 + n2))
  | `AddOp, Int i1, Int i2 -> Some (Int Z.(i1 + i2))
  | `AddOp, Rat q1, Rat q2 -> Some (Rat Q.(q1 + q2))
  | `AddOp, Real r1, Real r2 -> Some (Real (r1 +. r2))

  | `SubOp, Nat n1, Nat n2 when n1 >= n2 -> Some (Nat Z.(n1 - n2))
  | `SubOp, Int i1, Int i2 -> Some (Int Z.(i1 - i2))
  | `SubOp, Rat q1, Rat q2 -> Some (Rat Q.(q1 - q2))
  | `SubOp, Real r1, Real r2 -> Some (Real (r1 -. r2))

  | `MulOp, Nat n1, Nat n2 -> Some (Nat Z.(n1 * n2))
  | `MulOp, Int i1, Int i2 -> Some (Int Z.(i1 * i2))
  | `MulOp, Rat q1, Rat q2 -> Some (Rat Q.(q1 * q2))
  | `MulOp, Real r1, Real r2 -> Some (Real (r1 *. r2))

  | `DivOp, Nat n1, Nat n2 when Z.(n2 <> zero && rem n1 n2 = zero) -> Some (Nat Z.(n1 / n2))
  | `DivOp, Int i1, Int i2 when Z.(i2 <> zero && rem i1 i2 = zero) -> Some (Int Z.(i1 / i2))
  | `DivOp, Rat q1, Rat q2 when Q.(q2 <> zero) -> Some (Rat Q.(q1 / q2))
  | `DivOp, Real r1, Real r2 when r2 <> 0.0 -> Some (Real (r1 /. r2))

  | `ModOp, Nat n1, Nat n2 when Z.(n2 <> zero) -> Some (Nat Z.(rem n1 n2))
  | `ModOp, Int i1, Int i2 when Z.(i2 <> zero) -> Some (Int Z.(rem i1 i2))

  | `PowOp, Nat n1, Nat n2 -> Some (Nat Z.(n1 ** to_int n2))
  | `PowOp, Int i1, Int i2 when Z.(i2 >= zero && fits_int i2) -> Some (Int Z.(i1 ** to_int i2))
  | `PowOp, Rat q1, Rat q2 when Q.(q2 >= zero && Z.(equal (den q2) one) && Z.fits_int (num q2)) ->
    Some (Rat Q.(of_bigint Z.(num q1 ** to_int (num q2)) / of_bigint Z.(den q1 ** to_int (num q2))))
  | `PowOp, Rat _, Rat q2 when Q.(q2 < zero) ->
    (match bin op num1 (Rat Q.(- q2)) with
    | Some (Rat q) -> Some (Rat Q.(- q))
    | _ -> None
    )
  | `PowOp, Real r1, Real r2 -> Some (Real Float.(pow r1 r2))

  | _, _, _ -> None

let zero = function
  | NatT -> Nat Z.zero
  | IntT -> Int Z.zero
  | RatT -> Rat Q.zero
  | RealT -> Real 0.0

let one = function
  | NatT -> Nat Z.one
  | IntT -> Int Z.one
  | RatT -> Rat Q.one
  | RealT -> Real 1.0

let is_zero num = num = zero (to_typ num)
let is_one num = num = one (to_typ num)

(*
let left_neutral op num =
	match op with
  | AddOp -> is_zero num
  | MulOp -> is_one num
  | _ -> false

let right_neutral op num =
	match op with
  | AddOp | SubOp -> is_zero num
  | MulOp | DivOp | PowOp -> is_one num
  | _ -> false

let left_absorbing op num =
	match op with
  | MulOp | DivOp | ModOp -> is_zero num
  | PowOp -> is_zero num || is_one num
  | _ -> false

let right_absorbing op num =
	match op with
  | MulOp -> is_zero num
  | _ -> false

let right_zeroing op num =
	match op with
  | ModOp -> is_one num
  | _ -> false

let right_uniting op num =
	match op with
  | PowOp -> is_zero num
  | _ -> false
*)

let bin_partial (op : binop) arg1 arg2 of_ to_ : 'a option =
	match op, of_ arg1, of_ arg2 with
	| op, Some num1, Some num2 ->
	  (match bin op num1 num2 with
	  | Some num -> Some (to_ num)
	  | None -> None
	  )

(*
  | Some num1, None ->
    if left_neutral op num1 then Some arg2 else
    if left_absorbing op num1 then Some arg1 else
    None

  | None, Some num2 ->
    if right_neutral op num2 then Some arg1 else
    if right_absorbing op num2 then Some arg2 else
    if right_zeroing op num2 then Some (to_ (zero (to_typ num2))) else
    if right_uniting op num2 then Some (to_ (one (to_typ num2))) else
    None

  | None, None -> None
*)

  (* neutral elements *)
  | `AddOp, Some num1, _ when is_zero num1 -> Some arg2
  | `MulOp, Some num1, _ when is_one num1 -> Some arg2
  | (`AddOp | `SubOp), _, Some num2 when is_zero num2 -> Some arg1
  | (`MulOp | `DivOp | `PowOp), _, Some num2 when is_one num2 -> Some arg1

  (* absorbing elements *)
  | (`MulOp | `DivOp | `ModOp | `PowOp), Some num1, _ when is_zero num1 -> Some arg1
  | `PowOp, Some num1, _ when is_one num1 -> Some arg1
  | `MulOp, _, Some num2 when is_zero num2 -> Some arg2

  (* collapsing elements *)
  | `ModOp, _, Some num2 when is_one num2 -> Some (to_ (zero (to_typ num2)))
  | `PowOp, _, Some num2 when is_zero num2 -> Some (to_ (one (to_typ num2)))

  | _, _, _ -> None

let cmp (op : cmpop) num1 num2 : bool option =
  Util.Debug_log.(log "xl.num.cmp"
    (fun _ -> to_string num1 ^ " " ^ string_of_cmpop op ^ " " ^ to_string num2)
    (function None -> "?" | Some b -> Bool.to_string b)
  ) @@ fun _ ->
	match op, num1, num2 with
  | `LtOp, Nat n1, Nat n2 -> Some (n1 < n2)
  | `LtOp, Int i1, Int i2 -> Some (i1 < i2)
  | `LtOp, Rat q1, Rat q2 -> Some Q.(q1 < q2)
  | `LtOp, Real r1, Real r2 -> Some (r1 < r2)

  | `GtOp, Nat n1, Nat n2 -> Some (n1 > n2)
  | `GtOp, Int i1, Int i2 -> Some (i1 > i2)
  | `GtOp, Rat q1, Rat q2 -> Some Q.(q1 > q2)
  | `GtOp, Real r1, Real r2 -> Some (r1 > r2)

  | `LeOp, Nat n1, Nat n2 -> Some (n1 <= n2)
  | `LeOp, Int i1, Int i2 -> Some (i1 <= i2)
  | `LeOp, Rat q1, Rat q2 -> Some Q.(q1 <= q2)
  | `LeOp, Real r1, Real r2 -> Some (r1 <= r2)

  | `GeOp, Nat n1, Nat n2 -> Some (n1 >= n2)
  | `GeOp, Int i1, Int i2 -> Some (i1 >= i2)
  | `GeOp, Rat q1, Rat q2 -> Some Q.(q1 >= q2)
  | `GeOp, Real r1, Real r2 -> Some (r1 >= r2)

  | _, _, _ -> None
