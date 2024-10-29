import gleam/int
import sgleam/check

pub type Aspecto {
  TresPorQuatro
  DezesseisPorNove
  Outro
}

/// A resolucação de uma imagem ou tela
pub type Resolucao {
  Resolucao(
    // Deve ser maior que 0
    altura: Int,
    // Deve ser maior que 0
    largura: Int,
  )
}

/// Calcula a quantidade de pixels (em megapixels) de uma imagem com resolução *r*.
pub fn resolucao_em_megapixels(r: Resolucao) -> Float {
  int.to_float(r.altura * r.largura) /. 1_000_000.0
}

/// Produz True se a imagem com resolução *i* pode ser exibida na tela com
/// resolução *t* sem a necessidade de rotação ou redução de tamanho Isso é, se a
/// altura da imagem é menor ou igual a altura da tela e a largura da imagem é
/// menor ou igual a largura da tela.
pub fn imagem_cabe_na_tela(i: Resolucao, t: Resolucao) -> Bool {
  i.altura <= t.altura && i.largura <= t.largura
}

// Determina o aspecto da resolução *r*.
pub fn aspecto(r: Resolucao) -> Aspecto {
  case r.altura * 3 == r.largura * 4 {
    True -> TresPorQuatro
    False ->
      case r.altura * 16 == r.largura * 9 {
        True -> DezesseisPorNove
        False -> Outro
      }
  }
}

pub fn resolucao_em_megapixels_examples() {
  check.eq(resolucao_em_megapixels(Resolucao(360, 640)), 0.2304)
  check.eq(resolucao_em_megapixels(Resolucao(1024, 768)), 0.786432)
}

pub fn imagem_cabe_na_tela_examples() {
  check.eq(imagem_cabe_na_tela(Resolucao(300, 400), Resolucao(330, 450)), True)
  check.eq(imagem_cabe_na_tela(Resolucao(330, 450), Resolucao(330, 450)), True)
  // altura não cabe
  check.eq(imagem_cabe_na_tela(Resolucao(331, 400), Resolucao(330, 450)), False)
  // largura não cabe
  check.eq(imagem_cabe_na_tela(Resolucao(330, 451), Resolucao(330, 450)), False)
}

pub fn aspecto_examples() {
  check.eq(aspecto(Resolucao(1024, 768)), TresPorQuatro)
  check.eq(aspecto(Resolucao(1080, 1920)), DezesseisPorNove)
  check.eq(aspecto(Resolucao(600, 600)), Outro)
}
