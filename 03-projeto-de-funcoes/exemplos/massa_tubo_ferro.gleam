import sgleam/check

/// Comprimento é um número positivo dado em metros.
pub type Comprimento =
  Float

/// Massa é um número positivo dado em quilogramas.
pub type Massa =
  Float

// Na prática precisamos de mais casas decimais!
const pi: Float = 3.14

// Densidade do ferro, em kg/m^3.
const densidade_ferro: Float = 7874.0

/// Calcula a massa de um tubo de ferro a partir das suas dimensões.
/// Requer que *diametro_externo* seja maior que *diametro_interno*.
pub fn massa_tubo_ferro(
  diametro_externo: Comprimento,
  diametro_interno: Comprimento,
  altura: Comprimento,
) -> Massa {
  let area_externa = area_circulo(diametro_externo /. 2.0)
  let area_interna = area_circulo(diametro_interno /. 2.0)
  let volume = { area_externa -. area_interna } *. altura
  volume *. densidade_ferro
}

fn area_circulo(raio: Comprimento) -> Float {
  pi *. raio *. raio
}

pub fn massa_tubo_ferro_examples() {
  // -> 3.14 *. { 0.025 *. 0.025 -. 0.015 *. 0.015 } *. 0.1 *. 7874.0
  check.approx(massa_tubo_ferro(0.05, 0.03, 0.1), 0.9889744, 0.00000001)
}
