(* AL Name *)

(* Identifier derived from the syntax terminals defined in the DSL.
   The second in the tuple denotes its IL-type (for disambiguation).*)
type keyword = keyword' * string
and keyword' = string

type funcname = string (* name of a helper function defined in the DSL *)

type name = string     (* name of meta-variables in the DSL, which are variables in AL *)

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

type ('a, 'b) record = ('a * 'b ref) list

and store = (keyword', value) record
and stack = value list

(* AL AST *)
and value =
  | NumV of int64
  | StringV of string
  | ListV of value growable_array
  | RecordV of (keyword', value) record
  | ConstructV of keyword' * value list
  | OptV of value option
  | PairV of value * value
  | ArrowV of value * value
  (* TODO: Remove FrameV and LabelV *)
  | FrameV of value option * value
  | LabelV of value * value
  | StoreV of store ref

type extend_dir =
  | Front
  | Back

(* Operators *)

type expr_binop =
  | Add    (* `+` *)
  | Sub    (* `-` *)
  | Mul    (* `*` *)
  | Div    (* `/` *)
  | Exp    (* `^` *)

type cond_binop =
  | And    (* `/\` *)
  | Or     (* `\/` *)
  | Impl   (* `=>` *)
  | Equiv  (* `<=>` *)

type compare_op =
  | Eq     (* `=` *)
  | Ne     (* `=/=` *)
  | Lt     (* `<` *)
  | Gt     (* `>` *)
  | Le     (* `<=` *)
  | Ge     (* `>=` *)

(* Iteration *)

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of expr * name option  (* `^` exp *)

(* Expressions *)

and expr =
  (* Value *)
  | NumE of int64
  | StringE of string
  (* Numeric Operation *)
  | MinusE of expr
  | BinopE of expr_binop * expr * expr
  (* Function Call *)
  | AppE of funcname * expr list
  (* Data Structure *)
  | ListE of expr list
  | ListFillE of expr * expr
  | ConcatE of expr * expr
  | LengthE of expr
  | RecordE of (keyword, expr) record
  | AccessE of expr * path
  | ExtendE of expr * path list * expr * extend_dir
  | ReplaceE of expr * path list * expr
  | ConstructE of keyword * expr list (* CaseE? StructE? TaggedE? NamedTupleE? *)
  | OptE of expr option
  | PairE of expr * expr
  | ArrowE of expr * expr
  (* Context *)
  | ArityE of expr
  | FrameE of expr option * expr
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
  | DotP of keyword 

and cond =
  | NotC of cond
  | BinopC of cond_binop * cond * cond
  | CompareC of compare_op * expr * expr
  | IsCaseOfC of expr * keyword 
  | ValidC of expr

  | ContextKindC of keyword * expr (* can be desugared using IsCaseOf? *)
  | IsDefinedC of expr             (* can be desugared? *)

  (* Conditions used in assertions *)
  | TopLabelC
  | TopFrameC
  | TopValueC of expr option
  | TopValuesC of expr

  (* Yet *)
  | YetC of string

(* Instructions *)

type instr =
  | IfI of cond * instr list * instr list (* `if` cond `then` instr* `else` instr* *)
  | EitherI of instr list * instr list    (* `either` instr* `or` instr* *)
  | EnterI of expr * expr * instr list    (* `enter` expr`:` expr `after` instr* *)
  | AssertI of cond                       (* `assert` cond *)
  | PushI of expr                         (* `push` expr *)
  | PopI of expr                          (* `pop` expr *)
  | PopAllI of expr                       (* `pop all` expr *)
  | LetI of expr * expr                   (* `let` expr `=` expr *)
  | TrapI                                 (* `trap` *)
  | NopI                                  (* `nop` *)
  | ReturnI of expr option                (* `return` expr? *)
  | ExecuteI of expr                      (* `execute` expr *)
  | ExecuteSeqI of expr                   (* `execute' 'seq` expr *)
  | PerformI of name * expr list          (* `perform` name expr* *)
  | ExitI
  (* Mutations *)
  | ReplaceI of expr * path * expr
  | AppendI of expr * expr
  | AppendListI of expr * expr

  (* Administrative Instructions *)
  | OtherwiseI of instr list (* only during the intermediate processing of il->al *)
  | YetI of string           (* for future not yet implemented feature *)

(* Algorithms *)

type algorithm =             (* `algorithm` x`(`expr*`)` `{`instr*`}` *)
  | RuleA of keyword * expr list * instr list         (* inference rule *)
  | FuncA of funcname * expr list * instr list        (* helper function *)
