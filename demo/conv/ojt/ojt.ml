open Json_encoding

let name = "ocplib-json-typed"

(* this API doesn't use integers directly... *)
let int = conv string_of_int int_of_string string

let default_to d = function
  | None -> d
  | Some x -> x

let string_or_empty = string |> conv
  (default_to "")
  (fun s -> if s = "" then None else Some s)

let id = req "id" int
let employee_name = req "employee_name" string
let employee_salary = req "employee_salary" int
let employee_age = req "employee_age" int
let profile_image = req "profile_image" string_or_empty
let t = obj5 id employee_name employee_salary employee_age profile_image |> conv
  (fun t ->
    t.Api.Types.id, t.employee_name, t.employee_salary, t.employee_age, t.profile_image)
  (fun (id, employee_name, employee_salary, employee_age, profile_image) -> {
    Api.Types.id; employee_name; employee_salary; employee_age; profile_image})

let status = req "status" @@ constant "success"
let data = req "data" @@ list t
let list = def "list" @@ obj2 status data |> conv
  (fun l -> (), l)
  (fun ((), l) -> l)

let schema = schema list


module Y = Make (Json_repr.Yojson)

let list_of_json raw =
  try
    Result.Ok (Yojson.Safe.from_string raw |> Y.destruct list)
  with e ->
    print_error Format.str_formatter e;
    Result.Error (Format.flush_str_formatter ())
