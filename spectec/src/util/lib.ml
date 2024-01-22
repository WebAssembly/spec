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

  let split_hd = function
    | x::xs -> x, xs
    | _ -> failwith "split_hd"

  let rec split_last_opt = function
    | x::[] -> [], Some x
    | x::xs -> let ys, y = split_last_opt xs in x::ys, y
    | [] -> [], None
  let split_last l = let ys, y = split_last_opt l in ys, Option.get y

  let last_opt l = snd (split_last_opt l)
  let last l = snd (split_last l)

  let rec nub pred = function
    | [] -> []
    | x::xs -> x :: nub pred (List.filter (fun y -> not (pred x y)) xs)

  let filter_not pred = List.filter (fun x -> not (pred x))

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
end
