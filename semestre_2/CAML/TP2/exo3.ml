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
