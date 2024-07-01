public class EstadoTarefaMain {
    sealed interface EstadoTarefa permits Executando, Sucesso, Erro {};
    record Executando() implements EstadoTarefa {};
    record Sucesso(int duracao, String msg) implements EstadoTarefa {};
    record Erro(int erro, String msg) implements EstadoTarefa {};

    static String mensagem(EstadoTarefa estado) {
        return switch (estado) {
            case Executando e ->
                "A tarefa está executando";
            case Sucesso s ->
                String.format("A tarefa finalizou com sucesso (%ds): %s", s.duracao(), s.msg());
            case Erro e ->
                String.format("A tarefa falhou (erro %d): %s", e.erro(), e.msg());
        };
    }

    public static void main (String[] args) {
        Sucesso s = new Sucesso(10, "O arquivo foi salvo.");
        System.out.println(s);
        System.out.println(mensagem(s));
    }
}
