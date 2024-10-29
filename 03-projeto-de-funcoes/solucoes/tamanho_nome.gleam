import gleam/string
import sgleam/check

// Tamanho é um dos valores "curto", "médio" ou "longo"
pub type Tamanho =
  String

/// Classifica *nome* de acordo com a quantidade de caracteres da seguinte forma
/// - "curto" para nomes com 4 ou menos caracteres
/// - "longo" para nomes com mais que 10 caracteres
/// - "médio" para nomes que não são "curto" e nem "longo"
pub fn tamanho_nome(nome: String) -> String {
  case string.length(nome) <= 4 {
    True -> "curto"
    False ->
      case string.length(nome) <= 10 {
        True -> "médio"
        False -> "longo"
      }
  }
}

pub fn tamanho_nome_examples() {
  check.eq(tamanho_nome("Zé"), "curto")
  check.eq(tamanho_nome("José"), "curto")
  check.eq(tamanho_nome("Maria"), "médio")
  check.eq(tamanho_nome("Sebastiana"), "médio")
  check.eq(tamanho_nome("Constantino"), "longo")
}
