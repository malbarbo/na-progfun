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

/// Cria uma lista com *n* repetições do valor *v*.
pub fn repete(n: Int, v: a) -> List(a) {
  reduz_num(n, [], fn(lst, _) { [v, ..lst] })
}

pub fn repete_examples() {
  check.eq(repete(0, 3), [])
  check.eq(repete(3, 10), [10, 10, 10])
}

/// Calcula *a* elevado à potência *n* (a^n), com a != 0.
pub fn potencia(a: Float, n: Int) -> Float {
  reduz_num(n, 1.0, fn(e, _) { a *. e })
}

pub fn potencia_examples() {
  check.eq(potencia(10.0, 0), 1.0)
  check.eq(potencia(2.0, 1), 2.0)
  check.eq(potencia(2.0, 2), 4.0)
  check.eq(potencia(2.0, 3), 8.0)
}
