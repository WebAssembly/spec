module FloatPrims(Rep : Floatsig.REP) : Floatsig.FLOAT with type bits = Rep.t = 
struct 
  type t = Rep.t
  type bits = Rep.t

  let nondeterministic_nan = Rep.nondeterministic_nan

  let of_float = Rep.bits_of_float
  let to_float = Rep.float_of_bits
		   
  let of_bits x = x
  let to_bits x = x

  (* Most arithmetic ops that return NaN return a nondeterministic NaN *)
  let arith_of_bits = to_float
  let bits_of_arith f = if f <> f then Rep.nondeterministic_nan else of_float f

  let zero = of_float 0.0

  let add x y = bits_of_arith ((arith_of_bits x) +. (arith_of_bits y))
  let sub x y = bits_of_arith ((arith_of_bits x) -. (arith_of_bits y))
  let mul x y = bits_of_arith ((arith_of_bits x) *. (arith_of_bits y))
  let div x y = bits_of_arith ((arith_of_bits x) /. (arith_of_bits y))

  let sqrt  x = bits_of_arith (Pervasives.sqrt (arith_of_bits x))

  let ceil  x = bits_of_arith (Pervasives.ceil  (arith_of_bits x))
  let floor x = bits_of_arith (Pervasives.floor (arith_of_bits x))

  let trunc x =
    let xf = arith_of_bits x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
    (* trunc is either ceil or floor depending on which one is toward zero *)
    let f = if xf < 0.0 then Pervasives.ceil xf else Pervasives.floor xf in
    bits_of_arith f

  let nearest x =
    let xf = arith_of_bits x in
    (* preserve the sign of zero *)
    if xf = 0.0 then x else
      (* nearest is either ceil or floor depending on which is nearest or even *)
    let u = Pervasives.ceil xf in
    let d = Pervasives.floor xf in
    let um = abs_float (xf -. u) in
    let dm = abs_float (xf -. d) in
    let u_or_d = um < dm || 
                 (um = dm && let h = u /. 2. in Pervasives.floor h = h) in
    let f = if u_or_d then u else d in
    bits_of_arith f

  let min x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* min -0 0 is -0 *)
    if xf = yf then Rep.logor x y else
    if xf < yf then x else
	if xf > yf then y else
	nondeterministic_nan

  let max x y =
    let xf = arith_of_bits x in
    let yf = arith_of_bits y in
    (* max -0 0 is 0 *)
    if xf = yf then Rep.logand x y else
    if xf > yf then x else
	if xf < yf then y else
	nondeterministic_nan

  (* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
  let abs x =
    Rep.logand x Rep.max_int

  let neg x =
    Rep.logxor x Rep.min_int

  let copysign x y =
    Rep.logor (abs x) (Rep.logand y Rep.min_int)

  let eq x y = (arith_of_bits x) =  (arith_of_bits y)
  let ne x y = (arith_of_bits x) <> (arith_of_bits y)
  let lt x y = (arith_of_bits x) <  (arith_of_bits y)
  let gt x y = (arith_of_bits x) >  (arith_of_bits y)
  let le x y = (arith_of_bits x) <= (arith_of_bits y)
  let ge x y = (arith_of_bits x) >= (arith_of_bits y)

  let size = Rep.size

  (* TODO: OCaml's string_of_float and float_of_string are insufficient *)
  let of_string x = of_float (float_of_string x)
  let to_string x = string_of_float (to_float x)
end

