import gleam/list
import sgleam/check

/// Inverte os elementos de *lst*.
pub fn inverte(lst: List(a)) -> List(a) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> list.append(inverte(resto), [primeiro])
  }
}

pub fn inverte_examples() {
  check.eq(inverte([]), [])
  check.eq(inverte([7, 1]), [1, 7])
}

/// Inverte os elementos de *lst*.
pub fn inverte2(lst: List(a)) -> List(a) {
  inverte_loop(lst, [])
}

pub fn inverte_loop(lst: List(a), acc: List(a)) -> List(a) {
  // acc é a lista dos elementos já analisados em ordem reversa
  case lst {
    [] -> acc
    [primeiro, ..resto] -> inverte_loop(resto, [primeiro, ..acc])
  }
}

pub fn inverte2_examples() {
  check.eq(inverte2([]), [])
  check.eq(inverte2([7, 1]), [1, 7])
}
