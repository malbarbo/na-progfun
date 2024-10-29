import gleam/string
import sgleam/check

// Análise
//
// Rotacionar uma string a direita n caracteres, isto é, mover
// os últimos n caracteres para o início da string.
//
// Como chegamos nessa especificação a partir da análise?
// Se você tem interesse em saber, pergunte em sala!

/// Produz uma string realizando o equivalente a *n* operações de move 1 a
/// direita, se *n* é não negativo, ou o equivalente a *-n* operações de move 1
/// a esquerda se *n* é negativo. Mover 1 a direita significa colocar o último
/// caractere de uma string no início da string. Mover 1 a esquerda significa
/// colocar o o primeiro caractere de uma string no final da string
pub fn rotaciona_direita(s: String, n: Int) -> String {
  let tam = string.length(s)
  let div = case n < 0 {
    True -> { tam + n } % tam
    False -> n % tam
  }
  string.drop_left(s, tam - div) <> string.drop_right(s, div)
}

pub fn rotaciona_direita_examples() {
  check.eq(rotaciona_direita("marcelio", 5), "celiomar")
  check.eq(rotaciona_direita("abc", 0), "abc")
  check.eq(rotaciona_direita("abc", 1), "cab")
  check.eq(rotaciona_direita("abc", 2), "bca")
  check.eq(rotaciona_direita("abc", 3), "abc")
  check.eq(rotaciona_direita("abc", -1), "bca")
  check.eq(rotaciona_direita("abc", -2), "cab")
  check.eq(rotaciona_direita("abc", -3), "abc")
}
