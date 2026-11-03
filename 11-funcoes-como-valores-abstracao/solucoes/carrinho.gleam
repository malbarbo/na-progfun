import gleam/float
import gleam/int
import gleam/list
import sgleam/check

/// Um item do carrinho, com o nome do produto, o preço unitário e a quantidade
/// comprada.
pub type Item {
  Item(nome: String, preco: Float, quantidade: Int)
}

/// Calcula o valor total de *itens*.
pub fn total(itens: List(Item)) -> Float {
  // Plano: calcular o subtotal de cada item e somar os subtotais.
  list.fold_right(list.map(itens, subtotal), 0.0, float.add)
}

pub fn total_examples() {
  check.eq(total([]), 0.0)
  check.eq(total([Item("Caderno", 12.5, 2)]), 25.0)
  check.eq(
    total([
      Item("Caderno", 12.5, 2),
      Item("Caneta", 2.0, 3),
      Item("Mochila", 80.0, 1),
    ]),
    111.0,
  )
}

/// Calcula o valor de *item*: o preço unitário vezes a quantidade.
pub fn subtotal(item: Item) -> Float {
  item.preco *. int.to_float(item.quantidade)
}

pub fn subtotal_examples() {
  check.eq(subtotal(Item("Caneta", 2.0, 3)), 6.0)
  check.eq(subtotal(Item("Caneta", 2.0, 0)), 0.0)
}
