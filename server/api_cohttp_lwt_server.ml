let of_router router =
  let callback _conn req body =
    let uri = Cohttp.Request.uri req in
    let meth = Cohttp.Request.meth req in
    let headers = Cohttp.Request.headers req in
    let%lwt body = Cohttp_lwt.Body.to_string body in
    Api_cohttp_lwt_mock.Client.ctx_of_router router ~headers ~body meth uri
  in
  Cohttp_lwt_unix.Server.make ~callback ()
