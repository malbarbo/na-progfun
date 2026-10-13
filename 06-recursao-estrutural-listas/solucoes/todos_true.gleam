import sgleam/check

/// Produz True se todos os elementos de *lst* são True ou se *lst* é vazia,
/// produz False caso contrário.
pub fn todos_true(lst: List(Bool)) -> Bool {
  case lst {
    [] -> True
    [primeiro, ..resto] -> primeiro && todos_true(resto)
  }
}

pub fn todos_true_examples() {
  check.eq(todos_true([]), True)
  check.eq(todos_true([False]), False)
  check.eq(todos_true([True]), True)
  check.eq(todos_true([True, False]), False)
  check.eq(todos_true([True, True]), True)
  check.eq(todos_true([True, True, True]), True)
}

/// Versão sem case. O let assert não falha porque o bloco só é avaliado
/// quando *lst* não é vazia. A solução não ficou mais simples: a análise da
/// lista ficou mais difícil de ler e o compilador não verifica mais que todos
/// os casos foram tratados.
pub fn todos_true_sem_case(lst: List(Bool)) -> Bool {
  lst == []
  || {
    let assert [primeiro, ..resto] = lst
    primeiro && todos_true_sem_case(resto)
  }
}

pub fn todos_true_sem_case_examples() {
  check.eq(todos_true_sem_case([]), True)
  check.eq(todos_true_sem_case([False]), False)
  check.eq(todos_true_sem_case([True]), True)
  check.eq(todos_true_sem_case([True, False]), False)
  check.eq(todos_true_sem_case([True, True]), True)
  check.eq(todos_true_sem_case([True, True, True]), True)
}
