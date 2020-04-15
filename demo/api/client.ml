module type C = sig
  val name: string
  val list_of_yojson: Yojson.Safe.t -> (Types.t list, string) result
end

module Make (Client : Cohttp_lwt.S.Client) (Conv : C) = struct
  let list ?ctx () =
    let url = "http://dummy.restapiexample.com/api/v1/employees" in
    let%lwt _, body = Client.get ?ctx @@ Uri.of_string url in
    (* FIXME handle HTTP errors *)
    let%lwt raw = Cohttp_lwt.Body.to_string body in
    match Yojson.Safe.from_string raw |> Conv.list_of_yojson with
    | Error e -> failwith @@ "list: " ^ e
    | Ok l -> Lwt.return l
end
