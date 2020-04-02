module S = Json_schema.Make (Json_repr.Yojson)

let () =
  S.to_json Ojt.schema |>
  Yojson.Safe.pretty_print Format.std_formatter;
  Format.printf "@."
