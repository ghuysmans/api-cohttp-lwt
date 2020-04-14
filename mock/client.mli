include Cohttp_lwt.S.Client with
  type ctx =
    ?headers:Cohttp.Header.t ->
    ?body:string ->
    ?chunked:bool ->
    Cohttp.Code.meth ->
    Uri.t -> (Cohttp.Response.t * Cohttp_lwt.Body.t) Lwt.t


type router = (
  ?headers:Cohttp.Header.t ->
  ?body:string ->
  Cohttp.Code.meth ->
  (Cohttp.Code.status_code * string) Lwt.t
) Routes.router

val ctx_of_router: router -> ctx
