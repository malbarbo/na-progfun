import gleam/float
import gleam/result
import sgleam/check

const pi = 3.14

pub type Figura {
  Retangulo(largura: Float, altura: Float)
  Circulo(raio: Float)
}

// Calcula a área de *fig*.
pub fn area(fig: Figura) -> Float {
  case fig {
    Retangulo(largura, altura) -> largura *. altura
    Circulo(raio) -> pi *. raio *. raio
  }
}

pub fn area_examples() {
  check.eq(area(Retangulo(3.0, 4.0)), 12.0)
  check.eq(area(Circulo(2.0)), 12.56)
}

// Produz True se a figura *a* cabe dentro da figura *b*, False caso contrário.
//
// A seguinte tabela mostra as condições para que a figura *a* caiba dentro da
// figura *b*. Se *a* é um retângulo. então *da* é a sua diagonal, senão é seu
// diâmetro.
//
// fig a \ fig b     |   Retangulo(lb, ab)      | Circulo(rb)
// ------------------|--------------------------|---------------
// Retangulo(la, aa) |  la <= lb e aa <= ab     |  da <= 2 * rb
// Circulo(ra)       |  2*ra <= lb e 2*ra <= ab |  ra <= rb

pub fn cabe_examples() {
  // retangulo x retangulo
  check.eq(cabe(Retangulo(5.0, 18.0), Retangulo(10.0, 20.0)), True)
  check.eq(cabe(Retangulo(10.0, 20.0), Retangulo(10.0, 20.0)), True)
  // largura não cabe
  check.eq(cabe(Retangulo(11.0, 20.0), Retangulo(10.0, 20.0)), False)
  // altura não cabe
  check.eq(cabe(Retangulo(10.0, 21.0), Retangulo(10.0, 20.0)), False)
  // retangulo (diagonal 5) x circulo
  check.eq(cabe(Retangulo(3.0, 4.0), Circulo(3.0)), True)
  check.eq(cabe(Retangulo(3.0, 4.0), Circulo(2.5)), True)
  check.eq(cabe(Retangulo(3.0, 4.0), Circulo(2.4)), False)
  //circulo x retangulo
  check.eq(cabe(Circulo(2.0), Retangulo(4.0, 4.0)), True)
  check.eq(cabe(Circulo(2.0), Retangulo(4.0, 4.0)), True)
  // não cabe na largura
  check.eq(cabe(Circulo(2.0), Retangulo(3.0, 4.0)), False)
  // não cabe na altura
  check.eq(cabe(Circulo(2.0), Retangulo(4.0, 3.0)), False)
  // circulo x circulo
  check.eq(cabe(Circulo(2.0), Circulo(3.0)), True)
  check.eq(cabe(Circulo(3.0), Circulo(3.0)), True)
  check.eq(cabe(Circulo(4.0), Circulo(3.0)), False)
}

pub fn cabe(a: Figura, b: Figura) -> Bool {
  case a, b {
    Retangulo(la, aa), Retangulo(lb, ab) -> la <=. lb && aa <=. ab
    Retangulo(la, aa), Circulo(rb) -> {
      let da = result.unwrap(float.square_root(la *. la +. aa *. aa), 0.0)
      da <=. 2.0 *. rb
    }
    Circulo(ra), Retangulo(lb, ab) -> {
      let da = 2.0 *. ra
      da <=. lb && da <=. ab
    }
    Circulo(ra), Circulo(rb) -> ra <=. rb
  }
}
