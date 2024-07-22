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

val num_type : Types.num_type -> t
val vec_type : Types.vec_type -> t
val ref_type : Types.ref_type -> t
val val_type : Types.val_type -> t

val func_type : Types.func_type -> t
val global_type : Types.global_type -> t
val table_type : Types.table_type -> t
val memory_type : Types.memory_type -> t
val tag_type : Types.tag_type -> t
val extern_type : Types.extern_type -> t

val str_type : Types.str_type -> t
val sub_type : Types.sub_type -> t
val rec_type : Types.rec_type -> t
val def_type : Types.def_type -> t

val instr : Ast.instr -> t
val block : Ast.instr list -> t
val const : Ast.const -> t

val type_ : Ast.type_ -> t
val global : Ast.global -> t
val func : Ast.func -> t
val table : Ast.table -> t
val memory : Ast.memory -> t
val tag : Ast.tag -> t
val elem : Ast.elem_segment -> t
val data : Ast.data_segment -> t
val export : Ast.export -> t
val import : Ast.import -> t
val start : Ast.start -> t

val module_ : Ast.module_ -> t

val opt : ('a -> t) -> 'a option -> t
val list : ('a -> t) -> 'a list -> t
