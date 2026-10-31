import gleam/int
import gleam/list
import gleam/order.{type Order}
import gleam/string
import sgleam/check

/// A quantidade de ocorrências de um item (palavra ou expressão).
pub type Frequencia {
  Frequencia(item: String, quantidade: Int)
}

/// Devolve as *n* palavras/expressões mais frequentes de *itens*, junto com a
/// quantidade de ocorrências de cada uma, em ordem decrescente de frequência.
/// Itens com a mesma frequência ficam em ordem alfabética.
pub fn mais_frequentes(itens: List(String), n: Int) -> List(Frequencia) {
  // Plano: contar as ocorrências de cada item, ordenar as frequências em
  // ordem decrescente de quantidade e selecionar as n primeiras.
  itens
  // Etapa 1: conta as ocorrências de cada item
  |> list.fold_right([], incrementa)
  // Etapa 2: ordena em ordem decrescente de quantidade
  |> list.sort(compara_frequencia)
  // Etapa 3: seleciona as n primeiras
  |> list.take(n)
}

pub fn mais_frequentes_examples() {
  let itens = ["de", "casa", "de", "a", "casa", "de", "bola"]
  check.eq(mais_frequentes([], 2), [])
  check.eq(mais_frequentes(itens, 0), [])
  check.eq(mais_frequentes(itens, 2), [
    Frequencia("de", 3),
    Frequencia("casa", 2),
  ])
  check.eq(mais_frequentes(itens, 10), [
    Frequencia("de", 3),
    Frequencia("casa", 2),
    Frequencia("a", 1),
    Frequencia("bola", 1),
  ])
}

/// Adiciona uma ocorrência de *item* em *freqs*. Se *item* não está em
/// *freqs*, ele é adicionado com quantidade 1.
pub fn incrementa(freqs: List(Frequencia), item: String) -> List(Frequencia) {
  case list.any(freqs, fn(f) { f.item == item }) {
    True ->
      list.map(freqs, fn(f) {
        case f.item == item {
          True -> Frequencia(f.item, f.quantidade + 1)
          False -> f
        }
      })
    False -> [Frequencia(item, 1), ..freqs]
  }
}

pub fn incrementa_examples() {
  check.eq(incrementa([], "a"), [Frequencia("a", 1)])
  check.eq(incrementa([Frequencia("b", 2)], "a"), [
    Frequencia("a", 1),
    Frequencia("b", 2),
  ])
  check.eq(incrementa([Frequencia("a", 1), Frequencia("b", 2)], "b"), [
    Frequencia("a", 1),
    Frequencia("b", 3),
  ])
}

/// Compara *a* e *b* de maneira que a frequência com maior quantidade venha
/// antes. Se as quantidades são iguais, compara os itens em ordem alfabética.
pub fn compara_frequencia(a: Frequencia, b: Frequencia) -> Order {
  case int.compare(b.quantidade, a.quantidade) {
    order.Eq -> string.compare(a.item, b.item)
    ord -> ord
  }
}

pub fn compara_frequencia_examples() {
  check.eq(compara_frequencia(Frequencia("a", 3), Frequencia("b", 1)), order.Lt)
  check.eq(compara_frequencia(Frequencia("a", 1), Frequencia("b", 3)), order.Gt)
  check.eq(compara_frequencia(Frequencia("a", 1), Frequencia("b", 1)), order.Lt)
  check.eq(compara_frequencia(Frequencia("a", 1), Frequencia("a", 1)), order.Eq)
}
