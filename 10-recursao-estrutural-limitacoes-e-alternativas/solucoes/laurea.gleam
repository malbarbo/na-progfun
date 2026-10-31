import gleam/int
import gleam/list
import sgleam/check

/// Determina se um aluno deve receber Láurea Acadêmica, isto é, se mais do
/// que 2/3 das *notas* são maiores do que 9.0. Se a lista de notas estiver
/// vazia, produz False.
pub fn laureado(notas: List(Float)) -> Bool {
  let num_notas_altas = int.to_float(conta_notas_altas(notas))
  let total = int.to_float(list.length(notas))

  total >. 0.0 && num_notas_altas >. { total *. 2.0 /. 3.0 }
}

// Conta o número de notas > 9.0
fn conta_notas_altas(notas: List(Float)) -> Int {
  case notas {
    [] -> 0
    [primeiro, ..resto] if primeiro >. 9.0 -> 1 + conta_notas_altas(resto)
    [_, ..resto] -> conta_notas_altas(resto)
  }
}

pub fn laureado_examples() {
  check.eq(laureado([]), False)
  check.eq(laureado([9.2]), True)
  check.eq(laureado([9.0]), False)
  check.eq(laureado([8.2]), False)
  check.eq(laureado([7.5, 9.2]), False)
  check.eq(laureado([9.0, 10.0]), False)
  check.eq(laureado([9.1, 10.0]), True)
  // exatamente 2/3 não é mais do que 2/3
  check.eq(laureado([9.1, 9.5, 8.0]), False)
  check.eq(laureado([9.1, 9.5, 9.2, 8.0]), True)
}
