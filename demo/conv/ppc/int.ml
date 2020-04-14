(* this API doesn't use integers directly... *)
type t = int
let of_json_exn js = int_of_string (Protocol_conv_json.Json.to_string js)
let to_json i = Protocol_conv_json.Json.of_string (string_of_int i)
