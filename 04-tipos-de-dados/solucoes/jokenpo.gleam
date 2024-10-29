import gleam/option.{type Option, None, Some}
import sgleam/check

// Análise
//
// Determinar o nome do ganhador em uma rodada de Jokenpô entre dois jogadores.
// - Cada jogador pode fazer um dos símbolos com a mão: pedra, papel ou tesoura.
// - A pedra ganha da tesoura, a tesoura ganha do papel, e o papel ganha da pedra.

/// O símbolo feito com a mão em uma jogada.
pub type Mao {
  Pedra
  Papel
  Tesoura
}

pub type Jogada {
  Jogada(jogador: String, mao: Mao)
}

/// Determina o nome do jogador, entre o jogador que fez a jogada *a* e o
/// jogador que fez a jogada *b*, que ganhou a rodada do Jokenpô. Se houve
/// empate, devolve None.
///
/// Para determinar o vencedor as seguintes regras são utilizadas:
/// - Jogada iguais empate
/// - pedra ganha de tesoura
/// - tesoura ganha de papel
/// - papel ganha da pedra
///
/// a / b   | pedra | papel | tesoura
/// --------+-------+-------+--------
/// pedra   |   -   |   b   |  a
/// papel   |   a   |   -   |  b
/// tesoura |   b   |   a   |  -
pub fn ganhador(a: Jogada, b: Jogada) -> Option(String) {
  case a.mao, b.mao {
    ja, jb if ja == jb -> None
    Pedra, Tesoura | Papel, Pedra | Tesoura, Papel -> Some(a.jogador)
    _, _ -> Some(b.jogador)
  }
}

pub fn ganhador_examples() {
  // pedra x ...
  check.eq(ganhador(Jogada("pedro", Pedra), Jogada("paula", Pedra)), None)
  check.eq(
    ganhador(Jogada("pedro", Pedra), Jogada("paula", Papel)),
    Some("paula"),
  )
  check.eq(
    ganhador(Jogada("pedro", Pedra), Jogada("paula", Tesoura)),
    Some("pedro"),
  )

  // papel x ...
  check.eq(
    ganhador(Jogada("pedro", Papel), Jogada("paula", Pedra)),
    Some("pedro"),
  )
  check.eq(ganhador(Jogada("pedro", Papel), Jogada("paula", Papel)), None)
  check.eq(
    ganhador(Jogada("pedro", Papel), Jogada("paula", Tesoura)),
    Some("paula"),
  )

  // tesoura x ...
  check.eq(
    ganhador(Jogada("pedro", Tesoura), Jogada("paula", Pedra)),
    Some("paula"),
  )
  check.eq(
    ganhador(Jogada("pedro", Tesoura), Jogada("paula", Papel)),
    Some("pedro"),
  )
  check.eq(ganhador(Jogada("pedro", Tesoura), Jogada("paula", Tesoura)), None)
}
