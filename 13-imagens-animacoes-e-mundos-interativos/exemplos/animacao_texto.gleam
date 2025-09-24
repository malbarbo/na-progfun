import gleam/string
import sgleam/fill
import sgleam/image
import sgleam/world

pub fn main() {
  world.animate(cena_texto)
}

fn cena_texto(tick: Int) -> image.Image {
  let texto = "computação"
  // dividimos por 10 para desacelerar a animação
  let i = tick / 10 % string.length(texto)
  let inicio = string.slice(texto, 0, i)
  let letra = string.slice(texto, i, 1)
  let fim = string.slice(texto, i + 1, string.length(texto))
  let texto =
    image.text(inicio, 30, fill.black)
    |> image.beside(image.text(letra, 30, fill.red))
    |> image.beside(image.text(fim, 30, fill.black))
  image.empty_scene(230, 50) |> image.overlay(texto)
}
