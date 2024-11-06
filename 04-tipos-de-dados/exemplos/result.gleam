import gleam/int
import sgleam/check

/// Devolve a soma de *a* e *b* se as strings representam inteiros,
/// senão devolve Error.
pub fn soma(a: String, b: String) -> Result(String, Nil) {
  case int.parse(a) {
    Ok(a) ->
      case int.parse(b) {
        Ok(b) -> Ok(int.to_string(a + b))
        Error(_) -> Error(Nil)
      }
    Error(_) -> Error(Nil)
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
  check.eq(soma("31", "4"), Ok("35"))
  check.eq(soma("31", "a"), Error(Nil))
  check.eq(soma("a", "4"), Error(Nil))
  check.eq(soma("a", "b"), Error(Nil))
}
