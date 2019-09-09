(* TODO find such an endpoint... *)

let () =
  print_endline "search:";
  {|[
    {title:"Titanic", year:1997, director:"James Cameron"},
    {title:"Titanic", year:1953, director:"Jean Negulesco"}
  ]|} |>
  Atdgen_runtime.Util.Json.from_string Api_j.read_search |>
  List.iter @@ fun Api_t.{title; director; year} ->
    Printf.printf "%s (%d), directed by %s\n" title year director


let pp_fp ppf Api_t.{name; age} =
  Printf.fprintf ppf "%s (%d)" name age

let () =
  print_endline "details:";
  let Api_t.{title; director; year} =
    {|{title:"Titanic", year:1997, director:{name:"James Cameron", age:65}}|} |>
    Atdgen_runtime.Util.Json.from_string Api_j.read_movie
  in
  Printf.printf "%s (%d), directed by %a\n" title year pp_fp director
