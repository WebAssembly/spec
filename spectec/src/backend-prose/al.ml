open Reference_interpreter

(* AL Type *)

type al_type =
  | WasmValueT of Types.value_type
  | WasmValueTopT
  | EmptyListT
  | ListT of al_type
  | FunT of (al_type list * al_type)
  | IntT
  | AddrT
  | StringT
  | FrameT
  | StoreT
  | StateT
  | TopT

(* Wasm Data Structures *)

type global_inst = Values.value

type table_inst = Values.value list

type module_inst = { globaladdr: value list; tableaddr: value list }

and frame = { local: Values.value list; moduleinst: module_inst  }

and stack_elem =
  | ValueS of Values.value
  | FrameS of frame

and stack = stack_elem list

and store = { global: global_inst list; table: table_inst list }

(* AL AST *)

and value =
  | FrameV of frame
  | StoreV
  | ModuleInstV of module_inst
  | ListV of value list
  | WasmV of Values.value
  | WasmTypeV of Types.value_type
  | IntV of int
  | FloatV of float
  | StringV of string

type name = N of string | SubN of name * string

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of name                 (* `^` exp *)

type expr =
  | ValueE of value
  | MinusE of expr
  | AddE of (expr * expr)
  | SubE of (expr * expr)
  | MulE of (expr * expr)
  | DivE of (expr * expr)
  | PairE of (expr * expr)
  | AppE of (name * expr list)
  | NdAppE of (name * expr list)
  | RangedAppE of (name * expr * expr)
  | WithAppE of (name * expr * string)
  | IterE of (name * iter)
  | ConcatE of (expr * expr)
  | LengthE of expr
  | ArityE of expr
  | FrameE
  | BitWidthE of expr
  | PropE of (expr * string)
  | ListE of expr list
  | IndexAccessE of (expr * expr)
  | SliceAccessE of (expr * expr * expr)
  | ForWhichE of cond
  | RecordE of (string * expr) list
  | PageSizeE
  | AfterCallE
  | ContE of expr
  | LabelNthE of expr
  | LabelE of (expr * expr)
  | NameE of name
  (* Wasm Value Expr *)
  | ConstE of expr * expr
  | RefNullE of name
  | RefFuncAddrE of expr
  (* Yet *)
  | YetE of string

and cond =
  | NotC of cond
  | AndC of (cond * cond)
  | OrC of (cond * cond)
  | EqC of (expr * expr)
  | GtC of (expr * expr)
  | GeC of (expr * expr)
  | LtC of (expr * expr)
  | LeC of (expr * expr)
  | DefinedC of expr
  | PartOfC of expr list
  | TopC of string
  (* Yet *)
  | YetC of string

type instr =
  | IfI of (cond * instr list * instr list)
  | OtherwiseI of (instr list) (* This is only for intermideate process durinng il->al *)
  | WhileI of (cond * instr list)
  | RepeatI of (expr * instr list)
  | EitherI of (instr list * instr list)
  | AssertI of string
  | PushI of expr
  | PopI of expr
  (* change name as a `expr` type *)
  | LetI of (expr * expr)
  | TrapI
  | NopI
  | ReturnI of (expr option)
  | InvokeI of expr
  | EnterI of (string * expr)
  | ExecuteI of (string * expr list)
  | ReplaceI of (expr * expr)
  | JumpI of expr
  | PerformI of expr
  (* Yet *)
  | YetI of string

type algorithm = Algo of (string * (expr * al_type) list * instr list)
