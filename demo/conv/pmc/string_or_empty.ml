open Tiny_json.Json

type t = string option

let json_of_t = function
  | None -> String ""
  | Some s -> String s

let t_of_json =
  let f_exn ?trace js =
    match Json_conv.(exn string_of_json) ?trace js with
    | "" -> None
    | s -> Some s
  in
  Json_conv.result f_exn
