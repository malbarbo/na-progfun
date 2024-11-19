import gleam/list
import gleam/string
import sgleam/check

pub type Entrada {
  Arq(String)
  Dir(String, List(Entrada))
}

fn entrada_arvore(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) -> [nome]
    Dir(nome, entradas) -> [
      nome <> "/",
      ..adiciona_prefixo(entradas_arvores(entradas))
    ]
  }
}

fn entradas_arvores(entradas: List(Entrada)) -> List(String) {
  case entradas {
    [] -> []
    [entrada, ..resto] ->
      list.append(entrada_arvore(entrada), entradas_arvores(resto))
  }
}

fn adiciona_prefixo(lst: List(String)) -> List(String) {
  case lst {
    [] -> []
    [primeiro, ..resto] ->
      case eh_raiz_subarvore(primeiro) {
        True -> ["+- " <> primeiro, ..adiciona_prefixo(resto)]
        False ->
          case adiciona_prefixo(resto) {
            [] -> ["   " <> primeiro]
            [" " <> segundo, ..resto] -> [
              "   " <> primeiro,
              " " <> segundo,
              ..resto
            ]
            resto -> ["|  " <> primeiro, ..resto]
          }
      }
  }
}

fn eh_raiz_subarvore(s: String) -> Bool {
  !{
    string.starts_with(s, " ")
    || string.starts_with(s, "|")
    || string.starts_with(s, "+")
  }
}

pub fn entrada_arvore_examples() {
  let arv =
    Dir("disciplinas", [
      Dir("12026", [
        Arq("alunos.txt"),
        Dir("trabalhos", [
          Arq("trab1.md"),
          Dir("correcoes", [Arq("rascunho.txt"), Arq("final.txt")]),
          Arq("trab2.md"),
        ]),
      ]),
      Dir("6879", []),
      Dir("6884", []),
      Arq("anotacoes.txt"),
    ])

  check.eq(entrada_arvore(arv), [
    "disciplinas/", "+- 12026/", "|  +- alunos.txt", "|  +- trabalhos/",
    "|     +- trab1.md", "|     +- correcoes/", "|     |  +- rascunho.txt",
    "|     |  +- final.txt", "|     +- trab2.md", "+- 6879/", "+- 6884/",
    "+- anotacoes.txt",
  ])
}
