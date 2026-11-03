import gleam/int
import gleam/list
import gleam/order.{type Order}
import gleam/string
import sgleam/check

/// Devolve uma função de comparação que compara dois valores pelo resultado
/// de *chave*.
pub fn compara_por(chave: fn(a) -> Int) -> fn(a, a) -> Order {
  fn(x, y) { int.compare(chave(x), chave(y)) }
}

pub fn compara_por_examples() {
  check.eq(compara_por(string.length)("casa", "oi"), order.Gt)
  check.eq(compara_por(string.length)("oi", "casa"), order.Lt)
  check.eq(compara_por(string.length)("oi", "ab"), order.Eq)
  check.eq(list.sort(["casa", "oi", "abc"], compara_por(string.length)), [
    "oi", "abc", "casa",
  ])
  check.eq(list.sort([-5, 3, -1], compara_por(int.absolute_value)), [-1, 3, -5])
}
