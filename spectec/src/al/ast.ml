(* Names *)

(* Identifiers derived from the syntax terminals defined in the DSL.
   The second in the tuple denotes its IL-type (for disambiguation).*)
type keyword = keyword' * string
and keyword' = string

type funcname = string (* name of helper functions defined in the DSL *)

type name = string     (* name of meta-variables in the DSL, which are variables in AL *)

(* Values *)
type 'a growable_array = 'a array ref

type ('a, 'b) record = ('a * 'b ref) list

and store = (keyword', value) record

and value =
  | NumV of int64                       (* number *)
  | StringV of string                   (* string *)
  | ListV of value growable_array       (* list of values *)
  | RecordV of (keyword', value) record (* key-value mapping *)
  | ConstructV of keyword' * value list (* constructor *)
  | OptV of value option                (* optional value *)
  | PairV of value * value              (* pair of values *)
  | ArrowV of value * value             (* Wasm function type as an AL value *)
  | FrameV of value option * value      (* TODO: Desugar using ContructV *)
  | LabelV of value * value             (* TODO: Desugar using ContructV *)
  | StoreV of store ref                 (* TODO: Check Wasm specificity *)

type extend_dir =                       (* direction of extension *)
  | Front                               (* extend from the front *)
  | Back                                (* extend from the back *)

(* Operators *)

type binop =
  | AndOp    (* `/\` *)
  | OrOp     (* `\/` *)
  | ImplOp   (* `=>` *)
  | EquivOp  (* `<=>` *)
  | AddOp    (* `+` *)
  | SubOp    (* `-` *)
  | MulOp    (* `*` *)
  | DivOp    (* `/` *)
  | ExpOp    (* `^` *)

type cmpop =
  | EqOp     (* `=` *)
  | NeOp     (* `=/=` *)
  | LtOp     (* `<` *)
  | GtOp     (* `>` *)
  | LeOp     (* `<=` *)
  | GeOp     (* `>=` *)

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
  | BinopE of binop * expr * expr
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
  | IndexP of expr        (* `[` exp `]` *)
  | SliceP of expr * expr (* `[` exp `:` exp `]` *)
  | DotP of keyword       (* `.` atom *)

and cond =
  | NotC of cond
  | BinopC of binop * cond * cond
  | CompareC of cmpop * expr * expr
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
