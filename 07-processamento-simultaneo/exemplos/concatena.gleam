import sgleam/check

/// Produz uma nova lista com os elementos de *lsta* seguido dos elementos de
/// *lstb*.
pub fn concatena(lsta: List(a), lstb: List(a)) -> List(a) {
  case lsta {
    [] -> lstb
    [primeiro, ..resto] -> [primeiro, ..concatena(resto, lstb)]
  }
}

pub fn concatena_examples() {
  check.eq(concatena([], [10, 4, 6]), [10, 4, 6])
  check.eq(concatena([3], [10, 4, 6]), [3, 10, 4, 6])
  check.eq(concatena([7, 3], [10, 4, 6]), [7, 3, 10, 4, 6])
}
