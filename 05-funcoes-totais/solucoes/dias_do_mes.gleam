import gleam/int
import sgleam/check

/// Devolve a quantidade de dias do mês de número *m*, considerando um ano não
/// bissexto, ou Error(Nil) se *m* não representa um número entre 1 e 12.
pub fn dias_do_mes(m: String) -> Result(Int, Nil) {
  case int.parse(m) {
    Error(Nil) -> Error(Nil)
    Ok(n) ->
      case n {
        1 | 3 | 5 | 7 | 8 | 10 | 12 -> Ok(31)
        4 | 6 | 9 | 11 -> Ok(30)
        2 -> Ok(28)
        _ -> Error(Nil)
      }
  }
}

pub fn dias_do_mes_examples() {
  check.eq(dias_do_mes("1"), Ok(31))
  check.eq(dias_do_mes("2"), Ok(28))
  check.eq(dias_do_mes("4"), Ok(30))
  check.eq(dias_do_mes("12"), Ok(31))
  // não representa um número
  check.eq(dias_do_mes("dez"), Error(Nil))
  check.eq(dias_do_mes(""), Error(Nil))
  // não está entre 1 e 12
  check.eq(dias_do_mes("0"), Error(Nil))
  check.eq(dias_do_mes("13"), Error(Nil))
}

/// O motivo pelo qual não foi possível determinar a quantidade de dias de um
/// mês.
pub type ErroMes {
  NaoNumero
  ForaDaFaixa
}

/// Devolve a quantidade de dias do mês de número *m*, considerando um ano não
/// bissexto, ou NaoNumero se *m* não representa um número, ou ForaDaFaixa se
/// o número que *m* representa não está entre 1 e 12.
pub fn dias_do_mes_erro(m: String) -> Result(Int, ErroMes) {
  case int.parse(m) {
    Error(Nil) -> Error(NaoNumero)
    Ok(n) ->
      case n {
        1 | 3 | 5 | 7 | 8 | 10 | 12 -> Ok(31)
        4 | 6 | 9 | 11 -> Ok(30)
        2 -> Ok(28)
        _ -> Error(ForaDaFaixa)
      }
  }
}

pub fn dias_do_mes_erro_examples() {
  check.eq(dias_do_mes_erro("1"), Ok(31))
  check.eq(dias_do_mes_erro("2"), Ok(28))
  check.eq(dias_do_mes_erro("4"), Ok(30))
  check.eq(dias_do_mes_erro("12"), Ok(31))
  // não representa um número
  check.eq(dias_do_mes_erro("dez"), Error(NaoNumero))
  check.eq(dias_do_mes_erro(""), Error(NaoNumero))
  // não está entre 1 e 12
  check.eq(dias_do_mes_erro("0"), Error(ForaDaFaixa))
  check.eq(dias_do_mes_erro("13"), Error(ForaDaFaixa))
}
