import gleam/string
import sgleam/check

/// Inverte os caracteres de *s*.
pub fn inverte(s: String) -> String {
  let len = string.length(s)
  case len {
    0 | 1 -> s
    _ -> {
      let primeiro = string.slice(s, 0, 1)
      let ultimo = string.slice(s, len - 1, 1)
      ultimo <> inverte(string.slice(s, 1, len - 2)) <> primeiro
    }
  }
}

pub fn inverte_examples() {
  check.eq(inverte(""), "")
  check.eq(inverte("a"), "a")
  check.eq(inverte("abc"), "cba")
  check.eq(inverte("amor"), "roma")
}
