module Yojson = struct
  open Ppx_deriving_yojson_runtime

  module Make (S : Derivable.Yojson) = struct
    type t = S.t option

    let to_yojson = function
      | Some x -> S.to_yojson x
      | None -> `Int (-1)

    let of_yojson = function
      | `Int (-1) -> Ok None
      | j -> S.of_yojson j >|= fun x -> Some x
  end
end
