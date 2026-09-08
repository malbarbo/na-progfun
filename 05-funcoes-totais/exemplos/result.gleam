import gleam/int
import sgleam/check

/// Devolve a soma de *a* e *b* se as strings representam inteiros,
/// senão devolve Error.
pub fn soma(a: String, b: String) -> Result(String, Nil) {
  case int.parse(a) {
    Ok(a) ->
      case int.parse(b) {
        Ok(b) -> Ok(int.to_string(a + b))
        Error(Nil) -> Error(Nil)
      }
    Error(Nil) -> Error(Nil)
  }
}

pub fn soma_examples() {
  check.eq(soma("31", "4"), Ok("35"))
  check.eq(soma("31", "a"), Error(Nil))
  check.eq(soma("a", "4"), Error(Nil))
  check.eq(soma("a", "b"), Error(Nil))
}

/// Devolve a soma de *a* e *b* se as strings representam inteiros,
/// senão devolve Error.
pub fn soma_alt(a: String, b: String) -> Result(String, Nil) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    _, _ -> Error(Nil)
  }
}

pub fn soma_alt_examples() {
  check.eq(soma_alt("31", "4"), Ok("35"))
  check.eq(soma_alt("31", "a"), Error(Nil))
  check.eq(soma_alt("a", "4"), Error(Nil))
  check.eq(soma_alt("a", "b"), Error(Nil))
}

pub type ErroSoma {
  Primeiro
  Segundo
  Ambos
}

/// Devolve a soma de *a* e *b* se as strings representam inteiros, senão
/// devolve Primeiro, Segundo ou Ambos, indicando quais das strings não
/// representam inteiros.
pub fn soma_erro(a: String, b: String) -> Result(String, ErroSoma) {
  case int.parse(a), int.parse(b) {
    Ok(a), Ok(b) -> Ok(int.to_string(a + b))
    Error(Nil), Ok(_) -> Error(Primeiro)
    Ok(_), Error(Nil) -> Error(Segundo)
    Error(Nil), Error(Nil) -> Error(Ambos)
  }
}

pub fn soma_erro_examples() {
  check.eq(soma_erro("31", "4"), Ok("35"))
  check.eq(soma_erro("a", "4"), Error(Primeiro))
  check.eq(soma_erro("31", "a"), Error(Segundo))
  check.eq(soma_erro("a", "b"), Error(Ambos))
}
