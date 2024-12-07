open Util.Source
open Xl


(* Terminals *)

type num = Num.num
type text = string
type id = string phrase
type atom = Atom.atom
type mixop = Mixop.mixop


(* Iteration *)

type iter =
  | Opt                          (* `?` *)
  | List                         (* `*` *)
  | List1                        (* `+` *)
  | ListN of exp * id option     (* `^` exp *)


(* Types *)

and numtyp = Num.typ
and optyp = [Bool.typ | Num.typ]

and typ = typ' phrase
and typ' =
  | VarT of id * arg list        (* typid( arg* ) *)
  | BoolT                        (* `bool` *)
  | NumT of numtyp               (* numtyp *)
  | TextT                        (* `text` *)
  | TupT of (exp * typ) list     (* typ * ... * typ *)
  | IterT of typ * iter          (* typ iter *)

and deftyp = deftyp' phrase
and deftyp' =
  | AliasT of typ                (* type alias *)
  | StructT of typfield list     (* record type *)
  | VariantT of typcase list     (* variant type *)

and typfield = atom * (bind list * typ * prem list) * hint list  (* record field *)
and typcase = mixop * (bind list * typ * prem list) * hint list  (* variant case *)


(* Expressions *)

and unop = [Bool.unop | Num.unop | `PlusMinusOp | `MinusPlusOp]
and binop = [Bool.binop | Num.binop]
and cmpop = [Bool.cmpop | Num.cmpop]

and exp = (exp', typ) note_phrase
and exp' =
  | VarE of id                   (* varid *)
  | BoolE of bool                (* bool *)
  | NumE of num                  (* num *)
  | TextE of text                (* text *)
  | UnE of unop * optyp * exp            (* unop exp *)
  | BinE of binop * optyp * exp * exp    (* exp binop exp *)
  | CmpE of cmpop * optyp * exp * exp    (* exp cmpop exp *)
  | TupE of exp list             (* ( exp* ) *)
  | ProjE of exp * int           (* exp.i *)
  | CaseE of mixop * exp         (* atom exp? *)
  | UncaseE of exp * mixop       (* exp!mixop *)
  | OptE of exp option           (* exp? *)
  | TheE of exp                  (* exp! *)
  | StrE of expfield list        (* { expfield* } *)
  | DotE of exp * atom           (* exp.atom *)
  | CompE of exp * exp           (* exp @ exp *)
  | ListE of exp list            (* [exp ... exp] *)
  | LiftE of exp                 (* exp : _? <: _* *)
  | MemE of exp * exp            (* exp `<-` exp *)
  | LenE of exp                  (* |exp| *)
  | CatE of exp * exp            (* exp :: exp *)
  | IdxE of exp * exp            (* exp[exp]` *)
  | SliceE of exp * exp * exp    (* exp[exp : exp] *)
  | UpdE of exp * path * exp     (* exp[path = exp] *)
  | ExtE of exp * path * exp     (* exp[path =.. exp] *)
  | CallE of id * arg list       (* defid( arg* ) *)
  | IterE of exp * iterexp       (* exp iter *)
  | CvtE of exp * numtyp * numtyp (* exp : typ1 <:> typ2 *)
  | SubE of exp * typ * typ      (* exp : typ1 <: typ2 *)

and expfield = atom * exp        (* atom exp *)

and path = (path', typ) note_phrase
and path' =
  | RootP                        (*  *)
  | IdxP of path * exp           (* path `[` exp `]` *)
  | SliceP of path * exp * exp   (* path `[` exp `:` exp `]` *)
  | DotP of path * atom          (* path `.` atom *)

and iterexp = iter * (id * exp) list


(* Grammars *)

and sym = sym' phrase
and sym' =
  | VarG of id * arg list                    (* gramid (`(` arg,* `)`)? *)
  | NumG of int                              (* num *)
  | TextG of string                          (* `"`text`"` *)
  | EpsG                                     (* `eps` *)
  | SeqG of sym list                         (* sym sym *)
  | AltG of sym list                         (* sym `|` sym *)
  | RangeG of sym * sym                      (* sym `|` `...` `|` sym *)
  | IterG of sym * iterexp                   (* sym iter *)
  | AttrG of exp * sym                       (* exp `:` sym *)


(* Definitions *)

and arg = arg' phrase
and arg' =
  | ExpA of exp                                       (* exp *)
  | TypA of typ                                       (* `syntax` typ *)
  | DefA of id                                        (* `def` defid *)
  | GramA of sym                                      (* `grammar` sym *)

and bind = bind' phrase
and bind' =
  | ExpB of id * typ
  | TypB of id
  | DefB of id * param list * typ
  | GramB of id * param list * typ

and param = param' phrase
and param' =
  | ExpP of id * typ                                  (* varid `:` typ *)
  | TypP of id                                        (* `syntax` varid *)
  | DefP of id * param list * typ                     (* `def` defid params `:` typ *)
  | GramP of id * typ                                 (* `grammar` gramid params `:` typ *)

and def = def' phrase
and def' =
  | TypD of id * param list * inst list               (* syntax type (family) *)
  | RelD of id * mixop * typ * rule list              (* relation *)
  | DecD of id * param list * typ * clause list       (* definition *)
  | GramD of id * param list * typ * prod list        (* grammar *)
  | RecD of def list                                  (* recursive *)
  | HintD of hintdef

and inst = inst' phrase
and inst' =
  | InstD of bind list * arg list * deftyp            (* family instance clause *)

and rule = rule' phrase
and rule' =
  | RuleD of id * bind list * mixop * exp * prem list (* relation rule *)

and clause = clause' phrase
and clause' =
  | DefD of bind list * arg list * exp * prem list    (* definition clause *)

and prod = prod' phrase
and prod' =
  | ProdD of bind list * sym * exp * prem list        (* grammar production *)

and prem = prem' phrase
and prem' =
  | RulePr of id * mixop * exp                        (* premise *)
  | IfPr of exp                                       (* side condition *)
  | LetPr of exp * exp * string list                  (* binding *)
  | ElsePr                                            (* otherwise *)
  | IterPr of prem * iterexp                          (* iteration *)

and hintdef = hintdef' phrase
and hintdef' =
  | TypH of id * hint list
  | RelH of id * hint list
  | DecH of id * hint list
  | GramH of id * hint list

and hint = {hintid : id; hintexp : El.Ast.exp}        (* hint *)


(* Scripts *)

type script = def list
