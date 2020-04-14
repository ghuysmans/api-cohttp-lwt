let name = "ppx_yojson_conv"

type t = Api.Types.t = {
  id: Int.t;
  employee_name: string;
  employee_salary: Int.t;
  employee_age: Int.t;
  profile_image: String_or_empty.t;
} [@@deriving yojson] [@@yojson.allow_extra_fields]

type employees = {
  status: string;
  data: t list;
} [@@deriving yojson]

let list_of_yojson js =
  Result.Ok (employees_of_yojson js).data
