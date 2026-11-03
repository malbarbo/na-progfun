import gleam/int
import gleam/string
import sgleam/check

/// Concatena todos os elementos de *lst*.
pub fn concatena(lst: List(String)) -> String {
  concatena_loop(lst, "")
}

fn concatena_loop(lst: List(String), acc: String) -> String {
  // O uso de acumuladores evita o uso de memória extra para manter as chamadas
  // das funções.
  // *acc* é a concatenação dos elementos já visitados.
  case lst {
    [] -> acc
    [primeiro, ..resto] -> concatena_loop(resto, string.append(acc, primeiro))
  }
}

pub fn concatena_examples() {
  check.eq(concatena([]), "")
  check.eq(concatena(["casa ", "da", " sogra"]), "casa da sogra")
}

/// Determina o tamanho máximo entre todas as strings de *lst*.
pub fn max_tam(lst: List(String)) -> Int {
  max_tam_loop(lst, 0)
}

fn max_tam_loop(lst: List(String), acc: Int) -> Int {
  // O uso de acumuladores evita o uso de memória extra.
  // *acc* é o maior tamanho encontrado até agora.
  case lst {
    [] -> acc
    [primeiro, ..resto] ->
      max_tam_loop(resto, int.max(acc, string.length(primeiro)))
  }
}

pub fn max_tam_examples() {
  check.eq(max_tam([]), 0)
  check.eq(max_tam(["casa", "da", "sogra"]), 5)
}
