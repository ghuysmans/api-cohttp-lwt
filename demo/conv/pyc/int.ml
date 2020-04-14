(* this API doesn't use integers directly... *)
type t = int
let t_of_yojson js = int_of_string ([%of_yojson: string] js)
let yojson_of_t i = [%yojson_of: string] (string_of_int i)
