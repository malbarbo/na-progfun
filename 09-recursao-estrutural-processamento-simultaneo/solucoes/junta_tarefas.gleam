import sgleam/check

pub type Tarefa {
  Tarefa(descricao: String, prioridade: Int)
}

/// Junta as tarefas de *lsta* e *lstb*. O resultado é uma lista em ordem
/// monotonicamente decrescente de prioridades com os elementos de *lsta* e
/// *lstb*.
///
/// Requer que *lsta* e *lstb* estejam em ordem monotonicamente decrescente,
/// caso contrário o resultado é indefinido.
pub fn junta(lsta: List(Tarefa), lstb: List(Tarefa)) -> List(Tarefa) {
  case lsta, lstb {
    _, [] -> lsta
    [], _ -> lstb
    [a, ..restoa], [b, ..] if a.prioridade >= b.prioridade -> [
      a,
      ..junta(restoa, lstb)
    ]
    _, [b, ..restob] -> [b, ..junta(lsta, restob)]
  }
}

pub fn junta_examples() {
  let lsta = [
    Tarefa("Comprar comida", 10),
    Tarefa("Limpar a casa", 3),
    Tarefa("Jogar LOL", -2),
  ]

  let lstb = [
    Tarefa("Trabalho de PF", 8),
    Tarefa("Revisar IHC", 4),
    Tarefa("Caixa de emails", 4),
    Tarefa("Comprar ingressos", 0),
  ]

  check.eq(junta(lsta, lstb), [
    Tarefa("Comprar comida", 10),
    Tarefa("Trabalho de PF", 8),
    Tarefa("Revisar IHC", 4),
    Tarefa("Caixa de emails", 4),
    Tarefa("Limpar a casa", 3),
    Tarefa("Comprar ingressos", 0),
    Tarefa("Jogar LOL", -2),
  ])
}
