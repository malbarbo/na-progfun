from enum import Enum, auto

class TipoUsuario(Enum):
    '''
    Representa um tipo de usuário do RU.
    '''
    ALUNO = auto()
    # Servidores que recebem até 3 salários mínimos
    SERVIDOR_ATE_3 = auto()
    # Servidores que recebem mais de 3 salários mínimos
    SERVIDOR_MAIS_3 = auto()
    DOCENTE = auto()
    EXTERNO = auto()


def custo_tiquetes(tp: TipoUsuario, quant: int) -> float:
    '''
    Determina o custo de *quant* tíquetes para um usuário do tipo *tp*.

    O custo de um tíquete é determinado pelo tipo do usuário da seguinte forma:
    ALUNO             5,0
    SERVIDOR_ATE_3    5,0
    SERVIDOR_MAIS_3  10,0
    DOCENTE          10,0
    EXTERNO          19,0

    Se *quant* for negativo, devolve 0,0.

    Exemplos
    >>> custo_tiquetes(TipoUsuario.ALUNO, 3)
    15.0
    >>> custo_tiquetes(TipoUsuario.SERVIDOR_ATE_3, 2)
    10.0
    >>> custo_tiquetes(TipoUsuario.SERVIDOR_MAIS_3, 2)
    20.0
    >>> custo_tiquetes(TipoUsuario.DOCENTE, 3)
    30.0
    >>> custo_tiquetes(TipoUsuario.EXTERNO, 4)
    76.0
    >>> custo_tiquetes(TipoUsuario.ALUNO, -1)
    0.0
    '''
    if tp == TipoUsuario.ALUNO or tp == TipoUsuario.SERVIDOR_ATE_3:
        custo = 5.0
    elif tp == TipoUsuario.SERVIDOR_MAIS_3 or tp == TipoUsuario.DOCENTE:
        custo = 10.0
    else:
        custo = 19.0
    return custo * max(0, quant)
