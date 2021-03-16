open List;;

let entiers = [2; 5; 7; 3; 12; 4; 9; 2; 11];;
let sum l = fold_left (+) 0 l;;

sum entiers;;

let size l = fold_left (+) 0 (map (fun _ -> 1) l);;

size entiers;;

let last l = l;;

let nb_occ e l = size (filter (fun a -> a = e) l);;

nb_occ 2 entiers;;

let max_list l = fold_left (fun a b -> if a < b then b else a) 0 l;;

max_list entiers;;

let average l = (fold_left (+.) 0. (map (fun x -> float_of_int x) l)) /. fold_left (+.) 0. (map (fun _ -> 1.) l);;

average entiers;;

