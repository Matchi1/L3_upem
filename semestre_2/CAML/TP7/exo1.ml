open List;;

(* EXERCICE 1*)

let diagonal c : picture =
    (fun (x, y) -> if x = y then c else background);;

let square c long : picture =
    (fun (x, y) -> 
        let min = (0 - (long / 2)) and max = (0 + (long / 2))
        in
            if (min <= x && x <= max) && (min <= y && y <= max)
            then c
            else background
    );;

let rectangle c width height : picture =
    (fun (x, y) -> 
        let min_x = (0 - (width / 2)) and max_x = (0 + (width / 2))
        and min_y = (0 - (height / 2)) and max_y = (0 + (height / 2))
        in
            if (min_x <= x && x <= max_x) && (min_y <= y && y <= max_y)
            then c
            else background
    );;

let disk r c : picture =
    (fun (x, y) ->
        if (x * x + y * y) <= r * r
        then c
        else background
    );;

let circle r c : picture =
    (fun (x, y) ->
        let d = (x * x + y * y)
        in
            if (d <= r * r)
            && (d >= (r - 1) * (r - 1))
            then c
            else background
    );;

let move p vect : picture =
    (fun (x, y) ->
        p (x - (fst vect), y - (snd vect))
    );;

let vertical_symetry p : picture =
    (fun (x, y) ->
        p (-x, y)
    );;

let horizontal_symetry p : picture =
    (fun (x, y) ->
        p (x, -y)
    );;

(* EXERCICE 2*)

let v_lines n : picture =
    if n = 0
    then (fun (x, y) -> black)
    else
        (fun (x, y) ->
            if(x mod (n + 1) = 0)
            then black
            else background
        );;

let v_stripes n picture =
    if n = 0
    then (fun (x, y) -> black)
    else
        (fun (x, y) ->
            if(x / n mod 2 = 0)
            then black
            else background
        );;

let chessboard n picture =
    if n = 0
    then (fun (x, y) -> black)
    else
        (fun (x, y) ->
            if ((x / n mod 2 = 0 && y / n mod 2 = 0)
            || (x / n mod 2 = 1 && y / n mod 2 = 1))
            then black
            else background
        );;

let concentric c n : picture =
    (fun (x, y) ->

        let d = (int_of_float (sqrt (float_of_int (x * x + y * y))))
        in
            if (d / n mod 2 = 0)
            then c
            else background
    );;

(* EXERCICE 3 *)

let compose_two p1 p2 : picture =
    (fun (x, y) ->
        if p2 (x, y) = background
        then p1 (x, y)
        else p2 (x, y)
    );;

let left_ear = move (disk 20 black) (0 - 30, 30 + 0);;
let right_ear = move (disk 20 black) (0 + 30, 30 + 0);;
let ears = compose_two left_ear right_ear;;
let head = move (disk 40 black) (0, 0);;
let shadow_mickey = compose_two ears head;;

let compose pl =
    fold_left (fun a b -> compose_two a b) (hd pl) (tl pl);;

let face = move (disk 30 green) (0, 0);;
let left_eye = move (disk 5 black) (0 - 15, 10 + 0);;
let right_eye = move (disk 5 black) (0 + 15, 10 + 0);;
let nose = move (disk 6 black) (0, 0);;
let mickey = compose (left_ear :: right_ear :: head :: face :: left_eye :: right_eye :: nose :: []);;

(* EXERCICE 4 *)

let rotate p deg : picture =
    (fun (x, y) ->
        let (rho, theta) = to_polar (x, y)
        in 
            let (new_x, new_y) = from_polar (rho, theta +. deg)
            in p (new_x, new_y);
    );;

render (square red 50);;
render (move (rotate (square red 50) 1.) (w / 2, h / 2));;

render (move (rotate (mickey) 1.5704) (w / 2, h / 2));;

let rayon c =
    (fun (x, y) ->
        let (rho, theta) = to_polar (x, y)
        in
            let value = int_of_float (theta *. 100.)
            in
                if ((Int.abs value) mod 7 = 0 || (Int.abs value) mod 7 = 1 || (Int.abs value) mod 7 = 2)
                then c
                else background
    );;

let sun c = compose ((rayon c) :: (disk 50 c) :: []);;

render (move (sun red) (w / 2, h / 2));;

let compose_xor_two p1 p2 : picture =
    (fun (x, y) ->
        let c1 = p1 (x, y)
        and c2 = p2 (x, y)
        in
            if (c1 != background && c2 == background)
            then c1
            else 
                if (c1 == background && c2 != background)
                then c2
                else background
    );;

let double_concentric n =
    (fun (x, y) ->
        let con1 = (move (concentric black n) (w / 4, h / 2))
        and con2 = (move (concentric 0 n) ((3 * w) / 4, h / 2))
        in (compose_xor_two con1 con2) (x, y)
    );;

render (move (concentric blue 20) (w / 2, h / 2));;
render (double_concentric 20);;

let compose_xor pl =
    fold_left (fun a b -> compose_xor_two a b) (hd pl) (tl pl);;

let concentric1 = move (concentric black 20) (w / 2, h / 4);;
let concentric2 = move (concentric black 20) (w / 2, (3 * h) / 4);;
let concentric3 = move (concentric black 20) (w / 4, (3 * h) / 4);;
let concentric4 = move (concentric black 20) ((3 * w) / 4, (3 * h) / 4);;
let concentric5 = move (concentric black 20) (w / 4, h / 4);;
let concentric6 = move (concentric black 20) ((3 * w) / 4, h / 4);;
render (compose_xor ((double_concentric 20) :: (concentric1) :: concentric2 :: concentric3 :: concentric4 :: concentric5 :: concentric6 :: []));;

(* EXERCICE 7 *)

let sierpinski : picture =
    (fun (x, y) ->
        if (x lor y = x)
        then black
        else background
    );;

render (sierpinski);;
