import sgleam/check

pub type Arvore {
  Vazia
  No(valor: Int, esq: Arvore, dir: Arvore)
}

/// Produz True se *valor* está em *t*, False caso contrário.
///
/// Requer que *t* seja uma árvore binária de busca, isto é:
/// 1) Todos os valores da subárvore à esquerda são menores que o valor da
///    raiz.
/// 2) Todos os valores da subárvore à direita são maiores que o valor da raiz.
/// 3) As subárvores à esquerda e à direita também são árvores binárias de
///    busca.
pub fn contem(t: Arvore, valor: Int) -> Bool {
  case t {
    Vazia -> False
    No(t_valor, esq, dir) ->
      case valor {
        _ if valor > t_valor -> contem(dir, valor)
        _ if valor < t_valor -> contem(esq, valor)
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
