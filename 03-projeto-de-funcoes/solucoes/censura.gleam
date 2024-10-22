import gleam/int
import gleam/string
import sgleam/check

/// Produz uma nova string substituindo cada um dos primeiros *n* caracteres de
/// *frase* por "x". Se *n* for maior que a quantidade de caracteres de
/// *frase*, substiui todos os caracteres de frase por "x". Se n for negativo,
/// devolve *frase*.
pub fn censura(frase: String, n: Int) -> String {
  string.repeat("x", int.min(string.length(frase), n))
  <> string.drop_left(frase, n)
}

pub fn censura_examples() {
  check.eq(censura("droga de lanche!", 5), "xxxxx de lanche!")
  check.eq(censura("nada", 5), "xxxx")
  check.eq(censura("nada", -3), "nada")
}
