import sgleam/check

/// Representa os pontos cardiais de acordo com o esboço a seguir
///
///       Norte
///         |
/// Oeste -   - Leste
///         |
///        Sul
pub type Direcao {
  Norte
  Leste
  Sul
  Oeste
}

/// Produz a direção oposta de *d*.
pub fn direcao_oposta(d: Direcao) -> Direcao {
  case d {
    Norte -> Sul
    Sul -> Norte
    Leste -> Oeste
    Oeste -> Leste
  }
}

pub fn direcao_oposta_examples() {
  check.eq(direcao_oposta(Norte), Sul)
  check.eq(direcao_oposta(Sul), Norte)
  check.eq(direcao_oposta(Leste), Oeste)
  check.eq(direcao_oposta(Oeste), Leste)
}

/// Devolve a direção que está a 90 graus no sentido horário de *d*.
pub fn direcao_90_horario(d: Direcao) -> Direcao {
  case d {
    Norte -> Leste
    Leste -> Sul
    Sul -> Oeste
    Oeste -> Norte
  }
}

pub fn direcao_90_horario_examples() {
  check.eq(direcao_90_horario(Norte), Leste)
  check.eq(direcao_90_horario(Leste), Sul)
  check.eq(direcao_90_horario(Sul), Oeste)
  check.eq(direcao_90_horario(Oeste), Norte)
}

/// Devolve a direção que está a 90 graus no sentido anti-horário de *d*.
pub fn direcao_90_anti_horario(d: Direcao) -> Direcao {
  direcao_90_horario(direcao_90_horario(direcao_90_horario(d)))
}

pub fn direcao_90_anti_horario_examples() {
  check.eq(direcao_90_anti_horario(Norte), Oeste)
  check.eq(direcao_90_anti_horario(Leste), Norte)
  check.eq(direcao_90_anti_horario(Sul), Leste)
  check.eq(direcao_90_anti_horario(Oeste), Sul)
}
