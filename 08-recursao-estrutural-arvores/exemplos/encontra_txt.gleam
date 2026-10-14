import gleam/list
import gleam/string
import sgleam/check

type Entrada {
  Arq(String)
  Dir(String, List(Entrada))
}

/// Devolve os caminhos dos arquivos .txt de *ent*.
fn encontra_txt(ent: Entrada) -> List(String) {
  case ent {
    Arq(nome) ->
      case string.ends_with(nome, ".txt") {
        False -> []
        True -> [nome]
      }
    Dir(nome, entradas) ->
      adiciona_prefixo(nome, encontra_txt_lista(entradas))
  }
}

/// Devolve os caminhos dos arquivos .txt de *entradas*.
fn encontra_txt_lista(entradas: List(Entrada)) -> List(String) {
  case entradas {
    [] -> []
    [ent, ..resto] ->
      list.append(encontra_txt(ent), encontra_txt_lista(resto))
  }
}

/// Adiciona *prefixo* seguido de "/" no início de cada string de *lst*.
fn adiciona_prefixo(prefixo: String, lst: List(String)) -> List(String) {
  case lst {
    [] -> []
    [primeiro, ..resto] -> [
      prefixo <> "/" <> primeiro,
      ..adiciona_prefixo(prefixo, resto)
    ]
  }
}

pub fn adiciona_prefixo_examples() {
  check.eq(adiciona_prefixo("a", []), [])
  check.eq(adiciona_prefixo("a", ["x.txt", "b/y.txt"]), ["a/x.txt", "a/b/y.txt"])
}

pub fn encontra_txt_examples() {
  let ent =
    Dir("disciplinas", [
      Dir("12026", [
        Arq("alunos.txt"),
        Dir("trabs", [
          Arq("trab1.md"),
          Dir("correcoes", [Arq("rascunho.txt"), Arq("final.txt")]),
          Arq("trab2.md"),
        ]),
      ]),
      Dir("6879", []),
      Dir("6884", []),
      Arq("anotacoes.txt"),
    ])
  check.eq(encontra_txt(ent), [
    "disciplinas/12026/alunos.txt",
    "disciplinas/12026/trabs/correcoes/rascunho.txt",
    "disciplinas/12026/trabs/correcoes/final.txt", "disciplinas/anotacoes.txt",
  ])
}
