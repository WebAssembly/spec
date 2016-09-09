type memory
type t = memory

type size = int32  (* number of pages *)
type address = int64
type offset = int64

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

val page_size : offset
val mem_size : mem_size -> int

val create : size limits -> memory (* raise SizeOverflow, OutOfMemory *)
val size : memory -> size
val limits : memory -> size limits
val grow : memory -> size -> unit (* raise SizeOverflow, OutOfMemory *)

val load : memory -> address -> offset -> value_type -> value
val store : memory -> address -> offset -> value -> unit
val load_packed :
  mem_size -> extension -> memory -> address -> offset -> value_type -> value
val store_packed : mem_size -> memory -> address -> offset -> value -> unit
val blit : memory -> address -> string -> unit

