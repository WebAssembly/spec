module List =
struct
  include List

  let rec take n xs =
    match n, xs with
    | 0, _ -> []
    | n, x::xs' when n > 0 -> x :: take (n - 1) xs'
    | _ -> failwith "take"

  let rec drop n xs =
    match n, xs with
    | 0, _ -> xs
    | n, _::xs' when n > 0 -> drop (n - 1) xs'
    | _ -> failwith "drop"

  let rec split n xs =
    match n, xs with
    | 0, _ -> [], xs
    | n, x::xs' when n > 0 ->
      let xs1', xs2' = split (n - 1) xs' in x::xs1', xs2'
    | _ -> failwith "split"

  let split_hd = function
    | x::xs -> x, xs
    | _ -> failwith "split_hd"

  let rec split_last_opt' ys = function
    | x::[] -> Some (List.rev ys, x)
    | x::xs -> split_last_opt' (x::ys) xs
    | [] -> None
  let split_last_opt xs = split_last_opt' [] xs
  let split_last l = Option.get (split_last_opt l)

  let last_opt l = Option.map snd (split_last_opt l)
  let last l = snd (split_last l)

  let rec nub pred = function
    | [] -> []
    | x::xs -> x :: nub pred (List.filter (fun y -> not (pred x y)) xs)

  let filter_not pred = List.filter (fun x -> not (pred x))

  let rec flatten_opt = function
    | [] -> Some []
    | None::_ -> None
    | (Some x)::xos ->
      match flatten_opt xos with
      | Some xs -> Some (x::xs)
      | None -> None

  let fold_lefti f init xs =
    let rec aux i acc xs =
      match xs with
      | [] -> acc
      | hd :: tl -> aux (i+1) (f i acc hd) tl
    in
    aux 0 init xs

  let group_by eq xs =
    let rec aux acc xs =
      match xs with
      | [] -> acc
      | hd :: tl ->
        let same, diff = List.partition (fun g ->
          eq hd (List.hd g)
        ) acc in
        match same with
        | [group] -> aux (diff @ [group @ [hd]]) tl
        | _ -> aux (acc @ [[hd]]) tl
    in
    aux [] xs

end

module Char =
struct
  let is_digit_ascii c = '0' <= c && c <= '9'
  let is_uppercase_ascii c = 'A' <= c && c <= 'Z'
  let is_lowercase_ascii c = 'a' <= c && c <= 'z'
  let is_letter_ascii c = is_uppercase_ascii c || is_lowercase_ascii c
end

module String =
struct
  include String

  let implode cs =
    let buf = Buffer.create 80 in
    List.iter (Buffer.add_char buf) cs;
    Buffer.contents buf

  let explode s =
    let cs = ref [] in
    for i = String.length s - 1 downto 0 do cs := s.[i] :: !cs done;
    !cs

  let replace pattern replacement s =
    Str.global_replace (Str.regexp_string pattern) replacement s
end
