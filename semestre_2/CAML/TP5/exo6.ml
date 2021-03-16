open List;;

type bintree = Empty | Node of int * bintree * bintree;;

let example_tree =
    Node(1,
        Node(2,
            Node(4, Empty, Empty),
            Node(5, Node(7, Empty, Empty), Node(8, Empty, Empty))),
        Node(3, Empty, Node(6, Node(9, Empty, Empty), Empty)));;

let rec tree_map f tree = 
    match tree with
    | Empty -> Empty
    | Node (x, l, r) -> Node (f x, tree_map f l, tree_map f r);;

tree_map (fun x -> x * 2) example_tree;;

let rec fold_tree f tree =
    match tree with
    | Empty -> 0
    | Node (x, l, r) -> f x (fold_tree f l) (fold_tree f r);;

let f a b c = a + b + c;;

(f 1(f 2 (f 4 0 0) (f 5 (f 7 0 0) (f 8 0 0))) (f 3 0 (f 6 (f 9 0 0) 0)));;

fold_tree f example_tree;;

let bintree_count_internal_nodes tree = fold_tree (fun a b c -> 1 + b + c) tree;;

bintree_count_internal_nodes example_tree;;

let bintree_collect_internal_nodes tree =
    let rec bintree_collect_internal_nodes_aux tree acc =
        match tree with
        | Empty -> acc
        | Node (x, l, r) -> [x] @ acc @ (bintree_collect_internal_nodes_aux r acc) @ (bintree )
    in bintree_collect_internal_nodes_aux tree [];;

bintree_collect_internal_nodes example_tree;;
