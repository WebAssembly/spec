type memory
type t = memory

type size = int32  (* number of pages *)
type address = int64
type offset = int64

type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX

type value = Values.value
type value_type = Types.value_type

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit
exception OutOfMemory

val page_size : offset

val mem_size : mem_size -> int

val create : size -> size option -> memory (* raise SizeOverflow, OutOfMemory *)
val size : memory -> size
val grow : memory -> size -> unit (* raise SizeOverflow, OutOfMemory *)

val load : memory -> address -> offset -> value_type -> value
val store : memory -> address -> offset -> value -> unit
val load_extend :
  memory -> address -> offset -> mem_size -> extension -> value_type -> value
val store_wrap : memory -> address -> offset -> mem_size -> value -> unit
val blit : memory -> address -> string -> unit

