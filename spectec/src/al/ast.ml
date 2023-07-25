include Record

(* AL Type *)

type al_type =
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

type extend_dir =
  | Front
  | Back

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

type iter =
  | Opt
  | List
  | List1
  | ListN of name
  | IndexedListN of name * expr

and expr =
  (* Value *)
  | NumE of int64
  | StringE of string
  (* Numeric Operation *)
  | MinusE of expr
  | BinopE of expr_binop * expr * expr
  (* Function Call *)
  | AppE of name * expr list
  (* Data Structure *)
  | ListE of expr list
  | ListFillE of expr * expr
  | ConcatE of expr * expr
  | LengthE of expr
  | RecordE of expr record
  | AccessE of expr * path
  | ExtendE of expr * path list * expr * extend_dir
  | ReplaceE of expr * path list * expr
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
  | NameE of name
  | IterE of expr * name list * iter
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
  | ContextKindC of string * expr
  | IsDefinedC of expr
  | IsCaseOfC of expr * string
  | ValidC of expr
  (* Conditions used in assertions *)
  | TopLabelC
  | TopFrameC
  | TopValueC of expr option
  | TopValuesC of expr
  (* Yet *)
  | YetC of string

type instr =
  (* Nested instructions *)
  | IfI of cond * instr list * instr list
  | OtherwiseI of instr list (* This is only for intermideate process durinng il->al *)
  | WhileI of cond * instr list
  | EitherI of instr list * instr list
  | ForI of expr * instr list
  | ForeachI of expr * expr * instr list
  (* Flat instructions *)
  | AssertI of cond
  | PushI of expr
  | PopI of expr
  | PopAllI of expr
  | LetI of expr * expr
  | CallI of expr * name * expr list * (name list * iter) list
  | TrapI
  | NopI
  | ReturnI of expr option
  | EnterI of expr * expr
  | ExecuteI of expr
  | ExecuteSeqI of expr
  | JumpI of expr
  | PerformI of name * expr list
  | ExitNormalI of name
  | ExitAbruptI of name
  (* Mutations *)
  | ReplaceI of expr * path * expr
  | AppendI of expr * expr
  | AppendListI of expr * expr
  (* Yet *)
  | YetI of string

type algorithm = Algo of string * expr list * instr list

(* Smart Constructor *)
let singleton x = ConstructV (x, [])
let listV l = ListV (l |> Array.of_list |> ref)
let id str = NameE (N str)

module Value = struct
  let num i = NumV i
  let string_ s = StringV s
  let list_ l = ListV (Array.of_list l |> ref)
  let record r = RecordV r
  let construct tag args = ConstructV (tag, args)
  let opt v = OptV (Some v)
  let nont = OptV None
  let pair v1 v2 = PairV (v1, v2)
  let arrow v1 v2 = ArrowV (v1, v2)
  let frame arity v = FrameV (arity, v)
  let label arity v = LabelV (arity, v)
  let store store_ref = StoreV store_ref
end

module Expr = struct
  let num i = NumE i
  let string_ s = StringE s
  let minus e = MinusE e
  let binop binop e1 e2 = BinopE (binop, e1, e2)
  let app fname args = AppE (fname, args)
  let list_ el = ListE el
  let list_fill e time = ListFillE (e, time)
  let concat e1 e2 = ConcatE (e1, e2)
  let length e = LengthE e
  let record r = RecordE r
  let access e path = AccessE (e, path)
  let extend target paths e direction =
    ExtendE (target, paths, e, direction)
  let replace target paths e = ReplaceE(target, paths, e)
  let construct tag args = ConstructE (tag, args)
  let opt e = OptE (Some e)
  let none = OptE None
  let pair e1 e2 = PairE (e1, e2)
  let arrow e1 e2 = ArrowE (e1, e2)
  let arity e = ArityE e
  let frame arity e = FrameE (arity, e)
  let get_cur_frame = GetCurFrameE
  let label arity e = LabelE (arity, e)
  let get_cur_label = GetCurLabelE
  let get_cur_context = GetCurContextE
  let cont e = ContE e
  let name n = NameE n
  let iter e names it = IterE (e, names, it)
  let yet s = YetE s
end
