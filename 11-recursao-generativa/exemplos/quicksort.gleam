import gleam/list
import sgleam/check

/// Ordena *lst* em ordem não decrescente usando o algoritmo quicksort.
pub fn quicksort(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [pivo, ..resto] -> {
      let maiores = list.filter(resto, fn(x) { x >= pivo })
      let menores = list.filter(resto, fn(x) { x < pivo })
      list.append(quicksort(menores), [pivo, ..quicksort(maiores)])
    }
  }
}

pub fn quicksort_examples() {
  check.eq(quicksort([]), [])
  check.eq(quicksort([3]), [3])
  check.eq(quicksort([3, 3, 3]), [3, 3, 3])
  check.eq(quicksort([10, 3, -4, 5, 9]), [-4, 3, 5, 9, 10])
  check.eq(quicksort([3, 10, 0, 5, 9]), [0, 3, 5, 9, 10])
}
