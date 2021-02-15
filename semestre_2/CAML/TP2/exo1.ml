(* EXERCICE 1 *)
let rec fact n = 
    if n > 0 
    then 
        n * fact (n - 1) 
    else 1;;
fact;;
fact 0, fact 1, fact 2, fact 3, fact 4, fact 5;; 
