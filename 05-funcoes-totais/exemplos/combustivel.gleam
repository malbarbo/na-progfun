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
  check.eq(seleciona_combustivel(preco_(3.0), preco_(4.0)), Gasolina)
  check.eq(seleciona_combustivel(preco_(2.9), preco_(4.2)), Alcool)
  check.eq(seleciona_combustivel(preco_(3.5), preco_(5.0)), Alcool)
}

fn preco_(v: Float) -> Preco {
  let assert Ok(preco) = preco(v)
  preco
}
