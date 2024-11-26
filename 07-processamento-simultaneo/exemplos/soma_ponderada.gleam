import sgleam/check

/// Calcula a soma ponderada dos valores de *lst* considerando que cada
/// elemento de *lst* tem como peso o elemento correspondente em *pesos*.
/// Devolve Error(Nil) se *lst* e *pesos* tem quantidades diferente de
/// elementos.
pub fn soma_ponderada(
  lst: List(Float),
  pesos: List(Float),
) -> Result(Float, Nil) {
  case lst, pesos {
    [], [] -> Ok(0.0)
    [primeiro, ..resto], [peso, ..pesos] ->
      case soma_ponderada(resto, pesos) {
        Ok(s) -> Ok(s +. primeiro *. peso)
        _ -> Error(Nil)
      }
    _, _ -> Error(Nil)
  }
}

pub fn soma_ponderada_examples() {
  check.eq(soma_ponderada([], []), Ok(0.0))
  check.eq(soma_ponderada([], [1.0]), Error(Nil))
  check.eq(soma_ponderada([1.0], []), Error(Nil))
  check.eq(soma_ponderada([4.0], [2.0]), Ok(8.0))
  check.eq(soma_ponderada([3.0, 4.0], [5.0, 2.0]), Ok(23.0))
  check.eq(soma_ponderada([5.0, 3.0, 4.0], [1.0, 5.0, 2.0]), Ok(28.0))
}
