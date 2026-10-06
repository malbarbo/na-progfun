import sgleam/check

/// A classe de um item, entre 1 e 10.
pub opaque type Classe {
  Classe(valor: Int)
}

/// Devolve Ok(Classe) com o valor *n* se 1 <= n <= 10, Error(Nil) caso
/// contrário.
pub fn classe(n: Int) -> Result(Classe, Nil) {
  case 1 <= n && n <= 10 {
    True -> Ok(Classe(n))
    False -> Error(Nil)
  }
}

pub fn classe_examples() {
  check.eq(classe(0), Error(Nil))
  check.eq(classe(1), Ok(Classe(1)))
  check.eq(classe(10), Ok(Classe(10)))
  check.eq(classe(11), Error(Nil))
}

/// Devolve o valor em *c*.
pub fn valor(c: Classe) -> Int {
  c.valor
}

/// Devolve Ok com a classe anterior a *c*, ou Error(Nil) se *c* é a classe 1.
pub fn anterior(c: Classe) -> Result(Classe, Nil) {
  classe(valor(c) - 1)
}

pub fn anterior_examples() {
  let assert Ok(c1) = classe(1)
  let assert Ok(c2) = classe(2)
  let assert Ok(c10) = classe(10)
  check.eq(anterior(c1), Error(Nil))
  check.eq(anterior(c2), Ok(c1))
  check.eq(anterior(c10), classe(9))
}

/// Devolve quantos itens de classe 1 são necessários para construir um item
/// de classe *c*.
pub fn itens_classe1(c: Classe) -> Int {
  case anterior(c) {
    Error(_) -> 1
    Ok(a) -> 2 * itens_classe1(a)
  }
}

pub fn itens_classe1_examples() {
  let assert Ok(c1) = classe(1)
  let assert Ok(c2) = classe(2)
  let assert Ok(c3) = classe(3)
  let assert Ok(c10) = classe(10)
  check.eq(itens_classe1(c1), 1)
  check.eq(itens_classe1(c2), 2)
  check.eq(itens_classe1(c3), 4)
  check.eq(itens_classe1(c10), 512)
}
