import sgleam/fill
import sgleam/image
import sgleam/world

pub fn main() {
  world.animate(cena_ovni)
}

fn cena_ovni(tick: Int) -> image.Image {
  let ovni =
    image.circle(10, fill.green)
    |> image.overlay(image.rectangle(40, 4, fill.green))
  image.empty_scene(100, 100) |> image.place_image(50, tick, ovni)
}
