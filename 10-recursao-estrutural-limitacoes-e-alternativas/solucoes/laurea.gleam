import gleam/int
import gleam/list
import sgleam/check

/// Determina se um aluno deve receber Láurea Acadêmica.
/// O enunciado é ambíguo quanto aos limites; aqui consideramos que pelo
/// menos 2/3 das notas precisam ser maiores ou iguais a 9.0.
/// Se a lista de notas estiver vazia, produz False.
pub fn laureado(notas: List(Float)) -> Bool {
  let num_notas_altas = int.to_float(conta_notas_altas(notas))
  let total = int.to_float(list.length(notas))

  total >. 0.0 && num_notas_altas >=. { total *. 2.0 /. 3.0 }
}

// Conta o número de notas >= 9.0
fn conta_notas_altas(notas: List(Float)) -> Int {
  case notas {
    [] -> 0
    [primeiro, ..resto] if primeiro >=. 9.0 -> 1 + conta_notas_altas(resto)
    [_, ..resto] -> conta_notas_altas(resto)
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
