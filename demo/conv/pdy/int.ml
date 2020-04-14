(* this API doesn't use integers directly... *)
type t = int

let of_yojson js =
  match [%of_yojson: string] js with
  | Result.Ok s -> Result.Ok (int_of_string s)
  | Error e -> Error e

let to_yojson i = [%to_yojson: string] (string_of_int i)
