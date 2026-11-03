import gleam/int
import gleam/list
import gleam/result
import sgleam/check

/// Devolve uma lista com cada elemento de *lst* convertido para Int.
/// Devolve Error se algum valor não puder ser convertido.
pub fn strings_para_numeros(lst: List(String)) -> Result(List(Int), Nil) {
  // A biblioteca padrão tem funções que fazem o mesmo:
  // list.try_map(lst, int.parse) ou list.map(lst, int.parse) |> result.all
  list.fold_right(lst, Ok([]), fn(acc, s) {
    use resto <- result.try(acc)
    use n <- result.try(int.parse(s))
    Ok([n, ..resto])
  })
}

pub fn strings_para_numeros_examples() {
  check.eq(strings_para_numeros(["10", "-1", "7"]), Ok([10, -1, 7]))
  check.eq(strings_para_numeros(["10", "a", "7"]), Error(Nil))
}
