(* EXERCICE 2 *)
let rec fib n = 
    if n >= 2 
    then 
        fib (n - 2) + fib (n - 1) 
    else n;;
fib;;
fib 0, fib 1, fib 2, fib 3, fib 4, fib 5;; 
