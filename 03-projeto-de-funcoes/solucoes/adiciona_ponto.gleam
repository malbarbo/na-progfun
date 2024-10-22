import gleam/string
import sgleam/check

/// Adiciona um ponto final (".") em *frase* se ela ainda não terminar com um.
pub fn adiciona_ponto(frase: String) -> String {
  case string.slice(frase, -1, 1) == "." {
    True -> frase
    False -> frase <> "."
  }
}

pub fn adiciona_ponto_examples() {
  check.eq(adiciona_ponto("Vou contar"), "Vou contar.")
  check.eq(adiciona_ponto("Corri"), "Corri.")
  check.eq(adiciona_ponto(""), ".")
}
