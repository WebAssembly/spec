module Set : Set.S with type elt = int32

type t =
{
  types : Set.t;
  globals : Set.t;
  tables : Set.t;
  memories : Set.t;
  tags : Set.t;
  funcs : Set.t;
  elems : Set.t;
  datas : Set.t;
  locals : Set.t;
  labels : Set.t;
}

val empty : t
val union : t -> t -> t

val numtype : Types.numtype -> t
val vectype : Types.vectype -> t
val reftype : Types.reftype -> t
val valtype : Types.valtype -> t

val functype : Types.functype -> t
val globaltype : Types.globaltype -> t
val tabletype : Types.tabletype -> t
val memorytype : Types.memorytype -> t
val tagtype : Types.tagtype -> t
val externtype : Types.externtype -> t

val comptype : Types.comptype -> t
val subtype : Types.subtype -> t
val rectype : Types.rectype -> t
val deftype : Types.deftype -> t

val instr : Ast.instr -> t
val block : Ast.instr list -> t
val const : Ast.const -> t

val type_ : Ast.type_ -> t
val global : Ast.global -> t
val func : Ast.func -> t
val table : Ast.table -> t
val memory : Ast.memory -> t
val tag : Ast.tag -> t
val elem : Ast.elem -> t
val data : Ast.data -> t
val export : Ast.export -> t
val import : Ast.import -> t
val start : Ast.start -> t

val module_ : Ast.module_ -> t

val opt : ('a -> t) -> 'a option -> t
val list : ('a -> t) -> 'a list -> t
