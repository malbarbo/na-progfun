import gleam/int
import gleam/string
import sgleam/check

/// Conta a quantidade de dígitos de *n*.
/// Se *n* é 0, então devolve um.
/// Se *n* é menor que zero, então devolve a quantidade de dígitos do valor
/// absoluto de n.
pub fn quantidade_digitos(n: Int) -> Int {
  string.length(int.to_string(int.absolute_value(n)))
}

pub fn quantidade_digitos_examples() {
  check.eq(quantidade_digitos(121), 3)
  check.eq(quantidade_digitos(0), 1)
  check.eq(quantidade_digitos(-1519), 4)
}
