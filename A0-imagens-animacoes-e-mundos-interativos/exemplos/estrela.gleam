import sgleam/fill
import sgleam/image

pub fn smain() {
  image.star(40, fill.firebrick)
  |> image.to_svg()
}
