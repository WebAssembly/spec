open Util.Source

(* Types *)

type ty = string (* TODO *)

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
  | NumV of Z.t                        (* number *)
  | BoolV of bool                      (* boolean *)
  | TextV of string                    (* string *)
  | ListV of value growable_array      (* list of values *)
  | StrV of (kwd', value) record       (* key-value mapping *)
  | CaseV of kwd' * value list         (* constructor *)
  | OptV of value option               (* optional value *)
  | TupV of value list                 (* tuple of values *)
  | FrameV of value option * value     (* TODO: desugar using CaseV? *)
  | LabelV of value * value            (* TODO: desugar using CaseV? *)

type extend_dir =                      (* direction of extension *)
  | Front                              (* extend from the front *)
  | Back                               (* extend from the back *)

(* Operators *)

type unop =
  | NotOp    (* `~` *)
  | MinusOp  (* `-` *)

type binop =
  | ImplOp   (* `=>` *)
  | EquivOp  (* `<=>` *)
  | AddOp    (* `+` *)
  | SubOp    (* `-` *)
  | MulOp    (* `*` *)
  | DivOp    (* `/` *)
  | ExpOp    (* `^` *)
  (* compare operation *)
  | AndOp    (* `/\` *)
  | OrOp     (* `\/` *)
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

and expr = expr' phrase
and expr' =
  | VarE of id                          (* varid *)
  | NumE of Z.t                         (* number *)
  | BoolE of bool                       (* boolean *)
  | UnE of unop * expr                  (* unop expr *)
  | BinE of binop * expr * expr         (* expr binop expr *)
  | AccE of expr * path                 (* expr `[` path `]` *)
  | UpdE of expr * path list * expr     (* expr `[` path* `]` `:=` expr *)
  | ExtE of expr * path list * expr * extend_dir (* expr `[` path* `]` `:+` expr *)
  | StrE of (kwd, expr) record          (* `{` (kwd `->` expr)* `}` *)
  | CatE of expr * expr                 (* expr `++` expr *)
  | LenE of expr                        (* `|` expr `|` *)
  | TupE of expr list                   (* `(` (expr `,`)* `)` *)
  | CaseE of kwd * expr list            (* kwd `(` expr* `)` -- MixE/CaseE *)
  | CallE of id * expr list             (* id `(` expr* `)` *)
  | IterE of expr * id list * iter      (* expr (`{` id* `}`)* *)
  | OptE of expr option                 (* expr?  *)
  | ListE of expr list                  (* `[` expr* `]` *)
  | InfixE of expr * string * expr      (* "expr infix expr" *) (* TODO: Remove InfixE using hint *)
  | ArityE of expr                      (* "the arity of expr" *)
  | FrameE of expr option * expr        (* "the activation of expr (with arity expr)?" *)
  | LabelE of expr * expr               (* "the label whose arity is expr and whose continuation is expr" *)
  | GetCurFrameE                        (* "the current frame" *)
  | GetCurLabelE                        (* "the current lbael" *)
  | GetCurContextE                      (* "the current context" *)
  | ContE of expr                       (* "the continuation of expr" *)
  (* Conditions *)
  | IsCaseOfE of expr * kwd             (* expr is of the case kwd *)
  | IsValidE of expr                    (* expr is valid *)
  | ContextKindE of kwd * expr          (* TODO: desugar using IsCaseOf? *)
  | IsDefinedE of expr                  (* expr is defined *)
  | MatchE of expr * expr               (* expr matches expr *)
  | HasTypeE of expr * ty               (* the type of expr is ty *)
  (* Conditions used in assertions *)
  | TopLabelE                           (* "a label is now on the top of the stack" *)
  | TopFrameE                           (* "a frame is now on the top of the stack" *)
  | TopValueE of expr option            (* "a value (of type expr)? is now on the top of the stack" *)
  | TopValuesE of expr                  (* "at least expr number of values on the top of the stack" *)
  (* Administrative Instructions *)
  | SubE of id * ty                     (* varid, with specific type *)
  | YetE of string                      (* for future not yet implemented feature *)

and path = path' phrase
and path' =
  | IdxP of expr                    (* `[` expr `]` *)
  | SliceP of expr * expr           (* `[` expr `:` expr `]` *)
  | DotP of kwd                     (* `.` atom *)


(* Instructions *)

type instr = (instr', int) note_phrase
and instr' =
  | IfI of expr * instr list * instr list (* `if` cond `then` instr* `else` instr* *)
  | EitherI of instr list * instr list    (* `either` instr* `or` instr* *)
  | EnterI of expr * expr * instr list    (* `enter` expr`:` expr `after` instr* *)
  | AssertI of expr                       (* `assert` cond *)
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
