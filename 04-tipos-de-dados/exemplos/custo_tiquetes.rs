/// Representa o tipo de um usuário do RU da UEM.
pub enum TipoUsuario {
    Aluno,
    // Servidor que recebe até 3 salários mínimos
    ServidorAte3,
    // Servidor que recebe mais de 3 salários mínimos
    ServidorMais3,
    Docente,
    Externo,
}

/// Determina o custo de *quant* tíquetes para um usuário do tipo *tp*.
///
/// O custo de um tíquete é determinado pelo tipo do usuário da seguinte forma:
///
/// Aluno          5,0
/// ServidorAte3   5,0
/// ServidorMais3 10,0
/// Docente       10,0
/// Externo       19,0
///
/// Como *quant* é um u32, não é possível informar uma quantidade negativa.
///
/// # Exemplos
///
/// ```rust
/// # use custo_tiquetes::*;
///
/// assert_eq!(custo_tiquetes(TipoUsuario::Aluno, 3), 15.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::ServidorAte3, 2), 10.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::ServidorMais3, 2), 20.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::Docente, 3), 30.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::Externo, 4), 76.0);
/// ```
pub fn custo_tiquetes(tp: TipoUsuario, quant: u32) -> f64 {
    let custo = match tp {
        TipoUsuario::Aluno | TipoUsuario::ServidorAte3 => 5.0,
        TipoUsuario::ServidorMais3 | TipoUsuario::Docente => 10.0,
        TipoUsuario::Externo => 19.0,
    };
    custo * (quant as f64)
}
