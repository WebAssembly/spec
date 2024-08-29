open Util.Source

(* Terminals *)

type atom = El.Atom.atom
type mixop = Il.Ast.mixop

(* Types *)

type typ = Il.Ast.typ

(* Identifiers *)

type id = string

(* Anchors *)

type anchor = string

(* Values *)

type 'a growable_array = 'a array ref

type ('a, 'b) record = ('a * 'b ref) list

and store = (atom, value) record

and value =
  | NumV of Z.t                        (* number *)
  | BoolV of bool                      (* boolean *)
  | TextV of string                    (* string *)
  | ListV of value growable_array      (* list of values *)
  | StrV of (id, value) record         (* key-value mapping *)
  | CaseV of id * value list           (* constructor *)
  | OptV of value option               (* optional value *)
  | TupV of value list                 (* tuple of values *)

type extend_dir =                      (* direction of extension *)
  | Front                              (* extend from the front *)
  | Back                               (* extend from the back *)

(* Operators *)

type unop =
  | NotOp    (* `~` *)
  | MinusOp  (* `-` *)

type binop =
  (* arithmetic operation *)
  | AddOp    (* `+` *)
  | SubOp    (* `-` *)
  | MulOp    (* `*` *)
  | DivOp    (* `/` *)
  | ModOp    (* `\` *)
  | ExpOp    (* `^` *)
  (* logical operation *)
  | ImplOp   (* `=>` *)
  | EquivOp  (* `<=>` *)
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

and expr = (expr', Il.Ast.typ) note_phrase
and expr' =
  | VarE of id                                    (* varid *)
  | NumE of Z.t                                   (* number *)
  | BoolE of bool                                 (* boolean *)
  | UnE of unop * expr                            (* unop expr *)
  | BinE of binop * expr * expr                   (* expr binop expr *)
  | AccE of expr * path                           (* expr `[` path `]` *)
  | UpdE of expr * path list * expr               (* expr `[` path* `]` `:=` expr *)
  | ExtE of expr * path list * expr * extend_dir  (* expr `[` path* `]` `:+` expr *)
  | StrE of (atom, expr) record                   (* `{` (atom `->` expr)* `}` *)
  | CompE of expr * expr                          (* expr `++` expr *)
  | CatE of expr * expr                           (* expr `::` expr *)
  | MemE of expr * expr                           (* expr `<-` expr *)
  | LenE of expr                                  (* `|` expr `|` *)
  | TupE of expr list                             (* `(` (expr `,`)* `)` *)
  | CaseE of mixop * expr list                    (* mixop `(` expr* `)` -- CaseE *)
  | CallE of id * arg list                        (* id `(` expr* `)` *)
  | InvCallE of id * int option list * arg list   (* id`_`int*`^-1(` expr* `)` *)
  | IterE of expr * id list * iter                (* expr (`{` id* `}`)* *)
  | OptE of expr option                           (* expr?  *)
  | ListE of expr list                            (* `[` expr* `]` *)
  | GetCurStateE                                  (* "the current state" *)
  | GetCurContextE of atom option                 (* "the current context of certain (Some) or any (None) type" *)
  | ChooseE of expr                               (* "an element of" expr *)
  (* Conditions *)
  | IsCaseOfE of expr * atom                      (* expr is of the case atom *)
  | IsValidE of expr                              (* expr is valid *)
  | ContextKindE of atom                          (* "the fisrt non-value entry of the stack is a" atom *)
  | IsDefinedE of expr                            (* expr is defined *)
  | MatchE of expr * expr                         (* expr matches expr *)
  | HasTypeE of expr * typ                        (* the type of expr is ty *)
  (* Conditions used in assertions *)
  | TopValueE of expr option                      (* "a value (of type expr)? is now on the top of the stack" *)
  | TopValuesE of expr                            (* "at least expr number of values on the top of the stack" *)
  (* Administrative Instructions *)
  | SubE of id * typ                              (* varid, with specific type *)
  | YetE of string                                (* for future not yet implemented feature *)

and path = path' phrase
and path' =
  | IdxP of expr                    (* `[` expr `]` *)
  | SliceP of expr * expr           (* `[` expr `:` expr `]` *)
  | DotP of atom                    (* `.` atom *)

and arg = arg' phrase
and arg' =
  | ExpA of expr
  | TypA of typ

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
  | ThrowI of expr                        (* `throw` *)
  | NopI                                  (* `nop` *)
  | ReturnI of expr option                (* `return` expr? *)
  | ExecuteI of expr                      (* `execute` expr *)
  | ExecuteSeqI of expr                   (* `executeseq` expr *)
  | PerformI of id * arg list             (* `perform` id expr* *)
  | ExitI of atom                         (* `exit` *)
  | ReplaceI of expr * path * expr        (* `replace` expr `->` path `with` expr *)
  | AppendI of expr * expr                (* `append` expr `to the` expr *)
  | FieldWiseAppendI of expr * expr       (* `append` expr `to the` expr `, fieldwise` *)
  (* Administrative instructions *)
  | OtherwiseI of instr list              (* only during the intermediate processing of il->al *)
  | YetI of string                        (* for future not yet implemented feature *)

(* Algorithms *)

type algorithm = algorithm' phrase
and algorithm' =                                    (* `algorithm` f`(`expr*`)` `{`instr*`}` *)
  | RuleA of atom * anchor * arg list * instr list  (* reduction rule *)
  | FuncA of id * arg list * instr list             (* helper function *)


(* Scripts *)

type script = algorithm list
