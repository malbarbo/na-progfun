import sgleam/check

/// O preço do litro do combustível.
pub opaque type Preco {
  Preco(valor: Float)
}

pub type Combustivel {
  Alcool
  Gasolina
}

/// Devolve Ok(Preco) com o valor *v* se
/// v > 0, Error(Nil) caso contrário.
pub fn preco(v: Float) -> Result(Preco, Nil) {
  case v >. 0.0 {
    True -> Ok(Preco(v))
    False -> Error(Nil)
  }
}

/// Devolve o valor em *p*.
pub fn valor(p: Preco) -> Float {
  p.valor
}

pub fn seleciona_combustivel(
  preco_alcool: Preco,
  preco_gasolina: Preco,
) -> Combustivel {
  case valor(preco_alcool) <=. 0.7 *. valor(preco_gasolina) {
    True -> Alcool
    False -> Gasolina
  }
}

pub fn seleciona_combustivel_examples() {
  let assert Ok(alcool1) = preco(3.0)
  let assert Ok(gasolina1) = preco(4.0)
  check.eq(seleciona_combustivel(alcool1, gasolina1), Gasolina)

  let assert Ok(alcool2) = preco(2.9)
  let assert Ok(gasolina2) = preco(4.2)
  check.eq(seleciona_combustivel(alcool2, gasolina2), Alcool)

  let assert Ok(alcool3) = preco(3.5)
  let assert Ok(gasolina3) = preco(5.0)
  check.eq(seleciona_combustivel(alcool3, gasolina3), Alcool)
}
