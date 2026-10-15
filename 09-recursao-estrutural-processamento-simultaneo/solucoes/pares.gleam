import gleam/list
import sgleam/check

/// Devolve uma lista com todos os pares de elementos de *lsta* e *lstb*.
pub fn pares(lsta: List(a), lstb: List(a)) -> List(List(a)) {
  case lsta {
    [] -> []
    [primeiro, ..resto] ->
      list.append(pares_elemento(primeiro, lstb), pares(resto, lstb))
  }
}

pub fn pares_examples() {
  check.eq(pares([], [7, 4]), [])
  check.eq(pares([3], []), [])
  check.eq(pares([3, 1, 8], [7, 4]), [
    [3, 7],
    [3, 4],
    [1, 7],
    [1, 4],
    [8, 7],
    [8, 4],
  ])
}

/// Devolve uma lista com os pares formados por *a* e cada elemento de *lst*.
pub fn pares_elemento(a: a, lst: List(a)) -> List(List(a)) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [[a, primeiro], ..pares_elemento(a, resto)]
  }
}

pub fn pares_elemento_examples() {
  check.eq(pares_elemento(3, []), [])
  check.eq(pares_elemento(3, [7]), [[3, 7]])
  check.eq(pares_elemento(3, [7, 4]), [[3, 7], [3, 4]])
}
