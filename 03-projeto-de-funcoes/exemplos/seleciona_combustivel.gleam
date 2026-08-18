import sgleam/check

/// O preço do litro do combustível. Requer que seja um número positivo.
pub type Preco =
  Float

/// O tipo do combustível. Requer que seja "Álcool" ou "Gasolina".
pub type Combustivel =
  String

/// Encontra o combustível que deve ser utilizado no abastecimento. Produz
/// "Álcool" se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz "Gasolina" caso contrário.
pub fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  case preco_alcool <=. 0.7 *. preco_gasolina {
    True -> "Álcool"
    False -> "Gasolina"
  }
}

pub fn seleciona_combustivel_examples() {
  // 3.00 é maior que 70% de 4.00, que é 2.80
  // -> "Gasolina"
  check.eq(seleciona_combustivel(3.0, 4.0), "Gasolina")
  // 2.90 é menor que 70% de 4.20, que é 2.94
  // -> "Álcool"
  check.eq(seleciona_combustivel(2.9, 4.2), "Álcool")
  // 3.50 é exatamente 70% de 5.00
  // -> "Álcool"
  check.eq(seleciona_combustivel(3.5, 5.0), "Álcool")
}
