type t = string option

let t_of_yojson js =
  match [%of_yojson: string] js with
  | "" -> None
  | s -> Some s

let yojson_of_t t =
  let s =
    match t with
    | None -> ""
    | Some s -> s
  in
  [%yojson_of: string] s
