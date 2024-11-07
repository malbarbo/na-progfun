import sgleam/check

// Associação entre chave e valor.
pub type Par {
  Par(chave: String, valor: Int)
}

/// Devolve o valor associado com *s* em *lst* ou Error se *s* não aparece como
/// chave em *lst*.
pub fn busca(s: String, lst: List(Par)) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [par, ..] if s == par.chave -> Ok(par.valor)
    [_, ..resto] -> busca(s, resto)
  }
}

pub fn busca_examples() {
  check.eq(busca("casa", []), Error(Nil))
  check.eq(busca("casa", [Par("nada", 3), Par("outra", 2)]), Error(Nil))
  check.eq(busca("nada", [Par("nada", 3), Par("outra", 2)]), Ok(3))
  check.eq(busca("outra", [Par("nada", 3), Par("outra", 2)]), Ok(2))
}
