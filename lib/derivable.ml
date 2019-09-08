module type Yojson = sig
  type t
  val of_yojson: Yojson.Safe.t -> t Ppx_deriving_yojson_runtime.error_or
  val to_yojson: t -> Yojson.Safe.t
end
