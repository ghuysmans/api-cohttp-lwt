type t = bool

let to_xml_light = function
  | true -> Xml.PCData "1"
  | false -> Xml.PCData "0"

let of_xml_light_exn = function
  | Xml.Element (_, _, [PCData "1"]) -> true
  | Xml.Element (_, _, [PCData "0"]) -> false
  | _ -> failwith "Binary.of_xml_light_exn"
