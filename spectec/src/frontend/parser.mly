%{
open Util
open Source
open El.Ast


(* Error handling *)

let error at msg = Source.error at "syntax" msg

let parse_error msg =
  error Source.no_region
    (if msg = "syntax error" then "unexpected token" else msg)


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

let at () =
  positions_to_region (Parsing.symbol_start_pos ()) (Parsing.symbol_end_pos ())
let ati i =
  positions_to_region (Parsing.rhs_start_pos i) (Parsing.rhs_end_pos i)


let as_seq_typ typ =
  match typ.it with
  | SeqT (_::_::_ as typs) -> typs
  | _ -> [typ]

let as_seq_exp exp =
  match exp.it with
  | SeqE (_::_::_ as exps) -> exps
  | _ -> [exp]


(* Identifier Status *)

module VarSet = Set.Make(String)

let atom_vars = ref VarSet.empty

%}

%token LPAR RPAR LBRACK RBRACK LBRACE RBRACE
%token COLON SEMICOLON COMMA DOT DOT2 DOT3 BAR DASH
%token COMMA_NL NL_BAR NL3
%token EQ NE LT GT LE GE SUB EQDOT2
%token NOT AND OR
%token QUEST PLUS MINUS STAR SLASH UP COMPOSE
%token ARROW ARROW2 SQARROW TURNSTILE TILESTURN
%token DOLLAR TICK
%token BOT
%token HOLE MULTIHOLE FUSE
%token BOOL NAT TEXT
%token SYNTAX RELATION RULE VAR DEF
%token IFF OTHERWISE HINT
%token EPSILON
%token<bool> BOOLLIT
%token<int> NATLIT
%token<string> TEXTLIT
%token<string> UPID LOID DOTID
%token EOF

%right ARROW2
%left OR
%left AND
%nonassoc TURNSTILE
%nonassoc TILESTURN
%right SQARROW
%left COLON SUB
%left COMMA COMMA_NL
%right EQ NE LT GT LE GE
%right ARROW
%left SEMICOLON
%left DOT DOT2 DOT3
%left PLUS MINUS COMPOSE
%left STAR SLASH
%left UP
%left FUSE

%start script exp check_atom
%type<El.Ast.script> script
%type<El.Ast.exp> exp
%type<bool> check_atom

%%

/* Identifiers */

id : UPID { $1 } | LOID { $1 }

atomid_ : UPID { $1 }
varid : LOID { $1 $ at () }
defid : id { $1 $ at () }
relid : id { $1 $ at () }
hintid : id { $1 }
fieldid : atomid_ { Atom $1 }
dotid : DOTID { Atom $1 }

ruleid : ruleid_ { $1 }
ruleid_ : id { $1 } | ruleid_ DOTID { $1 ^ "." ^ $2 }
atomid : atomid_ { $1 } | atomid DOTID { $1 ^ "." ^ $2 }

atom :
  | atomid { Atom $1 }
  | BOT { Bot }

atom_as_varid :
  | atomid_ { atom_vars := VarSet.add $1 !atom_vars; $1 $ at () }

check_atom :
  | UPID EOF { VarSet.mem $1 !atom_vars }


/* Iteration */

iter :
  | QUEST { Opt }
  | PLUS { List1 }
  | STAR { List }
  | UP arith_prim { ListN $2 }


/* Types */

typ_prim : typ_prim_ { $1 $ at () }
typ_prim_ :
  | varid { VarT $1 }
  | BOOL { BoolT }
  | NAT { NatT }
  | TEXT { TextT }

typ_post : typ_post_ { $1 $ at () }
typ_post_ :
  | typ_prim_ { $1 }
  | LPAR typ_list RPAR
    { match $2 with
      | [typ], false -> ParenT typ
      | typs, _ -> TupT typs
    }
  | typ_post iter { IterT ($1, $2) }

typ : typ_post { $1 }

typ_list :
  | /* empty */ { [], true }
  | typ { $1::[], false }
  | typ COMMA typ_list { $1::fst $3, snd $3 }
  | typ COMMA_NL typ_list { $1::fst $3, snd $3 }

deftyp : deftyp_ { $1 $ at () }
deftyp_ :
  | nottyp { NotationT $1 }
  | LBRACE fieldtyp_list RBRACE { StructT $2 }
  | BAR casetyp_list { VariantT (fst $2, snd $2) }
  | NL_BAR casetyp_list { VariantT (fst $2, snd $2) }


nottyp_prim : nottyp_prim_ { $1 $ at () }
nottyp_prim_ :
  | typ_prim { TypT $1 }
  | atom { AtomT $1 }
  | TICK LPAR nottyp RPAR { BrackT (Paren, $3) }
  | TICK LBRACK nottyp RBRACK { BrackT (Brack, $3) }
  | TICK LBRACE nottyp RBRACE { BrackT (Brace, $3) }
  | LPAR nottyp RPAR {
      match $2.it with
      | TypT typ -> TypT (ParenT typ $ at ())
      | _ -> ParenNT $2
    }

nottyp_post : nottyp_post_ { $1 $ at () }
nottyp_post_ :
  | nottyp_prim_ { $1 }
  | nottyp_post iter {
      match $1.it with
      | TypT typ -> TypT (IterT (typ, $2) $ at ())
      | _ -> IterNT ($1, $2)
    }

nottyp_seq : nottyp_seq_ { $1 $ at () }
nottyp_seq_ :
  | nottyp_post_ { $1 }
  | nottyp_post nottyp_seq { SeqT ($1 :: as_seq_typ $2) }

nottyp_un : nottyp_un_ { $1 $ at () }
nottyp_un_ :
  | nottyp_seq_ { $1 }
  | DOT nottyp_un { InfixT (SeqT [] $ ati 1, Dot, $2) }
  | DOT2 nottyp_un { InfixT (SeqT [] $ ati 1, Dot2, $2) }
  | DOT3 nottyp_un { InfixT (SeqT [] $ ati 1, Dot3, $2) }
  | SEMICOLON nottyp_un { InfixT (SeqT [] $ ati 1, Semicolon, $2) }
  | ARROW nottyp_un { InfixT (SeqT [] $ ati 1, Arrow, $2) }

nottyp_bin : nottyp_bin_ { $1 $ at () }
nottyp_bin_ :
  | nottyp_un_ { $1 }
  | nottyp_bin DOT nottyp_bin { InfixT ($1, Dot, $3) }
  | nottyp_bin DOT2 nottyp_bin { InfixT ($1, Dot2, $3) }
  | nottyp_bin DOT3 nottyp_bin { InfixT ($1, Dot3, $3) }
  | nottyp_bin SEMICOLON nottyp_bin { InfixT ($1, Semicolon, $3) }
  | nottyp_bin ARROW nottyp_bin { InfixT ($1, Arrow, $3) }

nottyp_unrel : nottyp_unrel_ { $1 $ at () }
nottyp_unrel_ :
  | nottyp_bin_ { $1 }
  | COLON nottyp_rel { InfixT (SeqT [] $ ati 1, Colon, $2) }
  | SUB nottyp_rel { InfixT (SeqT [] $ ati 1, Sub, $2) }
  | SQARROW nottyp_rel { InfixT (SeqT [] $ ati 1, SqArrow, $2) }
  | TILESTURN nottyp_rel { InfixT (SeqT [] $ ati 1, Tilesturn, $2) }
  | TURNSTILE nottyp_rel { InfixT (SeqT [] $ ati 1, Turnstile, $2) }

nottyp_rel : nottyp_rel_ { $1 $ at () }
nottyp_rel_ :
  | nottyp_unrel_ { $1 }
  | nottyp_rel COLON nottyp_rel { InfixT ($1, Colon, $3) }
  | nottyp_rel SUB nottyp_rel { InfixT ($1, Sub, $3) }
  | nottyp_rel SQARROW nottyp_rel { InfixT ($1, SqArrow, $3) }
  | nottyp_rel TILESTURN nottyp_rel { InfixT ($1, Tilesturn, $3) }
  | nottyp_rel TURNSTILE nottyp_rel { InfixT ($1, Turnstile, $3) }

nottyp : nottyp_rel { $1 }

nottyps :
  | /* empty */ { [] }
  | nottyp_post nottyps { $1::$2 }

fieldtyp_list :
  | /* empty */ { [] }
  | fieldid typ hint_list { (Elem ($1, $2, $3))::[] }
  | fieldid typ hint_list COMMA fieldtyp_list { (Elem ($1, $2, $3))::$5 }
  | fieldid typ hint_list COMMA_NL fieldtyp_list { (Elem ($1, $2, $3))::Nl::$5 }

casetyp_list :
  | /* empty */ { [], [] }
  | varid { [Elem $1], [] }
  | varid BAR casetyp_list { (Elem $1)::fst $3, snd $3 }
  | varid NL_BAR casetyp_list { (Elem $1)::Nl::fst $3, snd $3 }
  | atom nottyps hint_list { [], (Elem ($1, $2, $3))::[] }
  | atom nottyps hint_list BAR casetyp_list { fst $5, (Elem ($1, $2, $3))::snd $5 }
  | atom nottyps hint_list NL_BAR casetyp_list { fst $5, (Elem ($1, $2, $3))::Nl::snd $5 }


/* Expressions */

exp_prim : exp_prim_ { $1 $ at () }
exp_prim_ :
  | varid { VarE $1 }
  | BOOLLIT { BoolE $1 }
  | NATLIT { NatE $1 }
  | TEXTLIT { TextE $1 }
  | EPSILON { EpsE }
  | LBRACE fieldexp_list RBRACE { StrE $2 }
  | HOLE { HoleE false }
  | MULTIHOLE { HoleE true }
  | LPAR exp_list RPAR
    { match $2 with
      | [], false -> ParenE (SeqE [] $ ati 2)
      | [exp], false -> ParenE exp
      | exps, _ -> TupE exps
    }
  | TICK LPAR exp RPAR { BrackE (Paren, $3) }
  | TICK LBRACK exp RBRACK { BrackE (Brack, $3) }
  | TICK LBRACE exp RBRACE { BrackE (Brace, $3) }
  | DOLLAR LPAR arith RPAR { $3.it }
  | DOLLAR defid exp_prim { CallE ($2, $3) }

exp_post : exp_post_ { $1 $ at () }
exp_post_ :
  | exp_prim_ { $1 }
  | exp_post LBRACK arith RBRACK { IdxE ($1, $3) }
  | exp_post LBRACK arith COLON arith RBRACK { SliceE ($1, $3, $5) }
  | exp_post LBRACK path EQ exp RBRACK { UpdE ($1, $3, $5) }
  | exp_post LBRACK path EQDOT2 exp RBRACK { ExtE ($1, $3, $5) }
  | exp_post dotid { DotE ($1, $2) }
  | exp_post iter { IterE ($1, $2) }

exp_atom : exp_atom_ { $1 $ at () }
exp_atom_ :
  | exp_post_ { $1 }
  | atom { AtomE $1 }

exp_seq : exp_seq_ { $1 $ at () }
exp_seq_ :
  | exp_atom_ { $1 }
  | exp_atom exp_seq { SeqE ($1 :: as_seq_exp $2) }

exp_call : exp_call_ { $1 $ at () }
exp_call_ :
  | exp_seq_ { $1 }
  | BAR exp BAR { LenE $2 }
  | NL_BAR exp BAR { LenE $2 }
  | BAR exp NL_BAR { LenE $2 }
  | NL_BAR exp NL_BAR { LenE $2 }

exp_un : exp_un_ { $1 $ at () }
exp_un_ :
  | exp_call_ { $1 }
  | NOT exp_un { UnE (NotOp, $2) }
  | DOT exp_un { InfixE (SeqE [] $ ati 1, Dot, $2) }
  | DOT2 exp_un { InfixE (SeqE [] $ ati 1, Dot2, $2) }
  | DOT3 exp_un { InfixE (SeqE [] $ ati 1, Dot3, $2) }
  | SEMICOLON exp_un { InfixE (SeqE [] $ ati 1, Semicolon, $2) }
  | ARROW exp_un { InfixE (SeqE [] $ ati 1, Arrow, $2) }

exp_bin : exp_bin_ { $1 $ at () }
exp_bin_ :
  | exp_un_ { $1 }
  | exp_bin COMPOSE exp_bin { CompE ($1, $3) }
  | exp_bin DOT exp_bin { InfixE ($1, Dot, $3) }
  | exp_bin DOT2 exp_bin { InfixE ($1, Dot2, $3) }
  | exp_bin DOT3 exp_bin { InfixE ($1, Dot3, $3) }
  | exp_bin SEMICOLON exp_bin { InfixE ($1, Semicolon, $3) }
  | exp_bin ARROW exp_bin { InfixE ($1, Arrow, $3) }
  | exp_bin EQ exp_bin { CmpE ($1, EqOp, $3) }
  | exp_bin NE exp_bin { CmpE ($1, NeOp, $3) }
  | exp_bin LT exp_bin { CmpE ($1, LtOp, $3) }
  | exp_bin GT exp_bin { CmpE ($1, GtOp, $3) }
  | exp_bin LE exp_bin { CmpE ($1, LeOp, $3) }
  | exp_bin GE exp_bin { CmpE ($1, GeOp, $3) }
  | exp_bin AND exp_bin { BinE ($1, AndOp, $3) }
  | exp_bin OR exp_bin { BinE ($1, OrOp, $3) }
  | exp_bin ARROW2 exp_bin { BinE ($1, OrOp, $3) }
  | exp_bin FUSE exp_bin { FuseE ($1, $3) }

exp_unrel : exp_unrel_ { $1 $ at () }
exp_unrel_ :
  | exp_bin_ { $1 }
  | COMMA exp_rel { CommaE (SeqE [] $ ati 1, $2) }
  | COMMA_NL exp_rel { CommaE (SeqE [] $ ati 1, $2) }
  | COLON exp_rel { InfixE (SeqE [] $ ati 1, Colon, $2) }
  | SUB exp_rel { InfixE (SeqE [] $ ati 1, Sub, $2) }
  | SQARROW exp_rel { InfixE (SeqE [] $ ati 1, SqArrow, $2) }
  | TILESTURN exp_rel { InfixE (SeqE [] $ ati 1, Tilesturn, $2) }
  | TURNSTILE exp_rel { InfixE (SeqE [] $ ati 1, Turnstile, $2) }

exp_rel : exp_rel_ { $1 $ at () }
exp_rel_ :
  | exp_unrel_ { $1 }
  | exp_rel COMMA exp_rel { CommaE ($1, $3) }
  | exp_rel COMMA_NL exp_rel { CommaE ($1, $3) }
  | exp_rel COLON exp_rel { InfixE ($1, Colon, $3) }
  | exp_rel SUB exp_rel { InfixE ($1, Sub, $3) }
  | exp_rel SQARROW exp_rel { InfixE ($1, SqArrow, $3) }
  | exp_rel TILESTURN exp_rel { InfixE ($1, Tilesturn, $3) }
  | exp_rel TURNSTILE exp_rel { InfixE ($1, Turnstile, $3) }

exp : exp_rel { $1 }

fieldexp_list :
  | /* empty */ { [] }
  | fieldid exps1 { (Elem ($1, $2))::[] }
  | fieldid exps1 COMMA fieldexp_list { (Elem ($1, $2))::$4 }
  | fieldid exps1 COMMA_NL fieldexp_list { (Elem ($1, $2))::Nl::$4 }

exp_list :
  | /* empty */ { [], true }
  | exp_bin { $1::[], false }
  | exp_bin COMMA exp_list { $1::fst $3, snd $3 }
  | exp_bin COMMA_NL exp_list { $1::fst $3, snd $3 }

exps1 :
  | exp_post { $1 }
  | exp_post exps1 { SeqE ($1 :: as_seq_exp $2) $ at () }


arith_prim : arith_prim_ { $1 $ at () }
arith_prim_ :
  | varid { VarE $1 }
  | NATLIT { NatE $1 }
  | LPAR arith RPAR { ParenE $2 }

arith_post : arith_post_ { $1 $ at () }
arith_post_ :
  | arith_prim_ { $1 }
  | arith_post UP arith_prim { BinE ($1, ExpOp, $3) }
  | arith_post LBRACK arith RBRACK { IdxE ($1, $3) }
  | arith_post dotid { DotE ($1, $2) }

arith_atom : arith_atom_ { $1 $ at () }
arith_atom_ :
  | arith_post_ { $1 }
  | atom { AtomE $1 }

arith_call : arith_call_ { $1 $ at () }
arith_call_ :
  | arith_atom_ { $1 }
  | BAR exp BAR { LenE $2 }
  | NL_BAR exp BAR { LenE $2 }
  | BAR exp NL_BAR { LenE $2 }
  | NL_BAR exp NL_BAR { LenE $2 }
  | DOLLAR defid { CallE ($2, SeqE [] $ at ()) }
  | DOLLAR defid exp_prim { CallE ($2, $3) }

arith_un : arith_un_ { $1 $ at () }
arith_un_ :
  | arith_call_ { $1 }
  | NOT arith_un { UnE (NotOp, $2) }
  | PLUS arith_un { UnE (PlusOp, $2) }
  | MINUS arith_un { UnE (MinusOp, $2) }

arith_bin : arith_bin_ { $1 $ at () }
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


path : path_ { $1 $ at () }
path_ :
  | /* empty */ { RootP }
  | path LBRACK arith RBRACK { IdxP ($1, $3) }
  | path dotid { DotP ($1, $2) }


/* Definitions */

def : def_ { $1 $ at () }
def_ :
  | SYNTAX varid hint_list EQ deftyp
    { SynD ($2, $5, $3) }
  | SYNTAX atom_as_varid hint_list EQ deftyp
    { SynD ($2, $5, $3) }
  | RELATION relid hint_list COLON nottyp
    { RelD ($2, $5, $3) }
  | RULE relid ruleid_list COLON exp premise_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      RuleD ($2, id $ ati 3, $5, $6) }
  | VAR varid COLON typ hint_list
    { VarD ($2, $4, $5) }
  | VAR atom_as_varid COLON typ hint_list
    { VarD ($2, $4, $5) }
  | DEF DOLLAR defid COLON typ hint_list
    { DecD ($3, SeqE [] $ ati 4, $5, $6) }
  | DEF DOLLAR defid exp_prim COLON typ hint_list
    { DecD ($3, $4, $6, $7) }
  | DEF DOLLAR defid EQ exp premise_opt
    { DefD ($3, SeqE [] $ ati 4, $5, $6) }
  | DEF DOLLAR defid exp_prim EQ exp premise_opt
    { DefD ($3, $4, $6, $7) }
  | NL3
    { SepD }

ruleid_list :
  | /* empty */ { "" }
  | SLASH ruleid ruleid_list { "/" ^ $2 ^ $3 }
  | MINUS ruleid ruleid_list { "-" ^ $2 ^ $3 }

premise_opt :
  | /* empty */ { None }
  | DASH premise { Some $2 }

premise_list :
  | /* empty */ { [] }
  | DASH premise premise_list { $2::$3 }

premise : premise_ { $1 $ at () }
premise_ :
  | relid COLON exp { RulePr ($1, $3, None) }
  | IFF exp { IffPr ($2, None) }
  | OTHERWISE { ElsePr }
  | LPAR relid COLON exp RPAR iter { RulePr ($2, $4, Some $6) }
  | LPAR IFF exp RPAR iter { IffPr ($3, Some $5) }

hint :
  | HINT LPAR hintid exp RPAR { {hintid = $3 $ ati 3; hintexp = $4} }

hint_list :
  | /* empty */ { [] }
  | hint hint_list { $1::$2 }


/* Scripts */

def_list :
  | /* empty */ { [] }
  | def def_list { $1::$2 }

script :
  | def_list EOF { $1 }

%%
