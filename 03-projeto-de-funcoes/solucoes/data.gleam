import gleam/string
import sgleam/check

/// Transforma *data*, do formato "dia/mes/ano" para o formato "ano/mes/dia".
/// Requer que o dia e o mês tenham dois dígitos e que o ano tenha quatro
/// dígitos.
pub fn dma_para_amd(data: String) -> String {
  let dia = string.slice(data, 0, 2)
  let mes = string.slice(data, 3, 2)
  let ano = string.slice(data, 6, 4)
  ano <> "/" <> mes <> "/" <> dia
}

pub fn dma_para_amd_examples() {
  check.eq(dma_para_amd("19/07/2023"), "2023/07/19")
  check.eq(dma_para_amd("01/01/1980"), "1980/01/01")
  check.eq(dma_para_amd("02/02/2002"), "2002/02/02")
}
