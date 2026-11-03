import gleam/int
import gleam/list
import gleam/order.{type Order}
import gleam/string
import sgleam/check

/// Devolve uma função de comparação que produz a ordem inversa de *compara*.
pub fn inverte(compara: fn(a, a) -> Order) -> fn(a, a) -> Order {
  fn(x, y) { compara(y, x) }
}

pub fn inverte_examples() {
  check.eq(inverte(int.compare)(1, 2), order.Gt)
  check.eq(inverte(int.compare)(2, 1), order.Lt)
  check.eq(inverte(int.compare)(2, 2), order.Eq)
  check.eq(list.sort([3, 1, 2], inverte(int.compare)), [3, 2, 1])
  check.eq(
    list.sort(["oi", "casa", "abc"], inverte(compara_por(string.length))),
    ["casa", "abc", "oi"],
  )
}

/// Devolve uma função de comparação que compara dois valores pelo resultado
/// de *chave*.
pub fn compara_por(chave: fn(a) -> Int) -> fn(a, a) -> Order {
  fn(x, y) { int.compare(chave(x), chave(y)) }
}
