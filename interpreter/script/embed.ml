type module_ = Ast.module_
type value = Value.value
type ref_ = Value.ref_

module type Engine =
sig
  type moduleinst
  type taginst
  type globalinst
  type memoryinst
  type tableinst
  type funcinst

  type externinst =
    | ExternTag of taginst
    | ExternGlobal of globalinst
    | ExternMemory of memoryinst
    | ExternTable of tableinst
    | ExternFunc of funcinst

  type error = Source.region * string
  type 'a return =
    | Return of 'a
    | Exn of Source.region * taginst * value list
    | Trap of error
    | Exhaustion of error

  val validate : module_ -> (Types.moduletype, error) result
  val validate_with_custom :
    module_ * Custom.section list -> (Types.moduletype, error) result
  val instantiate :
    module_ -> externinst list -> (moduleinst return, error) result

  val module_export : moduleinst -> Ast.name -> externinst option

  val tag_type : taginst -> Types.tagtype

  val global_type : globalinst -> Types.globaltype
  val global_get : globalinst -> value
  val global_set : globalinst -> value -> unit

  val memory_type : memoryinst -> Types.memorytype
  val memory_size : memoryinst -> int64
  val memory_grow : memoryinst -> int64 -> unit option
  val memory_load_byte : memoryinst -> int64 -> int option
  val memory_store_byte : memoryinst -> int64 -> int -> unit option

  val table_type : tableinst -> Types.tabletype
  val table_size : tableinst -> int64
  val table_grow : tableinst -> int64 -> ref_ -> unit option
  val table_get : tableinst -> int64 -> ref_ option
  val table_set : tableinst -> int64 -> ref_ -> unit option

  val func_type : funcinst -> Types.deftype
  val func_call : funcinst -> value list -> value list return
end
