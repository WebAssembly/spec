type memory
type t = memory
type address = int64
type size = int64
type offset = int64
type mem_size = Mem8 | Mem16 | Mem32
type extension = SX | ZX
type segment = {addr : address; data : string}
type value_type = Types.value_type
type value = Values.value

exception Type
exception Bounds
exception SizeOverflow
exception SizeLimit

val page_size : size

val create : size -> size option -> memory
val init : memory -> segment list -> unit
val size : memory -> size
val grow : memory -> size -> unit

val load : memory -> address -> offset -> value_type -> value
val store : memory -> address -> offset -> value -> unit
val load_extend :
  memory -> address -> offset -> mem_size -> extension -> value_type -> value
val store_wrap : memory -> address -> offset -> mem_size -> value -> unit

