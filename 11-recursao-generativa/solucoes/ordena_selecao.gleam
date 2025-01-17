import gleam/int
import gleam/list
import sgleam/check

/// Ordena *lst* em ordem não decrescente usando o algoritmo de ordenação por
/// seleção.
pub fn ordena_selecao(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> {
      let min = list.fold(resto, primeiro, int.min)
      let #(mins, outros) = list.partition(lst, fn(x) { x == min })
      list.append(mins, ordena_selecao(outros))
    }
  }
}

pub fn ordena_selecao_examples() {
  check.eq(ordena_selecao([]), [])
  check.eq(ordena_selecao([5]), [5])
  check.eq(ordena_selecao([5, 2]), [2, 5])
  check.eq(ordena_selecao([1, 5, 2]), [1, 2, 5])
  check.eq(ordena_selecao([7, 1, 5, 2]), [1, 2, 5, 7])
  check.eq(ordena_selecao([1, 7, 1, 2, 5, 2, 7, 1, 2]), [
    1, 1, 1, 2, 2, 2, 5, 7, 7,
  ])
}
