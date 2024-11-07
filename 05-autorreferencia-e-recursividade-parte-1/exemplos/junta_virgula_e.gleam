import sgleam/check

/// Produz uma string juntando os elementos de *lst* da seguinte forma:
/// - Se a *lst* é vazia, devolve "".
/// - Se a *lst* tem apenas um elemento, devolve esse elemento.
/// - Senão, junta as strings de *lst*, separando-as com ", ", com exceção
///   da última string, que é separada com " e ".
pub fn junta_virgula_e(lst: List(String)) -> String {
  case lst {
    [] -> ""
    [primeiro] -> primeiro
    [primeiro, segundo] -> primeiro <> " e " <> segundo
    [primeiro, ..resto] -> primeiro <> ", " <> junta_virgula_e(resto)
  }
}

pub fn junta_virgula_e_examples() {
  check.eq(junta_virgula_e([]), "")
  check.eq(junta_virgula_e(["maça"]), "maça")
  check.eq(
    junta_virgula_e(["mamão", "banana", "maça"]),
    "mamão, banana e maça",
  )
  check.eq(
    junta_virgula_e(["aveia", "mamão", "banana", "maça"]),
    "aveia, mamão, banana e maça",
  )
}
