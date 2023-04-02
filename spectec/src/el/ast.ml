open Util.Source


(* Lists *)

type 'a nl_elem =
  | Nl
  | Elem of 'a

type 'a nl_list = 'a nl_elem list


(* Terminals *)

type nat = int
type text = string
type id = string phrase

type atom =
  | Atom of string               (* atomid *)
  | Bot                          (* `_|_` *)
  | Dot                          (* `.` *)
  | Dot2                         (* `..` *)
  | Dot3                         (* `...` *)
  | Semicolon                    (* `;` *)
  | Arrow                        (* `->` *)
  | Colon                        (* `:` *)
  | Sub                          (* `<:` *)
  | SqArrow                      (* `~>` *)
  | Turnstile                    (* `|-` *)
  | Tilesturn                    (* `-|` *)

type brack =
  | Paren                        (* ``(` ... `)` *)
  | Brack                        (* ``[` ... `]` *)
  | Brace                        (* ``{` ... `}` *)

type dots = Dots | NoDots


(* Iteration *)

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of exp                 (* `^` exp *)


(* Types *)

and typ = typ' phrase
and typ' =
  | VarT of id                   (* varid *)
  | BoolT                        (* `bool` *)
  | NatT                         (* `nat` *)
  | TextT                        (* `text` *)
  | ParenT of typ                (* `(` typ `)` *)
  | TupT of typ list             (* `(` list2(typ, `,`) `)` *)
  | IterT of typ * iter          (* typ iter *)
  (* The forms below are only allowed in type definitions *)
  | StrT of typfield nl_list     (* `{` list(typfield,`,`') `}` *)
  | CaseT of dots * id nl_list * typcase nl_list * dots (* `|` list(`...`|varid|typcase, `|`) *)
  | AtomT of atom                (* atom *)
  | SeqT of typ list             (* `epsilon` / typ typ *)
  | InfixT of typ * atom * typ   (* typ atom typ *)
  | BrackT of brack * typ        (* ``` ([{ typ }]) *)

and typfield = atom * typ * hint list        (* atom typ hint* *)
and typcase = atom * typ list * hint list    (* atom typ* hint* *)


(* Expressions *)

and unop =
  | NotOp   (* `~` *)
  | PlusOp  (* `+` *)
  | MinusOp (* `-` *)

and binop =
  | AndOp  (* `/\` *)
  | OrOp   (* `\/` *)
  | ImplOp (* `=>` *)
  | EquivOp (* `<=>` *)
  | AddOp  (* `+` *)
  | SubOp  (* `-` *)
  | MulOp  (* `*` *)
  | DivOp  (* `/` *)
  | ExpOp  (* `^` *)

and cmpop =
  | EqOp (* `=` *)
  | NeOp (* `=/=` *)
  | LtOp (* `<` *)
  | GtOp (* `>` *)
  | LeOp (* `<=` *)
  | GeOp (* `>=` *)

and exp = exp' phrase
and exp' =
  | VarE of id                   (* varid *)
  | AtomE of atom                (* atom *)
  | BoolE of bool                (* bool *)
  | NatE of nat                  (* nat *)
  | TextE of text                (* text *)
  | UnE of unop * exp            (* unop exp *)
  | BinE of exp * binop * exp    (* exp binop exp *)
  | CmpE of exp * cmpop * exp    (* exp cmpop exp *)
  | EpsE                         (* `epsilon` *)
  | SeqE of exp list             (* exp exp *)
  | IdxE of exp * exp            (* exp `[` exp `]` *)
  | SliceE of exp * exp * exp    (* exp `[` exp `:` exp `]` *)
  | UpdE of exp * path * exp     (* exp `[` path `=` exp `]` *)
  | ExtE of exp * path * exp     (* exp `[` path `=..` exp `]` *)
  | StrE of expfield nl_list     (* `{` list(expfield, `,`) `}` *)
  | DotE of exp * atom           (* exp `.` atom *)
  | CommaE of exp * exp          (* exp `,` exp *)
  | CompE of exp * exp           (* exp `++` exp *)
  | LenE of exp                  (* `|` exp `|` *)
  | ParenE of exp * bool         (* `(` exp `)` *)
  | TupE of exp list             (* `(` list2(exp, `,`) `)` *)
  | InfixE of exp * atom * exp   (* exp atom exp *)
  | BrackE of brack * exp        (* ``` ([{ exp }]) *)
  | CallE of id * exp            (* `$` defid exp? *)
  | IterE of exp * iter          (* exp iter *)
  | HoleE of bool                (* `%` or `%%` *)
  | FuseE of exp * exp           (* exp `#` exp *)

and expfield = atom * exp        (* atom exp *)

and path = path' phrase
and path' =
  | RootP                        (*  *)
  | IdxP of path * exp           (* path `[` exp `]` *)
  | DotP of path * atom          (* path `.` atom *)


(* Definitions *)

and def = def' phrase
and def' =
  | SynD of id * id * typ * hint list        (* `syntax` synid hint* `=` typ *)
  | RelD of id * typ * hint list             (* `relation` relid `:` typ hint* *)
  | RuleD of id * id * exp * premise nl_list (* `rule` relid ruleid? `:` exp (`--` premise)* *)
  | VarD of id * typ * hint list             (* `var` varid `:` typ *)
  | DecD of id * exp * typ * hint list       (* `def` `$` defid exp? `:` typ hint* *)
  | DefD of id * exp * exp * premise nl_list (* `def` `$` defid exp? `=` exp (`--` premise)* *)
  | SepD                                     (* separator *)

and premise = premise' phrase
and premise' =
  | RulePr of id * exp * iter option         (* `(` metaid exp `)` iter? *)
  | IfPr of exp * iter option                (* `if` exp *)
  | ElsePr                                   (* `otherwise` *)

and hint = {hintid : id; hintexp : exp}      (* `(` `hint` hintid exp `)` *)


(* Scripts *)

type script = def list
