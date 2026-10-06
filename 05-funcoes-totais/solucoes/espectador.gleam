import gleam/option.{type Option, None, Some}
import sgleam/check

/// O espectador de uma sala de cinema. O jovem pode apresentar a carteirinha
/// de estudante, que tem um código numérico.
pub type Espectador {
  Crianca
  Jovem(carteirinha: Option(Int))
  Adulto
  Idoso
}

/// Devolve Some com o código da carteirinha de estudante de *e*, se *e* tem
/// uma carteirinha, ou None caso contrário.
pub fn carteirinha(e: Espectador) -> Option(Int) {
  case e {
    Jovem(c) -> c
    Crianca | Adulto | Idoso -> None
  }
}

pub fn carteirinha_examples() {
  check.eq(carteirinha(Jovem(Some(3412))), Some(3412))
  check.eq(carteirinha(Jovem(None)), None)
  // só o jovem tem carteirinha
  check.eq(carteirinha(Crianca), None)
  check.eq(carteirinha(Adulto), None)
  check.eq(carteirinha(Idoso), None)
}

/// Devolve True se *e* tem direito a desconto no ingresso, False caso
/// contrário. Crianças e idosos sempre têm desconto, adultos nunca têm, e o
/// jovem tem desconto apenas se apresentar a carteirinha de estudante.
pub fn tem_desconto(e: Espectador) -> Bool {
  case e {
    Crianca -> True
    Jovem(Some(_)) -> True
    Jovem(None) -> False
    Adulto -> False
    Idoso -> True
  }
}

pub fn tem_desconto_examples() {
  check.eq(tem_desconto(Crianca), True)
  check.eq(tem_desconto(Jovem(Some(3412))), True)
  check.eq(tem_desconto(Jovem(None)), False)
  check.eq(tem_desconto(Adulto), False)
  check.eq(tem_desconto(Idoso), True)
}
