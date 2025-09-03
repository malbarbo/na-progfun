import gleam/list
import sgleam/check

/// Produz True se *lst* é palíndromo, isto é, tem os mesmos elementos quando
/// lida da direita para a esquerda e da esquerda para a direita. Produz False
/// caso contrário.
pub fn palindromo(lst: List(Int)) -> Bool {
  case lst {
    [] | [_] -> True
    [primeiro, ..] ->
      Ok(primeiro) == list.last(lst) && palindromo(sem_extremos(lst))
  }
}

pub fn palindromo_examples() {
  check.eq(palindromo([]), True)
  check.eq(palindromo([2]), True)
  check.eq(palindromo([1, 2]), False)
  check.eq(palindromo([3, 3]), True)
  check.eq(palindromo([3, 7, 3]), True)
  check.eq(palindromo([3, 7, 3, 3]), False)
}

/// Remove o primeiro e o último de *lst*. Se *lst* é vazia ou só tem um
/// elemento, devolve vazia.
fn sem_extremos(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [_, ..resto] -> sem_ultimo(resto)
  }
}

/// Remove o último elementod e *lst*. Se *lst* é vazia, devolve vazia.
fn sem_ultimo(lst: List(Int)) -> List(Int) {
  case lst {
    [] | [_] -> []
    [primeiro, ..resto] -> [primeiro, ..sem_ultimo(resto)]
  }
}

/// Produz True se *lst* é palíndromo, isto é, tem os mesmos elementos quando
/// lida da direita para a esquerda e da esquerda para a direita.  Produz False
/// caso contrário.
pub fn palindromo2(lst: List(Int)) -> Bool {
  lst == list.reverse(lst)
}

pub fn palindromo2_examples() {
  check.eq(palindromo2([]), True)
  check.eq(palindromo2([2]), True)
  check.eq(palindromo2([1, 2]), False)
  check.eq(palindromo2([3, 3]), True)
  check.eq(palindromo2([3, 7, 3]), True)
  check.eq(palindromo2([3, 7, 3, 3]), False)
}
