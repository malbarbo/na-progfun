import gleam/list
import sgleam/check

/// Um aluno com seu nome e sua nota.
pub type Aluno {
  Aluno(nome: String, nota: Float)
}

/// Devolve o nome dos alunos de *alunos* que foram aprovados, isto é, que têm
/// nota maior ou igual a 6.0.
pub fn aprovados(alunos: List(Aluno)) -> List(String) {
  // Plano: selecionar os alunos aprovados e obter o nome de cada um.
  list.map(list.filter(alunos, aprovado), nome)
}

pub fn aprovados_examples() {
  check.eq(aprovados([]), [])
  check.eq(aprovados([Aluno("Ana", 5.9)]), [])
  check.eq(
    aprovados([
      Aluno("Ana", 7.0),
      Aluno("Bia", 5.5),
      Aluno("Caio", 6.0),
      Aluno("Davi", 4.0),
    ]),
    ["Ana", "Caio"],
  )
}

/// Devolve True se *aluno* tem nota maior ou igual a 6.0, False caso contrário.
pub fn aprovado(aluno: Aluno) -> Bool {
  aluno.nota >=. 6.0
}

pub fn aprovado_examples() {
  check.eq(aprovado(Aluno("Ana", 6.0)), True)
  check.eq(aprovado(Aluno("Bia", 5.9)), False)
}

/// Devolve o nome de *aluno*.
pub fn nome(aluno: Aluno) -> String {
  aluno.nome
}

pub fn nome_examples() {
  check.eq(nome(Aluno("Ana", 6.0)), "Ana")
}
