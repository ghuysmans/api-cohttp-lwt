type t = Uri.t option

let to_xml_light = function
  | None -> Xml.PCData ""
  | Some uri -> Xml.PCData (Uri.to_string uri)

let of_xml_light_exn = function
  | Xml.Element (_, _, [PCData s]) -> Some (Uri.of_string s)
  | Xml.Element (_, _, []) -> None
  | x -> failwith @@ Xml.to_string x
