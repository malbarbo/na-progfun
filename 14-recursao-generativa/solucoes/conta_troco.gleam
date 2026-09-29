import sgleam/check

/// Calcula a quantidade de formas diferentes de obter *valor* somando valores
/// em *moedas*.
pub fn conta_troco(valor: Int, moedas: List(Int)) -> Int {
  case valor, moedas {
    _, [] -> 0
    0, _ -> 1
    _, [primeira, ..resto] if valor < primeira -> conta_troco(valor, resto)
    _, [primeira, ..resto] -> {
      conta_troco(valor - primeira, moedas) + conta_troco(valor, resto)
    }
  }
}

pub fn conta_troco_examples() {
  check.eq(conta_troco(1, []), 0)
  check.eq(conta_troco(0, [1, 2]), 1)
  check.eq(conta_troco(3, [4]), 0)
  check.eq(conta_troco(4, [1, 2]), 3)
  check.eq(conta_troco(6, [2, 3]), 2)
  check.eq(conta_troco(10, [2, 3, 4]), 5)
}
