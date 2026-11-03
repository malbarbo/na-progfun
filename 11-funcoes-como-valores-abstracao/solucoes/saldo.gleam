import gleam/list
import sgleam/check

/// Uma movimentação de uma conta bancária.
pub type Movimentacao {
  Deposito(valor: Float)
  Saque(valor: Float)
}

/// Calcula o saldo final de uma conta com saldo inicial zero e as
/// movimentações *movs*.
pub fn saldo(movs: List(Movimentacao)) -> Float {
  list.fold_right(movs, 0.0, aplica)
}

pub fn saldo_examples() {
  check.eq(saldo([]), 0.0)
  check.eq(saldo([Deposito(100.0)]), 100.0)
  check.eq(saldo([Deposito(100.0), Saque(30.0), Deposito(15.5)]), 85.5)
  check.eq(saldo([Saque(20.0)]), -20.0)
}

/// Atualiza *saldo* de acordo com a movimentação *mov*.
pub fn aplica(saldo: Float, mov: Movimentacao) -> Float {
  case mov {
    Deposito(valor) -> saldo +. valor
    Saque(valor) -> saldo -. valor
  }
}

pub fn aplica_examples() {
  check.eq(aplica(50.0, Deposito(10.0)), 60.0)
  check.eq(aplica(50.0, Saque(10.0)), 40.0)
}
