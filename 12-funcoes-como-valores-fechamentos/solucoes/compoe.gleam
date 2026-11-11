import gleam/int
import gleam/list
import gleam/string
import sgleam/check

/// Devolve a função composta de *f* com *g*, isto é, a função que aplica *g*
/// ao seu argumento e depois aplica *f* ao resultado.
pub fn compoe(f: fn(b) -> c, g: fn(a) -> b) -> fn(a) -> c {
  fn(x) { f(g(x)) }
}

pub fn compoe_examples() {
  check.eq(compoe(int.is_odd, string.length)("abc"), True)
  check.eq(compoe(int.is_odd, string.length)("casa"), False)
  check.eq(
    list.filter(["casa", "oi", "abc"], compoe(int.is_odd, string.length)),
    ["abc"],
  )
}

/// Devolve uma função que aplica *f* ao argumento e *f* a esse resultado.
pub fn duas_vezes(f: fn(a) -> a) -> fn(a) -> a {
  compoe(f, f)
}

pub fn duas_vezes_examples() {
  check.eq(duas_vezes(fn(n) { n + 1 })(3), 5)
  check.eq(duas_vezes(fn(n) { n * 2 })(5), 20)
}
