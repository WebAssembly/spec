module Set : Set.S with type elt = int32

type t =
{
  types : Set.t;
  globals : Set.t;
  tables : Set.t;
  memories : Set.t;
  funcs : Set.t;
  elems : Set.t;
  datas : Set.t;
  locals : Set.t;
  labels : Set.t;
}

val empty : t
val union : t -> t -> t

val instr : Ast.instr -> t
val block : Ast.instr list -> t
val const : Ast.const -> t

val type_ : Ast.type_ -> t
val global : Ast.global -> t
val func : Ast.func -> t
val table : Ast.table -> t
val memory : Ast.memory -> t
val elem : Ast.elem_segment -> t
val data : Ast.data_segment -> t
val export : Ast.export -> t
val import : Ast.import -> t
val start : Ast.start -> t

val module_ : Ast.module_ -> t

val list : ('a -> t) -> 'a list -> t
