import sgleam/check

/// Cria uma nova lista com os elementos de *lst* que têm um elemento
/// correspondente True em *selecao*. Os elementos excedentes da lista mais
/// longa são ignorados.
pub fn seleciona(lst: List(a), selecao: List(Bool)) -> List(a) {
  case lst, selecao {
    [primeiro, ..rlst], [True, ..rselecao] -> [
      primeiro,
      ..seleciona(rlst, rselecao)
    ]
    [_, ..rlst], [False, ..rselecao] -> seleciona(rlst, rselecao)
    _, _ -> []
  }
}

pub fn seleciona_examples() {
  check.eq(seleciona([], []), [])
  check.eq(
    seleciona(["Jorge", "Amanda", "Pedro", "Joana"], [True, False, False, True]),
    ["Jorge", "Joana"],
  )
  check.eq(seleciona(["Jorge", "Amanda"], [True]), ["Jorge"])
  check.eq(seleciona(["Jorge"], [True, True]), ["Jorge"])
}
