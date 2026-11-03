import gleam/float
import gleam/int
import gleam/string
import sgleam/check

/// Reduz os elementos de *lst* em um acumulador usando a função *f*. O
/// acumulador começa com *init* e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da direita para a esquerda.
///
/// Por exemplo, a chamada reduz([4, 1, 2], 0, int.add) é equivalente a
/// *int.add(int.add(int.add(0, 2), 1), 4)*.
pub fn reduz(lst: List(a), init: b, f: fn(b, a) -> b) -> b {
  case lst {
    [] -> init
    [primeiro, ..resto] -> f(reduz(resto, init, f), primeiro)
  }
}

pub fn reduz_examples() {
  check.eq(reduz([4, 1, 2], 0, int.add), 7)
  check.eq(reduz([5.0, 2.0, 4.0], 1.0, float.multiply), 40.0)
}

/// Soma os números de *lst*.
pub fn soma(lst: List(Int)) -> Int {
  reduz(lst, 0, int.add)
}

pub fn soma_examples() {
  check.eq(soma([]), 0)
  check.eq(soma([3, 5]), 8)
}

/// Junta os itens de *lst* em ordem contrária.
pub fn junta_r(lst: List(String)) -> String {
  reduz(lst, "", string.append)
}

pub fn junta_r_examples() {
  check.eq(junta_r([]), "")
  check.eq(junta_r(["a", "", "c"]), "ca")
}
