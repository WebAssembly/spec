type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Encoded of string * string
  | Quoted of string * string

type action = action' Source.phrase
and action' =
  | Invoke of var option * Ast.name * Ast.literal list
  | Get of var option * Ast.name

type nanop = nanop' Source.phrase
and nanop' = (unit, unit, nan, nan, unit) Values.op
and nan = CanonicalNan | ArithmeticNan

type num_pat = num_pat' Source.phrase
and num_pat' =
  | LitPat of Ast.literal
  | NanPat of nanop

type result = result' Source.phrase
and result' =
  | NumResult of num_pat
  | SimdResult of Simd.shape * num_pat list

type assertion = assertion' Source.phrase
and assertion' =
  | AssertMalformed of definition * string
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertUninstantiable of definition * string
  | AssertReturn of action * result list
  | AssertTrap of action * string
  | AssertExhaustion of action * string

type command = command' Source.phrase
and command' =
  | Module of var option * definition
  | Register of Ast.name * var option
  | Action of action
  | Assertion of assertion
  | Meta of meta

and meta = meta' Source.phrase
and meta' =
  | Input of var option * string
  | Output of var option * string option
  | Script of var option * script

and script = command list

exception Syntax of Source.region * string
