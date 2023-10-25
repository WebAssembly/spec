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

type unop =
  | NotOp    (* `~` *)
  | MinusOp  (* `-` *)

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
  | NameE of name                       (* varid *)
  | NumE of int64                       (* number *)
  | StringE of string                   (* string *)
  | MinusE of expr
  | BinopE of binop * expr * expr
(*
  | UnE of unop * expr                  (* unop expr *)
  | BinE of binop * expr * expr         (* expr binop expr *)
 *)
  | IterE of expr * name list * iter    (* *)
  | AppE of funcname * expr list        (* Function Call *)
  | ListE of expr list                  (*  *)
  | ListFillE of expr * expr            (*  *)
  | ConcatE of expr * expr              (*  *)
  | LengthE of expr                     (*  *)
  | RecordE of (keyword, expr) record   (*  *)
  | AccessE of expr * path              (*  *)
  | ExtendE of expr * path list * expr * extend_dir (*  *)
  | ReplaceE of expr * path list * expr (*  *)
  | ConstructE of keyword * expr list   (* CaseE? StructE? TaggedE? NamedTupleE? *)
  | OptE of expr option                 (*  *)
  | PairE of expr * expr                (*  *)
  | ArrowE of expr * expr               (*  *)
  | ArityE of expr                      (*  *)
  | FrameE of expr option * expr        (*  *)
  | GetCurFrameE                        (*  *)
  | LabelE of expr * expr               (*  *)
  | GetCurLabelE                        (*  *)
  | GetCurContextE                      (*  *)
  | ContE of expr                       (*  *)
  (* Administrative Instructions *)
  | YetE of string                      (* for future not yet implemented feature *)

and path =
  | IdxP of expr             (* `[` exp `]` *)
  | SliceP of expr * expr    (* `[` exp `:` exp `]` *)
  | DotP of keyword          (* `.` atom *)

and cond =
  | UnC of unop * cond              (* unop expr *)
  | BinC of binop * cond * cond     (* expr binop expr *)
  | CmpC of cmpop * expr * expr     (* expr cmpop expr *)
  | IsCaseOfC of expr * keyword     (* expr is of the case keyword *)
  | ValidC of expr                  (* expr is valid *)
  | ContextKindC of keyword * expr  (* TODO: Desugar using IsCaseOf? *)
  | IsDefinedC of expr              (* expr is defined *)
  (* Conditions used in assertions *)
  | TopLabelC                       (* a label is now on the top of the stack *)
  | TopFrameC                       (* a frame is now on the top of the stack *)
  | TopValueC of expr option        (* a value (of type expr)? is now on the top of the stack *)
  | TopValuesC of expr              (* at least expr number of values on the top of the stack *)
  (* Administrative instructions *)
  | YetC of string                  (* for future not yet implemented feature *)

(* Instructions *)

type instr =
  | IfI of cond * instr list * instr list (* `if` cond `then` instr* `else` instr* *)
  | EitherI of instr list * instr list    (* `either` instr* `or` instr* *)
  | EnterI of expr * expr * instr list    (* `enter` expr`:` expr `after` instr* *)
  | AssertI of cond                       (* `assert` cond *)
  | PushI of expr                         (* `push` expr *)
  | PopI of expr                          (* `pop` expr *)
  | PopAllI of expr                       (* `popall` expr *)
  | LetI of expr * expr                   (* `let` expr `=` expr *)
  | TrapI                                 (* `trap` *)
  | NopI                                  (* `nop` *)
  | ReturnI of expr option                (* `return` expr? *)
  | ExecuteI of expr                      (* `execute` expr *)
  | ExecuteSeqI of expr                   (* `executeseq` expr *)
  | PerformI of name * expr list          (* `perform` name expr* *)
  | ExitI                                 (* `exit` *)
  | ReplaceI of expr * path * expr        (* `replace` expr `->` path `with` expr *)
  | AppendI of expr * expr                (* `append` expr expr *)
  (* Administrative instructions *)
  | OtherwiseI of instr list              (* only during the intermediate processing of il->al *)
  | YetI of string                        (* for future not yet implemented feature *)

(* Algorithms *)

type algorithm =             (* `algorithm` x`(`expr*`)` `{`instr*`}` *)
  | RuleA of keyword * expr list * instr list         (* inference rule *)
  | FuncA of funcname * expr list * instr list        (* helper function *)
