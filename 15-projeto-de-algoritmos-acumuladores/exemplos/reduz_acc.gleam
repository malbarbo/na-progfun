import sgleam/check

/// Reduz os elementos de *lst* em um acumulador usando a função *f*. O
/// acumulador começa com *init* e é atualizado chamando *f(acc, e)* para cada
/// elemento *e* de *lst* da esquerda para a direita.
fn reduz_acc(lst: List(a), acc: b, f: fn(b, a) -> b) -> b {
  case lst {
    [] -> acc
    [primeiro, ..resto] -> reduz_acc(resto, f(acc, primeiro), f)
  }
}

/// Conta a quantidade de elementos de *lst*.
pub fn tamanho(lst: List(a)) -> Int {
  reduz_acc(lst, 0, fn(acc, _) { acc + 1 })
}

pub fn tamanho_examples() {
  check.eq(tamanho([]), 0)
  check.eq(tamanho([4]), 1)
  check.eq(tamanho([7, 1]), 2)
}

/// Soma os elementos de *lst*.
pub fn soma(lst: List(Int)) -> Int {
  reduz_acc(lst, 0, fn(acc, e) { acc + e })
}

pub fn soma_examples() {
  check.eq(soma([]), 0)
  check.eq(soma([4]), 4)
  check.eq(soma([7, 1]), 8)
}

/// Inverte os elementos de *lst*.
pub fn inverte(lst: List(a)) -> List(a) {
  reduz_acc(lst, [], fn(acc, e) { [e, ..acc] })
}

pub fn inverte_examples() {
  check.eq(inverte([]), [])
  check.eq(inverte([7, 1]), [1, 7])
}
