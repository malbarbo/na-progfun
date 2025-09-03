# Este programa calcula a classificação dos times no campeonado brasileiro dado
# o resultados dos jogos.
#
# Para cada time é calculado o número de pontos, o número de vitórias e o saldo
# de gols (diferença entre os gols feitos e os gols sofridos).
#
# A classificação é feita baseada no número de pontos, os times com maiores
# números de pontos ficam na frente, em caso de empate, os seguintes itens são
# considerados:
#
# - Maior número de vitórias
# - Maior número de saldo de gols
# - Ordem alfabética
#
# Para executar os testes use o comando
#
# python3 -mdoctest -v brasileirao.py
#
# Para executar o programa para o arquivo resultados.txt use o comando
#
# python3 brasileirao.py < resultados.txt

from dataclasses import dataclass


@dataclass(frozen=True)
class Resultado:
    """
    O resultado de um jogo.
    """
    time1: str
    gols_time1: int
    time2: str
    gols_time2: int


@dataclass(frozen=True)
class Desempenho:
    """
    O desempenho de um time em um campeonato.
    """
    time: str
    pontos: int
    vitorias: int
    # diferença entre os gols feitos e os gols sofridos
    saldo_gols: int

    def __lt__(self, other) -> bool:
        """
        Verifica se self é menor (o desempenho é pior) que other considerando
        primeiro os pontos, depois as vitorias, depois saldo_gols e por último
        o nome do time (se vem depois em ordem alfabética).

        Exemplos
        >>> Desempenho('Palmeiras', 1, 0, -1) < Desempenho('Sao-Paulo', 1, 0, -1)
        False
        >>> Desempenho('Sao-Paulo', 1, 0, -1) < Desempenho('Atletico-MG', 3, 1, 0)
        True
        """
        if self.pontos != other.pontos:
            return self.pontos < other.pontos
        if self.vitorias != other.vitorias:
            return self.vitorias < other.vitorias
        if self.saldo_gols != other.saldo_gols:
            return self.saldo_gols < other.saldo_gols
        return self.time > other.time


def classificacao(resultados_str: list[str]) -> list[str]:
    """
    Gerar uma lista com a classificacao dos times a partir dos resultados dos
    jogos (resultados_str).
    A classificação é feita usando a comparação Desempenho.__lt__
    Cada resultado deve estar de acordo com o descrito em str_resultado.
    Cada desempenho da saída é gerado com desempenho_str.

    Exemplo
    >>> classificacao([
    ... 'Sao-Paulo 1 Atletico-MG 2',
    ... 'Flamengo 2 Palmeiras 1',
    ... 'Palmeiras 0 Sao-Paulo 0',
    ... 'Atletico-MG 1 Flamengo 2'])
    ['Flamengo 6 2 2', 'Atletico-MG 3 1 0', 'Palmeiras 1 0 -1', 'Sao-Paulo 1 0 -1']
    """
    # As anotações dos tipos das variáveis não são necessárias, mas estão
    # presentes para esclarecer o código.
    resultados: list[Resultado] = list(map(str_resultado, resultados_str))
    times: set[str] = identifica_times(resultados)
    desempenhos: list[Desempenho] = list(map(lambda t: calcula_desempenho(t, resultados), times))
    tabela: list[Desempenho] = sorted(desempenhos, reverse=True)
    return list(map(desempenho_str, tabela))


def str_resultado(s: str) -> Resultado:
    """
    Cria um Resultado a partir de s.
    Requer que s esteja no formato 'time1 gols1 time2 gols2'.

    Exemplo
    >>> str_resultado("Sao-Paulo 1 Atletico-MG 2")
    Resultado(time1='Sao-Paulo', gols_time1=1, time2='Atletico-MG', gols_time2=2)
    """
    valores = s.split()
    return Resultado(valores[0], int(valores[1]), valores[2], int(valores[3]))


def desempenho_str(d: Desempenho) -> str:
    """
    Cria uma string com o formato 'time pontos vitorias saldo_gols' que
    representa o desempenho d.

    Exemplo
    >>> desempenho_str(Desempenho('Flamengo', 6, 2, 2))
    'Flamengo 6 2 2'
    """
    return f'{d.time} {d.pontos} {d.vitorias} {d.saldo_gols}'


def identifica_times(resultados: list[Resultado]) -> set[str]:
    """
    Identifica o nomes dos times que aparecem em resultados.

    Exemplo
    >>> resultados = [
    ... Resultado('Sao-Paulo', 1, 'Atletico-MG', 2),
    ... Resultado('Flamengo', 2, 'Palmeiras', 1),
    ... Resultado('Palmeiras', 0, 'Sao-Paulo', 0),
    ... Resultado('Atletico-MG', 1, 'Flamengo', 2)]
    >>> sorted(identifica_times(resultados))
    ['Atletico-MG', 'Flamengo', 'Palmeiras', 'Sao-Paulo']
    """
    def time1(r: Resultado) -> str:
        return r.time1

    def time2(r: Resultado) -> str:
        return r.time2

    times1 = list(map(time1, resultados))
    times2 = list(map(time2, resultados))

    return set(times1 + times2)


def calcula_desempenho(time: str, resultados: list[Resultado]) -> Desempenho:
    """
    Calcula o desempenho de time considerando os resultados.

    Exemplo
    >>> resultados = [
    ... Resultado('Sao-Paulo', 1, 'Atletico-MG', 2),
    ... Resultado('Flamengo', 2, 'Palmeiras', 1),
    ... Resultado('Palmeiras', 0, 'Sao-Paulo', 0),
    ... Resultado('Atletico-MG', 1, 'Flamengo', 2)]
    >>> calcula_desempenho('Sao-Paulo', resultados)
    Desempenho(time='Sao-Paulo', pontos=1, vitorias=0, saldo_gols=-1)
    """
    if len(resultados) == 0:
        return Desempenho(time, 0, 0, 0)
    else:
        r = resultados[0]
        d = calcula_desempenho(time, resultados[1:])
        if r.time1 == time:
            return atualiza_desempenho(d, r.gols_time1, r.gols_time2)
        elif r.time2 == time:
            return atualiza_desempenho(d, r.gols_time2, r.gols_time1)
        else:
            return d


def atualiza_desempenho(d: Desempenho, gols_feitos: int, gols_sofridos: int) -> Desempenho:
    """
    Atualiza o desempenho d, dados os gols_feitos e os gols_sofridos pelo time.
    Vitória vale 3 pontos; empate, 1 ponto; e derrota, 0 pontos.

    Exemplos
    >>> atualiza_desempenho(Desempenho('Flamengo', 3, 1, 4), 2, 2)
    Desempenho(time='Flamengo', pontos=4, vitorias=1, saldo_gols=4)
    >>> atualiza_desempenho(Desempenho('Flamengo', 3, 1, 4), 3, 2)
    Desempenho(time='Flamengo', pontos=6, vitorias=2, saldo_gols=5)
    >>> atualiza_desempenho(Desempenho('Flamengo', 3, 1, 4), 0, 2)
    Desempenho(time='Flamengo', pontos=3, vitorias=1, saldo_gols=2)
    """
    pontos = \
        3 if gols_feitos > gols_sofridos else \
        1 if gols_feitos == gols_sofridos else \
        0
    vitorias = \
        1 if gols_feitos > gols_sofridos else \
        0
    return Desempenho(d.time, d.pontos + pontos, d.vitorias + vitorias, d.saldo_gols + gols_feitos - gols_sofridos)


def main():
    import sys
    tabela = classificacao(sys.stdin.readlines())
    print("\n".join(tabela))


if __name__ == "__main__":
    main()
