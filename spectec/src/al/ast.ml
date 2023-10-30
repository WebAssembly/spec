(* Identifiers *)

type id = string

(* Identifiers derived from the syntax terminals defined in the DSL.
   The second in the tuple denotes its IL-type (for disambiguation).*)
type kwd = kwd' * string
and kwd' = string

(* Values *)
type 'a growable_array = 'a array ref

type ('a, 'b) record = ('a * 'b ref) list

and store = (kwd', value) record

and value =
  | NumV of int64                      (* number *)
  | StringV of string                  (* string *)
  | ListV of value growable_array      (* list of values *)
  | RecordV of (kwd', value) record    (* key-value mapping *)
  | ConstructV of kwd' * value list    (* constructor *)
  | OptV of value option               (* optional value *)
  | PairV of value * value             (* pair of values *)
  | ArrowV of value * value            (* Wasm function type as an AL value *)
  | FrameV of value option * value     (* TODO: desugar using ContructV? *)
  | LabelV of value * value            (* TODO: desugar using ContructV? *)
  | StoreV of store ref                (* TODO: check Wasm specificity? *)

type extend_dir =                      (* direction of extension *)
  | Front                              (* extend from the front *)
  | Back                               (* extend from the back *)

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
  | Opt                        (* `?` *)
  | List                       (* `*` *)
  | List1                      (* `+` *)
  | ListN of expr * id option  (* `^` exp *)

(* Expressions *)

and expr =
  | VarE of id                          (* varid *)
  | NumE of int64                       (* number *)
  | UnE of unop * expr                  (* unop expr *)
  | BinE of binop * expr * expr         (* expr binop expr *)
  | AccessE of expr * path              (* expr `[` path `]` *)
  | ReplaceE of expr * path list * expr (* expr `[` path* `]` `:=` expr *)
  | ExtendE of expr * path list * expr * extend_dir (* expr `[` path* `]` `:+` expr *)
  | RecordE of (kwd, expr) record       (* `{` (kwd `->` expr)* `}` *)
  | ConcatE of expr * expr              (* expr `++` expr *)
  | LengthE of expr                     (* `|` expr `|` *)
  | PairE of expr * expr                (* `(` expr `,` expr `)` *)
  | ConstructE of kwd * expr list       (* kwd `(` expr* `)` -- MixE/CaseE *)
  | AppE of id * expr list              (* id `(` expr* `)` *)
  | IterE of expr * id list * iter      (* expr (`{` id* `}`)* *)
  | OptE of expr option                 (* expr?  *)
  | ListE of expr list                  (* `[` expr* `]` *)
  | ListFillE of expr * expr            (* expr `^` expr -- IterE with a constant exponent *)
  | ArrowE of expr * expr               (* "expr -> expr" *)
  | ArityE of expr                      (* "the arity of expr" *)
  | FrameE of expr option * expr        (* "the activation of expr (with arity expr)?" *)
  | LabelE of expr * expr               (* "the label whose arity is expr and whose continuation is expr" *)
  | GetCurFrameE                        (* "the current frame" *)
  | GetCurLabelE                        (* "the current lbael" *)
  | GetCurContextE                      (* "the current context" *)
  | ContE of expr                       (* "the continuation of expr" *)
  (* Administrative Instructions *)
  | YetE of string                      (* for future not yet implemented feature *)

and path =
  | IdxP of expr                    (* `[` expr `]` *)
  | SliceP of expr * expr           (* `[` expr `:` expr `]` *)
  | DotP of kwd                     (* `.` atom *)

and cond =
  | UnC of unop * cond              (* unop expr *)
  | BinC of binop * cond * cond     (* expr binop expr *)
  | CmpC of cmpop * expr * expr     (* expr cmpop expr *)
  | IsCaseOfC of expr * kwd         (* expr is of the case kwd *)
  | IsValidC of expr                (* expr is valid *)
  | ContextKindC of kwd * expr      (* TODO: desugar using IsCaseOf? *)
  | IsDefinedC of expr              (* expr is defined *)
  (* Conditions used in assertions *)
  | TopLabelC                       (* "a label is now on the top of the stack" *)
  | TopFrameC                       (* "a frame is now on the top of the stack" *)
  | TopValueC of expr option        (* "a value (of type expr)? is now on the top of the stack" *)
  | TopValuesC of expr              (* "at least expr number of values on the top of the stack" *)
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
  | PerformI of id * expr list            (* `perform` id expr* *)
  | ExitI                                 (* `exit` *)
  | ReplaceI of expr * path * expr        (* `replace` expr `->` path `with` expr *)
  | AppendI of expr * expr                (* `append` expr expr *)
  (* Administrative instructions *)
  | OtherwiseI of instr list              (* only during the intermediate processing of il->al *)
  | YetI of string                        (* for future not yet implemented feature *)

(* Algorithms *)

type algorithm =                          (* `algorithm` x`(`expr*`)` `{`instr*`}` *)
  | RuleA of kwd * expr list * instr list (* reduction rule *)
  | FuncA of id * expr list * instr list  (* helper function *)
