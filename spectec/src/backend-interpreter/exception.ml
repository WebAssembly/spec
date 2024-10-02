exception Invalid of exn * Printexc.raw_backtrace
exception Trap
exception Throw
exception OutOfMemory
exception Timeout
exception MissingReturnValue of string
exception ArgMismatch of string
exception UnknownFunc of string
exception FreeVar of string
exception WrongConversion of string

(* For AL-level debugging *)
exception Error of Util.Source.region * string * string
