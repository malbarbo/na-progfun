import gleam/list
import sgleam/check

/// Produz uma lista com o sinal de cada elemento de *lst*.
pub fn sinais(lst: List(Int)) -> List(Int) {
  list.map(lst, sinal)
}

/// Determina o sinal de *n*. O sinal é 1 para *n* positivo, -1 para *n*
/// negativo e 0 para *n* 0.
fn sinal(n: Int) -> Int {
  case n {
    _ if n > 0 -> 1
    _ if n == 0 -> 0
    _ -> -1
  }
}

pub fn sinais_examples() {
  check.eq(sinais([10, 0, 2, -4, -1, 0, 8]), [1, 0, 1, -1, -1, 0, 1])
}
