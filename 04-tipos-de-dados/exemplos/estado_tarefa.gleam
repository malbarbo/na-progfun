import gleam/int
import sgleam/check

pub type EstadoTarefa {
  Executando
  Sucesso(Int, String)
  Erro(Int, String)
}

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
