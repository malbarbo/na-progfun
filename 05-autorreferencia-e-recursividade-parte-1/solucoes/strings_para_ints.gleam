import gleam/int
import sgleam/check

/// Converte os valores de *lst* para inteiros usando a função gleam/int.parse.
/// Se alguma conversão falhar, devolve Error(Nil).
pub fn strings_para_ints(lst: List(String)) -> Result(List(Int), Nil) {
  case lst {
    [] -> Ok([])
    [primeiro, ..resto] ->
      case int.parse(primeiro) {
        Ok(primeiro) ->
          case strings_para_ints(resto) {
            Ok(resto) -> Ok([primeiro, ..resto])
            _ -> Error(Nil)
          }
        _ -> Error(Nil)
      }
  }
}

pub fn strings_para_ints_examples() {
  check.eq(strings_para_ints([]), Ok([]))
  check.eq(strings_para_ints(["1"]), Ok([1]))
  check.eq(strings_para_ints(["a"]), Error(Nil))
  check.eq(strings_para_ints(["1", "2"]), Ok([1, 2]))
  check.eq(strings_para_ints(["1", "a", "2"]), Error(Nil))
}
