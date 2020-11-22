module Make () = struct
  let employees = Hashtbl.create 50

  let list ?headers ?body meth =
    ignore headers;
    match meth, body with
    | `GET, _ -> Lwt.return (`OK, "{\
      \"status\": \"success\",\
      \"data\": [{\
        \"id\": \"1\",\
        \"employee_name\": \"Bob\",\
        \"employee_salary\": \"42000\",\
        \"employee_age\": \"50\",\
        \"profile_image\": \"\"\
      }]}"
    )
    | _ -> Lwt.return (`Method_not_allowed, "meh")

  let get id ?headers ?body meth =
    ignore headers;
    match meth, body with
    | `GET, _ ->
      (match Hashtbl.find_opt employees id with
      | None -> Lwt.return (`Not_found, "no such employee")
      | Some _e -> Lwt.return (`OK, "TODO"))
    | _ -> Lwt.return (`Method_not_allowed, "meh")

  let router = Routes.(one_of [
    s "api" / s "v1" / s "employees" /? nil @--> list;
    s "api" / s "v1" / s "employee" / int /? nil @--> get;
  ])
end
