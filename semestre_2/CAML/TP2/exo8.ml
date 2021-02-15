(* EXERCICE 8 *)
let rec fib_aux n r1 r2 =
    if n < 2 then r1
    else
        fib_aux (n - 1)(r1 + r2) r1;;

let fib' n =
    if n < 2 then n
    else 
        fib_aux n 1 0;;
fib, fib';;
fib 0 = fib' 0, fib 1 = fib' 1, fib 2 = fib' 2, fib 10 = fib' 10;;
