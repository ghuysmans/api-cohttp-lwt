open Js_of_ocaml

(* module M = Api.Make (Cohttp_lwt_xhr.Client) *)
module M = Api.Make (Api_cohttp_lwt.Cors_anywhere)

let _ = Dom_events.(listen Dom_html.document Typ.domContentLoaded) @@ fun _ _ ->
  match Dom_html.getElementById_coerce "l" Dom_html.CoerceTo.ul with
  | None -> failwith "l"
  | Some ul ->
    Lwt.async (fun () ->
      let%lwt l = M.list () in
      l |> List.iter (fun e ->
        let li = Dom_html.(createLi document) in
        li##.innerHTML := Js.string (e.Api.employee_name);
        ignore (ul##appendChild (li :> Dom.node Js.t))
      );
      Lwt.return_unit
    );
    false
