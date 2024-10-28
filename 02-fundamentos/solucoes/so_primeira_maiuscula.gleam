import gleam/string
import sgleam/check

/// Devolve *s* com a primeira letra em maiúscula e o restante em minúscula.
pub fn so_primeira_maiuscula(s: String) -> String {
  string.uppercase(string.slice(s, 0, 1))
  <> string.lowercase(string.slice(s, 1, string.length(s)))
}

pub fn so_primeira_maiuscula_examples() {
  check.eq(so_primeira_maiuscula("paula"), "Paula")
  check.eq(so_primeira_maiuscula("ALFREDO"), "Alfredo")
}

