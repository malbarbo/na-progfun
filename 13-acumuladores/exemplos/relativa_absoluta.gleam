import gleam/int
import gleam/list
import sgleam/check

/// Converte a lista *lst* de distâncias relativas para uma lista de distâncias
/// absolutas. O primeiro item da lista representa a distância da origem.
pub fn relativa_para_absoluta(lst: List(Int)) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      primeiro,
      ..list.map(relativa_para_absoluta(resto), int.add(_, primeiro))
    ]
  }
}

pub fn relativa_para_absoluta_examples() {
  check.eq(relativa_para_absoluta([50, 40, 70, 30, 30]), [50, 90, 160, 190, 220])
}

/// Converte uma lista de distâncias relativas para uma lista de distâncias
/// absolutas. O primeiro item da lista representa a distância da origem.
pub fn relativa_para_absoluta_acc(lst: List(Int)) -> List(Int) {
  relativa_para_absoluta_loop(lst, 0)
}

fn relativa_para_absoluta_loop(lst: List(Int), acc_dist: Int) -> List(Int) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      primeiro + acc_dist,
      ..relativa_para_absoluta_loop(resto, primeiro + acc_dist)
    ]
  }
}

/// Exemplos para relativa_para_absoluta
pub fn relativa_para_absoluta_acc_examples() {
  check.eq(relativa_para_absoluta_acc([50, 40, 70, 30, 30]), [
    50, 90, 160, 190, 220,
  ])
}
