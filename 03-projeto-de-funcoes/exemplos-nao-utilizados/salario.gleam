import sgleam/check

/// Calcula o novo salário a partir de um percentual de aumento determinado a
/// partir de *salario_atual* da seguinte forma:
/// - salario_atual <= 1200, percentual de aumento de 10%
/// - 1200 < salario_atual <= 3000, percentual de aumento de 7%
/// - 3000 < salario_atual <= 8000, percentual de aumento de 3%
/// - 8000 < salario_atual, sem aumento
pub fn novo_salario(salario_atual: Float) -> Float {
  case salario_atual <=. 1200.0 {
    // 10% de aumento
    True -> salario_atual *. 1.1
    False ->
      case salario_atual <=. 3000.0 {
        // 7% de aumento
        True -> salario_atual *. 1.07
        False ->
          case salario_atual <=. 8000.0 {
            // 3% de aumento
            True -> salario_atual *. 1.03
            // sem aumento
            False -> salario_atual
          }
      }
  }
}

pub fn novo_salario_examples() {
  // salario_atual <= 1200
  check.eq(novo_salario(1000.0), 1100.0)
  check.eq(novo_salario(1200.0), 1320.0)

  // salario_atual <= 3000
  check.eq(novo_salario(2000.0), 2140.0)
  check.eq(novo_salario(3000.0), 3210.0)

  // salario_atual <= 8000
  check.eq(novo_salario(5000.0), 5150.0)
  check.eq(novo_salario(8000.0), 8240.0)

  // salario_atual > 8000
  check.eq(novo_salario(8000.01), 8000.01)
}
