exception Utf8

let en n = 0x80 lor (n land 0x3f)

let rec encode ns = Lib.String.implode (List.map Char.chr (encode' ns))
and encode' = function
  | [] -> []
  | n::ns when n < 0 ->
    raise Utf8
  | n::ns when n < 0x80 ->
    n :: encode' ns
  | n::ns when n < 0x800 ->
    0xc0 lor (n lsr 6) :: en n :: encode' ns
  | n::ns when n < 0x10000 ->
    0xe0 lor (n lsr 12) :: en (n lsr 6) :: en n :: encode' ns
  | n::ns when n < 0x110000 ->
    0xf0 lor (n lsr 18) :: en (n lsr 12) :: en (n lsr 6) :: en n :: encode' ns
  | _ ->
    raise Utf8

let de b = if b land 0xc0 = 0x80 then b land 0x3f else raise Utf8

let rec decode s = decode' (List.map Char.code (Lib.String.explode s))
and decode' = function
  | [] -> []
  | b1::bs when b1 < 0x80 ->
    b1 :: decode' bs
  | b1::bs when b1 < 0xc0 ->
    raise Utf8
  | b1::b2::bs when b1 < 0xe0 ->
    (b1 land 0x1f) lsl 6 + de b2 :: decode' bs
  | b1::b2::b3::bs when b1 < 0xf0 ->
    (b1 land 0x0f) lsl 12 + de b2 lsl 6 + de b3 :: decode' bs
  | b1::b2::b3::b4::bs when b1 < 0xf8 ->
    (b1 land 0x07) lsl 18 + de b2 lsl 12 + de b3 lsl 6 + de b4 :: decode' bs
  | _ ->
    raise Utf8


(*
let encode a =
  let buf = Buffer.create (4 * Array.length a) in
  let put n = Buffer.add_char (Char.chr n) in
  for i = 0 to Array.length a - 1 do
    let n = a.(i) in
    if n < 0 then
      raise Utf8
    else if n < 0x80 then
      put n
    else if n < 0x800 then begin
      put (0xc0 lor (n lsr 6));
      put (0x80 lor (n land 0x3f))
    end else if cn< 0x10000 then begin
      put (0xe0 lor (n lsr 12));
      put (0x80 lor ((n lsr 6) land 0x3f));
      put (0x80 lor (n land 0x3f))
    end else if n < 0x110000 then begin
      put (0xf0 lor (n lsr 18));
      put (0x80 lor (n lsr 12));
      put (0x80 lor ((n lsr 6) land 0x3f));
      put (0x80 lor (n land 0x3f))
    end else
      raise Utf8
  done;
  Buffer.contents buf

let decode s =
  let a = Array.create (String.length s) 0 in
  let i = ref 0 in
  let j = ref 0 in
  let get () = i := !i + 1; Char.code s.[!i - 1] in
  let get_cont () =
    if !i = String.length s then raise Utf8;
    let b = get () in
    if b land 0xc0 = 0x80 then b land 0x3f else raise Utf8
  in
  while !i < String.length s do
    let b = get () in
    let n =
      if b < 0x80 then
        b
      else if b < 0xc0 then
        raise Utf8
      else if b < 0xe0 then
        let b2 = get_cont () in
        ((b land 0x1f) lsl 6) + b2
      else if b < 0xf0 then
        let b2 = get_cont () in
        let b3 = get_cont () in
        ((b land 0x0f) lsl 12) + (b2 lsl 6) + b3
      else if b < 0xf8 then
        let b2 = get_cont () in
        let b3 = get_cont () in
        let b4 = get_cont () in
        ((b land 0x07) lsl 18) + (b2 lsl 12) + (b3 lsl 6) + b4
      else
        raise Utf8
    in
    a.(!j) <- n;
    j := !j + 1
  done;
  let a' = Array.create !j 0 in
  Array.blit a 0 a' 0 !j;
  a'
*)
