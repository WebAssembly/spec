(* Expressions *)

type var = Kernel.var

type labeling = labeling' Source.phrase
and labeling' = Unlabelled | Labelled

type target = target' Source.phrase
and target' = Case of var | Case_br of var

type expr = expr' Source.phrase
and expr' =
  | Nop
  | Block of labeling * expr list
  | If of expr * expr
  | If_else of expr * expr * expr
  | Br_if of expr * var
  | Loop of labeling * labeling * expr list
  | Label of expr
  | Br of var * expr option
  | Return of var * expr option
  | Tableswitch of labeling * expr * target list * target * expr list list
  | Call of var * expr list
  | Call_import of var * expr list
  | Call_indirect of var * expr * expr list
  | Get_local of var
  | Set_local of var * expr
  | Load of Kernel.memop * expr
  | Store of Kernel.memop * expr * expr
  | Load_extend of Kernel.extop * expr
  | Store_wrap of Kernel.wrapop * expr * expr
  | Const of Kernel.literal
  | Unary of Kernel.unop * expr
  | Binary of Kernel.binop * expr * expr
  | Select of Kernel.selop * expr * expr * expr
  | Compare of Kernel.relop * expr * expr
  | Convert of Kernel.cvt * expr
  | Unreachable
  | Host of Kernel.hostop * expr list


(* Functions *)

type func = func' Source.phrase
and func' =
{
  ftype : var;
  locals :Types.value_type list;
  body : expr list;
}


(* Modules *)

type module_ = module' Source.phrase
and module' =
{
  memory : Kernel.memory option;
  types : Types.func_type list;
  funcs : func list;
  imports : Kernel.import list;
  exports : Kernel.export list;
  table : var list;
}
