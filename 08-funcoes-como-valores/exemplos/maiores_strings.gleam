import gleam/int
import gleam/list
import gleam/string
import sgleam/check

/// Cria uma lista com as strings de *lst* que têm tamanho máximo entre todos
/// as strings de *lst*.
pub fn maiores_strings(lst: List(String)) -> List(String) {
  let maximo = tamanho_maximo(lst)

  list.filter(lst, fn(s) { string.length(s) == maximo })
}

pub fn maiores_strings_examples() {
  check.eq(maiores_strings(["oi", "casa", "aba", "boi", "eita", "a", "cadê"]), [
    "casa", "eita", "cadê",
  ])
}

/// Devolve o tamanho máximo entre todas as strings de *lst*.
pub fn tamanho_maximo(lst: List(String)) -> Int {
  list.fold(list.map(lst, string.length), 0, int.max)
}

pub fn tamanho_maximo_examples() {
  check.eq(
    tamanho_maximo(["oi", "casa", "aba", "boi", "eita", "a", "cadê"]),
    4,
  )
}
