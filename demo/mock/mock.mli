module Make : functor () -> sig
  val employees: (int, Api.Types.t) Hashtbl.t
  val router: Api_cohttp_lwt_mock.Client.router
end
