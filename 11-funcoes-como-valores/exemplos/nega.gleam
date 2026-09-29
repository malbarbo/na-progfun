import sgleam/check

/// Devolve uma função que é semelhante a *pred*, mas que devolve a negação do
/// resultado de *pred*.
pub fn nega(pred: fn(a) -> Bool) -> fn(a) -> Bool {
  fn(x: a) -> Bool { !pred(x) }
}

pub fn nega_examples() {
  check.eq(nega(fn(x: Int) -> Bool { x > 0 })(3), False)
  check.eq(nega(fn(x: Int) -> Bool { x > 0 })(-3), True)
  check.eq(nega(fn(x: Int) -> Bool { x % 2 == 0 })(4), False)
  check.eq(nega(fn(x: Int) -> Bool { x % 2 == 0 })(3), True)
}
