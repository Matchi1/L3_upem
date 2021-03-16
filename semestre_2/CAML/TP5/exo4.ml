open List;;

let entiers = [2; 5; 7; 3; 12; 4; 9; 2; 11];;
let is_even = fun x -> x mod 2 = 0;;
is_even 0, is_even 1, is_even 2;;

let rec my_for_all p l =
    if l = [] then true
    else
        if p (hd l) then my_for_all p (tl l)
        else false;;

my_for_all (fun x -> x < 20) entiers;;

let my_for_all2 p l = fold_left (fun a b -> a && (p b)) true l;;

my_for_all2 (fun x -> x < 20) entiers;;

let my_for_all3 p l = fold_right (fun a b -> (p a) && b) l true;;

my_for_all3 (fun x -> x < 20) entiers;;

let my_exists p l = fold_left (fun a b -> a || (p b)) false l;;

my_exists (fun x -> x = 1) entiers;;
my_exists (fun x -> x = 2) entiers;;

let rec none p l = 
    if l = [] then true
    else
        if p (hd l) then false
        else none p (tl l);;

none (fun x -> x = 1) entiers;;
none (fun x -> x = 2) entiers;;

let not_all p l = fold_left (fun a b -> a || not (p b)) false l;;

not_all (fun x -> x < 20) entiers;;
not_all (fun x -> x = 2) entiers;;

let rec ordered p l =
    match l with
    | [_] -> true
    | _ -> if p (hd l) (hd (tl l)) then ordered p (tl l) else false;;

ordered (<) [1; 2; 3];;
ordered (<) [1; 4; 3];;
ordered (fun x y -> x + y >= 1) [1; 4; -3; 6];;
ordered (fun x y -> x + y >= 1) [1; 4; -5; 6];;

let filter2 p l1 l2 = map2 (fun a b -> if p a b then (a, b) else (a,a)) l1 l2;;
filter2 (<) [2; 2; 3] [1; 4; 5];;
