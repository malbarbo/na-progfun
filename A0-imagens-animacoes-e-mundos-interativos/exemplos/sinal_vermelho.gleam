// Sinal vermelho
//
// Exemplo de jogo multijogador.
//
// Regras
//
// - De 2 a 4 jogadores. Cada jogador tem um corredor na sua raia.
// - Um sinal alterna entre verde e vermelho a cada segundo.
// - Com o sinal verde, o corredor avança um passo; com o sinal vermelho, o
//   corredor volta para o início da raia.
// - Vence quem chegar primeiro à linha de chegada.
//
// Controles
//
// - Enter (só o jogador 1): começa a contagem para a corrida (na abertura e no
//   resultado).
// - Espaço: move o corredor (avança com o sinal verde e volta ao início com
//   o vermelho).

import gleam/int
import gleam/list
import gleam/option.{type Option, None, Some}
import sgleam/check
import sgleam/color.{type Color}
import sgleam/env.{type Env}
import sgleam/fill
import sgleam/image.{type Image}
import sgleam/key
import sgleam/mworld.{type Player}
import sgleam/stroke
import sgleam/style

// ----------------------------------------------------------------------
// Constantes
// ----------------------------------------------------------------------

/// Quantidade de passos até a linha de chegada.
const chegada = 20

/// Tamanho de um passo, em pixels.
const passo = 20

/// Altura de uma raia, em pixels.
const altura_raia = 40

/// Largura de uma raia e da tela, em pixels.
const largura = 440

/// Altura da tela, em pixels.
const altura = 300

/// Segundos da contagem antes da corrida.
const contagem = 3

// ----------------------------------------------------------------------
// Tipos de dados
// ----------------------------------------------------------------------

/// O sinal da corrida.
pub type Sinal {
  Verde
  Vermelho
}

/// O corredor do *jogador*, que está a *passos* passos do início.
pub type Corredor {
  Corredor(jogador: Player, passos: Int)
}

/// O estado do jogo.
pub type Estado {
  /// Antes da corrida. Os *segundos* que faltam para a corrida começar são
  /// None se a contagem não começou.
  Abertura(jogadores: List(Player), segundos: Option(Int))
  /// Durante uma corrida.
  Corrida(corredores: List(Corredor), sinal: Sinal)
  /// Depois de uma corrida, com os corredores na posição final.
  Resultado(corredores: List(Corredor))
}

// ----------------------------------------------------------------------
// Mundo
// ----------------------------------------------------------------------

pub fn smain() {
  mworld.create_from(inicio, 2, 4, tela)
  |> mworld.on_key_up(trata_tecla)
  |> mworld.on_tick(tique)
  |> mworld.tick_rate(1)
}

/// Cria o estado inicial com os *jogadores*.
pub fn inicio(_env: Env, jogadores: List(Player)) -> Estado {
  Abertura(jogadores, None)
}

// ----------------------------------------------------------------------
// Teclas
// ----------------------------------------------------------------------

/// Trata a *tecla* pressionada por *jogador*: Enter do jogador 1 começa a
/// contagem (abertura e resultado) e espaço move o corredor (corrida).
pub fn trata_tecla(
  estado: Estado,
  jogador: Player,
  tecla: key.Event,
) -> Estado {
  let primeiro = mworld.player_index(jogador) == 1
  case estado, tecla {
    Abertura(jogadores, None), key.Enter if primeiro ->
      comeca_contagem(jogadores)
    Resultado(corredores), key.Enter if primeiro -> recomeca(corredores)
    Corrida(corredores, sinal), key.Char(" ") ->
      move(corredores, sinal, jogador)
    _, _ -> estado
  }
}

pub fn trata_tecla_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  let fim = [Corredor(ana, 3), Corredor(bia, 20)]
  let abertura = Abertura([ana, bia], None)
  check.eq(trata_tecla(abertura, ana, key.Enter), comeca_contagem([ana, bia]))
  check.eq(trata_tecla(abertura, bia, key.Enter), abertura)
  check.eq(
    trata_tecla(Corrida(cs, Verde), bia, key.Char(" ")),
    move(cs, Verde, bia),
  )
  check.eq(trata_tecla(Corrida(cs, Verde), ana, key.Enter), Corrida(cs, Verde))
  check.eq(trata_tecla(Resultado(fim), ana, key.Enter), recomeca(fim))
  check.eq(trata_tecla(Resultado(fim), bia, key.Enter), Resultado(fim))
}

/// Começa a contagem para a corrida dos *jogadores*.
pub fn comeca_contagem(jogadores: List(Player)) -> Estado {
  Abertura(jogadores, Some(contagem))
}

pub fn comeca_contagem_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(comeca_contagem([ana, bia]), Abertura([ana, bia], Some(3)))
}

/// Começa a contagem para uma nova corrida com os jogadores dos *corredores*.
pub fn recomeca(corredores: List(Corredor)) -> Estado {
  comeca_contagem(list.map(corredores, fn(c) { c.jogador }))
}

pub fn recomeca_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(
    recomeca([Corredor(ana, 3), Corredor(bia, 20)]),
    Abertura([ana, bia], Some(3)),
  )
}

/// Move o corredor do *jogador*: com o *sinal* verde, ele avança um passo e,
/// se chegou, a corrida termina; com o vermelho, volta ao início.
pub fn move(
  corredores: List(Corredor),
  sinal: Sinal,
  jogador: Player,
) -> Estado {
  case sinal {
    Vermelho -> Corrida(muda_passos(corredores, jogador, fn(_) { 0 }), Vermelho)
    Verde -> {
      let corredores = muda_passos(corredores, jogador, fn(p) { p + 1 })
      case list.any(corredores, chegou) {
        True -> Resultado(corredores)
        False -> Corrida(corredores, Verde)
      }
    }
  }
}

pub fn move_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  // sinal verde
  check.eq(
    move(cs, Verde, ana),
    Corrida([Corredor(ana, 4), Corredor(bia, 19)], Verde),
  )
  // sinal verde e chegada
  check.eq(
    move(cs, Verde, bia),
    Resultado([Corredor(ana, 3), Corredor(bia, 20)]),
  )
  // sinal vermelho
  check.eq(
    move(cs, Vermelho, bia),
    Corrida([Corredor(ana, 3), Corredor(bia, 0)], Vermelho),
  )
}

/// Aplica *f* aos passos do corredor do *jogador*.
pub fn muda_passos(
  corredores: List(Corredor),
  jogador: Player,
  f: fn(Int) -> Int,
) -> List(Corredor) {
  list.map(corredores, fn(c) {
    case c.jogador == jogador {
      True -> Corredor(jogador, f(c.passos))
      False -> c
    }
  })
}

pub fn muda_passos_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let assert Ok(cris) = mworld.fake_player(3, "cris")
  let cs = [Corredor(ana, 3), Corredor(bia, 5)]
  check.eq(muda_passos([], ana, fn(p) { p + 1 }), [])
  check.eq(muda_passos(cs, ana, fn(p) { p + 1 }), [
    Corredor(ana, 4),
    Corredor(bia, 5),
  ])
  check.eq(muda_passos(cs, bia, fn(_) { 0 }), [
    Corredor(ana, 3),
    Corredor(bia, 0),
  ])
  check.eq(muda_passos(cs, cris, fn(_) { 0 }), cs)
}

/// Devolve True se o corredor *c* chegou à linha de chegada, False caso
/// contrário.
pub fn chegou(c: Corredor) -> Bool {
  c.passos >= chegada
}

pub fn chegou_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  check.eq(chegou(Corredor(ana, 19)), False)
  check.eq(chegou(Corredor(ana, 20)), True)
}

// ----------------------------------------------------------------------
// Tiques
// ----------------------------------------------------------------------

/// Avança o *estado* em um tique. Na abertura, se a contagem começou, ela
/// avança. Na corrida, o sinal troca de cor.
pub fn tique(estado: Estado) -> Estado {
  case estado {
    Abertura(jogadores, Some(segundos)) -> conta(jogadores, segundos)
    Corrida(corredores, sinal) -> Corrida(corredores, troca(sinal))
    _ -> estado
  }
}

pub fn tique_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  let cs = [Corredor(ana, 3), Corredor(bia, 19)]
  let fim = [Corredor(ana, 3), Corredor(bia, 20)]
  check.eq(tique(Abertura([ana, bia], None)), Abertura([ana, bia], None))
  check.eq(tique(Abertura([ana, bia], Some(2))), conta([ana, bia], 2))
  check.eq(tique(Corrida(cs, Verde)), Corrida(cs, Vermelho))
  check.eq(tique(Resultado(fim)), Resultado(fim))
}

/// Avança a contagem dos *jogadores*, que está em *segundos*. Quando chega a
/// zero, começa a corrida, com os corredores no início e o sinal verde.
pub fn conta(jogadores: List(Player), segundos: Int) -> Estado {
  case segundos {
    0 -> Corrida(list.map(jogadores, fn(j) { Corredor(j, 0) }), Verde)
    _ -> Abertura(jogadores, Some(segundos - 1))
  }
}

pub fn conta_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.eq(conta([ana, bia], 1), Abertura([ana, bia], Some(0)))
  check.eq(
    conta([ana, bia], 0),
    Corrida([Corredor(ana, 0), Corredor(bia, 0)], Verde),
  )
}

/// Troca a cor do *sinal*.
pub fn troca(sinal: Sinal) -> Sinal {
  case sinal {
    Verde -> Vermelho
    Vermelho -> Verde
  }
}

pub fn troca_examples() {
  check.eq(troca(Verde), Vermelho)
  check.eq(troca(Vermelho), Verde)
}

// ----------------------------------------------------------------------
// Desenho
// ----------------------------------------------------------------------

/// Desenha a tela do *estado* para o *jogador*.
pub fn tela(estado: Estado, jogador: Player) -> Image {
  let conteudo = case estado {
    Abertura(_, segundos) -> tela_abertura(segundos, jogador)
    Corrida(corredores, sinal) -> tela_corrida(corredores, sinal, jogador)
    Resultado(corredores) -> tela_resultado(corredores, jogador)
  }
  image.overlay(conteudo, image.rectangle(largura, altura, fill.white))
}

/// Desenha a tela de abertura para o *jogador*, com os *segundos* da
/// contagem, se ela começou.
pub fn tela_abertura(segundos: Option(Int), jogador: Player) -> Image {
  let indice = mworld.player_index(jogador)
  let aviso = case segundos {
    None if indice == 1 -> texto("Pressione Enter para começar", 20)
    None -> texto("Aguardando o jogador 1 começar", 20)
    Some(0) -> texto("Já!", 40)
    Some(s) -> texto(int.to_string(s), 40)
  }
  empilha([
    texto("Sinal vermelho", 32),
    texto("Pressione espaço para avançar com o sinal verde.", 16),
    texto("Com o sinal vermelho, você volta para o início!", 16),
    image.text("Você é " <> nome(jogador), 20, fill.with(cor(indice))),
    aviso,
  ])
}

/// Desenha a tela da corrida para o *jogador*: o *sinal* e as raias dos
/// *corredores*, com a raia do jogador destacada e a linha de chegada.
pub fn tela_corrida(
  corredores: List(Corredor),
  sinal: Sinal,
  jogador: Player,
) -> Image {
  let raias =
    empilha(list.map(corredores, fn(c) { raia(c, c.jogador == jogador) }))
  let altura_raias = image.height(raias)
  let linha = image.rectangle(2, altura_raias, fill.black)
  let raias =
    image.place_image(
      raias,
      passo / 2 + chegada * passo,
      altura_raias / 2,
      linha,
    )
  image.above(desenha_sinal(sinal), raias)
}

/// Desenha a tela de resultado dos *corredores* para o *jogador*.
pub fn tela_resultado(corredores: List(Corredor), jogador: Player) -> Image {
  let mensagem = case list.find(corredores, chegou) {
    Ok(c) if c.jogador == jogador -> "Você venceu!"
    Ok(c) -> nome(c.jogador) <> " venceu!"
    Error(_) -> "Fim da corrida!"
  }
  let aviso = case mworld.player_index(jogador) {
    1 -> "Pressione Enter para correr novamente"
    _ -> "Aguardando o jogador 1 recomeçar"
  }
  empilha([texto(mensagem, 32), texto(aviso, 20)])
}

/// Devolve o apelido do *jogador*, ou "Jogador i", em que i é o índice do
/// jogador, se o apelido é vazio.
pub fn nome(jogador: Player) -> String {
  case mworld.player_nickname(jogador) {
    "" -> "Jogador " <> int.to_string(mworld.player_index(jogador))
    apelido -> apelido
  }
}

pub fn nome_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(sem_apelido) = mworld.fake_player(2, "")
  check.eq(nome(ana), "ana")
  check.eq(nome(sem_apelido), "Jogador 2")
}

/// Desenha o *sinal*.
pub fn desenha_sinal(sinal: Sinal) -> Image {
  case sinal {
    Verde -> image.circle(20, fill.green)
    Vermelho -> image.circle(20, fill.red)
  }
}

pub fn desenha_sinal_examples() {
  check.same(desenha_sinal(Verde), image.circle(20, fill.green))
  check.same(desenha_sinal(Vermelho), image.circle(20, fill.red))
}

/// Desenha a raia do corredor *c*, com o fundo amarelo se *destaque* é True
/// e branco caso contrário.
pub fn raia(c: Corredor, destaque: Bool) -> Image {
  let fundo = case destaque {
    True -> color.lightyellow
    False -> color.white
  }
  image.rectangle(
    largura,
    altura_raia,
    style.join([fill.with(fundo), stroke.gray]),
  )
  |> image.place_image(
    passo / 2 + c.passos * passo,
    altura_raia / 2,
    image.circle(passo / 2, fill.with(cor(mworld.player_index(c.jogador)))),
  )
}

pub fn raia_examples() {
  let assert Ok(ana) = mworld.fake_player(1, "ana")
  let assert Ok(bia) = mworld.fake_player(2, "bia")
  check.same(
    raia(Corredor(bia, 0), False),
    image.rectangle(440, 40, style.join([fill.white, stroke.gray]))
      |> image.place_image(10, 20, image.circle(10, fill.orange)),
  )
  check.same(
    raia(Corredor(ana, 3), True),
    image.rectangle(440, 40, style.join([fill.lightyellow, stroke.gray]))
      |> image.place_image(70, 20, image.circle(10, fill.blue)),
  )
}

/// Devolve a cor do jogador de índice *indice*.
pub fn cor(indice: Int) -> Color {
  case indice {
    1 -> color.blue
    2 -> color.orange
    3 -> color.purple
    _ -> color.brown
  }
}

pub fn cor_examples() {
  check.eq(cor(1), color.blue)
  check.eq(cor(2), color.orange)
  check.eq(cor(3), color.purple)
  check.eq(cor(4), color.brown)
}

/// Empilha as *imagens*, a primeira no topo.
pub fn empilha(imagens: List(Image)) -> Image {
  list.fold(imagens, image.empty, image.above)
}

/// Produz uma imagem com o texto *s* em preto, com tamanho *tamanho_fonte*.
pub fn texto(s: String, tamanho_fonte: Int) -> Image {
  image.text(s, tamanho_fonte, fill.black)
}
