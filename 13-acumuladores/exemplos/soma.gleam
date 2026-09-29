import sgleam/check

/// Soma os elementos de *lst*.
pub fn soma(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] -> primeiro + soma(resto)
  }
}

pub fn soma_examples() {
  check.eq(soma([]), 0)
  check.eq(soma([4]), 4)
  check.eq(soma([7, 1]), 8)
}

/// Soma os elementos de *lst*.
pub fn soma2(lst: List(Int)) -> Int {
  soma_loop(lst, 0)
}

pub fn soma_loop(lst: List(Int), acc: Int) -> Int {
  // acc é a soma dos elementos já processados
  case lst {
    [] -> acc
    [primeiro, ..resto] -> soma_loop(resto, acc + primeiro)
  }
}

pub fn soma2_examples() {
  check.eq(soma2([]), 0)
  check.eq(soma2([4]), 4)
  check.eq(soma2([7, 1]), 8)
}
