let name = "ppx_meta_conv"

open Json_conv.Default

type employee = Api.Types.t = {
  id: Int.t;
  employee_name: string;
  employee_salary: Int.t;
  employee_age: Int.t;
  profile_image: String_or_empty.t;
} [@@deriving conv{json}]

type t = {
  status: string;
  data: employee list;
} [@@deriving conv{json}]

let list_of_json js =
  Tiny_json.Json.parse js |>
  t_of_json |> function
    | Ok {data; _} -> Ok data
    | Error e -> Error (Format.asprintf "%a" Json_conv.format_error e)
