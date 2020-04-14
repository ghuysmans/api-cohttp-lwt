type ctx =
  ?headers:Cohttp.Header.t ->
  ?body:string ->
  ?chunked:bool ->
  Cohttp.Code.meth ->
  Uri.t -> (Cohttp.Response.t * Cohttp_lwt.Body.t) Lwt.t

let sexp_of_ctx _ = Sexplib0.Sexp.List [] (* TODO? *)

let default_ctx ?headers ?body ?chunked _ _ =
  Lwt.fail_with "mock" [@@ocaml.warning "-27"]

type router = (
  ?headers:Cohttp.Header.t ->
  ?body:string ->
  Cohttp.Code.meth ->
  (Cohttp.Code.status_code * string) Lwt.t
) Routes.router

let ctx_of_router router ?headers ?body ?chunked meth uri =
  ignore chunked;
  let%lwt status, body =
    match Routes.match' router ~target:(Uri.path uri) with
    | None -> Lwt.return (`Not_found, "Not found")
    | Some r -> r ?headers ?body meth
  in
  Lwt.return (
    Cohttp.Response.make ~version:`HTTP_1_1 ~status (),
    Cohttp_lwt.Body.of_string body
  )

let call ?ctx ?headers ?body ?chunked meth uri =
  let%lwt body =
    match body with
    | None -> Lwt.return None
    | Some x ->
      let%lwt s = Cohttp_lwt.Body.to_string x in
      Lwt.return (Some s)
  in
  match ctx with
  | None -> Lwt.fail_invalid_arg "missing ctx"
  | Some ctx -> ctx ?headers ?body ?chunked meth uri

let head ?ctx ?headers uri =
  Lwt.Infix.(call ?ctx ?headers `HEAD uri >|= fst)
let get ?ctx ?headers uri =
  call ?ctx ?headers `GET uri
let delete ?ctx ?body ?chunked ?headers uri =
  call ?ctx ?body ?chunked ?headers `DELETE uri
let post ?ctx ?body ?chunked ?headers uri =
  call ?ctx ?body ?chunked ?headers `POST uri
let put ?ctx ?body ?chunked ?headers uri =
  call ?ctx ?body ?chunked ?headers `PUT uri
let patch ?ctx ?body ?chunked ?headers uri =
  call ?ctx ?body ?chunked ?headers `PATCH uri
let post_form ?ctx ?headers ~params uri =
  Lwt.fail_with "TODO post_form" [@@ocaml.warning "-27"]
let callv ?ctx uri req =
  Lwt.fail_with "TODO callv" [@@ocaml.warning "-27"]
