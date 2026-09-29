import gleam/list
import sgleam/check

/// Devolve uma lista com todos os pares de elementos de *ltsa* e *lstb*.
pub fn pares(lsta: List(a), lstb: List(a)) -> List(List(a)) {
  case lsta {
    [] -> []
    [primeiro, ..resto] ->
      list.append(list.map(lstb, fn(v) { [primeiro, v] }), pares(resto, lstb))
  }
}

pub fn pares_examples() {
  check.eq(pares([3, 1, 8], [7, 4]), [
    [3, 7],
    [3, 4],
    [1, 7],
    [1, 4],
    [8, 7],
    [8, 4],
  ])
}
