import sgleam/check

/// Uma hora do dia, entre 0 e 23.
pub opaque type Hora {
  Hora(valor: Int)
}

/// Devolve Ok(Hora) com o valor *h* se 0 <= h <= 23, Error(Nil) caso
/// contrário.
pub fn hora(h: Int) -> Result(Hora, Nil) {
  case 0 <= h && h <= 23 {
    True -> Ok(Hora(h))
    False -> Error(Nil)
  }
}

pub fn hora_examples() {
  check.eq(hora(-1), Error(Nil))
  check.eq(hora(0), Ok(Hora(0)))
  check.eq(hora(23), Ok(Hora(23)))
  check.eq(hora(24), Error(Nil))
}

/// Devolve o valor em *h*.
pub fn valor(h: Hora) -> Int {
  h.valor
}

/// Um intervalo entre doses, de 1 a 24 horas.
pub opaque type Intervalo {
  Intervalo(horas: Int)
}

/// Devolve Ok(Intervalo) com *h* horas se 1 <= h <= 24, Error(Nil) caso
/// contrário.
pub fn intervalo(h: Int) -> Result(Intervalo, Nil) {
  case 1 <= h && h <= 24 {
    True -> Ok(Intervalo(h))
    False -> Error(Nil)
  }
}

pub fn intervalo_examples() {
  check.eq(intervalo(0), Error(Nil))
  check.eq(intervalo(1), Ok(Intervalo(1)))
  check.eq(intervalo(24), Ok(Intervalo(24)))
  check.eq(intervalo(25), Error(Nil))
}

/// Devolve o número de horas em *i*.
pub fn horas(i: Intervalo) -> Int {
  i.horas
}

/// Devolve a hora *i* horas depois de *h*.
pub fn avanca(h: Hora, i: Intervalo) -> Hora {
  Hora({ valor(h) + horas(i) } % 24)
}

pub fn avanca_examples() {
  let assert Ok(h10) = hora(10)
  let assert Ok(h22) = hora(22)
  let assert Ok(i8) = intervalo(8)
  let assert Ok(i24) = intervalo(24)
  check.eq(valor(avanca(h10, i8)), 18)
  check.eq(valor(avanca(h22, i8)), 6)
  check.eq(valor(avanca(h22, i24)), 22)
}

/// Produz a lista com os horários de *doses* doses, começando em *inicio* e
/// espaçadas por *i*.
pub fn horarios(inicio: Hora, i: Intervalo, doses: Int) -> List(Hora) {
  case doses {
    _ if doses <= 0 -> []
    _ -> [inicio, ..horarios(avanca(inicio, i), i, doses - 1)]
  }
}

pub fn horarios_examples() {
  let assert Ok(h22) = hora(22)
  let assert Ok(i8) = intervalo(8)
  let assert Ok(h6) = hora(6)
  let assert Ok(h14) = hora(14)
  check.eq(horarios(h22, i8, -1), [])
  check.eq(horarios(h22, i8, 0), [])
  check.eq(horarios(h22, i8, 1), [h22])
  check.eq(horarios(h22, i8, 4), [h22, h6, h14, h22])
}
