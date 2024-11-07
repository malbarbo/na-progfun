import sgleam/check

/// Soma *x* a cada elemento de *lst*.
pub fn soma_x(lst: List(Int), x: Int) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [primeiro + x, ..soma_x(resto, x)]
  }
}

pub fn soma_x_examples() {
  check.eq(soma_x([], 4), [])
  check.eq(soma_x([4, 2], 5), [9, 7])
  check.eq(soma_x([3, -1, 4], -2), [1, -3, 2])
}
