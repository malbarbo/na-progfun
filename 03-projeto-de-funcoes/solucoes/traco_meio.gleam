import gleam/string
import sgleam/check

/// Produz True se *s* tem um número ímpar de caracteres e o caractere do meio
/// é "-", False caso contrário.
pub fn traco_meio(s: String) -> Bool {
  let tam = string.length(s)
  let meio = tam / 2
  tam % 2 == 1 && string.slice(s, meio, 1) == "-"
}

pub fn traco_meio_examples() {
  check.eq(traco_meio("lero-lero"), True)
  check.eq(traco_meio("quase-meio"), False)
  check.eq(traco_meio("-"), True)
}
