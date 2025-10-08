%{
open Util
open Source
open El.Ast
open Xl


(* Errors *)

let error at msg = Error.error at "syntax" msg


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

let ($) it pos = it $ at pos
let ($$) it pos = it $$ at pos % Atom.info ""


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


(* Identifiers *)

let check_varid_bind id =
  if id.it = (El.Convert.strip_var_suffix id).it then id else
    error id.at "invalid identifer suffix in binding position"


(* Classifications *)

let is_post_exp e =
  match e.it with
  | VarE _ | AtomE _
  | BoolE _ | NumE _
  | EpsE
  | ParenE _ | TupE _ | BrackE _
  | ListE _ | IdxE _ | SliceE _ | ExtE _
  | StrE _ | DotE _
  | IterE _ | CvtE _ | CallE _
  | HoleE _ -> true
  | _ -> false

let is_atom t =
  match t.it with
  | AtomT _ -> true
  | _ -> false

let is_typfield t =
  match t.it with
  | SeqT [t1; _] -> is_atom t1
  | VarT _ | BoolT | NumT _ | TextT | TupT _ | SeqT _
  | AtomT _ | InfixT _ | BrackT _
  | ParenT _ | IterT _ -> false
  | StrT _ | CaseT _ | ConT _ | RangeT _ -> assert false

let rec is_typcase t =
  match t.it with
  | AtomT _ | InfixT _ | BrackT _ -> true
  | SeqT (t'::_) -> is_typcase t'
  | VarT _ | BoolT | NumT _ | TextT | TupT _ | SeqT _
  | ParenT _ | IterT _ -> false
  | StrT _ | CaseT _ | ConT _ | RangeT _ -> assert false

let rec is_typcon t =
  match t.it with
  | AtomT _ | InfixT _ | BrackT _ | SeqT _ -> true
  | VarT _ | BoolT | NumT _ | TextT | TupT _ | ParenT _ -> false
  | IterT (t1, _) -> is_typcon t1
  | StrT _ | CaseT _ | ConT _ | RangeT _ -> assert false


(* Helpers for grammar productions *)

let rec alt_sym = function
  | [] -> assert false
  | Nl::alts -> alt_sym alts
  | (Elem g)::alts when List.for_all ((=) Nl) alts -> g
  | alts ->
    let open Source in
    AltG alts $ over_region (El.Convert.map_filter_nl_list Source.at alts)

let long_prod (g, e, prems) =
  let open Source in
  let ats = g.at :: e.at :: El.Convert.map_filter_nl_list Source.at prems in
  Elem (SynthP (g, e, prems) $ over_region ats)

let equiv_prod (g1, g2, prems) =
  let open Source in
  let ats = g1.at :: g2.at :: El.Convert.map_filter_nl_list Source.at prems in
  Elem (EquivP (g1, g2, prems) $ over_region ats)

let short_prod (g, prems) =
  let open Source in
  let var () = VarE ("<implicit-prod-result>" $ g.at, []) $ g.at in
  let ats = g.at :: El.Convert.map_filter_nl_list Source.at prems in
  Elem (SynthP (AttrG (var (), g) $ g.at, var (), prems) $ over_region ats)

let rec long_alt_prod (els, e, prems) = long_alt_prod' (List.rev els, e, prems)
and long_alt_prod' = function
  | ([], _, _) -> assert false
  | (Nl::elsr, e, []) -> long_alt_prod' (elsr, e, []) @ [Nl]
  | (Nl::elsr, e, prems) -> long_alt_prod' (elsr, e, prems)
  | ((Elem g)::elsr, e, prems) when List.for_all ((=) Nl) elsr ->
    [long_prod (g, e, prems)]
  | (elsr, e, prems) ->
    let open Source in
    let ats = El.Convert.map_filter_nl_list Source.at elsr in
    [long_prod (AltG (List.rev elsr) $ over_region ats, e, prems)]

let rec long_equiv_prod (alts, g2, prems) = long_equiv_prod' (List.rev alts, g2, prems)
and long_equiv_prod' = function
  | ([], _, _) -> assert false
  | (Nl::elsr, g2, []) -> long_equiv_prod' (elsr, g2, []) @ [Nl]
  | (Nl::elsr, g2, prems) -> long_equiv_prod' (elsr, g2, prems)
  | ((Elem g1)::elsr, g2, prems) when List.for_all ((=) Nl) elsr ->
    [equiv_prod (g1, g2, prems)]
  | (elsr, g2, prems) ->
    let open Source in
    let ats = El.Convert.map_filter_nl_list Source.at elsr in
    [equiv_prod (AltG (List.rev elsr) $ over_region ats, g2, prems)]

let rec short_alt_prod (els, prems) = short_alt_prod' (List.rev els, prems)
and short_alt_prod' = function
  | ([], []) -> []
  | ([], _) -> assert false
  | (Nl::elsr, []) -> short_alt_prod' (elsr, []) @ [Nl]
  | (Nl::elsr, prems) -> short_alt_prod' (elsr, prems)
  | ((Elem g)::elsr, prems) ->
    List.rev_map (function Nl -> Nl | Elem g -> short_prod (g, [])) elsr
    @ [short_prod (g, prems)]

%}

%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE
%token COLON SEMICOLON COMMA DOT DOTDOT DOTDOTDOT BAR BARBAR DASH COLONSUB
%token BIGAND BIGOR BIGADD BIGMUL BIGCAT
%token COMMA_NL NL_BAR NL_NL NL_NL_NL
%token EQ NE LT GT LE GE APPROX EQUIV ASSIGN SUB SUP EQCAT EQSUB EQUIVSUB APPROXSUB
%token NOT AND OR
%token QUEST PLUS MINUS STAR SLASH BACKSLASH UP CAT PLUSMINUS MINUSPLUS
%token ARROW ARROW2 ARROWSUB ARROW2SUB DARROW2 SQARROW SQARROWSUB SQARROWSTAR SQARROWSTARSUB
%token MEM NOTMEM PREC SUCC TURNSTILE TILESTURN TURNSTILESUB TILESTURNSUB
%token DOLLAR TICK
%token BOT TOP
%token HOLE MULTIHOLE NOTHING FUSE FUSEFUSE LATEX
%token<int> HOLEN
%token BOOL NAT INT RAT REAL TEXT
%token SYNTAX GRAMMAR RELATION RULE VAR DEF
%token IF OTHERWISE HINT_LPAREN
%token EPS INFINITY
%token<bool> BOOLLIT
%token<Z.t> NATLIT HEXLIT CHARLIT
%token<string> TEXTLIT
%token<string> UPID LOID DOTID UPID_LPAREN LOID_LPAREN
%token EOF

%right ARROW2 DARROW2 ARROW2SUB
%left OR
%left AND
%nonassoc TURNSTILE TURNSTILESUB
%nonassoc TILESTURN TILESTURNSUB
%right SQARROW SQARROWSUB SQARROWSTAR SQARROWSTARSUB PREC SUCC BIGAND BIGOR BIGADD BIGMUL BIGCAT
%left COLON SUB SUP ASSIGN EQUIV APPROX COLONSUB EQUIVSUB APPROXSUB
%left COMMA COMMA_NL
%right EQ NE LT GT LE GE MEM NOTMEM EQSUB
%right ARROW ARROWSUB
%left SEMICOLON
%left DOT DOTDOT DOTDOTDOT
%left PLUS MINUS CAT
%left STAR SLASH BACKSLASH

%start script typ_eof exp_eof sym_eof check_atom
%type<El.Ast.script> script
%type<El.Ast.typ> typ_eof
%type<El.Ast.exp> exp_eof
%type<El.Ast.sym> sym_eof
%type<bool> check_atom

%%

(* Lists *)

%inline bar(X) :  (* X is dummy to enforce polymorphism *)
  | BAR { [] }
  | NL_BAR { [Nl] }

%inline comma(X) :  (* X is dummy to enforce polymorphism *)
  | COMMA { [] }
  | COMMA_NL { [Nl] }

comma_list(X) :
  | (* empty *) { [] }
  | X { $1::[] }
  | X comma(X) comma_list(X) { $1::$3 }

comma_nl_list(X) :
  | (* empty *) { [] }
  | X { (Elem $1)::[] }
  | X comma(X) comma_nl_list(X) { (Elem $1)::$2 @ $3 }

nl_bar_list(X) : nl_bar_list1(X, X) { $1 }
nl_bar_list1(X, Y) :
  | X { Elem $1 :: [] }
  | X bar(X) nl_bar_list(Y) { (Elem $1)::$2 @ $3 }

nl_dash_list(X) :
  | (* empty *) { [] }
  | nl_dash_list1(X) { $1 }

nl_dash_list1(X) :
  | DASH DASH nl_dash_list(X) { Nl::$3 }
  | DASH X nl_dash_list(X) { (Elem $2)::$3 }

%inline bar_dots :
  | DOTDOTDOT {}
  | bar(bar_dots) DOTDOTDOT {}

dots_bar_list(X) :
  | dots_bar_list1(X) { let x, y = $1 in (NoDots, x, y) }
  | bar(X) dots_bar_list1(X) { let x, y = $2 in (NoDots, x, y) }
  | bar_dots bar(X) dots_bar_list1(X) { let x, y = $3 in (Dots, $2 @ x, y) }

dots_bar_list1(X) :
  | (* empty *) { [], NoDots }
  | DOTDOTDOT { [], Dots }
  | X { (Elem $1)::[], NoDots }
  | X bar(X) dots_bar_list1(X) { let x, y = $3 in (Elem $1)::$2 @ x, y }

dots_comma_list(X) :
  | dots_comma_list1(X) { let x, y = $1 in (NoDots, x, y) }
  | DOTDOTDOT comma(X) dots_comma_list1(X) { let x, y = $3 in (Dots, $2 @ x, y) }

dots_comma_list1(X) :
  | (* empty *) { [], NoDots }
  | DOTDOTDOT { [], Dots }
  | X { (Elem $1)::[], NoDots }
  | X comma(X) dots_comma_list1(X) { let x, y = $3 in (Elem $1)::$2 @ x, y }


(* Identifiers *)

id : UPID { $1 } | LOID { $1 }
id_lparen : UPID_LPAREN { $1 } | LOID_LPAREN { $1 }

atomid_ : UPID { $1 }
varid : LOID { $1 $ $sloc }
defid : id { $1 $ $sloc } | IF { "if" $ $sloc }
relid : id { $1 $ $sloc }
gramid : id { $1 $ $sloc }
hintid : id { $1 }
fieldid : atomid_ { Atom.Atom $1 $$ $sloc } | atom_escape { $1 $$ $sloc }
dotid : DOTID { Atom.Atom $1 $$ $sloc }

atomid_lparen : UPID_LPAREN { $1 }
varid_lparen : LOID_LPAREN { $1 $ $sloc }
defid_lparen : id_lparen { $1 $ $sloc }
gramid_lparen : id_lparen { $1 $ $sloc }

ruleid : ruleid_ { $1 }
ruleid_ :
  | id { $1 }
  | NATLIT { Z.to_string $1 }
  | BOOLLIT { Bool.to_string $1 }
  | INFINITY { "infinity" }
  | EPS { "eps" }
  | IF { "if" }
  | VAR { "var" }
  | DEF { "def" }
  | RULE { "rule" }
  | RELATION { "relation" }
  | SYNTAX { "syntax" }
  | GRAMMAR { "grammar" }
  | ruleid_ DOTID { $1 ^ "." ^ $2 }
atomid : atomid_ { $1 } | atomid DOTID { $1 ^ "." ^ $2 }

atom :
  | atom_ { $1 $$ $sloc }
atom_ :
  | atomid { Atom.Atom $1 }
  | atom_escape { $1 }
atom_escape :
  | TICK EQ { Atom.Equal }
  | TICK NE { Atom.NotEqual }
  | TICK LT { Atom.Less }
  | TICK GT { Atom.Greater }
  | TICK LE { Atom.LessEqual }
  | TICK GE { Atom.GreaterEqual }
  | TICK MEM { Atom.Mem }
  | TICK NOTMEM { Atom.NotMem }
  | TICK QUEST { Atom.Quest }
  | TICK PLUS { Atom.Plus }
  | TICK STAR { Atom.Star }
  | TICK BAR { Atom.Bar }
  | TICK CAT { Atom.Cat }
  | TICK COMMA { Atom.Comma }
  | TICK ARROW2 { Atom.Arrow2 }
  | TICK infixop_ { $2 }
  | TICK relop_ { $2 }
  | BOT { Atom.Bot }
  | TOP { Atom.Top }
  | INFINITY { Atom.Infinity }

varid_bind_with_suffix :
  | varid { $1 }
  | atomid_ { Id.make_var $1; $1 $ $sloc }
varid_bind :
  | varid_bind_with_suffix { check_varid_bind $1 }
varid_bind_lparen :
  | varid_lparen { check_varid_bind $1 }
  | atomid_lparen { Id.make_var $1; check_varid_bind ($1 $ $sloc) }

enter_scope :
  | (* empty *) { Id.enter_scope () }
exit_scope :
  | (* empty *) { Id.exit_scope () }

check_atom :
  | UPID EOF { Id.is_var (El.Convert.strip_var_suffix ($1 $ $sloc)).it }


(* Operators *)

%inline unop :
  | NOT { `NotOp }
  | PLUS { `PlusOp }
  | MINUS { `MinusOp }
  | PLUSMINUS { `PlusMinusOp }
  | MINUSPLUS { `MinusPlusOp }

%inline binop :
  | PLUS { `AddOp }
  | MINUS { `SubOp }
  | STAR { `MulOp }
  | SLASH { `DivOp }
  | BACKSLASH { `ModOp }

%inline cmpop :
  | EQ { `EqOp }
  | NE { `NeOp }
  | LT { `LtOp }
  | GT { `GtOp }
  | LE { `LeOp }
  | GE { `GeOp }

%inline boolop :
  | AND { `AndOp }
  | OR { `OrOp }
  | ARROW2 { `ImplOp }
  | DARROW2 { `EquivOp }

%inline infixop :
  | infixop_ { $1 $$ $sloc }
%inline infixop_ :
  | DOT { Atom.Dot }
  | DOTDOT { Atom.Dot2 }
  | DOTDOTDOT { Atom.Dot3 }
  | SEMICOLON { Atom.Semicolon }
  | BACKSLASH { Atom.Backslash }
  | ARROW { Atom.Arrow }
  | ARROWSUB { Atom.ArrowSub }
  | ARROW2SUB { Atom.Arrow2Sub }
  | BIGAND { Atom.BigAnd }
  | BIGOR { Atom.BigOr }
  | BIGADD { Atom.BigAdd }
  | BIGMUL { Atom.BigMul }
  | BIGCAT { Atom.BigCat }

%inline relop :
  | relop_ { $1 $$ $sloc }
%inline relop_ :
  | EQSUB { Atom.EqualSub }
  | COLON { Atom.Colon }
  | COLONSUB { Atom.ColonSub }
  | SUB { Atom.Sub }
  | SUP { Atom.Sup }
  | ASSIGN { Atom.Assign }
  | EQUIV { Atom.Equiv }
  | EQUIVSUB { Atom.EquivSub }
  | APPROX { Atom.Approx }
  | APPROXSUB { Atom.ApproxSub }
  | SQARROW { Atom.SqArrow }
  | SQARROWSUB { Atom.SqArrowSub }
  | SQARROWSTAR { Atom.SqArrowStar }
  | SQARROWSTARSUB { Atom.SqArrowStarSub }
  | PREC { Atom.Prec }
  | SUCC { Atom.Succ }
  | TILESTURN { Atom.Tilesturn }
  | TILESTURNSUB { Atom.TilesturnSub }
  | TURNSTILE { Atom.Turnstile }
  | TURNSTILESUB { Atom.TurnstileSub }


(* Iteration *)

iter :
  | QUEST { Opt }
  | PLUS { List1 }
  | STAR { List }
  | UP arith_prim
    { match $2.it with
      | ParenE {it = CmpE ({it = VarE (id, []); _}, `LtOp, e); _} ->
        ListN (e, Some id)
      | _ -> ListN ($2, None)
    }


(* Types *)

numtyp :
  | NAT { `NatT }
  | INT { `IntT }
  | RAT { `RatT }
  | REAL { `RealT }

(*typ_prim : typ_prim_ { $1 $ $sloc }*)
typ_prim_ :
  | varid { VarT ($1, []) }
  | varid_lparen comma_list(arg) RPAREN { VarT ($1, $2) }
  | BOOL { BoolT }
  | numtyp { NumT $1 }
  | TEXT { TextT }

typ_post : typ_post_ { $1 $ $sloc }
typ_post_ :
  | typ_prim_ { $1 }
  | LPAREN comma_list(typ) RPAREN
    { match $2 with
      | [] -> ParenT (SeqT [] $ $sloc)
      | [t] -> ParenT t
      | ts -> TupT ts }
  | typ_post iter { IterT ($1, $2) }

typ : typ_post { $1 }

deftyp : deftyp_ { $1 $ $sloc }
deftyp_ :
  | LBRACE dots_comma_list(fieldtyp) RBRACE
    { let dots1, tfs, dots2 = $2 in
      match dots1, El.Convert.filter_nl tfs, dots2 with
      | NoDots, [(t, prems, hints)], NoDots when not (is_typfield t) ->
        if prems <> [] then
          error t.at "misplaced premise"
        else if hints <> [] then
          error (List.hd hints).hintid.at "misplaced hint"
        else
          t.it
      | _ ->
        let y1, y2, _ =
          List.fold_right
            (fun elem (y1, y2, at) ->
              (* at is the position of leftmost id element so far *)
              match elem with
              | Nl -> if at = None then y1, Nl::y2, at else Nl::y1, y2, at
              | Elem (t, prems, hints) ->
                match t.it with
                | SeqT [{it = AtomT atom; _}; t2] when at = None ->
                  y1, (Elem (atom, (t2, prems), hints))::y2, None
                | AtomT _ | InfixT _ | BrackT _ | SeqT _ ->
                  error t.at "malformed field type"
                | _ when prems = [] && hints = [] ->
                  (Elem t)::y1, y2, Some t.at
                | _ ->
                  let at = Option.value at ~default: t.at in
                  error at "misplaced type"
            ) tfs ([], [], None)
        in StrT (dots1, y1, y2, dots2) }
  | dots_bar_list(casetyp)
    { let dots1, tcs, dots2 = $1 in
      match dots1, El.Convert.filter_nl tcs, dots2 with
      | NoDots, [(t, prems, hints)], NoDots when not (is_typcase t) ->
        if is_typcon t || prems <> [] then
          ConT ((t, prems), hints)
        else if hints = [] then
          t.it
        else
          error (List.hd hints).hintid.at "misplaced hint"
      | _ ->
        let y1, y2, _ =
          List.fold_right
            (fun elem (y1, y2, at) ->
              (* at is the position of leftmost id element so far *)
              match elem with
              | Nl -> if at = None then y1, Nl::y2, at else Nl::y1, y2, at
              | Elem (t, prems, hints) ->
                match t.it with
                | AtomT atom
                | InfixT (_, atom, _)
                | BrackT (atom, _, _)
                | SeqT ({it = AtomT atom; _}::_)
                | SeqT ({it = InfixT (_, atom, _); _}::_)
                | SeqT ({it = BrackT (atom, _, _); _}::_) when at = None ->
                  y1, (Elem (atom, (t, prems), hints))::y2, None
                | _ when prems = [] && hints = [] ->
                  (Elem t)::y1, y2, Some t.at
                | _ ->
                  let at = Option.value at ~default: t.at in
                  error at "misplaced type"
            ) tcs ([], [], None)
        in CaseT (dots1, y1, y2, dots2) }
  | nl_bar_list1(enumtyp(enum1), enumtyp(arith)) { RangeT $1 }


(*nottyp_prim : nottyp_prim_ { $1 $ $sloc }*)
nottyp_prim_ :
  | typ_prim_ { $1 }
  | atom { AtomT $1 }
  | atomid_lparen nottyp RPAREN
    { SeqT [
        AtomT (Atom.Atom $1 $$ $loc($1)) $ $loc($1);
        ParenT $2 $ $loc($2)
      ] }
  | TICK LPAREN nottyp RPAREN
    { BrackT (Atom.LParen $$ $loc($2), $3, Atom.RParen $$ $loc($4)) }
  | TICK LBRACK nottyp RBRACK
    { BrackT (Atom.LBrack $$ $loc($2), $3, Atom.RBrack $$ $loc($4)) }
  | TICK LBRACE nottyp RBRACE
    { BrackT (Atom.LBrace $$ $loc($2), $3, Atom.RBrace $$ $loc($4)) }
  | LPAREN comma_list(typ) RPAREN
    { match $2 with
      | [] -> ParenT (SeqT [] $ $sloc)
      | [t] -> ParenT t
      | ts -> TupT ts }

nottyp_post : nottyp_post_ { $1 $ $sloc }
nottyp_post_ :
  | nottyp_prim_ { $1 }
  | nottyp_post iter { IterT ($1, $2) }

nottyp_seq : nottyp_seq_ { $1 $ $sloc }
nottyp_seq_ :
  | nottyp_post_ { $1 }
  | nottyp_post nottyp_seq { SeqT ($1 :: as_seq_typ $2) }

nottyp_un : nottyp_un_ { $1 $ $sloc }
nottyp_un_ :
  | nottyp_seq_ { $1 }
  | infixop nottyp_un { InfixT (SeqT [] $ $loc($1), $1, $2) }

nottyp_bin : nottyp_bin_ { $1 $ $sloc }
nottyp_bin_ :
  | nottyp_un_ { $1 }
  | nottyp_bin infixop nottyp_bin { InfixT ($1, $2, $3) }

nottyp_rel : nottyp_rel_ { $1 $ $sloc }
nottyp_rel_ :
  | nottyp_bin_ { $1 }
  | relop nottyp_rel { InfixT (SeqT [] $ $loc($1), $1, $2) }
  | nottyp_rel relop nottyp_rel { InfixT ($1, $2, $3) }

nottyp : nottyp_rel { $1 }

fieldtyp :
  | nottyp hint* prem_bin_list { $1, $3, $2 }

casetyp :
  | nottyp hint* prem_list { $1, $3, $2 }

%inline enumtyp(X) :
  | X { ($1, None) }
  | X BAR DOTDOTDOT BAR arith { ($1, Some $5) }

%inline enum1 :
  | exp_lit { $1 }
  | PLUS arith_un { UnE (`PlusOp, $2) $ $sloc }
  | MINUS arith_un { UnE (`MinusOp, $2) $ $sloc }
  | DOLLAR LPAREN arith RPAREN { $3 }
  | DOLLAR numtyp DOLLAR LPAREN arith RPAREN { CvtE ($5, $2) $ $sloc }


(* Expressions *)

exp_lit : exp_lit_ { $1 $ $sloc }
exp_lit_ :
  | BOOLLIT { BoolE $1 }
  | NATLIT { NumE (`DecOp, `Nat $1) }
  | HEXLIT { NumE (`HexOp, `Nat $1) }
  | CHARLIT { NumE (`CharOp, `Nat $1) }
  | TICK NATLIT { NumE (`AtomOp, `Nat $2) }
  | TEXTLIT { TextE $1 }

exp_var_ :
  | varid { VarE ($1, []) }
  | varid_lparen comma_list(arg) RPAREN { VarE ($1, $2) }
  | BOOL { VarE ("bool" $ $sloc, []) }
  | NAT { VarE ("nat" $ $sloc, []) }
  | INT { VarE ("int" $ $sloc, []) }
  | RAT { VarE ("rat" $ $sloc, []) }
  | REAL { VarE ("real" $ $sloc, []) }
  | TEXT { VarE ("text" $ $sloc, []) }

exp_call : exp_call_ { $1 $ $sloc }
exp_call_ :
  | DOLLAR defid { CallE ($2, []) }
  | DOLLAR defid_lparen comma_list(arg) RPAREN { CallE ($2, $3) }

exp_hole_ :
  | HOLEN { HoleE (`Num $1) }
  | HOLE { HoleE `Next }
  | MULTIHOLE { HoleE `Rest }
  | NOTHING { HoleE `None }
  | LATEX LPAREN list(TEXTLIT) RPAREN { LatexE (String.concat " " $3) }

exp_prim : exp_prim_ { $1 $ $sloc }
exp_prim_ :
  | exp_lit_ { $1 }
  | exp_var_ { $1 }
  | exp_call_ { $1 }
  | exp_hole_ { $1 }
  | EPS { EpsE }
  | LBRACE comma_nl_list(fieldexp) RBRACE { StrE $2 }
  | LPAREN comma_list(exp_bin) RPAREN
    { match $2 with
      | [] -> ParenE (SeqE [] $ $sloc)
      | [e] -> ParenE e
      | es -> TupE es }
  | TICK LPAREN exp RPAREN
    { BrackE (Atom.LParen $$ $loc($2), $3, Atom.RParen $$ $loc($4)) }
  | TICK LBRACK exp RBRACK
    { BrackE (Atom.LBrack $$ $loc($2), $3, Atom.RBrack $$ $loc($4)) }
  | TICK LBRACE exp RBRACE
    { BrackE (Atom.LBrace $$ $loc($2), $3, Atom.RBrace $$ $loc($4)) }
  | DOLLAR LPAREN arith RPAREN { $3.it }
  | DOLLAR numtyp DOLLAR LPAREN arith RPAREN { CvtE ($5, $2) }
  | FUSEFUSE exp_prim { UnparenE $2 }

exp_post : exp_post_ { $1 $ $sloc }
exp_post_ :
  | exp_prim_ { $1 }
  | exp_atom LBRACK arith RBRACK { IdxE ($1, $3) }
  | exp_atom LBRACK arith COLON arith RBRACK { SliceE ($1, $3, $5) }
  | exp_atom LBRACK path EQ exp RBRACK { UpdE ($1, $3, $5) }
  | exp_atom LBRACK path EQCAT exp RBRACK { ExtE ($1, $3, $5) }
  | exp_atom iter { IterE ($1, $2) }
  | exp_post dotid { DotE ($1, $2) }

exp_atom : exp_atom_ { $1 $ $sloc }
exp_atom_ :
  | exp_post_ { $1 }
  | atom { AtomE $1 }
  | atomid_lparen exp RPAREN
    { SeqE [
        AtomE (Atom.Atom $1 $$ $loc($1)) $ $loc($1);
        ParenE $2 $ $loc($2)
      ] }

exp_list : exp_list_ { $1 $ $sloc }
exp_list_ :
  | LBRACK RBRACK { ListE [] }
  | LBRACK exp_seq RBRACK { ListE (as_seq_exp $2) }
  | exp_list iter { IterE ($1, $2) }

exp_seq : exp_seq_ { $1 $ $sloc }
exp_seq_ :
  | exp_atom_ { $1 }
  | exp_list_ { $1 }
  | exp_seq exp_atom { SeqE (as_seq_exp $1 @ [$2]) }
  | exp_seq FUSE exp_atom { FuseE ($1, $3) }

exp_un : exp_un_ { $1 $ $sloc }
exp_un_ :
  | exp_seq_ { $1 }
  | bar(exp) exp bar(exp) { LenE $2 }
  | BARBAR gramid BARBAR { SizeE $2 }
  | unop exp_un { UnE ($1, $2) }
  | infixop exp_un { InfixE (SeqE [] $ $loc($1), $1, $2) }

exp_bin : exp_bin_ { $1 $ $sloc }
exp_bin_ :
  | exp_un_ { $1 }
  | exp_bin infixop exp_bin { InfixE ($1, $2, $3) }
  | exp_bin cmpop exp_bin { CmpE ($1, $2, $3) }
  | exp_bin boolop exp_bin { BinE ($1, $2, $3) }
  | exp_bin CAT exp_bin { CatE ($1, $3) }
  | exp_bin MEM exp_bin { MemE ($1, $3) }
  | exp_bin NOTMEM exp_bin { UnE (`NotOp, MemE ($1, $3) $ $sloc) }

exp_rel : exp_rel_ { $1 $ $sloc }
exp_rel_ :
  | exp_bin_ { $1 }
  | comma(exp) exp_rel { CommaE (SeqE [] $ $loc($1), $2) }
  | relop exp_rel { InfixE (SeqE [] $ $loc($1), $1, $2) }
  | exp_rel comma(exp) exp_rel { CommaE ($1, $3) }
  | exp_rel relop exp_rel { InfixE ($1, $2, $3) }

exp : exp_rel { $1 }

fieldexp :
  | fieldid exp_atom+
    { ($1, match $2 with [e] -> e | es -> SeqE es $ $loc($2)) }


arith_prim : arith_prim_ { $1 $ $sloc }
arith_prim_ :
  | exp_lit_ { $1 }
  | exp_var_ { $1 }
  | exp_call_ { $1 }
  | exp_hole_ { $1 }
  | LPAREN arith RPAREN { ParenE $2 }
  | LPAREN arith_bin STAR RPAREN
    { (* HACK: to allow "(s*)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        error (at $loc($3)) "misplaced token";
      IterE ($2, List) }
  | LPAREN arith_bin PLUS RPAREN
    { (* HACK: to allow "(s+)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        error (at $loc($3)) "misplaced token";
      IterE ($2, List1) }
  | LPAREN arith_bin QUEST RPAREN
    { (* HACK: to allow "(s?)" as arithmetic expression. *)
      if not (is_post_exp $2) then
        error (at $loc($3)) "misplaced token";
      IterE ($2, Opt) }
  | DOLLAR LPAREN exp RPAREN { $3.it }
  | DOLLAR numtyp DOLLAR LPAREN arith RPAREN { CvtE ($5, $2) }

arith_post : arith_post_ { $1 $ $sloc }
arith_post_ :
  | arith_prim_ { $1 }
  | arith_atom UP arith_prim { BinE ($1, `PowOp, $3) }
  | arith_atom LBRACK arith RBRACK { IdxE ($1, $3) }
  | arith_post dotid { DotE ($1, $2) }

arith_atom : arith_atom_ { $1 $ $sloc }
arith_atom_ :
  | arith_post_ { $1 }
  | atom { AtomE $1 }

arith_un : arith_un_ { $1 $ $sloc }
arith_un_ :
  | arith_atom_ { $1 }
  | bar(exp) exp bar(exp) { LenE $2 }
  | BARBAR gramid BARBAR { SizeE $2 }
  | unop arith_un { UnE ($1, $2) }

arith_bin : arith_bin_ { $1 $ $sloc }
arith_bin_ :
  | arith_un_ { $1 }
  | arith_bin binop arith_bin { BinE ($1, $2, $3) }
  | arith_bin cmpop arith_bin { CmpE ($1, $2, $3) }
  | arith_bin boolop arith_bin { BinE ($1, $2, $3) }
  | arith_bin CAT arith_bin { CatE ($1, $3) }
  | arith_bin MEM arith_bin { MemE ($1, $3) }
  | arith_bin NOTMEM arith_bin { UnE (`NotOp, MemE ($1, $3) $ $sloc) }

arith : arith_bin { $1 }


path : path_ { $1 $ $sloc }
path_ :
  | (* empty *) { RootP }
  | path LBRACK arith RBRACK { IdxP ($1, $3) }
  | path LBRACK arith COLON arith RBRACK { SliceP ($1, $3, $5) }
  | path dotid { DotP ($1, $2) }


(* Premises *)

prem_list :
  | enter_scope nl_dash_list(prem) exit_scope { $2 }

prem_list1 :
  | enter_scope nl_dash_list1(prem) exit_scope { $2 }

prem_bin_list :
  | enter_scope nl_dash_list(prem_bin) exit_scope { $2 }

(*prem_post : prem_post_ { $1 $ $sloc }*)
prem_post_ :
  | OTHERWISE { ElsePr }
  | LPAREN prem RPAREN iter*
    { let rec iters prem = function
        | [] -> prem
        | iter::iters' -> iters (IterPr (prem, iter) $ $sloc) iters'
      in (iters $2 $4).it }

prem_bin : prem_bin_ { $1 $ $sloc }
prem_bin_ :
  | prem_post_ { $1 }
  | relid COLON exp_bin { RulePr ($1, $3) }
  | IF exp_bin
    { let rec iters e =
        match e.it with
        | IterE (e1, iter) -> IterPr (Source.(iters e1 $ e1.at), iter)
        | _ -> IfPr e
      in iters $2 }

prem : prem_ { $1 $ $sloc }
prem_ :
  | prem_post_ { $1 }
  | relid COLON exp { RulePr ($1, $3) }
  | VAR varid_bind_with_suffix COLON typ { VarPr ($2, $4) }
  | IF exp
    { let rec iters e =
        match e.it with
        | IterE (e1, iter) -> IterPr (Source.(iters e1 $ e1.at), iter)
        | _ -> IfPr e
      in iters $2 }


(* Grammars *)

(*sym_prim : sym_prim_ { $1 $ $sloc }*)
sym_prim_ :
  | gramid { VarG ($1, []) }
  | gramid_lparen comma_list(arg) RPAREN { VarG ($1, $2) }
  | NATLIT { NumG (`DecOp, $1) }
  | HEXLIT { NumG (`HexOp, $1) }
  | CHARLIT { NumG (`CharOp, $1) }
  | TEXTLIT { TextG $1 }
  | TICK NATLIT { NumG (`AtomOp, $2) }
  | EPS { EpsG }
  | LPAREN comma_list(sym) RPAREN
    { match $2 with
      | [] -> ParenG (SeqG [] $ $sloc)
      | [g] -> ParenG g
      | gs -> TupG gs }
  | DOLLAR LPAREN arith RPAREN { ArithG $3 }
  | DOLLAR numtyp DOLLAR LPAREN arith RPAREN { ArithG (CvtE ($5, $2) $ $sloc) }

sym_post : sym_post_ { $1 $ $sloc }
sym_post_ :
  | sym_prim_ { $1 }
  | sym_post iter { IterG ($1, $2) }

sym_attr : sym_attr_ { $1 $ $sloc }
sym_attr_ :
  | sym_post_ { $1 }
  | sym_post COLON sym_post { AttrG (El.Convert.exp_of_sym $1, $3) }

sym_seq : sym_seq_ { $1 $ $sloc }
sym_seq_ :
  | sym_attr_ { $1 }
  | sym_seq sym_attr { SeqG (as_seq_sym $1 @ [Elem $2]) }
(*
  | sym_seq NL_NL sym_attr { SeqG (as_seq_sym $1 @ [Nl; Elem $3]) }
  | sym_seq NL_NL_NL sym_attr { SeqG (as_seq_sym $1 @ [Nl; Elem $3]) }
*)

sym_alt : sym_alt_ { $1 $ $sloc }
sym_alt_ :
  | sym_seq_ { $1 }
  | sym_alt bar(sym) sym_seq { AltG (as_alt_sym $1 @ $2 @ [Elem $3]) }
  | sym_alt bar(sym) DOTDOTDOT bar(sym) sym_seq { RangeG ($1, $5) }

sym : sym_alt { $1 }

(*
prod : prod_ { $1 $ $sloc }
prod_ :
  | sym ARROW2 exp prem_list { SynthP ($1, $3, $4) }
  | sym ARROW2 exp bar(sym) DOTDOTDOT bar(sym) sym ARROW2 exp
    { RangeP ($1, $3, $7, $9) }
  | sym EQUIV sym prem_list { EquivP ($1, $3, $4) }

gram :
  | dots_bar_list(prod) { $1 $ $sloc }


prod_short : prod_short_ { $1 $ $sloc }
prod_short_ :
  | sym_seq prem_list
    { let var () = VarE ("res" $ $loc($1), []) $ $loc($1) in
      (AttrG (var (), $1) $ $loc($1), var (), $2)
    }

gram_short :
  | dots_bar_list(prod_short) { $1 $ $sloc }
*)


gram : gram_ { $1 $ $sloc }
gram_ :  (* bar_dots * prod nl_list * bar_dots *)
  (* Inline and transform dots_bar_list to avoid conflicts *)
  | gram_long_or_short { let x, y = $1 [] in (NoDots, x, y) }
  | bar(sym) gram_long_or_short { let x, y = $2 [] in (NoDots, x, y) }
  | bar_dots bar(gram) gram_long_or_short { let x, y = $3 [] in (Dots, $2 @ x, y) }

gram_long_or_short :  (* prod nl_list * bar_dots *)
  | gram_empty { fun alts -> short_alt_prod (alts, []), $1 }
  | gram_long1 { $1 }
  | gram_short1 { $1 }
  | sym_seq { fun alts -> short_alt_prod (alts @ [Elem $1], []), NoDots }
  | sym_seq bar(sym) short_range_cont_or_gram_long_or_short { fun alts -> $3 alts $1 $2 }

gram_empty :  (* dots *)
  | (* empty *) { NoDots }
  | DOTDOTDOT { Dots }

gram_long1 :  (* sym nl_list -> prod nl_list * dots *)
  | sym_seq ARROW2 exp
    { fun alts -> long_alt_prod (alts @ [Elem $1], $3, []), NoDots }
  | sym_seq ARROW2 exp prem_list1 gram_cont(gram_long)
    { fun alts -> let x, y = $5 in
      long_alt_prod (alts @ [Elem $1], $3, $4) @ x, y }
  | sym_seq ARROW2 exp bar(gram) long_range_cont_or_gram_long
    { fun alts -> $5 (alt_sym (alts @ [Elem $1])) $3 $4 }
  | sym_seq EQUIV sym_seq prem_list gram_cont(gram_long)
    { fun alts -> let x, y = $5 in
      long_equiv_prod (alts @ [Elem $1], $3, $4) @ x, y }

gram_long :  (* prod nl_list * dots *)
  | gram_empty { [], $1 }
  | sym_alt ARROW2 exp { [long_prod ($1, $3, [])], NoDots }
  | sym_alt ARROW2 exp prem_list1 gram_cont(gram_long)
    { let x, y = $5 in long_prod ($1, $3, $4) :: x, y }
  | sym_alt ARROW2 exp bar(gram) long_range_cont_or_gram_long { $5 $1 $3 $4 }
  | sym_alt EQUIV sym_seq prem_list gram_cont(gram_long)
    { let x, y = $5 in equiv_prod ($1, $3, $4) :: x, y }

gram_short1 :  (* sym nl_list -> prod nl_list * dots *)
  | prod_short1 gram_cont(gram_short)
    { fun alts -> let x, y = $2 in ($1 alts) @ x, y }

gram_short :  (* prod nl_list * dots *)
  | gram_empty { [], $1 }
  | prod_short gram_cont(gram_short) { let x, y = $2 in $1::x, y }

%inline gram_cont(gram (* prod nl_list * dots *)) :  (* prod nl_list * dots *)
  | (* empty *) { [], NoDots }
  | bar(gram) gram { let x, y = $2 in $1 @ x, y }

(*
prod_long1 :  (* sym nl_list -> prod nl_list *)
  | sym_seq ARROW2 exp prem_list
    { fun alts -> long_alt_prod (alts @ [Elem $1], $3, $4) }
  | sym_seq EQUIV sym prem_list
    { fun alts -> [long_equiv_prod (alts @ [Elem $1], $3, $4)] }

prod_long :  (* prem nl_list -> prod nl_elem *)
  | sym_alt ARROW2 exp { fun prems -> long_prod ($1, $3, prems) }
  | sym_alt EQUIV sym { fun prems -> long_equiv_prod ($1, $3, prems) }
*)

prod_short1 :  (* sym nl_list -> prod nl_list *)
  | sym_seq prem_list1 { fun alts -> short_alt_prod (alts @ [Elem $1], $2) }

prod_short :  (* prod nl_elem *)
  | sym_seq prem_list { short_prod ($1, $2) }


long_range_cont_or_gram_long :  (* sym -> exp -> prod nl_list -> prod nl_list * dots *)
  | long_range_cont gram_cont(gram_long)
    { fun g1 e1 nl -> let x, y = $2 in $1 g1 e1 :: nl @ x, y }
  | gram_long
    { fun g1 e1 nl -> let x, y = $1 in
      Elem Source.(SynthP (g1, e1, []) $ over_region [g1.at; e1.at]) :: nl @ x, y }

long_range_cont :  (* sym -> exp -> prod nl_elem *)
  | DOTDOTDOT bar(gram) sym_seq ARROW2 exp
    { fun g1 e1 ->
      Elem Source.(RangeP (g1, e1, $3, $5) $ over_region [g1.at; $5.at]) }

short_range_cont_or_gram_long_or_short :  (* sym nl_list -> sym -> sym nl_list -> prod nl_list * dots *)
  | short_range_cont ARROW2 exp prem_list gram_cont(gram_long)
    { fun alts g1 nl ->
      let nl' = List.map (function Nl -> Nl | Elem _ -> assert false) nl in
      let x, y = $5 in long_alt_prod (alts @ [Elem ($1 g1)], $3, $4) @ nl' @ x, y }
  | short_range_cont prem_list1 gram_cont(gram_short)
    { fun alts g1 nl ->
      let nl' = List.map (function Nl -> Nl | Elem _ -> assert false) nl in
      let x, y = $3 in short_alt_prod (alts @ [Elem ($1 g1)], $2) @ nl' @ x, y }
  | short_range_cont
    { fun alts g1 nl ->
      let nl' = List.map (function Nl -> Nl | Elem _ -> assert false) nl in
      short_alt_prod (alts @ [Elem ($1 g1)], []) @ nl', NoDots }
  | short_range_cont bar(sym) gram_long_or_short
    { fun alts g1 nl -> $3 (alts @ [Elem ($1 g1)] @ nl @ $2) }
  | gram_long_or_short
    { fun alts g1 nl -> $1 (alts @ [Elem g1] @ nl) }

short_range_cont :  (* sym -> sym *)
  | DOTDOTDOT bar(sym) sym_seq
    { fun g1 -> Source.(RangeG (g1, $3) $ over_region [g1.at; $3.at]) }



(* Definitions *)

arg : arg_ { ref $1 $ $sloc }
arg_ :
  | exp_bin { ExpA $1 }
  | SYNTAX typ { TypA $2 }
  | SYNTAX atomid_ { Id.make_var $2; TypA (VarT ($2 $ $loc($2), []) $ $loc($2)) }
  | GRAMMAR sym { GramA $2 }
  | DEF DOLLAR defid { DefA $3 }
  (* HACK for representing def parameters as args *)
  | DEF exp_call COLON typ { ExpA (TypE ($2, $4) $ $sloc) }

param : param_ { $1 $ $sloc }
param_ :
  | varid_bind_with_suffix COLON typ { ExpP ($1, $3) }
  | typ
    { let id =
        try El.Convert.varid_of_typ $1 with Error.Error _ -> "" $ $sloc
      in ExpP (id, $1) }
  | SYNTAX varid_bind { TypP $2 }
  | GRAMMAR gramid COLON typ { GramP ($2, $4) }
  | DEF DOLLAR defid COLON typ
    { DefP ($3, [], $5) }
  | DEF DOLLAR defid_lparen enter_scope comma_list(param) RPAREN COLON typ exit_scope
    { DefP ($3, $5, $8) }


def :
  | def_ NL_NL* { $1 $ $loc($1) }
def_ :
  | SYNTAX varid_bind_lparen enter_scope comma_list(arg) RPAREN ruleid_list hint* exit_scope
    { FamD ($2, List.map El.Convert.param_of_arg $4, $7) }
  | SYNTAX varid_bind ruleid_list hint* EQ deftyp
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      TypD ($2, id $ $loc($3), [], $6, $4) }
  | SYNTAX varid_bind_lparen enter_scope comma_list(arg) RPAREN ruleid_list hint* EQ deftyp exit_scope
    { let id = if $6 = "" then "" else String.sub $6 1 (String.length $6 - 1) in
      TypD ($2, id $ $loc($6), $4, $9, $7) }
  | GRAMMAR varid_bind ruleid_list COLON typ hint* EQ gram
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      GramD ($2, id $ $loc($3), [], $5, $8, $6) }
  | GRAMMAR varid_bind ruleid_list hint* EQ gram
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      GramD ($2, id $ $loc($3), [], TupT [] $ $loc($1), $6, $4) }
  | GRAMMAR varid_bind_lparen enter_scope comma_list(param) RPAREN ruleid_list COLON typ hint* EQ gram exit_scope
    { let id = if $6 = "" then "" else String.sub $6 1 (String.length $6 - 1) in
      GramD ($2, id $ $loc($6), $4, $8, $11, $9) }
  | GRAMMAR varid_bind_lparen enter_scope comma_list(param) RPAREN ruleid_list hint* EQ gram exit_scope
    { let id = if $6 = "" then "" else String.sub $6 1 (String.length $6 - 1) in
      GramD ($2, id $ $loc($6), $4, TupT [] $ $loc($1), $9, $7) }
  | RELATION relid COLON nottyp hint*
    { RelD ($2, $4, $5) }
  | RULE relid ruleid_list COLON exp prem_list
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      RuleD ($2, id $ $loc($3), $5, $6) }
  | VAR varid_bind COLON typ hint*
    { VarD ($2, $4, $5) }
  | DEF DOLLAR defid COLON typ hint*
    { DecD ($3, [], $5, $6) }
  | DEF DOLLAR defid_lparen enter_scope comma_list(arg) RPAREN COLON typ hint* exit_scope
    { DecD ($3, List.map El.Convert.param_of_arg $5, $8, $9) }
  | DEF DOLLAR defid EQ exp prem_list
    { DefD ($3, [], $5, $6) }
  | DEF DOLLAR defid_lparen enter_scope comma_list(arg) RPAREN EQ exp prem_list exit_scope
    { DefD ($3, $5, $8, $9) }
  | NL_NL_NL
    { SepD }
  | SYNTAX varid_bind ruleid_list hint*
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (TypH ($2, id $ $loc($3), $4) $ $sloc) }
  | SYNTAX varid_bind ruleid_list atom hint*
    { HintD (AtomH ($2, $4, $5) $ $sloc) }
  | SYNTAX varid_bind ruleid_list TICK LPAREN hint*
    { HintD (AtomH ($2, Atom.LParen $$ $loc($5), $6) $ $sloc) }
  | SYNTAX varid_bind ruleid_list TICK LBRACK hint*
    { HintD (AtomH ($2, Atom.LBrack $$ $loc($5), $6) $ $sloc) }
  | SYNTAX varid_bind ruleid_list TICK LBRACE hint*
    { HintD (AtomH ($2, Atom.LBrace $$ $loc($5), $6) $ $sloc) }
  | GRAMMAR varid_bind ruleid_list hint*
    { let id = if $3 = "" then "" else String.sub $3 1 (String.length $3 - 1) in
      HintD (GramH ($2, id $ $loc($3), $4) $ $sloc) }
  | RELATION relid hint*
    { HintD (RelH ($2, $3) $ $sloc) }
  | VAR varid_bind hint*
    { HintD (VarH ($2, $3) $ $sloc) }
  | DEF DOLLAR defid hint*
    { HintD (DecH ($3, $4) $ $sloc) }

ruleid_list :
  | (* empty *) { "" }
  | SLASH ruleid ruleid_list { "/" ^ $2 ^ $3 }
  | MINUS ruleid ruleid_list { "-" ^ $2 ^ $3 }


hint :
  | HINT_LPAREN hintid exp RPAREN
    { {hintid = $2 $ $loc($2); hintexp = $3} }
  | HINT_LPAREN hintid RPAREN
    { {hintid = $2 $ $loc($2); hintexp = SeqE [] $ $loc($2)} }


(* Scripts *)

script :
  | NL_NL* def* EOF { $2 }

typ_eof :
  | typ EOF { $1 }

exp_eof :
  | exp EOF { $1 }

sym_eof :
  | sym EOF { $1 }

%%
