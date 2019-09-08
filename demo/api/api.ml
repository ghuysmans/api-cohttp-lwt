type t = {
  id: string;
  employee_name: string;
} [@@deriving yojson {strict = false}]

module Make (Client : Cohttp_lwt.S.Client) = struct
  let list () =
    let url = "http://dummy.restapiexample.com/api/v1/employees" in
    let%lwt _, body = Client.get @@ Uri.of_string url in
    let%lwt raw = Cohttp_lwt.Body.to_string body in
    match Yojson.Safe.from_string raw |> [%derive.of_yojson: t list] with
    | Error e -> failwith @@ "list: " ^ e
    | Ok l -> Lwt.return l
end
