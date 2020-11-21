open Js_of_ocaml

module M = Ojt_browser

let _ = Dom_events.(listen Dom_html.document Typ.domContentLoaded) @@ fun _ _ ->
  match Dom_html.getElementById_coerce "l" Dom_html.CoerceTo.ul with
  | None -> failwith "l"
  | Some ul ->
    Lwt.async (fun () -> Lwt.catch (fun () ->
      let%lwt l = M.list () in
      l |> List.iter (fun e ->
        let li = Dom_html.(createLi document) in
        li##.innerHTML := Js.string (e.Api.Types.employee_name);
        ignore (ul##appendChild (li :> Dom.node Js.t))
      );
      Lwt.return_unit
    ) (function
      | Api.Client.ConversionError e ->
        Dom_html.window##alert (Js.string e);
        Lwt.return_unit
      | _ ->
        Lwt.return_unit
    ));
    false
