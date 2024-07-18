from __future__ import annotations
from dataclasses import dataclass

@dataclass
class Link:
    primeiro: int
    resto: Lista

Lista = Link | None

def soma(lst: Lista) -> int:
    '''
    Soma os valores de *lst*.
    Exemplos
    >>> soma(None)
    0
    >>> soma(Link(3, None))
    3
    >>> soma(Link(4, Link(3, None)))
    7
    >>> soma(Link(1, Link(4, Link(3, None))))
    8
    '''
    if lst is None:
        return 0
    else:
        return lst.primeiro + soma(lst.resto)
