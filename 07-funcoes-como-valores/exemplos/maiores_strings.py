def maiores_strings(lst: list[str]) -> list[str]:
    '''
    Cria uma lista com os elementos de lst que têm tamanho
    máximo entre todos os elementos de lst.

    Exemplos
    >>> maiores_strings(['oi', 'casa', 'aba', 'boi', 'eita', 'a', 'cadê'])
    ['casa', 'eita', 'cadê']
    '''    

    def tamanho_maximo(lst: list[str]) -> int:
        return max(map(len, lst))
    
    tmax = tamanho_maximo(lst)

    def tem_tamanho_maximo(s: str) -> bool:
        return len(s) == tmax
    
    return list(filter(tem_tamanho_maximo, lst))