open List;;

(*
 *  EXPLICATION
 *
 *  Perm est une fonction qui va utiliser une fonction auxiliaire Perm_aux
 *  pour créer une partie des permutations.
 *  Perm_aux s'inspire du tri à bulle.
 *  Perm utilise les sous-permutations d'une liste pour créer une liste
 *  des permutations de la liste.
 *
 *  EXEMPLE
 *
 *  [1; 2; 3] utiliser les permutations de la liste [2; 3]
 *  [2; 3] -> [[2; 3]; [3; 2]]
 *  On utilise ensuite le nombre 1 comme valeur à remonter dans la liste
 *  [1; 2; 3] -> [2; 1; 3] -> [2; 3; 1]
 *  On enregistre chaque étape lors de la remonté de la valeur.
 *  On continue le parcours les sous-permutations (dans ce cas-ci [3; 2]) 
 *  [1; 3; 2] -> [3; 1; 2] -> [3; 2; 1]
 *  le programme s'arrête quand il n'y a plus de sous-permutations.
 *  [[1; 2; 3]; [2; 1; 3]; [2; 3; 1]; [1; 3; 2]; [3; 1; 2]; [3; 2; 1]]
 * *)

let example_list = [1; 2; 3; 4];;

let exchange_element_list i j l = 
    let f a =
        if a = nth l i then nth l j
        else if a = nth l j then nth l i
        else a
    in map f l;;

exchange_element_list 1 3 example_list;;
exchange_element_list 0 3 example_list;;
exchange_element_list 0 2 example_list;;

let rec perm_aux count l acc =
    if count + 1 = length l then acc
    else 
        let tmp_list = (exchange_element_list count (count + 1) l)
        in perm_aux (count + 1) tmp_list (acc @ [tmp_list]);;

let rec perm l =
    match (length l) with
    | 0 -> [l]
    | 1 -> [l]
    | 2 -> [] @ [l] @ [rev l]
    | _ ->
            let rec perm_full first sub_perm acc =
                match sub_perm with
                | [] -> acc
                | _ -> let tmp_list = [first] @ (hd sub_perm)
                        in 
                            let tmp_acc = perm_aux 0 tmp_list []
                            in perm_full first (tl sub_perm) (acc @ [tmp_list] @ tmp_acc)
            in perm_full (hd l) (perm (tl l)) [];;

perm [1; 2];;
perm [1; 2; 3];;
perm [1; 2; 3; 4];;
     
