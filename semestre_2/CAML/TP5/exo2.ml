open List;;

let entiers = [2; 5; 7; 3; 12; 4; 9; 2; 11];;
let animaux = ["Wombat"; "aXolotl"; "pangolin"; "suricate"; "paresseuX"; "quoKKa"; "lemurien"];;

map (fun a -> String.length a) animaux;;
map (fun a -> String.uppercase a) animaux;;
filter (fun a -> String.equal (String.lowercase a) a) animaux;;
filter (fun a -> (String.length a) mod 2 = 0) animaux;;
map (fun a -> match (a mod 2) with 0 -> (a, "paire") | _ -> (a, "impaire")) entiers;;
map (fun a -> init a (fun b -> a)) entiers;;
[] = filter (fun a -> Char.equal (String.get a 0) 's') animaux;;
fold_left (fun a b -> a && b = 2) true (map (fun a -> String.length a mod 5) animaux);;
