module type P = sig
  val proxy: Uri.t -> Uri.t
end

module Make (Client : Cohttp_lwt.S.Client) (Proxy : P) = struct
  open Proxy

  type ctx = Client.ctx
  let default_ctx = Client.default_ctx
  let sexp_of_ctx = Client.sexp_of_ctx

  let call ?ctx ?headers ?body ?chunked meth uri =
    Client.call ?ctx ?headers ?body ?chunked meth (proxy uri)
  let callv ?ctx uri stream =
    Client.callv ?ctx (proxy uri) stream

  let get ?ctx ?headers uri =
    Client.get ?ctx ?headers (proxy uri)
  let post_form ?ctx ?headers ~params uri =
    Client.post_form ?ctx ?headers ~params (proxy uri)
  let patch ?ctx ?body ?chunked ?headers uri =
    Client.patch ?ctx ?body ?chunked ?headers (proxy uri)
  let put ?ctx ?body ?chunked ?headers uri =
    Client.put ?ctx ?body ?chunked ?headers (proxy uri)
  let post ?ctx ?body ?chunked ?headers uri =
    Client.post ?ctx ?body ?chunked ?headers (proxy uri)
  let delete ?ctx ?body ?chunked ?headers uri =
    Client.delete ?ctx ?body ?chunked ?headers (proxy uri)
  let head ?ctx ?headers uri =
    Client.head ?ctx ?headers (proxy uri)
end
