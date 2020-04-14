let name = "ppx_deriving_yojson"

type t = Api.Types.t = {
  id: Int.t;
  employee_name: string;
  employee_salary: Int.t;
  employee_age: Int.t;
  profile_image: String_or_empty.t;
} [@@deriving yojson {strict = false}]

type employees = {
  status: string;
  data: t list;
} [@@deriving yojson]

let list_of_yojson js =
  match employees_of_yojson js with
  | Result.Ok e -> Result.Ok e.data
  | Error e -> Error e
