open Js_of_ocaml

type t = string option

let of_jsobject x =
  match Ppx_jsobject_conv_runtime.string_of_jsobject x with
  | Error e -> Error e
  | Ok "" -> Ok None
  | Ok s -> Ok (Some s)

let jsobject_of = function
  | None -> Js.string ""
  | Some s -> Js.string s
