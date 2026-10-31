import gleam/int
import gleam/list
import sgleam/check

/// Um aluno com seu nome e sua nota.
pub type Aluno {
  Aluno(nome: String, nota: Float)
}

/// Devolve o nome dos alunos de *alunos* que têm nota maior do que a média da
/// turma. Se a turma é vazia, devolve a lista vazia.
pub fn acima_da_media(alunos: List(Aluno)) -> List(String) {
  // Plano: calcular a média das notas, selecionar os alunos com nota maior do
  // que a média e obter os nomes dos alunos selecionados.
  //
  // A média de uma turma vazia não está definida, mas a resposta para uma
  // turma vazia está: nenhum aluno tem nota acima da média. Por isso tratamos
  // esse caso separadamente, e a função é total.
  case alunos {
    [] -> []
    _ -> {
      // Etapa 1: calcula a média das notas
      let media =
        list.fold_right(alunos, 0.0, fn(acc, a) { acc +. a.nota })
        /. int.to_float(list.length(alunos))
      // Etapa 2: seleciona os alunos com nota acima da média
      // Etapa 3: obtém os nomes dos alunos selecionados
      alunos
      |> list.filter(fn(a) { a.nota >. media })
      |> list.map(fn(a) { a.nome })
    }
  }
}

pub fn acima_da_media_examples() {
  check.eq(acima_da_media([]), [])
  check.eq(acima_da_media([Aluno("Ana", 7.0)]), [])
  check.eq(acima_da_media([Aluno("Ana", 7.0), Aluno("Bia", 7.0)]), [])
  check.eq(
    acima_da_media([
      Aluno("Ana", 8.0),
      Aluno("Bia", 5.0),
      Aluno("Caio", 9.0),
      Aluno("Davi", 6.0),
    ]),
    // média 7.0
    ["Ana", "Caio"],
  )
}
