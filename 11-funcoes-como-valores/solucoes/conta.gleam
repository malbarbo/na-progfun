import gleam/int
import gleam/list
import sgleam/check

/// Conta a quantidade de elementos em *lst* que satisfazem o predicado *pred*.
pub fn conta(lst: List(a), pred: fn(a) -> Bool) -> Int {
  list.fold_right(lst, 0, fn(acc, e) {
    case pred(e) {
      True -> acc + 1
      False -> acc
    }
  })
}

pub fn conta_examples() {
  check.eq(conta([3, 1, 2, 4, 7], int.is_odd), 3)
  check.eq(conta([1, -1, 2, 3, -2, 5], fn(n) { n > 0 }), 4)
}
