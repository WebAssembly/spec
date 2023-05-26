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

module FieldName = struct
  type t = string

  let compare = Stdlib.compare
end

module Record = Map.Make (FieldName)

type 'a record = 'a Record.t

(* Wasm value *)
and global_inst = value

(* Wasm value list *)
and table_inst = value

(* Table, Global: Address list *)
and label = int * value list

(* local: Wasm value list, module_inst: ModuleInstV *)
and frame = int * value record

(* global: global_inst list table: table_inst list *)
and store = value record
and stack = value list

(* AL AST *)
and value =
  | LabelV of label
  | FrameV of frame
  | StoreV of store ref
  | ListV of value array
  | WasmTypeV of Types.value_type
  | WasmInstrV of string * value list
  | IntV of int
  | FloatV of float
  | StringV of string
  | PairV of value * value
  | ArrowV of value * value
  | ConstructV of string * value list
  | RecordV of value record
  | OptV of value option
  | WasmModuleV

type name = N of string | SubN of name * string

type iter =
  | Opt (* `?` *)
  | List (* `*` *)
  | List1 (* `+` *)
  | ListN of name (* `^` exp *)

type expr =
  | ValueE of value
  | MinusE of expr
  | AddE of (expr * expr)
  | SubE of (expr * expr)
  | MulE of (expr * expr)
  | DivE of (expr * expr)
  | PairE of (expr * expr)
  | AppE of (name * expr list)
  | MapE of (name * expr list * iter)
  | IterE of (name * iter)
  | ConcatE of (expr * expr)
  | LengthE of expr
  | ArityE of expr
  | GetCurLabelE
  | GetCurFrameE
  | FrameE of (expr * expr)
  | BitWidthE of expr
  | ListFillE of expr * expr
  | ListE of expr array
  | AccessE of (expr * path)
  | ForWhichE of cond
  | RecordE of expr record
  | TupE of expr list
  | PageSizeE
  | AfterCallE
  | ContE of expr
  | LabelNthE of expr
  | LabelE of (expr * expr)
  | WasmInstrE of (string * expr list)
  | NameE of name
  | ArrowE of expr * expr
  | ConstructE of string * expr list (* CaseE? StructE? TaggedE? NamedTupleE? *)
  | OptE of expr option
  (* Wasm Value Expr *)
  | ConstE of expr * expr
  | RefNullE of name
  | RefFuncAddrE of expr
  (* Yet *)
  | YetE of string

and path =
  | IndexP of expr
  | SliceP of expr * expr
  | DotP of string

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
  | CaseOfC of (expr * string)
  | TopC of string
  (* Yet *)
  | YetC of string

type instr =
  | IfI of (cond * instr list * instr list)
  | OtherwiseI of instr list (* This is only for intermideate process durinng il->al *)
  | WhileI of (cond * instr list)
  | RepeatI of (expr * instr list)
  | EitherI of (instr list * instr list)
  | ForI of expr * instr list
  | ForeachI of expr * expr * instr list
  | YieldI of expr
  | AssertI of string
  | PushI of expr
  | PopI of expr
  | PopAllI of expr
  (* change name as a `expr` type *)
  | LetI of (expr * expr)
  | TrapI
  | NopI
  | ReturnI of expr option
  | InvokeI of expr
  | EnterI of (expr * expr)
  | ExecuteI of expr
  | ExecuteSeqI of expr
  | ReplaceI of (expr * path * expr)
  | JumpI of expr
  | PerformI of expr
  | ExitNormalI of name
  | ExitAbruptI of name
  | AppendI of (expr * expr * string)
  (* Yet *)
  | YetI of string

type algorithm = Algo of (string * (expr * al_type) list * instr list)
