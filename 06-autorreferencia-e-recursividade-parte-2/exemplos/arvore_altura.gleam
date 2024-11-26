import gleam/int
import sgleam/check

pub type Arvore {
  Vazia
  No(valor: Int, esq: Arvore, dir: Arvore)
}

/// Devolve a altura de *avr. A altura de uma árvore binária é a distância da
/// raiz a seu descendente mais afastado. Uma árvore com um único nó tem altura
/// 0.
pub fn altura(tree: Arvore) -> Int {
  case tree {
    Vazia -> -1
    No(_, left, right) -> 1 + int.max(altura(left), altura(right))
  }
}

pub fn altura_examples() {
  //     t4  3
  //       /   \
  //  t3  4     7  t2
  //     /     / \
  //    3     8   9  t1
  //             /
  //        t0  10

  let t0 = No(10, Vazia, Vazia)
  let t1 = No(9, t0, Vazia)
  let t2 = No(7, No(8, Vazia, Vazia), t1)
  let t3 = No(4, No(3, Vazia, Vazia), Vazia)
  let t4 = No(3, t3, t2)

  check.eq(altura(Vazia), -1)
  check.eq(altura(t0), 0)
  check.eq(altura(t1), 1)
  check.eq(altura(t2), 2)
  check.eq(altura(t3), 1)
  check.eq(altura(t4), 3)
}
