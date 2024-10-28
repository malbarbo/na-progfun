import sgleam/check

/// Calcula a área de um retângulo com dimensões *largura* x *altura*.
pub fn area_retangulo(largura: Float, altura: Float) -> Float {
  largura *. altura
}

pub fn area_retangulo_examples() {
  check.eq(area_retangulo(3.0, 5.0), 15.0)
  check.eq(area_retangulo(2.0, 2.5), 5.0)
}
