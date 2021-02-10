(* EXERCICE 1 *)
let rec fact n = 
    if n > 0 
    then 
        n * fact (n - 1) 
    else 1;;
fact;;
fact 0, fact 1, fact 2, fact 3, fact 4, fact 5;; 

(* EXERCICE 2 *)
let rec fib n = 
    if n >= 2 
    then 
        fib (n - 2) + fib (n - 1) 
    else n;;
fib;;
fib 0, fib 1, fib 2, fib 3, fib 4, fib 5;; 

(* EXERCICE 3 *)
let rec pgcd m n =
    if m = 0 then n
    else 
        if m > n
        then
            pgcd n m
        else
            pgcd (n mod m) m;;

pgcd;;
pgcd 1 1;;
pgcd 20 30;;
pgcd 77 34;;
        
(* EXERCICE 4 *)
let rec ackermann m n =
    if m = 0 then n + 1
    else
        if m >= 1 && n = 0
        then 
            ackermann (m - 1) 1
        else
            ackermann (m - 1)(ackermann m (n - 1));;

ackermann;;
ackermann 0 1, ackermann 1 1, ackermann 2 1, ackermann 3 1;;
ackermann 0 2, ackermann 1 2, ackermann 2 2, ackermann 3 2;;

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

(* EXERCICE 6 *)
let rec is_even n =
    if n = 0 then true
    else
        is_odd (n - 1)
    and is_odd n =
        if n != 0 && is_even (n - 1) then true else false;;
is_even;;
is_odd;;
is_even 0, is_even 1, is_even 2, is_even 3, is_even 4, is_even 5;;
is_odd 0, is_odd 1, is_odd 2, is_odd 3, is_odd 4, is_odd 5;;

(* EXERCICE 7 *)
let rec fact_aux n result =
    if n <= 1 then result
    else
        fact_aux (n - 1)(n * result);;


let fact' n =
    fact_aux n 1;;

fact, fact';;
fact 0 = fact' 0, fact 1 = fact' 1, fact 2 = fact' 2, fact 10 = fact' 10;;

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

(* EXERCICE 9 *)
(* EXERCICE 10 *)
let rec exp x n =
    if n = 1 then x
    else
        x * exp x (n - 1);;
exp 2 5;;

let rec exp_aux x n result =
    if n = 0 then result
    else
        exp_aux x (n - 1)(x * result);;

let exp' x n =
    exp_aux x n 1;;

exp 2 5 = exp' 2 5;;

(* EXERCICE 11 *)

let rec sum1_aux n m =
    if n > m then 0
    else
        n + sum1_aux (n + 1) m;;

let rec sum1 n m =
    if n > m then 0
    else
        sum1 (n + 1) (m) + sum1_aux n m;;

let rec sum2_aux2 j k =
    if k >= j then 0.
    else
        float(k) /. float(j) +. sum2_aux2 j (k + 1);;

let rec sum2_aux n j =
    if j > n then 0.
    else
        sum2_aux n (j + 1) +. sum2_aux2 j 0;;

let rec sum2 n =
    sum2_aux n 0;;

sum1, sum2;;
sum1 1 3, sum1 0 10, sum1 5 10, sum1 5 3;;
sum2 0, sum2 3, sum2 5, sum2 10;;

