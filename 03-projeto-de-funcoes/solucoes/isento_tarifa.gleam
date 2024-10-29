import sgleam/check

/// Produz True se uma pessoa com *idade* é isento da tarifa de transporte
/// público, isto é, tem menos que 18 anos ou 65 ou mais. Produz False caso
/// contrário.
pub fn isento_tarifa(idade: Int) -> Bool {
  idade < 18 || idade >= 65
}

pub fn isento_tarifa_examples() {
  check.eq(isento_tarifa(17), True)
  check.eq(isento_tarifa(18), False)
  check.eq(isento_tarifa(50), False)
  check.eq(isento_tarifa(65), True)
  check.eq(isento_tarifa(70), True)
}
