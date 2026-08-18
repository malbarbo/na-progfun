import gleam/int
import sgleam/check

/// O estado de uma tarefa
pub type EstadoTarefa {
  // A tarefa está em execução
  Executando
  // A tarefa finalizou com sucesso.
  // Requer que duracao seja >= 0.
  Sucesso(duracao: Int, msg: String)
  // A tarefa finalizou com falha
  Erro(codigo: Int, msg: String)
}

/// Produz uma string amigável para o usuário que descreve o *estado* de uma tarefa.
pub fn mensagem(estado: EstadoTarefa) -> String {
  case estado {
    Executando -> "A tarefa está em execução."
    Sucesso(duracao, msg) ->
      "Tarefa concluída (" <> int.to_string(duracao) <> "s): " <> msg
    Erro(codigo, msg) ->
      "A tarefa falhou (erro " <> int.to_string(codigo) <> "): " <> msg
  }
}

pub fn mensagem_examples() {
  check.eq(mensagem(Executando), "A tarefa está em execução.")
  check.eq(
    mensagem(Sucesso(12, "Os resultados estão corretos.")),
    "Tarefa concluída (12s): Os resultados estão corretos.",
  )
  check.eq(
    mensagem(Erro(123, "Número inválido '12a'.")),
    "A tarefa falhou (erro 123): Número inválido '12a'.",
  )
}

/// Produz a duração de *estado*, ou -1 se o estado não tem duração.
pub fn duracao(estado: EstadoTarefa) -> Int {
  case estado {
    Sucesso(duracao, _) -> duracao
    _ -> -1
  }
}

pub fn duracao_examples() {
  check.eq(duracao(Executando), -1)
  check.eq(duracao(Sucesso(10, "Recuperação exitosa.")), 10)
  check.eq(duracao(Erro(-23, "Arquivo não existente.")), -1)
}
