import sgleam/check

/// O espaço que uma janela ocupa em um ambiente gráfico.
pub type Janela {
  Janela(
    // coordenada x do canto superior esquerdo
    x: Int,
    // coordenada y do canto superior esquerdo
    y: Int,
    // quantidade de pixels à direita de (x, y)
    largura: Int,
    // quantidade de pixels abaixo de (x, y)
    altura: Int,
  )
}

// A posição de um clique no ambiente gráfico.
pub type Clique {
  Clique(
    // deve ser maior que 0 e menor que a largura do ambiente
    x: Int,
    // deve ser maior que 0 e menor que a altura do ambiente
    y: Int,
  )
}

// Devolve True se o clique *c* está dentro do espaço da janela *j*, False caso contrário.
pub fn dentro_janela(j: Janela, c: Clique) -> Bool {
  j.x <= c.x
  && c.x < { j.x + j.largura }
  && j.y <= c.y
  && c.y < { j.y + j.altura }
}

pub fn dentro_janela_examples() {
  //  x = 100, y = 100, largura = 300, altura = 200
  //
  //        p5
  //      +-----------+
  //  p4  | p1        | p2
  //      |           |
  //      +-----------+
  //        p3
  let jj = Janela(x: 100, y: 100, largura: 300, altura: 200)

  // p1 - dentro da janela
  check.eq(dentro_janela(jj, Clique(x: 150, y: 150)), True)
  // p2 - dentro do espaço da altura e depois do espaço da largura
  check.eq(dentro_janela(jj, Clique(x: 600, y: 150)), False)
  // p3 - depois do espaço da altura e dentro do espaço da largura
  check.eq(dentro_janela(jj, Clique(x: 150, y: 300)), False)
  // p4 - dentro do espaço da altura e antes do espaço da largura
  check.eq(dentro_janela(jj, Clique(x: 150, y: 50)), False)
  // p5 - antes do espaço da altura e dentro do espaço da largura
  check.eq(dentro_janela(jj, Clique(x: 150, y: 50)), False)
  // canto superior esquerdo
  check.eq(dentro_janela(jj, Clique(x: 100, y: 100)), True)
  // canto superior direito
  check.eq(dentro_janela(jj, Clique(x: 399, y: 100)), True)
  check.eq(dentro_janela(jj, Clique(x: 400, y: 100)), False)
  // canto inferior direito
  check.eq(dentro_janela(jj, Clique(x: 399, y: 299)), True)
  check.eq(dentro_janela(jj, Clique(x: 400, y: 299)), False)
  check.eq(dentro_janela(jj, Clique(x: 399, y: 300)), False)
  check.eq(dentro_janela(jj, Clique(x: 400, y: 300)), False)
  // canto inferior esquerdo
  check.eq(dentro_janela(jj, Clique(x: 100, y: 299)), True)
  check.eq(dentro_janela(jj, Clique(x: 100, y: 300)), False)
}

/// Produz True se o espaço das janelas *a* e *b* se sobrepõem, False caso contrário.
pub fn janelas_soprepoem(a: Janela, b: Janela) -> Bool {
  a.x < { b.x + b.largura }
  && b.x < { a.x + a.largura }
  && a.y < { b.y + b.altura }
  && b.y < { a.y + a.altura }
}

pub fn janelas_soprepoem_examples() {
  // fixa (eixo y): a janela a vem antes da janela b
  // variável: posição da borda direita de a
  check.eq(
    janelas_soprepoem(
      Janela(x: 10, y: 20, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 210, y: 20, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 310, y: 20, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 410, y: 20, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  // fixa: (eixo y) interseção da parte de baixo de a com a parte de cima de b
  // variável: posição da borda direita de a
  check.eq(
    janelas_soprepoem(
      Janela(x: 10, y: 250, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 210, y: 250, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    True,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 310, y: 250, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    True,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 410, y: 250, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  // fixa: (eixo y) interseção da parte de cima de a com a parte de baixo de b
  // variável: posição da borda direita de a
  check.eq(
    janelas_soprepoem(
      Janela(x: 10, y: 450, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 210, y: 450, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    True,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 310, y: 450, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    True,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 410, y: 450, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  // fixa: (eixo y) a janela a vem depois da janela b
  // variável: posição da borda direita de a
  check.eq(
    janelas_soprepoem(
      Janela(x: 10, y: 550, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 210, y: 550, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 310, y: 550, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
  check.eq(
    janelas_soprepoem(
      Janela(x: 410, y: 550, largura: 100, altura: 200),
      Janela(x: 300, y: 400, largura: 50, altura: 100),
    ),
    False,
  )
}
