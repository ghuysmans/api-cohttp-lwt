let () = Lwt_main.run (
  Index.modules |> Lwt_list.iter_s (fun (module P : Api.Client.C) ->
    if P.name = Sys.argv.(1) then
      let module M = Api.Client.Make (Cohttp_lwt_unix.Client) (P) in
      let%lwt l = M.list () in
      l |> Lwt_list.iter_s (fun e ->
        Lwt_io.printl e.Api.Types.employee_name
      )
    else
      Lwt.return_unit
  )
)
