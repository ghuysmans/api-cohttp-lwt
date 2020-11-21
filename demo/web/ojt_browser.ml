include Api.Client.Make (Cohttp_lwt_xhr.Client) (struct
  let name = "ocplib-json-typed-browser"

  let list_of_json js =
    try
      Result.Ok (Json_repr_browser.(parse js |> Json_encoding.destruct Ojt.list))
    with e ->
      Json_encoding.print_error Format.str_formatter e;
      Result.Error (Format.flush_str_formatter ())
end)
