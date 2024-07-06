open Util.Source


(* Lists *)

type 'a nl_elem =
  | Nl
  | Elem of 'a

type 'a nl_list = 'a nl_elem list


(* Terminals *)

type nat = Z.t
type text = string
type id = string phrase
type atom = Atom.atom


(* Iteration *)

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of exp * id option     (* `^` exp *)


(* Types *)

and dots = Dots | NoDots

and numtyp =
  | NatT                         (* `nat` *)
  | IntT                         (* `int` *)
  | RatT                         (* `rat` *)
  | RealT                        (* `real` *)

and typ = typ' phrase
and typ' =
  | VarT of id * arg list        (* varid (`(` arg,* `)`)? *)
  | BoolT                        (* `bool` *)
  | NumT of numtyp               (* numtyp *)
  | TextT                        (* `text` *)
  | ParenT of typ                (* `(` typ `)` *)
  | TupT of typ list             (* `(` list2(typ, `,`) `)` *)
  | IterT of typ * iter          (* typ iter *)
  (* The forms below are only allowed in type definitions *)
  | StrT of typfield nl_list     (* `{` list(typfield,`,`') `}` *)
  | CaseT of dots * typ nl_list * typcase nl_list * dots (* `|` list(`...`|typ|typcase, `|`) *)
  | ConT of typcon               (* typ prem* *)
  | RangeT of typenum nl_list    (* exp `|` `...` `|` exp *)
  | AtomT of atom                (* atom *)
  | SeqT of typ list             (* `eps` / typ typ *)
  | InfixT of typ * atom * typ   (* typ atom typ *)
  | BrackT of atom * typ * atom  (* ``` ([{ typ }]) *)

and typfield = atom * (typ * prem nl_list) * hint list (* atom typ prem* hint* *)
and typcase = atom * (typ * prem nl_list) * hint list  (* atom typ* prem* hint* *)
and typcon = (typ * prem nl_list) * hint list          (* typ prem* *)
and typenum = exp * exp option                         (* exp (`|` exp (`|` `...` `|` exp)?)* *)


(* Expressions *)

and natop =
  | DecOp   (* n *)
  | HexOp   (* 0xhex *)
  | CharOp  (* U+hex *)
  | AtomOp  (* `n *)

and unop =
  | NotOp   (* `~` *)
  | PlusOp  (* `+` *)
  | MinusOp (* `-` *)
  | PlusMinusOp (* `+-` *)
  | MinusPlusOp (* `-+` *)

and binop =
  | AndOp  (* `/\` *)
  | OrOp   (* `\/` *)
  | ImplOp (* `=>` *)
  | EquivOp (* `<=>` *)
  | AddOp  (* `+` *)
  | SubOp  (* `-` *)
  | MulOp  (* `*` *)
  | DivOp  (* `/` *)
  | ModOp  (* `\` *)
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
  | VarE of id * arg list        (* varid (`(` arg,* `)`)? *)
  | AtomE of atom                (* atom *)
  | BoolE of bool                (* bool *)
  | NatE of natop * nat          (* nat *)
  | TextE of text                (* text *)
  | UnE of unop * exp            (* unop exp *)
  | BinE of exp * binop * exp    (* exp binop exp *)
  | CmpE of exp * cmpop * exp    (* exp cmpop exp *)
  | EpsE                         (* `eps` *)
  | SeqE of exp list             (* exp exp *)
  | IdxE of exp * exp            (* exp `[` exp `]` *)
  | SliceE of exp * exp * exp    (* exp `[` exp `:` exp `]` *)
  | UpdE of exp * path * exp     (* exp `[` path `=` exp `]` *)
  | ExtE of exp * path * exp     (* exp `[` path `=..` exp `]` *)
  | StrE of expfield nl_list     (* `{` list(expfield, `,`) `}` *)
  | DotE of exp * atom           (* exp `.` atom *)
  | CommaE of exp * exp          (* exp `,` exp *)
  | CompE of exp * exp           (* exp `++` exp *)
  | MemE of exp * exp            (* exp `<-` exp *)
  | LenE of exp                  (* `|` exp `|` *)
  | SizeE of id                  (* `||` exp `||` *)
  | ParenE of exp * [`Sig | `Insig]  (* `(` exp `)` *)
  | TupE of exp list             (* `(` list2(exp, `,`) `)` *)
  | InfixE of exp * atom * exp   (* exp atom exp *)
  | BrackE of atom * exp * atom  (* ``` ([{ exp }]) *)
  | CallE of id * arg list       (* `$` defid (`(` arg,* `)`)? *)
  | IterE of exp * iter          (* exp iter *)
  | TypE of exp * typ            (* exp `:` typ *)
  | ArithE of exp                (* `$(` exp `)` *)
  | HoleE of [`Num of int | `Next | `Rest | `None]  (* `%N` or `%` or `%%` or `!%` *)
  | FuseE of exp * exp           (* exp `#` exp *)
  | UnparenE of exp              (* `##` exp *)
  | LatexE of string             (* `latex` `(` `"..."`* `)` *)

and expfield = atom * exp        (* atom exp *)

and path = path' phrase
and path' =
  | RootP                        (*  *)
  | IdxP of path * exp           (* path `[` exp `]` *)
  | SliceP of path * exp * exp   (* path `[` exp `:` exp `]` *)
  | DotP of path * atom          (* path `.` atom *)


(* Grammars *)

and sym = sym' phrase
and sym' =
  | VarG of id * arg list                    (* gramid (`(` arg,* `)`)? *)
  | NatG of natop * nat                      (* nat *)
  | TextG of string                          (* `"`text`"` *)
  | EpsG                                     (* `eps` *)
  | SeqG of sym nl_list                      (* sym sym *)
  | AltG of sym nl_list                      (* sym `|` sym *)
  | RangeG of sym * sym                      (* sym `|` `...` `|` sym *)
  | ParenG of sym                            (* `(` sym `)` *)
  | TupG of sym list                         (* `(` sym ',' ... ',' sym `)` *)
  | IterG of sym * iter                      (* sym iter *)
  | ArithG of exp                            (* `$(` exp `)` *)
  | AttrG of exp * sym                       (* exp `:` sym *)
  | FuseG of sym * sym                       (* sym `#` sym *)
  | UnparenG of sym                          (* `##` sym *)

and prod = prod' phrase
and prod' = sym * exp * prem nl_list         (* `|` sym `=>` exp (`--` prem)* *)

and gram = gram' phrase
and gram' = dots * prod nl_list * dots       (* `|` list(`...`|prod, `|`) *)


(* Definitions *)

and param = param' phrase
and param' =
  | ExpP of id * typ                         (* varid `:` typ *)
  | TypP of id                               (* `syntax` varid *)
  | GramP of id * typ                        (* `grammar` gramid `:` typ *)
  | DefP of id * param list * typ            (* `def` `$` defid params `:` typ *)

and arg = arg' ref phrase
and arg' =
  | ExpA of exp                              (* exp *)
  | TypA of typ                              (* `syntax` typ *)
  | GramA of sym                             (* `grammar` sym *)
  | DefA of id                               (* `def` defid *)

and def = def' phrase
and def' =
  | FamD of id * param list * hint list            (* `syntax` typid params hint* *)
  | TypD of id * id * arg list * typ * hint list   (* `syntax` typid args hint* `=` typ *)
  | GramD of id * id * param list * typ * gram * hint list (* `grammar` gramid params hint* `:` type `=` gram *)
  | RelD of id * typ * hint list                   (* `relation` relid `:` typ hint* *)
  | RuleD of id * id * exp * prem nl_list          (* `rule` relid ruleid? `:` exp (`--` prem)* *)
  | VarD of id * typ * hint list                   (* `var` varid `:` typ *)
  | DecD of id * param list * typ * hint list      (* `def` `$` defid params `:` typ hint* *)
  | DefD of id * arg list * exp * prem nl_list     (* `def` `$` defid args `=` exp (`--` prem)* *)
  | SepD                                           (* separator *)
  | HintD of hintdef

and prem = prem' phrase
and prem' =
  | VarPr of id * typ                        (* `var` id `:` typ *)
  | RulePr of id * exp                       (* ruleid `:` exp *)
  | IfPr of exp                              (* `if` exp *)
  | ElsePr                                   (* `otherwise` *)
  | IterPr of prem * iter                    (* prem iter *)

and hintdef = hintdef' phrase
and hintdef' =
  | AtomH of id * atom * hint list
  | TypH of id * id * hint list
  | GramH of id * id * hint list
  | RelH of id * hint list
  | VarH of id * hint list
  | DecH of id * hint list

and hint = {hintid : id; hintexp : exp}      (* `(` `hint` hintid exp `)` *)


(* Scripts *)

type script = def list
