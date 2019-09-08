module M = Api.Make (Cohttp_lwt_unix.Client)

let () = Lwt_main.run (
  let%lwt l = M.list () in
  l |> List.iter (fun e ->
    print_endline e.Api.employee_name
  );
  Lwt.return_unit
)
