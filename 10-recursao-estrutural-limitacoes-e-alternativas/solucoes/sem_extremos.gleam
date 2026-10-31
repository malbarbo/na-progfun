import sgleam/check

/// Remove o primeiro e o último elemento de *lst*. Se *lst* é vazia ou só tem
/// um elemento, devolve vazia.
pub fn sem_extremos(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [_, ..resto] -> sem_ultimo(resto)
  }
}

pub fn sem_extremos_examples() {
  check.eq(sem_extremos([]), [])
  check.eq(sem_extremos([7]), [])
  check.eq(sem_extremos([7, 3]), [])
  check.eq(sem_extremos([7, 3, 2]), [3])
  check.eq(sem_extremos([4, 1, 5, 1, 4]), [1, 5, 1])
}

/// Remove o último elemento de *lst*. Se *lst* é vazia, devolve vazia.
pub fn sem_ultimo(lst: List(Int)) -> List(Int) {
  case lst {
    [] | [_] -> []
    [primeiro, ..resto] -> [primeiro, ..sem_ultimo(resto)]
  }
}

pub fn sem_ultimo_examples() {
  check.eq(sem_ultimo([]), [])
  check.eq(sem_ultimo([7]), [])
  check.eq(sem_ultimo([7, 3]), [7])
  check.eq(sem_ultimo([7, 3, 2]), [7, 3])
}
