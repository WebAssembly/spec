(* WebAssembly-compatible i64 implementation *)

(* TODO Make this type opaque? *)
type t = int64

val of_int64 : int64 -> t
val to_int64 : t -> int64

val zero : t

val add : t -> t -> t
val sub : t -> t -> t
val mul : t -> t -> t
val div_s : t -> t -> t
val div_u : t -> t -> t
val rem_s : t -> t -> t
val rem_u : t -> t -> t
val and_ : t -> t -> t
val or_ : t -> t -> t
val xor : t -> t -> t
val shl : t -> t -> t
val shr_s : t -> t -> t
val shr_u : t -> t -> t
val clz : t -> t
val ctz : t -> t
val popcnt : t -> t
val eq : t -> t -> bool
val ne : t -> t -> bool
val lt_s : t -> t -> bool
val lt_u : t -> t -> bool
val le_s : t -> t -> bool
val le_u : t -> t -> bool
val gt_s : t -> t -> bool
val gt_u : t -> t -> bool
val ge_s : t -> t -> bool
val ge_u : t -> t -> bool

val of_string : string -> t
val to_string : t -> string
