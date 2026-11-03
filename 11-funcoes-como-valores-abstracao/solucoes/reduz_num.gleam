import gleam/int
import gleam/list
import sgleam/check

/// Aplica a função *f* repetidamente ao valor *init* e aos números de 1 a *n*,
/// isto é, f(... f(f(init, 1), 2) ..., n).
pub fn reduz_num(n: Int, init: a, f: fn(a, Int) -> a) -> a {
  case n <= 0 {
    True -> init
    False -> f(reduz_num(n - 1, init, f), n)
  }
}

/// Exemplos de uso das funções
pub fn reduz_num_examples() {
  // soma_nat
  check.eq(reduz_num(4, 0, int.add), 10)

  // lista_num
  check.eq(reduz_num(4, [], adiciona_fim), [1, 2, 3, 4])
}

/// Adiciona *e* ao final de *lst*.
pub fn adiciona_fim(lst: List(a), e: a) -> List(a) {
  list.append(lst, [e])
}
