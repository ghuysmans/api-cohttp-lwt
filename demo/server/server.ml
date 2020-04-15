module M = Mock.Make ()

let () = Lwt_main.run (
  Cohttp_lwt_unix.Server.create
    ~mode:(`TCP (`Port 8000))
    (Api_cohttp_lwt_server.of_router M.router)
)
