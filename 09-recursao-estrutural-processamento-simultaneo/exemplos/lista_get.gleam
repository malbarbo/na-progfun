import sgleam/check

/// Devolve o elemento na posição *i* de *lst* (indexado a partir de 0).
/// Devolve Error(Nil) se *i* é negativo ou é maior ou igual à quantidade de
/// elementos de *lst*.
pub fn lista_get(lst: List(a), k: Int) -> Result(a, Nil) {
  case lst, k {
    [primeiro, ..], 0 -> Ok(primeiro)
    [_, ..resto], _ if k > 0 -> lista_get(resto, k - 1)
    _, _ -> Error(Nil)
  }
}

pub fn lista_get_examples() {
  // [], 0
  check.eq(lista_get([], 0), Error(Nil))
  // [], > 0
  check.eq(lista_get([], 2), Error(Nil))
  // [_, ..], 0
  check.eq(lista_get([3, 2, 8], 0), Ok(3))
  // [_, ..], > 0
  check.eq(lista_get([3, 2, 8, 10], 2), Ok(8))
  check.eq(lista_get([3, 2, 8, 10], 4), Error(Nil))
  // [], < 0
  check.eq(lista_get([], -1), Error(Nil))
  // [_, ..], < 0
  check.eq(lista_get([3, 5], -2), Error(Nil))
}
