import sgleam/check

/// Salário é um valor em reais, deve ser um número positivo.
pub type Salario =
  Float

/// Calcula o novo salário a partir de *salario_atual*, aplicando o percentual
/// de aumento determinado da seguinte forma
/// - salario_atual <= 1200, aumento de 10%
/// - 1200 < salario_atual <= 3000, aumento de 7%
/// - 3000 < salario_atual <= 8000, aumento de 3%
/// - 8000 < salario_atual, sem aumento
pub fn novo_salario(salario_atual: Salario) -> Salario {
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
  // -> 1000.0 *. 1.1
  check.eq(novo_salario(1000.0), 1100.0)
  check.eq(novo_salario(1200.0), 1320.0)

  // 1200 < salario_atual <= 3000
  // -> 2000.0 *. 1.07
  check.eq(novo_salario(2000.0), 2140.0)
  check.eq(novo_salario(3000.0), 3210.0)

  // 3000 < salario_atual <= 8000
  // -> 5000.0 *. 1.03
  check.eq(novo_salario(5000.0), 5150.0)
  check.eq(novo_salario(8000.0), 8240.0)

  // 8000 < salario_atual
  // -> 8000.01
  check.eq(novo_salario(8000.01), 8000.01)
}
