module type P = sig
  val proxy: Uri.t -> Uri.t
end

module Make : functor
  (Client : Cohttp_lwt.S.Client)
  (Proxy : P) ->
  Cohttp_lwt.S.Client
