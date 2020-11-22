open Js_of_ocaml

type t = int

let of_jsobject x =
  match Ppx_jsobject_conv_runtime.string_of_jsobject x with
  | Error e -> Error e
  | Ok s ->
    try Ok (int_of_string s)
    with Failure _ -> Error "int_of_string"

let jsobject_of i = Js.Unsafe.coerce (Obj.magic i)
