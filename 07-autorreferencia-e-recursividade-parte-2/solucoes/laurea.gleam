import gleam/int
import gleam/list
import sgleam/check

/// Determina se um aluno deve receber Láurea Acadêmica.
/// Para isso, pelo menos 2/3 das notas precisam ser maiores ou iguais a 9.0.
/// Se a lista de notas estiver vazia, retorna `False`.
pub fn laureado(notas: List(Float)) -> Bool {
  let num_maiores_que_9 = int.to_float(conta_maiores_que_9(notas))
  let total = int.to_float(list.length(notas))

  total >. 0.0 && num_maiores_que_9 >=. { total *. 2.0 /. 3.0 }
}

// Conta o número de notas >= 9.0
fn conta_maiores_que_9(notas: List(Float)) -> Int {
  case notas {
    [] -> 0
    [primeiro, ..resto] if primeiro >=. 9.0 -> 1 + conta_maiores_que_9(resto)
    [_, ..resto] -> conta_maiores_que_9(resto)
  }
}

pub fn laureado_examples() {
  check.eq(laureado([]), False)
  check.eq(laureado([9.2]), True)
  check.eq(laureado([8.2]), False)
  check.eq(laureado([7.5, 9.2]), False)
  check.eq(laureado([9.0, 10.0]), True)
  check.eq(laureado([9.0, 8.0, 9.4]), True)
  check.eq(laureado([9.0, 8.0, 8.9]), False)
  check.eq(laureado([9.0, 9.1, 8.0, 8.9, 10.0]), False)
  check.eq(laureado([9.0, 9.1, 8.0, 8.9, 10.0, 9.6]), True)
}
