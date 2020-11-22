open Js_of_ocaml

let name = "ppx_jsobject_conv"

type employee = Api.Types.t = {
  id: Int.t;
  employee_name: string;
  employee_salary: Int.t;
  employee_age: Int.t;
  profile_image: String_or_empty.t;
} [@@deriving jsobject]

type t = {
  status: string;
  data: employee list;
} [@@deriving jsobject]

let list_of_json js =
  Json.unsafe_input (Js.string js) |>
  of_jsobject |> function
    | Ok {data; _} -> Ok data
    | Error e -> Error e
