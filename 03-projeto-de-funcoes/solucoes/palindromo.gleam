import sgleam/check

/// Produz True se *n* tem 4 dígitos e é palíndromo, isto é, tem os mesmos
/// dígitos quando lido da direita para a esquerda ou da esquerda para a
/// direita. Produz False caso contrário.
pub fn palindromo(n: Int) -> Bool {
  // A operação (n / 1) não é necessária, mas
  // foi colocada para ilustrar como o processo é
  // generalizado para cada dígito.
  let unidade = { n / 1 } % 10
  let dezena = { n / 10 } % 10
  let centena = { n / 100 } % 10
  let milhar = { n / 1000 } % 10
  unidade == milhar && dezena == centena
}

pub fn palindromo_examples() {
  check.eq(palindromo(11), False)
  check.eq(palindromo(222), False)
  check.eq(palindromo(9119), True)
  check.eq(palindromo(1221), True)
  check.eq(palindromo(21_112), False)
}
