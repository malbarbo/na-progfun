import sgleam/check

// Renda é um número positivo com duas casas decimais.
// Imposto é um número positivo com duas casas decimais.

/// Calcula o imposto que uma pessoa com a renda *r* deve pagar. O percentual
/// do imposto é determinado da seguinte forma
/// - Se r <= 100, 5% de 5
/// - Se 1000 < r <= 5000, 5% de 1000 e 10% do que passar de 1000
/// - Se 5000 < r, 5% de 1000, 10% de 4000 e 20% do que passar de 5000
pub fn calcula_imposto(r: Float) -> Float {
  case r <=. 1000.0 {
    True -> r *. 0.05
    False ->
      case r <=. 5000.0 {
        True -> 50.0 +. { r -. 1000.0 } *. 0.1
        False -> 450.0 +. { r -. 5000.0 } *. 0.2
      }
  }
}

pub fn calcula_imposto_examples() {
  check.eq(calcula_imposto(900.0), 45.0)
  check.eq(calcula_imposto(1000.0), 50.0)
  check.eq(calcula_imposto(3000.0), 250.0)
  check.eq(calcula_imposto(5000.0), 450.0)
  check.eq(calcula_imposto(10_000.0), 1450.0)
}
