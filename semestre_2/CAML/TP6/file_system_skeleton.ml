open List
open String

(* val files : fs_item -> fs_file list = <fun> *)
let rec files_aux l acc =
    match l with
    | [] -> acc
    | FileItem (file) :: siblings -> files_aux siblings (file :: acc)
    | FolderItem (_, item_list) :: siblings -> files_aux siblings (files_aux item_list acc);;

let files items =
    match items with
    | FileItem file -> [file]
    | FolderItem (_, item_list) -> files_aux item_list [];;


(* val folders : fs_item -> fs_folder list = <fun> *)

let rec folders_aux l acc =
    match l with
    | [] -> acc
    | FileItem _ :: siblings -> folders_aux siblings acc
    | FolderItem (name, item_list) :: siblings -> folders_aux siblings (folders_aux item_list (name :: acc));;

let folders items =
    match items with
    | FileItem file -> []
    | FolderItem (name, item_list) -> folders_aux item_list [name];;

(* val is_image : fs_file -> bool = <fun> *)

let is_image file =
    match file with
    | File (_, PNG, _) -> true
    | File (_, JPG, _) -> true
    | _ -> false;;

(* val is_movie : fs_file -> bool = <fun> *)

let is_movie file =
    match file with
    | File (_, AVI, _) -> true
    | File (_, MKV, _) -> true
    | _ -> false;;

(* val is_document : fs_file -> bool = <fun> *)

let is_document file =
    match file with
    | File (_, DOC, _) -> true
    | File (_, PDF, _) -> true
    | _ -> false;;

(* val images : fs_item -> fs_file list = <fun> *)

let rec images_aux l acc =
    match l with
    | [] -> acc
    | FileItem file :: siblings -> 
            if is_image file 
            then images_aux siblings (file :: acc) 
            else images_aux siblings acc
    | FolderItem (_, item_list) :: siblings -> images_aux siblings (images_aux item_list acc);;

let images items =
    match items with
    | FileItem file -> if is_image file then [file] else []
    | FolderItem (_, item_list) -> images_aux item_list [];;

(* val movies : fs_item -> fs_file list = <fun> *)

let rec movies_aux l acc =
    match l with
    | [] -> acc
    | FileItem file :: siblings -> 
            if is_movie file 
            then movies_aux siblings (file :: acc) 
            else movies_aux siblings acc
    | FolderItem (_, item_list) :: siblings -> movies_aux siblings (movies_aux item_list acc);;

let movies items =
    match items with
    | FileItem file -> if is_movie file then [file] else []
    | FolderItem (_, item_list) -> movies_aux item_list [];;

(* val documents : fs_item -> fs_file list = <fun> *)

let rec documents_aux l acc =
    match l with
    | [] -> acc
    | FileItem file :: siblings -> 
            if is_document file 
            then documents_aux siblings (file :: acc) 
            else documents_aux siblings acc
    | FolderItem (_, item_list) :: siblings -> documents_aux siblings (documents_aux item_list acc);;

let documents items =
    match items with
    | FileItem file -> if is_document file then [file] else []
    | FolderItem (_, item_list) -> documents_aux item_list [];;

(* val rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)

let rec rec_search_list l name =
    match l with
    | [] -> []
    | file :: siblings -> 
            match file with
            | File (fname, _, _) -> 
                    if String.equal fname name
                    then file :: rec_search_list siblings name
                    else rec_search_list siblings name;;


(* val tail_rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)

let tail_rec_search_list l name =
    let rec tail_rec_search_list_aux l name acc =
        match l with
        | [] -> acc
        | file :: _ ->
                match file with
                | File (fname, _, _) -> 
                        if String.equal fname name
                        then tail_rec_search_list_aux (tl l) name (file :: acc)
                        else tail_rec_search_list_aux (tl l) name acc
    in tail_rec_search_list_aux l name [];;


(* val not_rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)

let not_rec_search_list l name =
    let aux a b =
        match b with
        | File (fname, _, _) -> 
                if String.equal fname name
                then b :: a else a
    in fold_left aux [] l;;

(* val search : fs_item -> String.t -> fs_file list = <fun> *)


(* val search_documents : fs_item -> String.t -> fs_file list = <fun> *)

let same_name file name =
    match file with
    | File (fname, _, _) -> if String.equal fname name then true else false;;

let search_documents items =
    (fun name -> 
        match items with
        | FileItem file -> if same_name file name then [file] else []
        | FolderItem (_, files) -> 
                let rec aux a b =
                    match b with
                    | FileItem file -> if same_name file name then file :: a else a
                    | FolderItem (_, items_list) -> fold_left aux a items_list
                in fold_left aux [] files
    );;

(* val search_documents_fun : (fs_file list -> 'a) -> fs_item -> 'a = <fun> *)


(* val size_images : fs_item -> int = <fun> *)

let size_file file =
    match file with
    | File (_, _, fsize) -> fsize;;

let size_images items =
    match items with
        | FileItem file -> size_file file
        | FolderItem (_, files) -> 
                let rec aux a b =
                    match b with
                    | FileItem file -> a + size_file file
                    | FolderItem (_, items_list) -> fold_left aux a items_list
                in fold_left aux 0 files;;

(* val fs_filter : (fs_item -> bool) -> fs_item -> fs_item_name list = <fun> *)

let get_name item =
    match item with
    | FolderItem (folder, _) -> (match folder with Folder fname -> fname)
    | FileItem file -> match file with File (fname, _, _) -> fname;;

let fs_filter p items =
    match items with
    | FolderItem (folder, item_list) ->
            let rec aux a b =
                match b with
                | FileItem _ -> if p b then (get_name b) :: a else a
                | FolderItem (_, items_list) -> 
                        if p b then (get_name b) :: a 
                        else fold_left aux a items_list
            in fold_left aux [] item_list
    | _ -> if p items then [(get_name items)] else [];;


(* val item_names_with_large6_name : fs_item -> fs_item_name list = <fun> *)

let item_names_with_large6_name items =
    let p item =
        match item with
        | FileItem file -> (
            match file with 
            | File (fname, _, _) -> 
                    if String.length fname >= 6 then true else false
            )
        | FolderItem (folder, _) -> (
            match folder with Folder fname ->
                if String.length fname >= 6 then true else false
        )
    in fs_filter p items;;

(* val item_names_with_digit_in_name : fs_item -> fs_item_name list = <fun> *)

let contains_digit str =
    let transform c =
        if ('0' < c && c < '9') then 'a' else c
    in not (String.equal str (String.map (transform) str));;


let item_names_with_digit_in_name items =
    let p item =
        match item with
        | FileItem file -> (
            match file with 
            | File (fname, _, _) -> 
                    if contains_digit fname then true else false
            )
        | FolderItem (folder, _) -> (
            match folder with Folder fname ->
                if contains_digit fname then true else false
        )
    in fs_filter p items;;

(* val full_paths : fs_item -> string list = <fun> *)

let full_paths items =
    let rec aux path litems =
        let rec fold_aux a b =
            match b with
            | FileItem file -> (match file with File (fname, _, _) -> (fname :: path) :: a)
            | FolderItem (folder, list_items) -> (
                    match folder with Folder fname -> 
                        (aux (fname :: path) list_items) @ a
            )
        in let new_path =
            if path = [] then [] else path :: []
            in fold_left fold_aux new_path litems
    in 
        let create_path lpath = String.concat "/" (rev lpath)
        in List.map create_path (aux [] [items]);;

(* val no_two_identical_names : String.t list -> bool = <fun> *)

let rec no_two_identical_names lstr =
    match lstr with
    | [] -> true
    | str :: siblings -> 
            let rec aux name lname =
                match lname with
                | [] -> true
                | element :: siblings -> if String.equal name element then false else aux name siblings
            in
            if aux str siblings then no_two_identical_names siblings else false;;

(* val name_with_ext : fs_item -> fs_item_name = <fun> *)

let name_with_ext item =
    match item with
    | FileItem file -> (
        match file with File (fname, ftype, _) -> 
            match ftype with 
            | PDF -> String.concat "." (fname :: ("pdf" :: []))
            | DOC -> String.concat "." (fname :: ("doc" :: []))
            | PNG -> String.concat "." (fname :: ("png" :: []))
            | JPG -> String.concat "." (fname :: ("jpg" :: []))
            | AVI -> String.concat "." (fname :: ("avi" :: []))
            | MKV -> String.concat "." (fname :: ("mkv" :: []))
        )
    | FolderItem (folder, _) -> match folder with Folder fname -> fname;;

(* val check : fs_item -> bool = <fun> *)

let check items =
    let rec aux lstr item =
        let new_name = name_with_ext item
        in
            match item with
            | FolderItem (_, list_items) -> fold_left aux (new_name :: lstr) list_items
            | _ -> new_name :: lstr
    in no_two_identical_names (fold_left aux [] [items]);;

(* val du : fs_item -> (fs_item_name * fs_file_size) list = <fun> *)

    


