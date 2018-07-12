type memory
type t = memory

type size = int32  (* number of pages *)
type address = int64
type offset = int32

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

type value = Values.value
type value_type = Types.value_type
type 'a limits = 'a Types.limits

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : int64
val mem_size : mem_size -> int

val create : size limits -> memory (* raise SizeOverflow, OutOfMemory *)
val size : memory -> size
val bound : memory -> address
val limits : memory -> size limits
val grow : memory -> size -> unit
  (* raise SizeLimit, SizeOverflow, OutOfMemory *)

val load : memory -> address -> offset -> value_type -> value (* raise Bounds *)
val store : memory -> address -> offset -> value -> unit (* raise Bounds *)
val load_packed :
  mem_size -> extension -> memory -> address -> offset -> value_type -> value
 (* raise Type, Bounds *)
val store_packed : mem_size -> memory -> address -> offset -> value -> unit
 (* raise Type, Bounds *)
val blit : memory -> address -> string -> unit (* raise Bouunds *)

val of_bytes : bytes -> memory
val to_bytes : memory -> bytes

