def junta_virgula_e(lst: list[str]) -> str:
    '''
    Produz uma string juntando os elementos de *lst* da seguinte forma:
    _ Se a lista é vazia, devolve "".
    _ Se a lista tem apenas um elemento, devolve esse elemento.
    _ Senão, junta as strings de lst, separando-as com ", ", com exceção da
      última string, que é separada com " e ".

    Exemplos
    >>> junta_virgula_e([])
    ''
    >>> junta_virgula_e(['maçã'])
    'maçã'
    >>> junta_virgula_e(['banana', 'maçã'])
    'banana e maçã'
    >>> junta_virgula_e(['mamão', 'banana', 'maçã'])
    'mamão, banana e maçã'
    >>> junta_virgula_e(['aveia', 'mamão', 'banana', 'maçã'])
    'aveia, mamão, banana e maçã'
    '''
    match lst:
        case []:
            return ''
        case [primeiro]:
            return primeiro
        case [primeiro, segundo]:
            return primeiro + ' e ' + segundo
        case [primeiro, *resto]:
            return primeiro + ', ' + junta_virgula_e(resto)
