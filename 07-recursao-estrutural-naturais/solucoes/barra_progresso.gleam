import sgleam/check

/// Uma porcentagem, entre 0 e 100.
pub opaque type Porcentagem {
  Porcentagem(valor: Int)
}

/// Devolve Ok(Porcentagem) com o valor *p* se 0 <= p <= 100, Error(Nil) caso
/// contrário.
pub fn porcentagem(p: Int) -> Result(Porcentagem, Nil) {
  case 0 <= p && p <= 100 {
    True -> Ok(Porcentagem(p))
    False -> Error(Nil)
  }
}

pub fn porcentagem_examples() {
  check.eq(porcentagem(-1), Error(Nil))
  check.eq(porcentagem(0), Ok(Porcentagem(0)))
  check.eq(porcentagem(100), Ok(Porcentagem(100)))
  check.eq(porcentagem(101), Error(Nil))
}

/// Devolve o valor em *p*.
pub fn valor(p: Porcentagem) -> Int {
  p.valor
}

/// Produz a barra de progresso de 10 posições para *p*. Cada posição
/// preenchida representa 10% concluído.
pub fn barra(p: Porcentagem) -> String {
  let k = valor(p) / 10
  "[" <> repete_texto("#", k) <> repete_texto("-", 10 - k) <> "]"
}

pub fn barra_examples() {
  let assert Ok(p0) = porcentagem(0)
  let assert Ok(p40) = porcentagem(40)
  let assert Ok(p45) = porcentagem(45)
  let assert Ok(p100) = porcentagem(100)
  check.eq(barra(p0), "[----------]")
  check.eq(barra(p40), "[####------]")
  check.eq(barra(p45), "[####------]")
  check.eq(barra(p100), "[##########]")
}

/// Produz a string com *n* repetições de *s*.
pub fn repete_texto(s: String, n: Int) -> String {
  case n {
    _ if n <= 0 -> ""
    _ -> s <> repete_texto(s, n - 1)
  }
}

pub fn repete_texto_examples() {
  check.eq(repete_texto("#", -1), "")
  check.eq(repete_texto("#", 0), "")
  check.eq(repete_texto("#", 1), "#")
  check.eq(repete_texto("ab", 3), "ababab")
}
