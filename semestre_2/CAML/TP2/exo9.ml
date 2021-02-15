(* EXERCICE 9 *)
let rec syracuse_aux x n =
    if x = 1 
    then
        n
    else
        if x mod 2 = 0
        then
            syracuse_aux (x / 2) (n + 1)
        else
            syracuse_aux (x * 3 + 1) (n + 1);;

let syracuse x =
    syracuse_aux x 0;;

syracuse;;
syracuse 1;;
syracuse 14;;
syracuse 100;;
syracuse 1000;;
syracuse 10000;;
