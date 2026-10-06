import gleam/int
import sgleam/check

/// Uma duração de tempo, em horas e minutos.
pub opaque type Duracao {
  Duracao(horas: Int, minutos: Int)
}

/// Devolve Ok com a duração de *horas* horas e *minutos* minutos, ou
/// Error(Nil) se *horas* é negativo ou se *minutos* não está entre 0 e 59.
pub fn duracao(horas: Int, minutos: Int) -> Result(Duracao, Nil) {
  case horas >= 0 && minutos >= 0 && minutos <= 59 {
    True -> Ok(Duracao(horas, minutos))
    False -> Error(Nil)
  }
}

pub fn duracao_examples() {
  check.eq(duracao(0, 0), Ok(Duracao(0, 0)))
  check.eq(duracao(2, 30), Ok(Duracao(2, 30)))
  check.eq(duracao(10, 59), Ok(Duracao(10, 59)))
  // horas negativas
  check.eq(duracao(-1, 30), Error(Nil))
  // minutos fora da faixa
  check.eq(duracao(1, -1), Error(Nil))
  check.eq(duracao(1, 60), Error(Nil))
}

/// Devolve a quantidade de horas de *d*.
pub fn horas(d: Duracao) -> Int {
  d.horas
}

/// Devolve a quantidade de minutos de *d*.
pub fn minutos(d: Duracao) -> Int {
  d.minutos
}

/// Devolve Ok com a duração equivalente a *total* minutos, ou Error(Nil) se
/// *total* é negativo.
pub fn de_minutos(total: Int) -> Result(Duracao, Nil) {
  duracao(total / 60, total % 60)
}

pub fn de_minutos_examples() {
  check.eq(de_minutos(0), Ok(Duracao(0, 0)))
  check.eq(de_minutos(45), Ok(Duracao(0, 45)))
  check.eq(de_minutos(60), Ok(Duracao(1, 0)))
  check.eq(de_minutos(150), Ok(Duracao(2, 30)))
  check.eq(de_minutos(-1), Error(Nil))
}

/// Devolve a duração equivalente à soma de *a* e *b*.
///
/// Como *a* e *b* são durações válidas, a soma dos minutos fica entre 0 e 118,
/// então basta transferir no máximo uma hora para o total de horas.
pub fn soma(a: Duracao, b: Duracao) -> Duracao {
  let total = a.minutos + b.minutos
  Duracao(a.horas + b.horas + total / 60, total % 60)
}

pub fn soma_examples() {
  check.eq(soma(Duracao(0, 0), Duracao(2, 15)), Duracao(2, 15))
  check.eq(soma(Duracao(1, 20), Duracao(2, 30)), Duracao(3, 50))
  // a soma dos minutos passa de 59
  check.eq(soma(Duracao(0, 30), Duracao(0, 30)), Duracao(1, 0))
  check.eq(soma(Duracao(1, 40), Duracao(2, 30)), Duracao(4, 10))
}

/// Devolve *d* em uma forma amigável para o usuário, omitindo as horas ou os
/// minutos quando o valor é zero.
pub fn para_string(d: Duracao) -> String {
  case d.horas, d.minutos {
    0, 0 -> "0min"
    h, 0 -> int.to_string(h) <> "h"
    0, m -> int.to_string(m) <> "min"
    h, m -> int.to_string(h) <> "h" <> int.to_string(m) <> "min"
  }
}

pub fn para_string_examples() {
  check.eq(para_string(Duracao(0, 0)), "0min")
  check.eq(para_string(Duracao(2, 0)), "2h")
  check.eq(para_string(Duracao(0, 45)), "45min")
  check.eq(para_string(Duracao(1, 30)), "1h30min")
}
