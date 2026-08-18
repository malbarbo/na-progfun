import sgleam/check

/// Cria uma nova lista com os elementos de *lst* que têm um elemento
/// correspondente True em *mst*.
pub fn seleciona(lst: List(a), mst: List(Bool)) -> List(a) {
  case lst, mst {
    [primeiro, ..rlst], [True, ..rmst] -> [primeiro, ..seleciona(rlst, rmst)]
    [_, ..rlst], [False, ..rmst] -> seleciona(rlst, rmst)
    _, _ -> []
  }
}

pub fn seleciona_examples() {
  check.eq(
    seleciona(["Jorge", "Amanda", "Pedro", "Joana"], [True, False, False, True]),
    ["Jorge", "Joana"],
  )
}
