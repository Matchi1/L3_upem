let average a b c = (a + b + c) / 3;;
let implies a b = if a && b then true else false;;
let inv c = (snd c, fst c);;
inv (1,3);;
let inv1 (a,b) = (b, a);;
inv1 (1,3);;
let inv2 ((a:int),(b:int)) = (b, a);;
inv2 (1,3);;
let f_one = 1;;
