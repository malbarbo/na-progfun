import gleam/float
import gleam/int
import gleam/list
import gleam/result
import sgleam/check

/// Soma os quadrados dos elementos pares de *lst*.
pub fn soma_quadrados_pares(lst: List(Int)) -> Int {
  // fn(x) { int.is_even(x) } é o mesmo que int.is_even e
  // fn(acc, x) { int.add(acc, x) } é o mesmo que int.add.
  // fn(x) { x * x } não pode ser abreviada, pois x aparece duas vezes.
  lst
  |> list.filter(int.is_even)
  |> list.map(fn(x) { x * x })
  |> list.fold_right(0, int.add)
}

pub fn soma_quadrados_pares_examples() {
  check.eq(soma_quadrados_pares([]), 0)
  check.eq(soma_quadrados_pares([1, 3]), 0)
  check.eq(soma_quadrados_pares([1, 2, 3, 4]), 20)
}

/// Calcula a média dos números representados por *a*, *b* e *c*. Devolve
/// Error(Nil) se alguma das strings não representa um número.
pub fn media3(a: String, b: String, c: String) -> Result(Float, Nil) {
  use x <- result.try(float.parse(a))
  use y <- result.try(float.parse(b))
  use z <- result.try(float.parse(c))
  Ok({ x +. y +. z } /. 3.0)
}

pub fn media3_examples() {
  check.eq(media3("1.0", "2.0", "6.0"), Ok(3.0))
  check.eq(media3("a", "2.0", "6.0"), Error(Nil))
  check.eq(media3("1.0", "b", "6.0"), Error(Nil))
  check.eq(media3("1.0", "2.0", "c"), Error(Nil))
}
