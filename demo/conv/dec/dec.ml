open Decoders_yojson.Safe.Decode

let name = "ocaml-decoders"

(* this API doesn't use integers directly... *)
let int = string >>= fun s -> succeed (int_of_string s)

let string_or_empty = string >>= function
  | "" -> succeed None
  | s -> succeed (Some s)

let t =
  field "id" int >>= fun id ->
  field "employee_name" string >>= fun employee_name ->
  field "employee_salary" int >>= fun employee_salary ->
  field "employee_age" int >>= fun employee_age ->
  field "profile_image" string_or_empty >>= fun profile_image ->
  succeed {
    Api.Types.id;
    employee_name;
    employee_salary;
    employee_age;
    profile_image
  }

let const_string c =
  string >>= fun s ->
  if s = c then succeed ()
  else fail @@ "expected " ^ c

let list =
  field "status" (const_string "success") >>= fun () ->
  field "data" (list t) >>= fun l ->
  succeed l

let list_of_yojson js =
  match decode_value list js with
  | Result.Ok l -> Result.Ok l
  | Error _ -> Error "decoder" (* FIXME *)
