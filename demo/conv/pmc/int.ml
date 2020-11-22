open Tiny_json.Json

type t = int

let json_of_t i = String (string_of_int i)

let t_of_json =
  let f_exn ?trace js =
    Json_conv.(exn string_of_json) ?trace js |> int_of_string
  in
  Json_conv.result f_exn
