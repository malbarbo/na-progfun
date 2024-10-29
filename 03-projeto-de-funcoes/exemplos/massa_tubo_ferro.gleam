import sgleam/check

// Comprimento é um número positivo dado em metros.
// Massa é um número positivo dado em quilogramas.

const pi: Float = 3.14

// Em kg/m^2
const densidade_ferro: Float = 7874.0


/// Calcula a massa de um tubo de ferro a partir das suas dimensões
/// Requer que diametro_externo > diametro_interno.
pub fn massa_tubo_ferro(
  diametro_externo: Float,
  diametro_interno: Float,
  altura: Float,
) -> Float {
  let area_externa = area_circulo(diametro_externo /. 2.0)
  let area_interna = area_circulo(diametro_interno /. 2.0)
  let volume = { area_externa -. area_interna } *. altura
  volume *. densidade_ferro
}

fn area_circulo(raio: Float) -> Float {
  pi *. raio *. raio
}

pub fn massa_tubo_ferro_examples() {
  check.approx(massa_tubo_ferro(0.05, 0.03, 0.1), 0.9889744, 0.00000001)
}
