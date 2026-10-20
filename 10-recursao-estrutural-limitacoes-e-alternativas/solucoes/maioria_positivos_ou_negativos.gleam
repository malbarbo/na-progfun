import sgleam/check

pub type Maioria {
  Positivo
  Negativo
  Nenhum
}

/// Produz Positivo se *lst* tem mais números positivos do que negativos,
/// Negativo se tem mais negativos do que positivos e Nenhum se as quantidades
/// são iguais. O zero não é positivo nem negativo.
pub fn maioria(lst: List(Int)) -> Maioria {
  let npositivos = num_positivos(lst)
  let nnegativos = num_negativos(lst)
  case npositivos == nnegativos {
    True -> Nenhum
    False ->
      case npositivos > nnegativos {
        True -> Positivo
        False -> Negativo
      }
  }
}

/// Conta a quantidade de elementos positivos em *lst*.
fn num_positivos(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] if primeiro > 0 -> 1 + num_positivos(resto)
    [_, ..resto] -> num_positivos(resto)
  }
}

/// Conta a quantidade de elementos negativos em *lst*.
fn num_negativos(lst: List(Int)) -> Int {
  case lst {
    [] -> 0
    [primeiro, ..resto] if primeiro < 0 -> 1 + num_negativos(resto)
    [_, ..resto] -> num_negativos(resto)
  }
}

pub fn maioria_examples() {
  check.eq(maioria([]), Nenhum)
  check.eq(maioria([0]), Nenhum)
  check.eq(maioria([10]), Positivo)
  check.eq(maioria([-2]), Negativo)
  check.eq(maioria([2, 10]), Positivo)
  check.eq(maioria([-1, 10]), Nenhum)
  check.eq(maioria([-1, -2]), Negativo)
  check.eq(maioria([10, -2]), Nenhum)
}
