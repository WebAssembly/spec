open Util.Source


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
  | ListN of exp                 (* `^` exp *)


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
  | VariantT of id list * typcase list  (* variant type *)

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

and exp = exp' phrase
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
  | DotE of typ * exp * atom     (* exp `.` atom *)
  | CompE of exp * exp           (* exp `@` exp *)
  | LenE of exp                  (* `|` exp `|` *)
  | TupE of exp list             (* `(` list2(exp, `,`) `)` *)
  | MixE of mixop * exp          (* exp atom exp *)
  | CallE of id * exp            (* defid exp? *)
  | IterE of exp * iter          (* exp iter *)
  | OptE of exp option           (* exp? : typ? *)
  | ListE of exp list            (* [exp ... exp] *)
  | CatE of exp * exp            (* exp :: exp *)
  | CaseE of atom * exp * typ    (* atom exp : typ *)
  | SubE of exp * typ * typ      (* exp : typ1 <: typ2 *)

and expfield = atom * exp        (* atom exp *)

and path = path' phrase
and path' =
  | RootP                        (*  *)
  | IdxP of path * exp           (* path `[` exp `]` *)
  | DotP of path * atom          (* path `.` atom *)


(* Definitions *)

and binds = (id * typ) list

and def = def' phrase
and def' =
  | SynD of id * deftyp * hint list                   (* syntax type *)
  | RelD of id * mixop * typ * rule list * hint list  (* relation *)
  | DecD of id * typ * typ * clause list * hint list  (* definition *)
  | RecD of def list                                  (* recursive *)

and rule = rule' phrase
and rule' =
  | RuleD of id * binds * mixop * exp * premise list  (* relation rule *)

and clause = clause' phrase
and clause' =
  | DefD of binds * exp * exp * premise list          (* definition clause *)

and premise = premise' phrase
and premise' =
  | RulePr of id * mixop * exp * iter option          (* premise *)
  | IfPr of exp * iter option                         (* side condition *)
  | ElsePr                                            (* otherwise *)

and hint = {hintid : id; hintexp : string list}       (* hint *)


(* Scripts *)

type script = def list
