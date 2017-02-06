type var = string Source.phrase

type definition = definition' Source.phrase
and definition' =
  | Textual of Ast.module_
  | Encoded of string * string

type action = action' Source.phrase
and action' =
  | Invoke of var option * string * Ast.literal list
  | Get of var option * string

type assertion = assertion' Source.phrase
and assertion' =
  | AssertMalformed of definition * string
  | AssertInvalid of definition * string
  | AssertUnlinkable of definition * string
  | AssertUninstantiable of definition * string
  | AssertReturn of action * Ast.literal list
  | AssertReturnNaN of action
  | AssertTrap of action * string
  | AssertExhaustion of action * string

type command = command' Source.phrase
and command' =
  | Module of var option * definition
  | Register of string * var option
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
