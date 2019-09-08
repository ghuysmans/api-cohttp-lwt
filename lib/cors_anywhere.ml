include Proxy.Make (Cohttp_lwt_xhr.Client) (struct
  let proxy uri =
    (* FIXME beware of redirections? *)
    (* TODO Uri.pct_encode? *)
    "https://cors-anywhere.herokuapp.com/" ^ Uri.to_string uri |>
    Uri.of_string
end)
