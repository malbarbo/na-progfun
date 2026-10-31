import gleam/int
import gleam/list
import gleam/string
import sgleam/check

/// Produz uma nova lista ajustando os elementos de *lst* para que eles fiquem
/// com o mesmo número de caracteres.  As strings com o maior tamanho
/// permanecem inalteradas; para as demais, espaços em branco são adicionados
/// ao final.
pub fn ajusta_tamanho(lst: List(String)) -> List(String) {
  // Plano: determinar o tamanho máximo entre as strings e completar cada
  // string com espaços até esse tamanho.

  // Etapa 1: determina o tamanho máximo
  let tamanho = lst |> list.map(string.length) |> list.fold_right(0, int.max)

  // Etapa 2: completa cada string com espaços
  list.map(lst, fn(s) { s <> string.repeat(" ", tamanho - string.length(s)) })
}

pub fn ajusta_tamanho_examples() {
  check.eq(ajusta_tamanho(["São Paulo", "Maringá", "Londrina"]), [
    "São Paulo", "Maringá  ", "Londrina ",
  ])
}
