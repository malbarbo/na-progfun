import sgleam/check

/// Uma lista de números
///
/// Exemplo de lista com 3, 1, 2
/// Link(3, Link(1, Link(2, Vazia)))
pub type Lista {
  Vazia
  Link(primeiro: Int, resto: Lista)
}

pub fn soma(lst: Lista) -> Int {
  case lst {
    Vazia -> 0
    Link(primeiro, resto) -> primeiro + soma(resto)
  }
}

pub fn soma_examples() {
  check.eq(soma(Vazia), 0)
  // 3 + 0
  check.eq(soma(Link(3, Vazia)), 3)
  // 2 + (5 + 0)
  check.eq(soma(Link(2, Link(5, Vazia))), 7)
}
