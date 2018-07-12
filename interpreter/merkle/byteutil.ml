
open Values

let trace name = if !Flags.trace then print_endline ("-- " ^ name)

let w256_to_string bs =
  let res = ref "" in
  for i = 0 to String.length bs - 1 do
    let code = Char.code (String.get bs i) in
    res := !res ^ (if code < 16 then "0" else "") ^ Printf.sprintf "%x" code
  done;
  !res

let bytes_to_hex bs =
  let res = ref "" in
  for i = 0 to Bytes.length bs - 1 do
    let code = Char.code (Bytes.get bs i) in
    res := !res ^ (if code < 16 then "0" else "") ^ Printf.sprintf "%x" code
  done;
  !res

let w256_to_int w =
  let res = ref 0 in
  for i = 0 to 8 do
    res := !res*256;
    res := !res + Char.code w.[i];
  done;
  !res

let from_hex str =
  let res = ref "" in
  for i = 0 to 31 do
    res := !res ^ String.make 1 (Char.chr (int_of_string ("0x" ^ String.sub str (i*2) 2)))
  done;
  !res

let bytes_from_hex str = Bytes.of_string (from_hex str)

let get_bytes_from_hex str =
  let res = ref "" in
  for i = 0 to String.length str/2 - 1 do
    res := !res ^ String.make 1 (Char.chr (int_of_string ("0x" ^ String.sub str (i*2) 2)))
  done;
  Bytes.of_string !res

let bytes32_to_int w =
  let res = ref 0 in
  for i = 0 to 31 do
    res := !res*256;
    res := !res + Char.code (Bytes.get w i);
  done;
  !res

let w256_to_value w =
  (* should have a tag for value *)
  I32 (Int32.of_int (w256_to_int w))

module Decode = struct

(* Decoding stream *)

type stream =
{
  bytes : string;
  pos : int ref;
}

exception EOS

let stream bs = {bytes = bs; pos = ref 0}

let len s = String.length s.bytes
let pos s = !(s.pos)
let eos s = (pos s = len s)

let check n s = if pos s + n > len s then raise EOS
let skip n s = check n s; s.pos := !(s.pos) + n

let read s = if !(s.pos) < len s then Char.code (String.get s.bytes (!(s.pos))) else 0
let peek s = if eos s then None else Some (read s)

(* let get s = check 1 s; let b = read s in skip 1 s; b *)
let get s =
  let b = read s in
  skip 1 s; b

let get_string n s = let i = pos s in skip n s; String.sub s.bytes i n

let u8 s = get s

let u16 s =
  let lo = u8 s in
  let hi = u8 s in
  hi lsl 8 + lo

let u32 s =
  let lo = Int32.of_int (u16 s) in
  let hi = Int32.of_int (u16 s) in
  Int32.(add lo (shift_left hi 16))

let u64 s =
  let lo = I64_convert.extend_u_i32 (u32 s) in
  let hi = I64_convert.extend_u_i32 (u32 s) in
  Int64.(add lo (shift_left hi 32))

let mini_memory bytes =
  let s = stream (Bytes.to_string (Memory.to_bytes bytes)) in
(*  trace ("Get memory: " ^ w256_to_string (Memory.to_bytes bytes)); *)
  let a = u64 s and b = u64 s in
(*  trace ("A: " ^ Int64.to_string a); *)
  (a, b)

let word bytes =
  let s = stream bytes in
  skip 24 s;
  (* so these words have different endian *)
  let res = ref 0L in
  for i = 0 to 7 do
    ignore i;
    res := Int64.(add (mul !res 256L) (of_int (u8 s)))
  done;
  !res

let bytes_to_array bytes =
  let s = stream (Bytes.to_string bytes) in
  let res = Array.make (Bytes.length bytes) 0L in
  for i = 0 to Bytes.length bytes / 8 do
    res.(i) <- u64 s
  done;
  res

end

(* Encoding *)

type stream = {
  buf : Buffer.t;
  patches : (int * char) list ref
}

let stream () = {buf = Buffer.create 8192; patches = ref []}
let pos s = Buffer.length s.buf
let put s b = Buffer.add_char s.buf b
let put_string s bs = Buffer.add_string s.buf bs
let patch s pos b = s.patches := (pos, b) :: !(s.patches)

let to_bytes s =
  let bs = Buffer.to_bytes s.buf in
  List.iter (fun (pos, b) -> Bytes.set bs pos b) !(s.patches);
  s.patches := [];
  Buffer.clear s.buf;
  bs

let s = stream ()

    let u8 i = put s (Char.chr (i land 0xff))
    let u16 i = u8 (i land 0xff); u8 (i lsr 8)
    let u32 i =
      Int32.(u16 (to_int (logand i 0xffffl));
             u16 (to_int (shift_right i 16)))
    let u64 i =
      Int64.(u32 (to_int32 (logand i 0xffffffffL));
             u32 (to_int32 (shift_right i 32)))

    let rec vu64 i =
      let b = Int64.(to_int (logand i 0x7fL)) in
      if 0L <= i && i < 128L then u8 b
      else (u8 (b lor 0x80); vu64 (Int64.shift_right_logical i 7))

    let rec vs64 i =
      let b = Int64.(to_int (logand i 0x7fL)) in
      if -64L <= i && i < 64L then u8 b
      else (u8 (b lor 0x80); vs64 (Int64.shift_right i 7))

    let vu1 i = vu64 Int64.(logand (of_int i) 1L)
    let vu32 i = vu64 Int64.(logand (of_int32 i) 0xffffffffL)
    let vs7 i = vs64 (Int64.of_int i)
    let vs32 i = vs64 (Int64.of_int32 i)
    let f64 x = u64 (F64.to_bits x)

let f32 x = u64 (Int64.of_int32 (F32.to_bits x))


let extend bs n =
  let nbs = Bytes.make n (Char.chr 0) in
  let len = Bytes.length bs in
  for i = 0 to len-1 do
    Bytes.set nbs (n-1-i) (Bytes.get bs i)
  done;
(*  Bytes.blit bs 0 nbs (n-len) len; *)
  Bytes.to_string nbs

let value = function
  | I32 i -> u32 i
(*  | I32 i -> u64 (Int64.of_int32 i) *)
  | I64 i -> u64 i
  | F32 i -> f32 i
  | F64 i -> f64 i

let get_value v =
  value v;
  extend (to_bytes s) 32

let get_value8 v =
  value v;
  extend (to_bytes s) 8

let mini_memory_v a b =
  value a;
  value b;
  let bs = to_bytes s in
(*  trace ("Making mem: " ^ w256_to_string bs); *)
  Memory.of_bytes bs

let mini_memory a b =
  u64 a;
  u64 b;
  let bs = to_bytes s in
  Memory.of_bytes bs

open Types

let type_code = function
 | I32Type -> 0
 | I64Type -> 1
 | F32Type -> 2
 | F64Type -> 3

(* generate hash for a type *)
let ftype_hash (FuncType (par, ret)) =
  let hash = Cryptokit.Hash.keccak 256 in
  List.iter (fun i -> hash#add_byte (type_code i)) par;
  hash#add_byte 0xff;
  List.iter (fun i -> hash#add_byte (type_code i)) ret;
  Decode.word hash#result



