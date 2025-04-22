import gleam/string
import sgleam/check

// Alinhamento é um dos valores "direita", "esquerda" ou "centro"
pub type Alinhamento =
  String

/// Produz uma nova string a partir de *s* que tem exatamente *num_chars*
/// caracteres e é alinhada de acordo com o *alinhamento*.
///
/// Se *s* tem exatamente *num_chars* caracteres, então produz *s*.
///
/// Se *s* tem mais do que *num_chars* caracteres, então *s* é truncada e "..."
/// é adicionado ao final para sinalizar que a string foi abreviada.
///
/// Se *s* tem menos do que *num_chars* caracteres, então espaços são
/// adicionados no início se *alinhamento* é "esquerda", no fim se
/// *alinhamento* é "direita", ou no início e fim se *alinhamento* e "centro".
/// Nesse último caso, se a quantidade de espaços adicionados for ímpar, então
/// no fim será adicionado 1 espaço a mais do que no início.
pub fn ajusta_string(s: String, num_chars: Int, alinhamento: String) -> String {
  case string.length(s) == num_chars {
    True -> s
    False ->
      case string.length(s) > num_chars {
        True -> string.slice(s, 0, num_chars - 3) <> "..."
        False -> {
          let num_espacos = num_chars - string.length(s)
          case alinhamento {
            "direita" -> string.repeat(" ", num_espacos) <> s
            "esquerda" -> s <> string.repeat(" ", num_espacos)
            _ -> {
              let num_espacos_inicio = num_espacos / 2
              let num_espacos_fim = num_espacos - num_espacos_inicio
              string.repeat(" ", num_espacos_inicio)
              <> s
              <> string.repeat(" ", num_espacos_fim)
            }
          }
        }
      }
  }
}

pub fn ajusta_string_examples() {
  // string.length(s) == num_chars
  check.eq(ajusta_string("casa", 4, "direita"), "casa")
  check.eq(ajusta_string("casa", 4, "esquerda"), "casa")
  check.eq(ajusta_string("casa", 4, "centro"), "casa")

  // string.length(s) > num_chars
  check.eq(ajusta_string("casa verde", 7, "direita"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "esquerda"), "casa...")
  check.eq(ajusta_string("casa verde", 7, "centro"), "casa...")
  check.eq(ajusta_string("casa verde", 9, "direita"), "casa v...")

  // string.length(s) < num_chars
  check.eq(ajusta_string("casa", 9, "direita"), "     casa")
  check.eq(ajusta_string("casa", 9, "esquerda"), "casa     ")
  check.eq(ajusta_string("casa", 9, "centro"), "  casa   ")
  check.eq(ajusta_string("casa", 10, "centro"), "   casa   ")
}
