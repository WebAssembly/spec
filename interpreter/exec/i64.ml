(* WebAssembly-compatible i64 implementation *)

include Ixx.Make
  (struct
    let bitwidth = 64
    include Int64
    let of_int64 = Fun.id
    let to_int64 = Fun.id
    let to_hex_string = Printf.sprintf "%Lx"
  end)

open Stdint

let to_i128 lo hi =
  let lo = Int128.of_uint64 (Uint64.of_int64 lo) in
  let hi = Int128.of_uint64 (Uint64.of_int64 hi) in
  Int128.logor lo (Int128.shift_left hi 64)

let split_i128 v =
  let lo = Int64.of_int128 v in
  let hi = Int64.of_int128 (Int128.shift_right v 64) in
  (lo, hi)

let add128 a b c d = split_i128 (Int128.add (to_i128 a b) (to_i128 c d))
let sub128 a b c d = split_i128 (Int128.sub (to_i128 a b) (to_i128 c d))

let mul_wide_s a b = split_i128 (Int128.mul (Int128.of_int64 a) (Int128.of_int64 b))
let mul_wide_u a b =
  let a = Uint64.of_int64 a in
  let b = Uint64.of_int64 b in
  let c = Uint128.mul (Uint128.of_uint64 a) (Uint128.of_uint64 b) in
  split_i128 (Int128.of_uint128 c)
