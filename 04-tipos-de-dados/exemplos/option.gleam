import gleam/option.{type Option, None, Some}
import gleam/string
import sgleam/check

/// Soma 1 ao valor opcional de *a*.
pub fn soma1(a: Option(Int)) -> Option(Int) {
  case a {
    None -> None
    Some(x) -> Some(x + 1)
  }
}

pub fn soma1_examples() {
  check.eq(soma1(None), None)
  check.eq(soma1(Some(10)), Some(11))
}

/// Devolve o primeiro caractere de *s* ou None se *s* é vazia.
pub fn primeiro(s: String) -> Option(String) {
  case s {
    "" -> None
    _ -> Some(string.slice(s, 0, 1))
  }
}

pub fn primeiro_examples() {
  check.eq(primeiro(""), None)
  check.eq(primeiro("casa"), Some("c"))
}
