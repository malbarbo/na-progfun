from enum import Enum, auto

class TipoUsuario(Enum):
    '''
    Representa um tipo de usuário do RU.
    '''
    ALUNO = auto()
    # Servidores que recebem até 3 salários mínimos
    SERVIDOR_ATE_3 = auto()
    # Servidores que recebem mais do que 3 salários mínimos
    SERVIDOR_MAISQ_3 = auto()
    DOCENTE = auto()
    EXTERNO = auto()


def custo_tiquetes(tp: TipoUsuario, quant: int) -> float:
    '''
    Determina o custo de *quant* tíquetes para um usuário do tipo *tp*.

    O custo de um tíquete é determinado pelo tipo do usuário da seguinte forma:
    ALUNO              5,0
    SERVIDOR_ATE_3     5,0
    SERVIDOR_MAISQ_3  10,0
    DOCENTE           10,0
    EXTERNO           19,0

    Exemplos
    >>> custo_tiquetes(TipoUsuario.ALUNO, 3)
    15.0
    >>> custo_tiquetes(TipoUsuario.SERVIDOR_ATE_3, 2)
    10.0
    >>> custo_tiquetes(TipoUsuario.SERVIDOR_MAISQ_3, 2)
    20.0
    >>> custo_tiquetes(TipoUsuario.DOCENTE, 3)
    30.0
    >>> custo_tiquetes(TipoUsuario.EXTERNO, 2)
    38.0
    '''
    if tp == TipoUsuario.ALUNO or tp == TipoUsuario.SERVIDOR_ATE_3:
        return quant * 5.0
    elif tp == TipoUsuario.SERVIDOR_MAISQ_3 or tp == TipoUsuario.DOCENTE:
        return quant * 10.0
    elif tp == TipoUsuario.EXTERNO:
        return quant * 19.0
