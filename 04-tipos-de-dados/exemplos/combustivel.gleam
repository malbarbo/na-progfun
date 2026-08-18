import sgleam/check

/// O preço do litro do combustível. Requer que seja um número positivo.
pub type Preco =
  Float

/// O tipo do combustível.
pub type Combustivel {
  Alcool
  Gasolina
}

/// Encontra o combustível que deve ser utilizado no abastecimento. Produz
/// Alcool se *preco_alcool* for menor ou igual a 70% do *preco_gasolina*,
/// produz Gasolina caso contrário.
pub fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  case preco_alcool <=. 0.7 *. preco_gasolina {
    True -> Alcool
    False -> Gasolina
  }
}

pub fn seleciona_combustivel_examples() {
  check.eq(seleciona_combustivel(3.0, 4.0), Gasolina)
  check.eq(seleciona_combustivel(2.9, 4.2), Alcool)
  check.eq(seleciona_combustivel(3.5, 5.0), Alcool)
}

/// Produz a mensagem que indica ao usuário qual combustível usar, a partir de *c*.
pub fn mensagem_combustivel(c: Combustivel) -> String {
  case c {
    Alcool -> "Use álcool."
    Gasolina -> "Use gasolina."
  }
}

pub fn mensagem_combustivel_examples() {
  check.eq(mensagem_combustivel(Alcool), "Use álcool.")
  check.eq(mensagem_combustivel(Gasolina), "Use gasolina.")
}
