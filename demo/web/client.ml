open Js_of_ocaml

module M = Api.Client.Make (Cohttp_lwt_xhr.Client) (struct
  let name = "ocplib-json-typed-browser"

  let list_of_json js =
    try
      Result.Ok (Json_repr_browser.(parse js |> Json_encoding.destruct Ojt.list))
    with e ->
      Json_encoding.print_error Format.str_formatter e;
      Result.Error (Format.flush_str_formatter ())
end)

let _ = Dom_events.(listen Dom_html.document Typ.domContentLoaded) @@ fun _ _ ->
  match Dom_html.getElementById_coerce "l" Dom_html.CoerceTo.ul with
  | None -> failwith "l"
  | Some ul ->
    Lwt.async (fun () ->
      let%lwt l = M.list () in
      l |> List.iter (fun e ->
        let li = Dom_html.(createLi document) in
        li##.innerHTML := Js.string (e.Api.Types.employee_name);
        ignore (ul##appendChild (li :> Dom.node Js.t))
      );
      Lwt.return_unit
    );
    false
