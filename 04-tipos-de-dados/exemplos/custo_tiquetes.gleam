import gleam/int
import sgleam/check

/// O tipo de usuário do RU da UEM.
pub type Usuario {
  Aluno
  // Servidor que recebe até 3 salários mínimos.
  ServidorAte3
  // Servidor que recebe mais do que 3 salários mínimos.
  ServidorMais3
  Docente
  Externo
}

/// Determina o custo de *quant* tíquetes para um usuário do tipo *usuario*.
/// O custo de um tíquete é
/// - Aluno           5,0
/// - ServidorAte3    5,0
/// - ServidorMais3  10,0
/// - Docente        10,0
/// - Externo        19,0
/// Se *quant* for negativo, devolve 0.0.
pub fn custo_tiquetes(usuario: Usuario, quant: Int) -> Float {
  case usuario {
    Aluno | ServidorAte3 -> 5.0
    ServidorMais3 | Docente -> 10.0
    Externo -> 19.0
  }
  *. int.to_float(int.max(0, quant))
}

pub fn custo_tiquetes_examples() {
  check.eq(custo_tiquetes(Aluno, 3), 15.0)
  check.eq(custo_tiquetes(ServidorAte3, 2), 10.0)
  check.eq(custo_tiquetes(ServidorMais3, 2), 20.0)
  check.eq(custo_tiquetes(Docente, 3), 30.0)
  check.eq(custo_tiquetes(Externo, 4), 76.0)
}
