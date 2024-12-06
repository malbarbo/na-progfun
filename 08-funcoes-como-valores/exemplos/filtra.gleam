import gleam/int
import sgleam/check

/// Devolve uma lista com todos os elementos *x* de *lst* tal que *pred(x)* é
/// True.
fn filtra(lst: List(a), pred: fn(a) -> Bool) -> List(a) {
  case lst {
    [] -> []
    [primeiro, ..resto] ->
      case pred(primeiro) {
        True -> [primeiro, ..filtra(resto, pred)]
        False -> filtra(resto, pred)
      }
  }
}

pub fn filtra_examples() {
  check.eq(filtra([3, 2, 7], int.is_even), [2])
  check.eq(filtra(["a", "", "b"], eh_nao_vazia), ["a", "b"])
}

/// Devolve uma lista com os valores pares de *lst*.
pub fn lista_pares(lst: List(Int)) -> List(Int) {
  filtra(lst, int.is_even)
}

pub fn lista_pares_examples() {
  check.eq(lista_pares([3, 2, 7]), [2])
}

/// Devolve uma lista com os valores positivos de *lst*.
pub fn lista_nao_vazia(lst: List(String)) -> List(String) {
  filtra(lst, eh_nao_vazia)
}

pub fn lista_nao_vazia_examples() {
  check.eq(lista_nao_vazia(["a", "", "b"]), ["a", "b"])
}

fn eh_nao_vazia(s: String) -> Bool {
  s != ""
}
