module type C = sig
  val name: string
  val list_of_json: string -> (Types.t list, string) result
end

exception ConversionError of string

module Make (Client : Cohttp_lwt.S.Client) (Conv : C) = struct
  let list ?ctx () =
    let url = "http://dummy.restapiexample.com/api/v1/employees" in
    let%lwt _, body = Client.get ?ctx @@ Uri.of_string url in
    (* FIXME handle HTTP errors *)
    let%lwt raw = Cohttp_lwt.Body.to_string body in
    match Conv.list_of_json raw with
    | Error e -> Lwt.fail (ConversionError e)
    | Ok l -> Lwt.return l
end
