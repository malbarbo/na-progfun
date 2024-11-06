import gleam/int
import gleam/string
import sgleam/check

/// Produz True se *palavra* é duplicada, isto é, é formada pela ocorrência de
/// duas partes iguais separadas ou não por hífen. Devolve False se palavra não
/// é duplicada.
pub fn duplicada(palavra: String) -> Bool {
  let tamanho = string.length(palavra)
  let meio = tamanho / 2
  int.is_even(tamanho)
  && string.drop_right(palavra, meio) == string.drop_left(palavra, meio)
  || int.is_odd(tamanho)
  && string.slice(palavra, meio, 1) == "-"
  && string.drop_right(palavra, meio + 1) == string.drop_left(palavra, meio + 1)
}

pub fn duplicada_examples() {
  check.eq(duplicada("xixi"), True)
  check.eq(duplicada("lero-lero"), True)
  check.eq(duplicada("aba"), False)
  check.eq(duplicada("ab-ba"), False)
}
