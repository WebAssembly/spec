type al_type =
  | WasmValueT of Reference_interpreter.Types.value_type
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

type value =
  | WasmV of Reference_interpreter.Values.value
  | IntV of int

type name = N of string | NN of string * string | SubN of name * string

type wasm_type_expr =
  | WasmTE of Reference_interpreter.Types.value_type
  | VarTE of string

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of name                 (* `^` exp *)

type expr =
  | ValueE of int
  | MinusE of expr
  | AddE of (expr * expr)
  | SubE of (expr * expr)
  | MulE of (expr * expr)
  | DivE of (expr * expr)
  | VecE of (expr * expr)
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
  | ConstE of wasm_type_expr * expr
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

type algorithm = Algo of (string * (name * al_type) list * instr list)
