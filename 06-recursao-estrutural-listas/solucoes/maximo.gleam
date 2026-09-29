import gleam/int
import sgleam/check

/// Devolve o valor máximo de *lst* ou Error(Nil) se *lst* é vazia.
pub fn maximo(lst: List(Int)) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..resto] ->
      case maximo(resto) {
        Error(Nil) -> Ok(primeiro)
        Ok(maximo_resto) -> Ok(int.max(primeiro, maximo_resto))
      }
  }
}

pub fn maximo_examples() {
  check.eq(maximo([]), Error(Nil))
  check.eq(maximo([2]), Ok(2))
  check.eq(maximo([2, 1]), Ok(2))
  check.eq(maximo([2, 1, 5]), Ok(5))
}
