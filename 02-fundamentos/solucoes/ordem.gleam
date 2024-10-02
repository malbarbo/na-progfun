import sgleam.{check_equal}

/// Determina se a sequência *a*, *b*, *c* está em ordem "crescente",
/// "decrescente" ou "sem ordem"
pub fn ordem(a: Int, b: Int, c: Int) -> String {
  case a < b && b < c {
    True -> "crescente"
    False ->
      case a > b && b > c {
        True -> "decrescente"
        False -> "sem ordem"
      }
  }
}

pub fn ordem_examples() {
  check_equal(ordem(3, 8, 12), "crescente")
  check_equal(ordem(3, 1, 4), "sem ordem")
  check_equal(ordem(3, 1, 0), "decrescente")
}
