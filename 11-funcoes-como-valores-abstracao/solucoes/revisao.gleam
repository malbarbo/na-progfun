import gleam/int
import gleam/list
import gleam/string
import sgleam/check

// As funções que podem parar antes de analisar todos os elementos da lista não
// são adequadas para serem implementadas com map, filter e fold_right. Entre os
// exercícios temos o de verificar se todos são verdadeiros, se algum é
// verdadeiro e se a lista está em ordem monotonicamente crescente.
//
// A função para encontrar o último pode ser implementada com fold_right, mas
// fica confusa. Com o fold, que ainda vamos ver, fica bom.
//
// As demais funções podem ser implementadas com fold_right, map e filter e ficam
// mais simples.

/// Concatena todos os elementos de *lst*.
pub fn concatena(lst: List(String)) -> String {
  list.fold_right(lst, "", junta_antes)
}

/// Junta *s* antes de *acc*.
pub fn junta_antes(acc: String, s: String) -> String {
  s <> acc
}

pub fn concatena_examples() {
  check.eq(concatena([]), "")
  check.eq(concatena(["casa", " ", "da ", "sogra"]), "casa da sogra")
}

/// Calcula o produto dos elementos de *lst*.
pub fn produto(lst: List(Int)) -> Int {
  list.fold_right(lst, 1, int.multiply)
}

pub fn produto_examples() {
  check.eq(produto([]), 1)
  check.eq(produto([5, 1, -4]), -20)
}

/// Devolve a quantidade de elementos de *lst*.
pub fn quantidade_elementos(lst: List(a)) -> Int {
  list.fold_right(lst, 0, soma_um)
}

/// Soma um a *tam*, ignorando o elemento *_e*.
pub fn soma_um(tam: Int, _e: a) -> Int {
  tam + 1
}

pub fn quantidade_elementos_examples() {
  check.eq(quantidade_elementos([]), 0)
  check.eq(quantidade_elementos([6, 1, 8]), 3)
}

/// Devolve uma nova lista contendo apenas os elementos de *lst*
/// que começam com a letra "A".
pub fn seleciona_comeca_a(lst: List(String)) -> List(String) {
  list.filter(lst, comeca_com_a)
}

/// Devolve True se *s* começa com a letra "A", False caso contrário.
pub fn comeca_com_a(s: String) -> Bool {
  string.first(s) == Ok("A")
}

pub fn seleciona_comeca_a_examples() {
  check.eq(seleciona_comeca_a(["Apenas", "um", "teste", ",", "viu", "Ana"]), [
    "Apenas", "Ana",
  ])
}

/// Calcula a amplitude de *lst*, isto é, a diferença entre o maior e o menor
/// valor. Devolve Error se a lista for vazia.
pub fn amplitude(lst: List(Int)) -> Result(Int, Nil) {
  case lst {
    [] -> Error(Nil)
    [primeiro, ..resto] -> {
      // Plano: determinar o máximo, o mínimo e calcular a diferença.
      let maximo = list.fold_right(resto, primeiro, int.max)
      let minimo = list.fold_right(resto, primeiro, int.min)
      Ok(maximo - minimo)
    }
  }
}

pub fn amplitude_examples() {
  check.eq(amplitude([]), Error(Nil))
  check.eq(amplitude([10]), Ok(0))
  check.eq(amplitude([2, -5, 10, 8, 12, -1]), Ok(17))
}
