(* List of actively logged functions' labels *)
let active : string list = []

let fmt = Printf.sprintf
let loc = Source.string_of_region

let log_exn _exn =
  if active <> [] then
    Printf.eprintf "\n%s\n%!" (Printexc.get_backtrace ())

let log_at (type a) label at (arg_f : unit -> string) (res_f : a -> string) (f : unit -> a) : a =
  if not (label = "" || List.mem label active) then f () else
  let ats = if at = Source.no_region then "" else " " ^ Source.string_of_region at in
  let arg = arg_f () in
  Printf.eprintf "[%s%s] %s\n%!" label ats arg;
  match f () with
  | exception exn ->
    let bt = Printexc.get_raw_backtrace () in
    Printf.eprintf "[%s%s] %s => raise %s\n%!" label ats arg (Printexc.to_string exn);
    Printexc.raise_with_backtrace exn bt
  | x ->
    let res = res_f x in
    if res <> "" then Printf.eprintf "[%s%s] %s => %s\n%!" label ats arg res;
    x

let log_in_at label at arg_f = log_at label at arg_f (Fun.const "") Fun.id
let log_in label = log_in_at label Source.no_region
let log label = log_at label Source.no_region
let log_if_at label at b arg_f res_f f = if b then log_at label at arg_f res_f f else f ()
let log_if label = log_if_at label Source.no_region

module MySet = Set.Make(String)
module MyMap = Map.Make(String)

let opt f xo = match xo with None -> "-" | Some x -> f x
let seq f xs = String.concat " " (List.map f xs)
let list f xs = String.concat ", " (List.map f xs)
let set s = seq Fun.id (MySet.elements s)
let mapping f m = seq (fun (x, y) -> x ^ "=" ^ f y) (MyMap.bindings m)

let qline _ = "--------------------"
let hline _ = "----------------------------------------"
let line  _ = "--------------------------------------------------------------------------------"
let dline _ = "================================================================================"
