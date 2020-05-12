type var = string Source.phrase

type Values.ref_ += ExternRef of int32
type literal = Values.value Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Encoded of string * string
  | Quoted of string * string

type action = action' Source.phrase
and action' =
  | Invoke of var option * Ast.name * literal list
  | Get of var option * Ast.name

type nanop = nanop' Source.phrase
and nanop' = (Lib.void, Lib.void, nan, nan) Values.op
and nan = CanonicalNan | ArithmeticNan

type result = result' Source.phrase
and result' =
  | LitResult of literal
  | NanResult of nanop
  | RefResult of Types.ref_type

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


let () =
  let type_of_ref' = !Values.type_of_ref' in
  Values.type_of_ref' := function
    | ExternRef _ -> Types.ExternRefType
    | r -> type_of_ref' r

let () =
  let string_of_ref' = !Values.string_of_ref' in
  Values.string_of_ref' := function
    | ExternRef n -> "ref " ^ Int32.to_string n
    | r -> string_of_ref' r
