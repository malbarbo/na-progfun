def junta_virgula_e(lst: str) -> str:
    '''
    Produz uma string juntando os elementos de *lst* da seguinte forma:
    _ Se a lista é vazia, devolve "".
    _ Se a lista tem apenas um elemento, devolve esse elemento.
    _ Senão, junta as strings de lst, separando_as com ", ", com exceção da
      última string, que é separada com " e ".

    Exemplos
    >>> junta_virgula_e([])
    ''
    >>> junta_virgula_e(['maça'])
    'maça'
    >>> junta_virgula_e(['mamão', 'banana', 'maça'])
    'mamão, banana e maça'
    >>> junta_virgula_e(['aveia', 'mamão', 'banana', 'maça'])
    'aveia, mamão, banana e maça'
    '''
    match lst:
        case []:
            return ''
        case [primeiro]:
            return primeiro
        case [primeiro, segundo]:
            return primeiro + ' e ' + segundo
        case _:
            return lst[0] + ', ' + junta_virgula_e(lst[1:])
