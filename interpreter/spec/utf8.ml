exception Utf8

let con n = 0x80 lor (n land 0x3f)

let rec encode ns = Lib.String.implode (List.map Char.chr (encode' ns))
and encode' = function
  | [] -> []
  | n::ns when n < 0 ->
    raise Utf8
  | n::ns when n < 0x80 ->
    n :: encode' ns
  | n::ns when n < 0x800 ->
    0xc0 lor (n lsr 6) :: con n :: encode' ns
  | n::ns when n < 0x10000 ->
    0xe0 lor (n lsr 12) :: con (n lsr 6) :: con n :: encode' ns
  | n::ns when n < 0x110000 ->
    0xf0 lor (n lsr 18) :: con (n lsr 12) :: con (n lsr 6) :: con n
    :: encode' ns
  | _ ->
    raise Utf8

let con b = if b land 0xc0 = 0x80 then b land 0x3f else raise Utf8
let code min n =
  if n < min || (0xd800 <= n && n < 0xe000) || n >= 0x110000 then raise Utf8
  else n

let rec decode s = decode' (List.map Char.code (Lib.String.explode s))
and decode' = function
  | [] -> []
  | b1::bs when b1 < 0x80 ->
    code 0x0 b1 :: decode' bs
  | b1::bs when b1 < 0xc0 ->
    raise Utf8
  | b1::b2::bs when b1 < 0xe0 ->
    code 0x80 ((b1 land 0x1f) lsl 6 + con b2) :: decode' bs
  | b1::b2::b3::bs when b1 < 0xf0 ->
    code 0x800 ((b1 land 0x0f) lsl 12 + con b2 lsl 6 + con b3) :: decode' bs
  | b1::b2::b3::b4::bs when b1 < 0xf8 ->
    code 0x10000 ((b1 land 0x07) lsl 18 + con b2 lsl 12 + con b3 lsl 6 + con b4)
    :: decode' bs
  | _ ->
    raise Utf8
