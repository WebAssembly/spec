open Reference_interpreter

(* AL Type *)

type al_type =
  | WasmValueT of Types.value_type
  | WasmValueTopT
  | PairT of al_type * al_type
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

type 'a growable_array = 'a array ref

type 'a record = (string * 'a ref) list

and store = value record
and stack = value list

(* AL AST *)
and value =
  | NumV of int64
  | StringV of string
  | ListV of value growable_array
  | RecordV of value record
  | ConstructV of string * value list
  | OptV of value option
  | PairV of value * value
  | ArrowV of value * value
  | FrameV of value * value
  | LabelV of value * value
  | StoreV of store ref

type name = N of string | SubN of name * string

type iter =
  | Opt
  | List
  | List1
  | ListN of name

type expr_binop =
  | Add
  | Sub
  | Mul
  | Div
  | Exp

type cond_binop =
  | And
  | Or
  | Impl
  | Equiv

type compare_op =
  | Eq
  | Ne
  | Gt
  | Ge
  | Lt
  | Le

type expr =
  (* Value *)
  | NumE of int64
  | StringE of string
  (* Numeric Operation *)
  | MinusE of expr
  | BinopE of expr_binop * expr * expr
  (* Function Call *)
  | AppE of name * expr list
  | MapE of name * expr list * iter list
  (* Data Structure *)
  | ListE of expr list
  | ListFillE of expr * expr
  | ConcatE of expr * expr
  | LengthE of expr
  | RecordE of expr record
  | AccessE of expr * path
  | ConstructE of string * expr list (* CaseE? StructE? TaggedE? NamedTupleE? *)
  | OptE of expr option
  | PairE of expr * expr
  | ArrowE of expr * expr
  (* Context *)
  | ArityE of expr
  | FrameE of expr * expr
  | GetCurFrameE
  | LabelE of expr * expr
  | GetCurLabelE
  | GetCurContextE
  | ContE of expr
  (* Name *)
  | NameE of name * iter list
  (* Yet *)
  | YetE of string

and path =
  | IndexP of expr
  | SliceP of expr * expr
  | DotP of string

and cond =
  | NotC of cond
  | BinopC of cond_binop * cond * cond
  | CompareC of compare_op * expr * expr
  | IsDefinedC of expr
  | IsCaseOfC of expr * string
  | IsTopC of string
  | ValidC of expr
  (* Yet *)
  | YetC of string

type instr =
  | IfI of cond * instr list * instr list
  | OtherwiseI of instr list (* This is only for intermideate process durinng il->al *)
  | WhileI of cond * instr list
  | EitherI of instr list * instr list
  | ForI of expr * instr list
  | ForeachI of expr * expr * instr list
  | AssertI of string
  | PushI of expr
  | PopI of expr
  | PopAllI of expr
  (* change name as a `expr` type *)
  | LetI of expr * expr
  | TrapI
  | NopI
  | ReturnI of expr option
  | EnterI of expr * expr
  | ExecuteI of expr
  | ExecuteSeqI of expr
  | JumpI of expr
  | PerformI of expr
  | ExitNormalI of name
  | ExitAbruptI of name
  (* Mutations *)
  | ReplaceI of expr * path * expr
  | AppendI of expr * expr
  | AppendListI of expr * expr
  (* Yet *)
  | YetI of string

type algorithm = Algo of string * (expr * al_type) list * instr list

(* Smart Constructor *)
let singleton x = ConstructV (x, [])
let listV l = ListV (l |> Array.of_list |> ref)
let id str = NameE (N str, [])
