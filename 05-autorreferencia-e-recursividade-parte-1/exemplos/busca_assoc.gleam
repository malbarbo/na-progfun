import sgleam/check

// Associação entre chave e valor.
pub type Par {
  Par(chave: String, valor: Int)
}

/// Devolve o valor associado com *s* em *lst* ou Error se *s* não aparece como
/// chave em *lst*.
pub fn busca(lst: List(Par), s: String) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [Par(chave, valor), ..] if s == chave -> Ok(valor)
    [_, ..resto] -> busca(resto, s)
  }
}

pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}
