import sgleam/check

// Define a variante para formas de pagamento
pub type FormaPagamento {
  Dinheiro
  Pix
  Boleto
  //
  Cartao(parcelas: Int)
}

/// Calcula o valor final da compra de valor *v* considerando a forma-pagamento
/// da seguinte maneira:
/// - dinheiro ou pix, 10% de desconto
/// - boleto; 5% de desconto
/// - cartão em até 3 vezes (inclusive); sem desconto
/// - cartão em mais que 3 vezes; acréscimo de 15%
pub fn valor_final_compra(
  valor: Float,
  forma_pagamento: FormaPagamento,
) -> Float {
  case forma_pagamento {
    // 10% de desconto
    Dinheiro | Pix -> valor *. 0.9
    // 5% de desconto
    Boleto -> valor *. 0.95
    // 15% de acréscimo
    Cartao(parcelas) if parcelas > 3 -> valor *. 1.15
    // sem desconto
    Cartao(_) -> valor
  }
}

pub fn valor_final_compra_examples() {
  check.eq(valor_final_compra(100.0, Dinheiro), 100.0 *. 0.9)
  check.eq(valor_final_compra(200.0, Pix), 200.0 *. 0.9)
  check.eq(valor_final_compra(300.0, Boleto), 300.0 *. 0.95)
  check.eq(valor_final_compra(100.0, Cartao(1)), 100.0)
  check.eq(valor_final_compra(100.0, Cartao(3)), 100.0)
  check.eq(valor_final_compra(200.0, Cartao(4)), 200.0 *. 1.15)
}
