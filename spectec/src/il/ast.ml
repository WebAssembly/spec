open Util.Source


(* TODO: annotate types on nodes *)


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
  | LParen                       (* `(` *)
  | LBrack                       (* `[` *)
  | LBrace                       (* `{` *)
  | RParen                       (* `)` *)
  | RBrack                       (* `]` *)
  | RBrace                       (* `}` *)
  | Quest                        (* `?` *)
  | Star                         (* `*` *)

type mixop = atom list list      (* mixfix name *)


(* Iteration *)

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of exp * id option     (* `^` exp *)


(* Types *)

and typ = typ' phrase
and typ' =
  | VarT of id                   (* varid *)
  | BoolT                        (* `bool` *)
  | NatT                         (* `nat` *)
  | TextT                        (* `text` *)
  | TupT of typ list             (* typ * ... * typ *)
  | IterT of typ * iter          (* typ iter *)

and deftyp = deftyp' phrase
and deftyp' =
  | AliasT of typ                       (* type alias *)
  | NotationT of mixop * typ            (* notation type *)
  | StructT of typfield list            (* record type *)
  | VariantT of typcase list            (* variant type *)

and typfield = atom * typ * hint list   (* record field *)
and typcase = atom * typ * hint list    (* variant case *)


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

and exp = (exp', typ) note_phrase
and exp' =
  | VarE of id                   (* varid *)
  | BoolE of bool                (* bool *)
  | NatE of nat                  (* nat *)
  | TextE of text                (* text *)
  | UnE of unop * exp            (* unop exp *)
  | BinE of binop * exp * exp    (* exp binop exp *)
  | CmpE of cmpop * exp * exp    (* exp cmpop exp *)
  | IdxE of exp * exp            (* exp `[` exp `]` *)
  | SliceE of exp * exp * exp    (* exp `[` exp `:` exp `]` *)
  | UpdE of exp * path * exp     (* exp `[` path `=` exp `]` *)
  | ExtE of exp * path * exp     (* exp `[` path `=..` exp `]` *)
  | StrE of expfield list        (* `{` list(expfield, `,`) `}` *)
  | DotE of exp * atom           (* exp `.` atom *)
  | CompE of exp * exp           (* exp `@` exp *)
  | LenE of exp                  (* `|` exp `|` *)
  | TupE of exp list             (* `(` list2(exp, `,`) `)` *)
  | MixE of mixop * exp          (* exp atom exp *)
  | CallE of id * exp            (* defid exp? *)
  | IterE of exp * iterexp       (* exp iter *)
  | OptE of exp option           (* exp? *)
  | TheE of exp                  (* THE exp *)
  | ListE of exp list            (* [exp ... exp] *)
  | CatE of exp * exp            (* exp :: exp *)
  | CaseE of atom * exp          (* atom exp *)
  | SubE of exp * typ * typ      (* exp : typ1 <: typ2 *)

and expfield = atom * exp        (* atom exp *)

and path = (path', typ) note_phrase
and path' =
  | RootP                        (*  *)
  | IdxP of path * exp           (* path `[` exp `]` *)
  | SliceP of path * exp * exp   (* path `[` exp `:` exp `]` *)
  | DotP of path * atom          (* path `.` atom *)

and iterexp = iter * id list


(* Definitions *)

and binds = (id * typ * iter list) list

and def = def' phrase
and def' =
  | SynD of id * deftyp                               (* syntax type *)
  | RelD of id * mixop * typ * rule list              (* relation *)
  | DecD of id * typ * typ * clause list              (* definition *)
  | RecD of def list                                  (* recursive *)
  | HintD of hintdef

and rule = rule' phrase
and rule' =
  | RuleD of id * binds * mixop * exp * premise list  (* relation rule *)

and clause = clause' phrase
and clause' =
  | DefD of binds * exp * exp * premise list          (* definition clause *)

and premise = premise' phrase
and premise' =
  | RulePr of id * mixop * exp                        (* premise *)
  | IfPr of exp                                       (* side condition *)
  | LetPr of exp * exp                                (* assignment *)
  | ElsePr                                            (* otherwise *)
  | IterPr of premise * iterexp                       (* iteration *)

and hintdef = hintdef' phrase
and hintdef' =
  | SynH of id * hint list
  | RelH of id * hint list
  | DecH of id * hint list

and hint = {hintid : id; hintexp : string list}       (* hint *)


(* Scripts *)

type script = def list
