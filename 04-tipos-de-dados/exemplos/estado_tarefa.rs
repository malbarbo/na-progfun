pub enum EstadoTarefa {
    Executando,
    Sucesso(u32, String),
    Erro(u32, String),
}

pub fn mensagem(estado: &EstadoTarefa) -> String {
    use EstadoTarefa::*;
    match estado {
        Executando =>
            "A tarefa está em execução".to_string(),
        Sucesso(tempo, msg) =>
            format!("A tarefa finalizou com sucesso ({tempo}s): {msg}"),
        Erro(codigo, msg) =>
            format!("A tarefa falhou (erro {codigo}): {msg}"),
    }
}

pub fn main() {}
