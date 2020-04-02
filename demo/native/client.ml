module M = Api.Client.Make (Cohttp_lwt_unix.Client) (Ojt)

let () = Lwt_main.run (
  let%lwt l = M.list () in
  l |> List.iter (fun e ->
    print_endline e.Api.Types.employee_name
  );
  Lwt.return_unit
)
