import gleam/float
import gleam/int
import gleam/string
import sgleam/check

/// Combina os elementos de *lst* usando *f*. O resultado começa com *init* e é
/// atualizado com *f(res, e)* para cada elemento *e* de *lst*, da direita para
/// a esquerda.
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
  check.eq(reduz([1, 2], 0, int.add), 3)
  check.eq(reduz([5.0, 2.0, 4.0], 1.0, float.multiply), 40.0)
}

/// Soma *soma* com o tamanho de *s*.
pub fn soma_tam(soma: Int, s: String) -> Int {
  soma + string.length(s)
}

pub fn soma_tam_examples() {
  check.eq(soma_tam(0, "casa"), 4)
  check.eq(soma_tam(3, "a"), 4)
}

/// Soma os tamanhos das strings de *lst*.
pub fn soma_tamanhos(lst: List(String)) -> Int {
  reduz(lst, 0, soma_tam)
}

pub fn soma_tamanhos_examples() {
  check.eq(soma_tamanhos([]), 0)
  check.eq(soma_tamanhos(["casa", "a"]), 5)
}

/// Junta os itens de *lst* em ordem contrária.
pub fn junta_r(lst: List(String)) -> String {
  reduz(lst, "", string.append)
}

pub fn junta_r_examples() {
  check.eq(junta_r([]), "")
  check.eq(junta_r(["a", "", "c"]), "ca")
  check.eq(junta_r(["", "c"]), "c")
}
