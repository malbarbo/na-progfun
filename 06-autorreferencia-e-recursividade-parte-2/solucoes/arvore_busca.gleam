import sgleam/check

pub type Arvore {
  Vazia
  No(valor: Int, esq: Arvore, dir: Arvore)
}

/// Produz True se *valor* está em *r*, False caso contrário.
///
/// Requer que `r` seja uma árvore binária de busca, isto é:
/// 1) A subárvore à esquerda contém valores nos nós menores que o valor no nó
///    raiz.
/// 2) A subárvore à direita contém valores nos nós maiores que o valor no nó
///    raiz.
/// 3) As subárvores à esquerda e à direita também são árvores binárias de
///    busca.
pub fn contem(r: Arvore, valor: Int) -> Bool {
  case r {
    Vazia -> False
    No(r_valor, esq, dir) ->
      case valor {
        _ if valor > r_valor -> contem(dir, valor)
        _ if valor < r_valor -> contem(esq, valor)
        _ -> True
      }
  }
}

pub fn contem_examples() {
  // Árvores usadas para testes:
  //     t4  4
  //        / \
  //       /   \
  //  t3  3     8  t2
  //     /     / \
  //    1     7   10  t1
  //             /
  //        t0  9
  let t0 = No(9, Vazia, Vazia)
  let t1 = No(10, t0, Vazia)
  let t2 = No(8, No(7, Vazia, Vazia), t1)
  let t3 = No(3, No(1, Vazia, Vazia), Vazia)
  let t4 = No(4, t3, t2)
  check.eq(contem(Vazia, 3), False)
  check.eq(contem(t4, 4), True)
  check.eq(contem(t4, 3), True)
  check.eq(contem(t4, 8), True)
  check.eq(contem(t4, 10), True)
  check.eq(contem(t4, 6), False)
  check.eq(contem(t4, 2), False)
}
