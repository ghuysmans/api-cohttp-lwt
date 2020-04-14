type t = string option

let of_yojson js =
  match [%of_yojson: string] js with
  | Result.Ok "" -> Result.Ok None
  | Ok s -> Ok (Some s)
  | Error e -> Error e

let to_yojson t =
  let s =
    match t with
    | None -> ""
    | Some s -> s
  in
  [%to_yojson: string] s
