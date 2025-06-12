import sgleam/check

// Associação entre chave e valor.
pub type Par(a, b) {
  Par(chave: a, valor: b)
}

/// Devolve o valor associado com *s* em *lst* ou Error(Nil) se *chave* não
/// aparece em *lst*.
pub fn busca(lst: List(Par(a, b)), chave: a) -> Result(b, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..] if primeiro.chave == chave -> Ok(primeiro.valor)
    [_, ..resto] -> busca(resto, chave)
  }
}

pub fn busca_examples() {
  check.eq(busca([], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "casa"), Error(Nil))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "nada"), Ok(3))
  check.eq(busca([Par("nada", 3), Par("outra", 2)], "outra"), Ok(2))
}
