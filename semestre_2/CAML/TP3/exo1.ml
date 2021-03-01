open List;;
(* problème : On a pas la liste dans l'ordre croissant *)
let rec integers_1 n = if n < 0 then [] else n :: integers_1 (n - 1) ;;
integers_1 10;;

(* problème: ça prend beaucoup de temps, peu performant*)
let rec integers_2 n = if n < 0 then [] else integers_2 (n - 1) @ [n];;
integers_2 10;;

let integers_3 n = List.rev (integers_1 n);;
integers_3 10;;

(* si l'on transforme integers_1 en une fonction récursive terminale
 * il sera possible de ranger les nombres dans l'ordre croissant *)

let integers_4 n = 
    let rec integers_4_aux n l =
        if n < 0 then l
        else integers_4_aux (n - 1) (n::l)
    in integers_4_aux n [];;
integers_4 10;;
