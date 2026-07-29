module Engine (* : Engine.Engine *) =
struct
  include Instance

  type error = Source.region * string
  type 'a return =
    | Return of 'a
    | Exn of Source.region * taginst * Value.t list
    | Trap of error
    | Exhaustion of error

  let result f x y =
    try Return (f x y) with
    | Eval.Trap (at, msg) -> Trap (at, msg)
    | Eval.Exception (at, Exn.Exn (a, vs)) -> Exn (at, a, vs)
    | Eval.Exhaustion (at, msg) -> Exhaustion (at, msg)

  let guard exns f x y =
    try Some (f x y) with
    | exn when List.mem exn exns -> None

  let validate m =
    try Ok (Valid.check_module m) with
    | Valid.Invalid (at, msg) -> Error (at, msg)

  let validate_with_custom (m, cs) =
    try Ok (Valid.check_module_with_custom (m, cs)) with
    | Valid.Invalid (at, msg) -> Error (at, msg)

  let instantiate m ims =
    try Ok (result Eval.init m ims) with
    | Eval.Link (at, msg) -> Error (at, msg)

  let module_export = Instance.export

  let tag_type = Tag.type_of

  let global_type = Global.type_of
  let global_get = Global.load
  let global_set = Global.store

  let memory_type = Memory.type_of
  let memory_size = Memory.size
  let memory_grow =
    guard Memory.[SizeLimit; SizeOverflow; OutOfMemory] Memory.grow
  let memory_load_byte = guard [Memory.Bounds] Memory.load_byte
  let memory_store_byte m = guard [Memory.Bounds] (Memory.store_byte m)

  let table_type = Table.type_of
  let table_size = Table.size
  let table_grow t =
    guard Table.[SizeLimit; SizeOverflow; OutOfMemory] (Table.grow t)
  let table_get = guard [Table.Bounds] Table.load
  let table_set t = guard [Table.Bounds] (Table.store t)

  let func_type = Func.type_of
  let func_call = result Eval.invoke
end


include Runner.Make (Engine)
