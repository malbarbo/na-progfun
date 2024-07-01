/// Representa o tipo de um usuário do Ru da UEM.
pub enum TipoUsuario {
    Aluno,
    // Servidor que recebe até 3 salários mínimos
    ServidorAte3,
    // Servidor que recebe mais do que 3 salários mínimos
    ServidorMaisq3,
    Docente,
    Externo,
}

/// Determina o custo de *quant* tíquetes para um usuário do tipo *tp*.
///
/// O custo de um tíquete é determinado pelo tipo do usuário da seguinte forma:
///
/// Aluno           5,0
/// ServidorAte3    5,0
/// ServidorMaisq3 10,0
/// Docente        10,0
/// Externo        19,0
///
/// # Exemplos
///
/// ```rust
/// # use custo_tiquetes::*;
///
/// assert_eq!(custo_tiquetes(TipoUsuario::Aluno, 3), 15.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::ServidorAte3, 2), 10.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::ServidorMaisq3, 2), 20.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::Docente, 3), 30.0);
/// assert_eq!(custo_tiquetes(TipoUsuario::Externo, 2), 38.0);
/// ```
pub fn custo_tiquetes(tp: TipoUsuario, quant: u32) -> f64 {
    match tp {
        TipoUsuario::Aluno | TipoUsuario::ServidorAte3 => (quant as f64) * 5.0,
        TipoUsuario::ServidorMaisq3 | TipoUsuario::Docente => (quant as f64) * 10.0,
        TipoUsuario::Externo => (quant as f64) * 19.0,
    }
}
