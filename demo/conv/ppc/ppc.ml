open Protocol_conv_json

let name = "ppx_protocol_conv_yojson"

type t = Api.Types.t = {
  id: Int.t;
  employee_name: string;
  employee_salary: Int.t;
  employee_age: Int.t;
  profile_image: String_or_empty.t;
} [@@deriving protocol ~driver:(module Json)]

type employees = {
  status: string;
  data: t list;
} [@@deriving protocol ~driver:(module Json)]

let list_of_json js =
  match Yojson.Safe.from_string js |> employees_of_json with
  | Result.Ok r -> Result.Ok (r.data)
  | Error e -> Error (Json.error_to_string_hum e)
