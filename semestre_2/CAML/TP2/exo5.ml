(* EXERCICE 5 *)
let rec binom n k = 
    if k = 0 then 1
    else
        if n < k then 0
        else
            binom (n - 1) (k - 1) + binom (n - 1) k;;
binom;;
binom 0 0;;
binom 1 0, binom 1 1;;
binom 2 0, binom 2 1, binom 2 2;;
binom 3 0, binom 3 1, binom 3 2, binom 3 3;;
binom 4 0, binom 4 1, binom 4 2, binom 4 3, binom 4 4;;
