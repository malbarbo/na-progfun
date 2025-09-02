import sgleam/check

/// O estado de um quadrado no campo do jogo.
pub type Estado {
  Aberto
  Fechado
  FechadoComBandeira
}

/// Um quadrado no campo de jogo.
pub type Quadrado {
  /// True se tem mina, False caso contrário.
  Quadrado(mina: Bool, estado: Estado)
}

/// Uma ação do usuário no jogo.
pub type Acao {
  Abrir
  AdicionarBandeira
  RemoverBandeira
}

/// Atualiza o estado do quadrado *q* dado a *acao* do usuário. A atualização é
/// feita conforme a tabela a seguir, onde - significa que o quadrado permanece
/// como estava.
///
/// | estado/ação          |  abrir  | adicionar bandeira   | remover bandeira |
/// |---------------------:|:-------:|:--------------------:|:----------------:|
/// | aberto               |   -     |          -           |        -         |
/// | fechado              | aberto  | fechado-com-bandeira |        -         |
/// | fechado-com-bandeira |   -     |          -           |      fechado     |
pub fn atualiza_quadrado(q: Quadrado, acao: Acao) -> Quadrado {
  case q.estado, acao {
    Fechado, Abrir -> Quadrado(..q, estado: Aberto)
    Fechado, AdicionarBandeira -> Quadrado(..q, estado: FechadoComBandeira)
    FechadoComBandeira, RemoverBandeira -> Quadrado(..q, estado: Fechado)
    _, _ -> q
  }
}

pub fn atualiza_quadrado_examples() {
  let aberto = Quadrado(False, Aberto)
  let fechado = Quadrado(False, Fechado)
  let bandeira = Quadrado(False, FechadoComBandeira)

  // Aberto
  check.eq(atualiza_quadrado(aberto, Abrir), aberto)
  check.eq(atualiza_quadrado(aberto, AdicionarBandeira), aberto)
  check.eq(atualiza_quadrado(aberto, RemoverBandeira), aberto)

  // Fechado
  check.eq(atualiza_quadrado(fechado, Abrir), aberto)
  check.eq(atualiza_quadrado(fechado, AdicionarBandeira), bandeira)
  check.eq(atualiza_quadrado(fechado, RemoverBandeira), fechado)

  // FechadoComBandeira
  check.eq(atualiza_quadrado(bandeira, Abrir), bandeira)
  check.eq(atualiza_quadrado(bandeira, AdicionarBandeira), bandeira)
  check.eq(atualiza_quadrado(bandeira, RemoverBandeira), fechado)
}
