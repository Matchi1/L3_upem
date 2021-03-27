(* file system item type *)
type fs_file_type = PDF (* portable document format *)
                  | DOC (* microsoft document *)
                  | PNG (* portable network graphics *)
                  | JPG (* joint photographic experts group, *)
                  | AVI (* audio video interleave *)
                  | MKV (* matroska video *)

(* file system item name alias *)
type fs_item_name = string

(* file system item size alias *)
type fs_file_size = int

(* file system file *)
(* a file is described by its name, its type and its size *)
type fs_file = File of fs_item_name * fs_file_type * fs_file_size

(* file system folder *)
(* a folder is simply described by its name *)
type fs_folder = Folder of fs_item_name

(* file system item *)
(* a file system item is either a folder (containing items) or a file *)
type fs_item = FolderItem of fs_folder * fs_item list
             | FileItem of fs_file
