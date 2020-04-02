type t = string option

let of_json_exn js =
  match Protocol_conv_json.Json.to_string js with
  | "" -> None
  | s -> Some s

let to_json t =
  let s =
    match t with
    | None -> ""
    | Some s -> s
  in
  Protocol_conv_json.Json.of_string s
