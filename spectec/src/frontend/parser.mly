%{
open Util
open Source
open El.Ast


(* Position handling *)

let position_to_pos position =
  { file = position.Lexing.pos_fname;
    line = position.Lexing.pos_lnum;
    column = position.Lexing.pos_cnum - position.Lexing.pos_bol
  }

let positions_to_region position1 position2 =
  { left = position_to_pos position1;
    right = position_to_pos position2
  }

let at (l, r) = positions_to_region l r


(* Conversions *)

let as_seq_typ typ =
  match typ.it with
  | SeqT (_::_::_ as typs) -> typs
  | _ -> [typ]

let as_seq_exp exp =
  match exp.it with
  | SeqE (_::_::_ as exps) -> exps
  | _ -> [exp]

let as_seq_sym sym =
  match sym.it with
  | SeqG (_::_::_ as syms) -> syms
  | _ -> [Elem sym]

let as_alt_sym sym =
  match sym.it with
  | AltG (_::_::_ as syms) -> syms
  | _ -> [Elem sym]

let tup_exp exps lr =
  match exps with
  | [], false -> ParenE (SeqE [] $ at lr, false) $ at lr
  | [exp], false -> ParenE (exp, false) $ at lr
  | exps, _ -> TupE exps $ at lr


(* Identifier Status *)

module VarSet = Set.Make(String)

let atom_vars = ref VarSet.empty

let strip_ticks id =
  let i = ref (String.length id) in
  while !i > 0 && id.[!i - 1] = '\'' do decr i done;
  String.sub id 0 !i


(* Parentheses Role etc *)

type prec = Op | Seq | Post | Prim

let prec_of_exp = function  (* as far as iteration is concerned *)
  | VarE _ | BoolE _ | NatE _ | HexE _ | CharE _ | TextE _ | EpsE | StrE _
  | ParenE _ | TupE _ | BrackE _ | CallE _ | HoleE _ -> Prim
  | AtomE _ | IdxE _ | SliceE _ | UpdE _ | ExtE _ | DotE _ | IterE _ -> Post
  | SeqE _ -> Seq
  | UnE _ | BinE _ | CmpE _ | InfixE _ | LenE _ | SizeE _
  | CommaE _ | CompE _ | FuseE _ -> Op

(* Extra parentheses can be inserted to disambiguate the role of elements of
 * an iteration. For example, `( x* )` will be interpreted differently from `x*`
 * in a place where an expression of some type `t*` is expected. In particular,
 * we assume `x* : t*` in the latter case, but `x* : t` in the former
 * (which makes sense in the case where `t` itself is an iteration type).
 * To make this distinction ducing elaboration, we mark potential parentheses
 * as "significant" (true) when they are not syntactically enforced, and instead
 * are assumed to have been inserted to express iteration injection.
 *)
let signify_pars prec = function
  | ParenE (exp, false) -> ParenE (exp, prec < prec_of_exp exp.it)
  | exp' -> exp'

let is_post_exp e =
  match e.it with
  | VarE _ | AtomE _
  | BoolE _ | NatE _ | HexE _ | CharE _
  | EpsE
  | ParenE _ | TupE _ | BrackE _
  | IdxE _ | SliceE _ | ExtE _
  | StrE _ | DotE _
  | IterE _ | CallE _
  | HoleE _ -> true
  | _ -> false

%}

%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE
%token COLON SEMICOLON COMMA DOT DOTDOT DOTDOTDOT BAR BARBAR DASH
%token COMMA_NL NL_BAR NL_NL_DASH NL_NL_NL
%token EQ NE LT GT LE GE APPROX EQUIV ASSIGN SUB SUP EQDOT2
%token NOT AND OR
%token QUEST PLUS MINUS STAR SLASH BACKSLASH UP COMPOSE
%token IN ARROW ARROW2 DARROW2 SQARROW SQARROWSTAR PREC SUCC TURNSTILE TILESTURN
%token DOLLAR TICK
%token BOT TOP
%token HOLE MULTIHOLE FUSE
%token BOOL NAT INT RAT REAL TEXT
%token SYNTAX GRAMMAR RELATION RULE VAR DEF
%token IF OTHERWISE HINT_LPAREN
%token EPSILON INFINITY
%token<bool> BOOLLIT
%token<int> NATLIT HEXLIT CHARLIT
%token<string> TEXTLIT
%token<string> UPID LOID DOTID UPID_LPAREN LOID_LPAREN
%token EOF

%right ARROW2 DARROW2
%left OR
%left AND
%nonassoc TURNSTILE
%nonassoc TILESTURN
%right SQARROW SQARROWSTAR PREC SUCC
%left COLON SUB SUP ASSIGN EQUIV APPROX
%left COMMA COMMA_NL
%right EQ NE LT GT LE GE IN
%right ARROW
%left SEMICOLON
%left DOT DOTDOT DOTDOTDOT
%left PLUS MINUS COMPOSE
%left STAR SLASH BACKSLASH

%start script expression check_atom
%type<El.Ast.script> script
%type<El.Ast.exp> expression
%type<bool> check_atom

%%

(* Identifiers *)

id : UPID { $1 } | LOID { $1 }
id_lparen : UPID_LPAREN { $1 } | LOID_LPAREN { $1 }

atomid_ : UPID { $1 }
varid : LOID { $1 $ at $sloc }
defid : id { $1 $ at $sloc } | IF { "if" $ at $sloc }
relid : id { $1 $ at $sloc }
gramid : id { $1 $ at $sloc }
hintid : id { $1 }
fieldid : atomid_ { Atom $1 }
dotid : DOTID { Atom $1 }

atomid_lparen : UPID_LPAREN { $1 }
varid_lparen : LOID_LPAREN { $1 $ at $sloc }
defid_lparen : id_lparen { $1 $ at $sloc }
gramid_lparen : id_lparen { $1 $ at $sloc }

ruleid : ruleid_ { $1 }
ruleid_ :
  | id { $1 }
  | NATLIT { Int.to_string $1 }
  | BOOLLIT { Bool.to_string $1 }
  | IF { "if" }
  | VAR { "var" }
  | DEF { "def" }
  | ruleid_ DOTID { $1 ^ "." ^ $2 }
atomid : atomid_ { $1 } | atomid DOTID { $1 ^ "." ^ $2 }

atom :
  | atomid { Atom $1 }
  | TICK QUEST { Quest }
  | TICK PLUS { Plus }
  | TICK STAR { Star }
  | BOT { Bot }
  | TOP { Top }
  | INFINITY { Infinity }

atom_as_varid :
  | atomid_ { atom_vars := VarSet.add $1 !atom_vars; $1 $ at $sloc }
atom_as_varid_lparen :
  | atomid_lparen { atom_vars := VarSet.add $1 !atom_vars; $1 $ at $sloc }

check_atom :
  | UPID EOF { VarSet.mem (strip_ticks $1) !atom_vars }


(* Iteration *)

iter :
  | QUEST { Opt }
  | PLUS { List1 }
  | STAR { List }
  | UP arith_prim
    { match $2.it with
      | ParenE ({it = CmpE({it = VarE id; _}, LtOp, e); _}, false) ->
        ListN (e, Some id)
      | _ -> ListN ($2, None)
    }


(* Types *)

typ_prim : typ_prim_ { $1 $ at $sloc }
typ_prim_ :
  | varid { VarT $1 }
  | BOOL { BoolT }
  | NAT { NumT NatT }
  | INT { NumT IntT }
  | RAT { NumT RatT }
  | REAL { NumT RealT }
  | TEXT { TextT }

typ_post : typ_post_ { $1 $ at $sloc }
typ_post_ :
  | typ_prim_ { $1 }
  | LPAREN typ_list RPAREN
    { match $2 with
      | [typ], false -> ParenT typ
      | typs, _ -> TupT typs
    }
  | typ_post iter { IterT ($1, $2) }

typ : typ_post { $1 }

typ_list :
  | (* empty *) { [], true }
  | typ { $1::[], false }
  | typ COMMA typ_list { $1::fst $3, snd $3 }
  | typ COMMA_NL typ_list { $1::fst $3, snd $3 }

deftyp : deftyp_ { $1 $ at $sloc }
deftyp_ :
  | nottyp { $1.it }
  | LBRACE fieldtyp_list RBRACE { StrT $2 }
  | BAR casetyp_list { let x, y, z = $2 in CaseT (NoDots, x, y, z) }
  | NL_BAR casetyp_list { let x, y, z = $2 in CaseT (NoDots, x, y, z) }
  | dots BAR casetyp_list { let x, y, z = $3 in CaseT (Dots, x, y, z) }
  | dots NL_BAR casetyp_list { let x, y, z = $3 in CaseT (Dots, x, Nl::y, z) }
  | enumtyp_list1 { RangeT $1 }

dots :
  | DOTDOTDOT {}
  | BAR DOTDOTDOT {}
  | NL_BAR DOTDOTDOT {}


(*nottyp_prim : nottyp_prim_ { $1 $ at $sloc }*)
nottyp_prim_ :
  | typ_prim { $1.it }
  | atom { AtomT $1 }
  | atomid_lparen nottyp RPAREN
    { SeqT [AtomT (Atom $1) $ at $loc($1); ParenT $2 $ at $loc($2)] }
  | TICK LPAREN nottyp RPAREN { BrackT (LParen, $3, RParen) }
  | TICK LBRACK nottyp RBRACK { BrackT (LBrack, $3, RBrack) }
  | TICK LBRACE nottyp RBRACE { BrackT (LBrace, $3, RBrace) }
  | LPAREN nottyp_list RPAREN { match $2 with [t] -> ParenT t | ts -> TupT ts }

nottyp_post : nottyp_post_ { $1 $ at $sloc }
nottyp_post_ :
  | nottyp_prim_ { $1 }
  | nottyp_post iter { IterT ($1, $2) }

nottyp_seq : nottyp_seq_ { $1 $ at $sloc }
nottyp_seq_ :
  | nottyp_post_ { $1 }
  | nottyp_post nottyp_seq { SeqT ($1 :: as_seq_typ $2) }

nottyp_un : nottyp_un_ { $1 $ at $sloc }
nottyp_un_ :
  | nottyp_seq_ { $1 }
  | DOT nottyp_un { InfixT (SeqT [] $ at $loc($1), Dot, $2) }
  | DOTDOT nottyp_un { InfixT (SeqT [] $ at $loc($1), Dot2, $2) }
  | DOTDOTDOT nottyp_un { InfixT (SeqT [] $ at $loc($1), Dot3, $2) }
  | SEMICOLON nottyp_un { InfixT (SeqT [] $ at $loc($1), Semicolon, $2) }
  | ARROW nottyp_un { InfixT (SeqT [] $ at $loc($1), Arrow, $2) }

nottyp_bin : nottyp_bin_ { $1 $ at $sloc }
nottyp_bin_ :
  | nottyp_un_ { $1 }
  | nottyp_bin DOT nottyp_bin { InfixT ($1, Dot, $3) }
  | nottyp_bin DOTDOT nottyp_bin { InfixT ($1, Dot2, $3) }
  | nottyp_bin DOTDOTDOT nottyp_bin { InfixT ($1, Dot3, $3) }
  | nottyp_bin SEMICOLON nottyp_bin { InfixT ($1, Semicolon, $3) }
  | nottyp_bin BACKSLASH nottyp_bin { InfixT ($1, Backslash, $3) }
  | nottyp_bin ARROW nottyp_bin { InfixT ($1, Arrow, $3) }

nottyp_rel : nottyp_rel_ { $1 $ at $sloc }
nottyp_rel_ :
  | nottyp_bin_ { $1 }
  | COLON nottyp_rel { InfixT (SeqT [] $ at $loc($1), Colon, $2) }
  | SUB nottyp_rel { InfixT (SeqT [] $ at $loc($1), Sub, $2) }
  | SUP nottyp_rel { InfixT (SeqT [] $ at $loc($1), Sup, $2) }
  | ASSIGN nottyp_rel { InfixT (SeqT [] $ at $loc($1), Assign, $2) }
  | EQUIV nottyp_rel { InfixT (SeqT [] $ at $loc($1), Equiv, $2) }
  | APPROX nottyp_rel { InfixT (SeqT [] $ at $loc($1), Approx, $2) }
  | SQARROW nottyp_rel { InfixT (SeqT [] $ at $loc($1), SqArrow, $2) }
  | SQARROWSTAR nottyp_rel { InfixT (SeqT [] $ at $loc($1), SqArrowStar, $2) }
  | PREC nottyp_rel { InfixT (SeqT [] $ at $loc($1), Prec, $2) }
  | SUCC nottyp_rel { InfixT (SeqT [] $ at $loc($1), Succ, $2) }
  | TILESTURN nottyp_rel { InfixT (SeqT [] $ at $loc($1), Tilesturn, $2) }
  | TURNSTILE nottyp_rel { InfixT (SeqT [] $ at $loc($1), Turnstile, $2) }
  | IN nottyp_rel { InfixT (SeqT [] $ at $loc($1), In, $2) }
  | nottyp_rel COLON nottyp_rel { InfixT ($1, Colon, $3) }
  | nottyp_rel SUB nottyp_rel { InfixT ($1, Sub, $3) }
  | nottyp_rel SUP nottyp_rel { InfixT ($1, Sup, $3) }
  | nottyp_rel ASSIGN nottyp_rel { InfixT ($1, Assign, $3) }
  | nottyp_rel EQUIV nottyp_rel { InfixT ($1, Equiv, $3) }
  | nottyp_rel APPROX nottyp_rel { InfixT ($1, Approx, $3) }
  | nottyp_rel SQARROW nottyp_rel { InfixT ($1, SqArrow, $3) }
  | nottyp_rel SQARROWSTAR nottyp_rel { InfixT ($1, SqArrowStar, $3) }
  | nottyp_rel PREC nottyp_rel { InfixT ($1, Prec, $3) }
  | nottyp_rel SUCC nottyp_rel { InfixT ($1, Succ, $3) }
  | nottyp_rel TILESTURN nottyp_rel { InfixT ($1, Tilesturn, $3) }
  | nottyp_rel TURNSTILE nottyp_rel { InfixT ($1, Turnstile, $3) }
  | nottyp_rel IN nottyp_rel { InfixT ($1, In, $3) }

nottyp : nottyp_rel { $1 }

nottyps :
  | (* empty *) { [] }
  | nottyp_post nottyps { $1::$2 }

nottyp_list :
  | (* empty *) { [] }
  | nottyp { $1::[] }
  | nottyp COMMA nottyp_list { $1::$3 }
  | nottyp COMMA_NL nottyp_list { $1::$3 }

fieldtyp_list :
  | (* empty *) { [] }
  | fieldid typ hint_list premise_bin_list
    { (Elem ($1, ($2, $4), $3))::[] }
  | fieldid typ hint_list premise_bin_list COMMA fieldtyp_list
    { (Elem ($1, ($2, $4), $3))::$6 }
  | fieldid typ hint_list premise_bin_list COMMA_NL fieldtyp_list
    { (Elem ($1, ($2, $4), $3))::Nl::$6 }

casetyp_list :
  | (* empty *) { [], [], NoDots }
  | DOTDOTDOT { [], [], Dots }
  | varid casetyp_cont
    { let x, y, z = $2 `L in (Elem $1)::x, y, z }
  | atom nottyps hint_list premise_list casetyp_cont
    { let x, y, z = $5 `R in x, (Elem ($1, ($2, $4), $3))::y, z }
  | TICK LPAREN nottyps RPAREN hint_list premise_list casetyp_cont
    { let x, y, z = $7 `R in
      x, (Elem (LParen, ($3@[AtomT RParen $ at $loc($4)], $6), $5))::y, z }
  | TICK LBRACK nottyps RBRACK hint_list premise_list casetyp_cont
    { let x, y, z = $7 `R in
      x, (Elem (LBrack, ($3@[AtomT RBrack $ at $loc($4)], $6), $5))::y, z }
  | TICK LBRACE nottyps RBRACE hint_list premise_list casetyp_cont
    { let x, y, z = $7 `R in
      x, (Elem (LBrace, ($3@[AtomT RBrace $ at $loc($4)], $6), $5))::y, z }

casetyp_cont :
  | (* empty *) { fun (_side : [`L | `R]) -> [], [], NoDots }
  | BAR casetyp_list { fun _side -> $2 }
  | NL_BAR casetyp_list
    { fun side -> let x, y, z = $2 in 
      if side = `L then Nl::x, y, z else x, Nl::y, z }

enumtyp_list :
  | arith { Elem ($1, None) :: [] }
  | arith BAR enumtyp_list { Elem ($1, None) :: $3 }
  | arith NL_BAR enumtyp_list { Elem ($1, None) :: $3 }
  | arith BAR DOTDOTDOT BAR arith { Elem ($1, Some $5) :: [] }
  | arith BAR DOTDOTDOT BAR arith BAR enumtyp_list { Elem ($1, Some $5) :: $7 }
  | arith BAR DOTDOTDOT BAR arith NL_BAR enumtyp_list { Elem ($1, Some $5) :: Nl :: $7 }

enumtyp_list1 :
  | arith_lit { Elem ($1, None) :: [] }
  | arith_lit BAR enumtyp_list { Elem ($1, None) :: $3 }
  | arith_lit NL_BAR enumtyp_list { Elem ($1, None) :: Nl :: $3 }
  | arith_lit BAR DOTDOTDOT BAR arith { Elem ($1, Some $5) :: [] }
  | arith_lit BAR DOTDOTDOT BAR arith BAR enumtyp_list { Elem ($1, Some $5) :: $7 }
  | arith_lit BAR DOTDOTDOT BAR arith NL_BAR enumtyp_list { Elem ($1, Some $5) :: $7 }
  | PLUS arith_un { Elem (UnE (PlusOp, $2) $ $2.at, None) :: [] }
  | PLUS arith_un BAR enumtyp_list { Elem (UnE (PlusOp, $2) $ $2.at, None) :: $4 }
  | PLUS arith_un NL_BAR enumtyp_list { Elem (UnE (PlusOp, $2) $ $2.at, None) :: Nl :: $4 }
  | PLUS arith_un BAR DOTDOTDOT BAR arith { Elem (UnE (PlusOp, $2) $ $2.at, Some $6) :: [] }
  | PLUS arith_un BAR DOTDOTDOT BAR arith BAR enumtyp_list { Elem (UnE (PlusOp, $2) $ $2.at, Some $6) :: $8 }
  | PLUS arith_un BAR DOTDOTDOT BAR arith NL_BAR enumtyp_list { Elem (UnE (PlusOp, $2) $ $2.at, Some $6) :: $8 }
  | MINUS arith_un { Elem (UnE (MinusOp, $2) $ $2.at, None) :: [] }
  | MINUS arith_un BAR enumtyp_list { Elem (UnE (MinusOp, $2) $ $2.at, None) :: $4 }
  | MINUS arith_un NL_BAR enumtyp_list { Elem (UnE (MinusOp, $2) $ $2.at, None) :: Nl :: $4 }
  | MINUS arith_un BAR DOTDOTDOT BAR arith { Elem (UnE (MinusOp, $2) $ $2.at, Some $6) :: [] }
  | MINUS arith_un BAR DOTDOTDOT BAR arith BAR enumtyp_list { Elem (UnE (MinusOp, $2) $ $2.at, Some $6) :: $8 }
  | MINUS arith_un BAR DOTDOTDOT BAR arith NL_BAR enumtyp_list { Elem (UnE (MinusOp, $2) $ $2.at, Some $6) :: $8 }


(* Expressions *)

(*exp_prim : exp_prim_ { $1 $ at $sloc }*)
exp_prim_ :
  | varid { VarE $1 }
  | BOOL { VarE ("bool" $ at $sloc) }
  | NAT { VarE ("nat" $ at $sloc) }
  | INT { VarE ("int" $ at $sloc) }
  | TEXT { VarE ("text" $ at $sloc) }
  | BOOLLIT { BoolE $1 }
  | NATLIT { NatE $1 }
  | HEXLIT { HexE $1 }
  | CHARLIT { CharE $1 }
  | TEXTLIT { TextE $1 }
  | EPSILON { EpsE }
  | LBRACE fieldexp_list RBRACE { StrE $2 }
  | HOLE { HoleE false }
  | MULTIHOLE { HoleE true }
  | LPAREN exp_list RPAREN { (tup_exp $2 $loc($2)).it }
  | TICK LPAREN exp RPAREN { BrackE (LParen, $3, RParen) }
  | TICK LBRACK exp RBRACK { BrackE (LBrack, $3, RBrack) }
  | TICK LBRACE exp RBRACE { BrackE (LBrace, $3, RBrace) }
  | DOLLAR LPAREN arith RPAREN { $3.it }
  | DOLLAR defid { CallE ($2, TupE [] $ at $sloc) }
  | DOLLAR defid_lparen exp_list RPAREN { CallE ($2, tup_exp $3 $loc($3)) }

exp_post : exp_post_ { $1 $ at $sloc }
exp_post_ :
  | exp_prim_ { signify_pars Post $1 }
  | exp_atom LBRACK arith RBRACK { IdxE ($1, $3) }
  | exp_atom LBRACK arith COLON arith RBRACK { SliceE ($1, $3, $5) }
  | exp_atom LBRACK path EQ exp RBRACK { UpdE ($1, $3, $5) }
  | exp_atom LBRACK path EQDOT2 exp RBRACK { ExtE ($1, $3, $5) }
  | exp_atom iter { IterE ($1, $2) }
  | exp_post dotid { DotE ($1, $2) }

exp_atom : exp_atom_ { $1 $ at $sloc }
exp_atom_ :
  | exp_post_ { $1 }
  | atom { AtomE $1 }
  | atomid_lparen exp RPAREN
    { SeqE [AtomE (Atom $1) $ at $loc($1); ParenE ($2, false) $ at $loc($2)] }

exp_seq : exp_seq_ { $1 $ at $sloc }
exp_seq_ :
  | exp_atom_ { signify_pars Seq $1 }
  | exp_seq exp_atom { SeqE (as_seq_exp $1 @ [$2]) }
  | exp_seq FUSE exp_atom { FuseE ($1, $3) }

exp_un : exp_un_ { $1 $ at $sloc }
exp_un_ :
  | exp_seq_ { signify_pars Op $1 }
  | BAR exp BAR { LenE $2 }
  | NL_BAR exp BAR { LenE $2 }
  | BAR exp NL_BAR { LenE $2 }
  | NL_BAR exp NL_BAR { LenE $2 }
  | BARBAR gramid BARBAR { SizeE $2 }
  | NOT exp_un { UnE (NotOp, $2) }
  | DOT exp_un { InfixE (SeqE [] $ at $loc($1), Dot, $2) }
  | DOTDOT exp_un { InfixE (SeqE [] $ at $loc($1), Dot2, $2) }
  | DOTDOTDOT exp_un { InfixE (SeqE [] $ at $loc($1), Dot3, $2) }
  | SEMICOLON exp_un { InfixE (SeqE [] $ at $loc($1), Semicolon, $2) }
  | ARROW exp_un { InfixE (SeqE [] $ at $loc($1), Arrow, $2) }

exp_bin : exp_bin_ { $1 $ at $sloc }
exp_bin_ :
  | exp_un_ { $1 }
  | exp_bin COMPOSE exp_bin { CompE ($1, $3) }
  | exp_bin DOT exp_bin { InfixE ($1, Dot, $3) }
  | exp_bin DOTDOT exp_bin { InfixE ($1, Dot2, $3) }
  | exp_bin DOTDOTDOT exp_bin { InfixE ($1, Dot3, $3) }
  | exp_bin SEMICOLON exp_bin { InfixE ($1, Semicolon, $3) }
  | exp_bin BACKSLASH exp_bin { InfixE ($1, Backslash, $3) }
  | exp_bin ARROW exp_bin { InfixE ($1, Arrow, $3) }
  | exp_bin EQ exp_bin { CmpE ($1, EqOp, $3) }
  | exp_bin NE exp_bin { CmpE ($1, NeOp, $3) }
  | exp_bin LT exp_bin { CmpE ($1, LtOp, $3) }
  | exp_bin GT exp_bin { CmpE ($1, GtOp, $3) }
  | exp_bin LE exp_bin { CmpE ($1, LeOp, $3) }
  | exp_bin GE exp_bin { CmpE ($1, GeOp, $3) }
  | exp_bin AND exp_bin { BinE ($1, AndOp, $3) }
  | exp_bin OR exp_bin { BinE ($1, OrOp, $3) }
  | exp_bin ARROW2 exp_bin { BinE ($1, ImplOp, $3) }
  | exp_bin DARROW2 exp_bin { BinE ($1, EquivOp, $3) }

exp_rel : exp_rel_ { $1 $ at $sloc }
exp_rel_ :
  | exp_bin_ { $1 }
  | COMMA exp_rel { CommaE (SeqE [] $ at $loc($1), $2) }
  | COMMA_NL exp_rel { CommaE (SeqE [] $ at $loc($1), $2) }
  | COLON exp_rel { InfixE (SeqE [] $ at $loc($1), Colon, $2) }
  | SUB exp_rel { InfixE (SeqE [] $ at $loc($1), Sub, $2) }
  | SUP exp_rel { InfixE (SeqE [] $ at $loc($1), Sup, $2) }
  | ASSIGN exp_rel { InfixE (SeqE [] $ at $loc($1), Assign, $2) }
  | EQUIV exp_rel { InfixE (SeqE [] $ at $loc($1), Equiv, $2) }
  | APPROX exp_rel { InfixE (SeqE [] $ at $loc($1), Approx, $2) }
  | SQARROW exp_rel { InfixE (SeqE [] $ at $loc($1), SqArrow, $2) }
  | SQARROWSTAR exp_rel { InfixE (SeqE [] $ at $loc($1), SqArrowStar, $2) }
  | PREC exp_rel { InfixE (SeqE [] $ at $loc($1), Prec, $2) }
  | SUCC exp_rel { InfixE (SeqE [] $ at $loc($1), Succ, $2) }
  | TILESTURN exp_rel { InfixE (SeqE [] $ at $loc($1), Tilesturn, $2) }
  | TURNSTILE exp_rel { InfixE (SeqE [] $ at $loc($1), Turnstile, $2) }
  | IN exp_rel { InfixE (SeqE [] $ at $loc($1), In, $2) }
  | exp_rel COMMA exp_rel { CommaE ($1, $3) }
  | exp_rel COMMA_NL exp_rel { CommaE ($1, $3) }
  | exp_rel COLON exp_rel { InfixE ($1, Colon, $3) }
  | exp_rel SUB exp_rel { InfixE ($1, Sub, $3) }
  | exp_rel SUP exp_rel { InfixE ($1, Sup, $3) }
  | exp_rel ASSIGN exp_rel { InfixE ($1, Assign, $3) }
  | exp_rel EQUIV exp_rel { InfixE ($1, Equiv, $3) }
  | exp_rel APPROX exp_rel { InfixE ($1, Approx, $3) }
  | exp_rel SQARROW exp_rel { InfixE ($1, SqArrow, $3) }
  | exp_rel SQARROWSTAR exp_rel { InfixE ($1, SqArrowStar, $3) }
  | exp_rel PREC exp_rel { InfixE ($1, Prec, $3) }
  | exp_rel SUCC exp_rel { InfixE ($1, Succ, $3) }
  | exp_rel TILESTURN exp_rel { InfixE ($1, Tilesturn, $3) }
  | exp_rel TURNSTILE exp_rel { InfixE ($1, Turnstile, $3) }
  | exp_rel IN exp_rel { InfixE ($1, In, $3) }

exp : exp_rel { $1 }

fieldexp_list :
  | (* empty *) { [] }
  | fieldid exps1 { (Elem ($1, $2))::[] }
  | fieldid exps1 COMMA fieldexp_list { (Elem ($1, $2))::$4 }
  | fieldid exps1 COMMA_NL fieldexp_list { (Elem ($1, $2))::Nl::$4 }

exp_list :
  | (* empty *) { [], true }
  | exp_bin { $1::[], false }
  | exp_bin COMMA exp_list { $1::fst $3, snd $3 }
  | exp_bin COMMA_NL exp_list { $1::fst $3, snd $3 }

exps1 :
  | exp_post { $1 }
  | exp_post exps1 { SeqE ($1 :: as_seq_exp $2) $ at $sloc }


arith_lit : arith_lit_ { $1 $ at $sloc }
arith_lit_ :
  | BOOLLIT { BoolE $1 }
  | NATLIT { NatE $1 }
  | HEXLIT { HexE $1 }
  | CHARLIT { CharE $1 }
  | HOLE { HoleE false }
  | MULTIHOLE { HoleE true }

arith_prim : arith_prim_ { $1 $ at $sloc }
arith_prim_ :
  | arith_lit_ { $1 }
  | varid { VarE $1 }
  | BOOL { VarE ("bool" $ at $sloc) }
  | NAT { VarE ("nat" $ at $sloc) }
  | INT { VarE ("int" $ at $sloc) }
  | TEXT { VarE ("text" $ at $sloc) }
  | LPAREN arith RPAREN { ParenE ($2, false) }
  | LPAREN arith_bin STAR RPAREN
    { (* HACK: to allow "(s*)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        Source.error (at $loc($3)) "syntax" "misplaced token";
      IterE ($2, List) }
  | LPAREN arith_bin PLUS RPAREN
    { (* HACK: to allow "(s+)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        Source.error (at $loc($3)) "syntax" "misplaced token";
      IterE ($2, List1) }
  | LPAREN arith_bin QUEST RPAREN
    { (* HACK: to allow "(s?)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        Source.error (at $loc($3)) "syntax" "misplaced token";
      IterE ($2, Opt) }
  | DOLLAR LPAREN exp RPAREN { $3.it }
  | DOLLAR defid { CallE ($2, TupE [] $ at $sloc) }
  | DOLLAR defid_lparen exp_list RPAREN { CallE ($2, tup_exp $3 $loc($3)) }

arith_post : arith_post_ { $1 $ at $sloc }
arith_post_ :
  | arith_prim_ { $1 }
  | arith_atom UP arith_prim { BinE ($1, ExpOp, $3) }
  | arith_atom LBRACK arith RBRACK { IdxE ($1, $3) }
  | arith_post dotid { DotE ($1, $2) }

arith_atom : arith_atom_ { $1 $ at $sloc }
arith_atom_ :
  | arith_post_ { $1 }
  | atom { AtomE $1 }

arith_un : arith_un_ { $1 $ at $sloc }
arith_un_ :
  | arith_atom_ { $1 }
  | BAR exp BAR { LenE $2 }
  | NL_BAR exp BAR { LenE $2 }
  | BAR exp NL_BAR { LenE $2 }
  | NL_BAR exp NL_BAR { LenE $2 }
  | NOT arith_un { UnE (NotOp, $2) }
  | PLUS arith_un { UnE (PlusOp, $2) }
  | MINUS arith_un { UnE (MinusOp, $2) }

arith_bin : arith_bin_ { $1 $ at $sloc }
arith_bin_ :
  | arith_un_ { $1 }
  | arith_bin STAR arith_bin { BinE ($1, MulOp, $3) }
  | arith_bin SLASH arith_bin { BinE ($1, DivOp, $3) }
  | arith_bin PLUS arith_bin { BinE ($1, AddOp, $3) }
  | arith_bin MINUS arith_bin { BinE ($1, SubOp, $3) }
  | arith_bin EQ arith_bin { CmpE ($1, EqOp, $3) }
  | arith_bin NE arith_bin { CmpE ($1, NeOp, $3) }
  | arith_bin LT arith_bin { CmpE ($1, LtOp, $3) }
  | arith_bin GT arith_bin { CmpE ($1, GtOp, $3) }
  | arith_bin LE arith_bin { CmpE ($1, LeOp, $3) }
  | arith_bin GE arith_bin { CmpE ($1, GeOp, $3) }
  | arith_bin AND arith_bin { BinE ($1, AndOp, $3) }
  | arith_bin OR arith_bin { BinE ($1, OrOp, $3) }
  | arith_bin ARROW2 arith_bin { BinE ($1, OrOp, $3) }

arith : arith_bin { $1 }


path : path_ { $1 $ at $sloc }
path_ :
  | (* empty *) { RootP }
  | path LBRACK arith RBRACK { IdxP ($1, $3) }
  | path LBRACK arith COLON arith RBRACK { SliceP ($1, $3, $5) }
  | path dotid { DotP ($1, $2) }


(* Premises *)

premise_list :
  | (* empty *) { [] }
  | DASH premise premise_list { (Elem $2)::$3 }
  | NL_NL_DASH premise premise_list { Nl::(Elem $2)::$3 }

premise_bin_list :
  | (* empty *) { [] }
  | DASH premise_bin premise_bin_list { (Elem $2)::$3 }
  | NL_NL_DASH premise_bin premise_bin_list { Nl::(Elem $2)::$3 }

(*premise_post : premise_post_ { $1 $ at $sloc }*)
premise_post_ :
  | OTHERWISE { ElsePr }
  | LPAREN premise RPAREN iter_list
    { let rec iters prem = function
        | [] -> prem
        | iter::iters' -> iters (IterPr (prem, iter) $ at $sloc) iters'
      in (iters $2 $4).it }

premise_bin : premise_bin_ { $1 $ at $sloc }
premise_bin_ :
  | premise_post_ { $1 }
  | relid COLON exp_bin { RulePr ($1, $3) }
  | IF exp_bin
    { let rec iters e =
        match e.it with
        | IterE (e1, iter) -> IterPr (iters e1 $ e1.at, iter)
        | _ -> IfPr e
      in iters $2 }

premise : premise_ { $1 $ at $sloc }
premise_ :
  | premise_post_ { $1 }
  | relid COLON exp { RulePr ($1, $3) }
  | IF exp
    { let rec iters e =
        match e.it with
        | IterE (e1, iter) -> IterPr (iters e1 $ e1.at, iter)
        | _ -> IfPr e
      in iters $2 }

iter_list :
  | (* empty *) { [] }
  | iter iter_list { $1::$2 }


(* Grammars *)

(*sym_prim : sym_prim_ { $1 $ at $sloc }*)
sym_prim_ :
  | gramid { VarG ($1, []) }
  | gramid_lparen sym_list RPAREN { VarG ($1, $2) }
  | NATLIT { NatG $1 }
  | HEXLIT { HexG $1 }
  | CHARLIT { CharG $1 }
  | TEXTLIT { TextG $1 }
  | EPSILON { EpsG }
  | LPAREN sym_list RPAREN { match $2 with [g] -> ParenG g | gs -> TupG gs }
  | DOLLAR LPAREN arith RPAREN { ArithG $3 }

sym_post : sym_post_ { $1 $ at $sloc }
sym_post_ :
  | sym_prim_ { $1 }
  | sym_post iter { IterG ($1, $2) }

sym_attr : sym_attr_ { $1 $ at $sloc }
sym_attr_ :
  | sym_post_ { $1 }
  | sym_post COLON sym_post { AttrG ($3, Elab.exp_of_sym $1) }

sym_seq : sym_seq_ { $1 $ at $sloc }
sym_seq_ :
  | sym_attr_ { $1 }
  | sym_seq sym_attr { SeqG (as_seq_sym $1 @ [Elem $2]) }
  | sym_seq NL_NL_NL sym_attr { SeqG (as_seq_sym $1 @ [Nl; Elem $3]) }

sym_alt : sym_alt_ { $1 $ at $sloc }
sym_alt_ :
  | sym_seq_ { $1 }
  | sym_alt BAR sym_seq { AltG (as_alt_sym $1 @ [Elem $3]) }
  | sym_alt NL_BAR sym_seq { AltG (as_alt_sym $1 @ [Nl; Elem $3]) }
  | sym_alt BAR DOTDOTDOT BAR sym_seq { RangeG ($1, $5) }
  | sym_alt BAR DOTDOTDOT NL_BAR sym_seq { RangeG ($1, $5) }
  | sym_alt NL_BAR DOTDOTDOT BAR sym_seq { RangeG ($1, $5) }
  | sym_alt NL_BAR DOTDOTDOT NL_BAR sym_seq { RangeG ($1, $5) }

sym : sym_alt { $1 }

sym_list :
  | (* empty *) { [] }
  | sym { [$1] }
  | sym COMMA sym_list { $1::$3 }
  | sym COMMA_NL sym_list { $1::$3 }

prod : prod_ { $1 $ at $sloc }
prod_ :
  | sym ARROW2 exp premise_list { ($1, $3, $4) }

prod_list :
  | (* empty *) { [], NoDots }
  | DOTDOTDOT { [], Dots }
  | prod { (Elem $1)::[], NoDots }
  | prod BAR prod_list { let x, y = $3 in (Elem $1)::x, y }
  | prod NL_BAR prod_list { let x, y = $3 in (Elem $1)::Nl::x, y }

gram : gram_ { $1 $ at $sloc }
gram_ :
  | BAR prod_list { let x, y = $2 in (NoDots, x, y) }
  | NL_BAR prod_list { let x, y = $2 in (NoDots, x, y) }
  | dots BAR prod_list { let x, y = $3 in (Dots, x, y) }
  | dots NL_BAR prod_list { let x, y = $3 in (Dots, Nl::x, y) }


(* Definitions *)

param : param_ { $1 $ at $sloc }
param_ :
  | varid { VarP $1 }
  | GRAMMAR gramid COLON varid iter_list { GramP ($2, $4, $5) }
  | GRAMMAR gramid COLON atom_as_varid iter_list { GramP ($2, $4, $5) }

param_list :
  | (* empty *) { [] }
  | param { $1::[] }
  | param COMMA param_list { $1::$3 }
  | param COMMA_NL param_list { $1::$3 }


def : def_ { $1 $ at $sloc }
def_ :
  | SYNTAX varid ruleid_list hint_list EQ deftyp
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      SynD ($2, id $ at $loc($3), $6, $4) }
  | SYNTAX atom_as_varid ruleid_list hint_list EQ deftyp
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      SynD ($2, id $ at $loc($3), $6, $4) }
  | GRAMMAR varid ruleid_list COLON typ hint_list EQ gram
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      GramD ($2, id $ at $loc($3), [], $5, $8, $6) }
  | GRAMMAR atom_as_varid ruleid_list COLON typ hint_list EQ gram
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      GramD ($2, id $ at $loc($3), [], $5, $8, $6) }
  | GRAMMAR varid_lparen param_list RPAREN ruleid_list COLON typ hint_list EQ gram
    { let id = if $5 = "" then "" else String.sub $5 1 (String.length $5 - 1) in
      GramD ($2, id $ at $loc($5), $3, $7, $10, $8) }
  | GRAMMAR atom_as_varid_lparen param_list RPAREN ruleid_list COLON typ hint_list EQ gram
    { let id = if $5 = "" then "" else String.sub $5 1 (String.length $5 - 1) in
      GramD ($2, id $ at $loc($5), $3, $7, $10, $8) }
  | RELATION relid COLON nottyp hint_list
    { RelD ($2, $4, $5) }
  | RULE relid ruleid_list COLON exp premise_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      RuleD ($2, id $ at $loc($3), $5, $6) }
  | VAR varid COLON typ hint_list
    { VarD ($2, $4, $5) }
  | VAR atom_as_varid COLON typ hint_list
    { VarD ($2, $4, $5) }
  | DEF DOLLAR defid COLON typ hint_list
    { DecD ($3, TupE [] $ at $loc($4), $5, $6) }
  | DEF DOLLAR defid_lparen exp_list RPAREN COLON typ hint_list
    { DecD ($3, tup_exp $4 $loc($4), $7, $8) }
  | DEF DOLLAR defid EQ exp premise_list
    { DefD ($3, TupE [] $ at $loc($4), $5, $6) }
  | DEF DOLLAR defid_lparen exp_list RPAREN EQ exp premise_list
    { DefD ($3, tup_exp $4 $loc($4), $7, $8) }
  | NL_NL_NL
    { SepD }
  | SYNTAX varid ruleid_list hint_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (SynH ($2, id $ at $loc($3), $4) $ at $sloc) }
  | SYNTAX atom_as_varid ruleid_list hint_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (SynH ($2, id $ at $loc($3), $4) $ at $sloc) }
  | SYNTAX varid ruleid_list atomid hint_list
    { HintD (AtomH ($4 $ at $loc($4), $5) $ at $sloc) }
  | SYNTAX atom_as_varid ruleid_list atomid hint_list
    { HintD (AtomH ($4 $ at $loc($4), $5) $ at $sloc) }
  | GRAMMAR varid ruleid_list hint_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (GramH ($2, id $ at $loc($3), $4) $ at $sloc) }
  | GRAMMAR atom_as_varid ruleid_list hint_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (GramH ($2, id $ at $loc($3), $4) $ at $sloc) }
  | RELATION relid hint_list
    { HintD (RelH ($2, $3) $ at $sloc) }
  | VAR varid hint_list
    { HintD (VarH ($2, $3) $ at $sloc) }
  | DEF DOLLAR defid hint_list
    { HintD (DecH ($3, $4) $ at $sloc) }

ruleid_list :
  | (* empty *) { "" }
  | SLASH ruleid ruleid_list { "/" ^ $2 ^ $3 }
  | MINUS ruleid ruleid_list { "-" ^ $2 ^ $3 }


hint :
  | HINT_LPAREN hintid exp RPAREN { {hintid = $2 $ at $loc($2); hintexp = $3} }
  | HINT_LPAREN hintid RPAREN { {hintid = $2 $ at $loc($2); hintexp = SeqE [] $ at $loc($2)} }

hint_list :
  | (* empty *) { [] }
  | hint hint_list { $1::$2 }


(* Scripts *)

def_list :
  | (* empty *) { [] }
  | def def_list { $1::$2 }

script :
  | def_list EOF { $1 }

expression :
  | exp EOF { $1 }

%%
