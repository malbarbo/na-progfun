#lang racket

;; Esta é uma implementação do jogo flappy bird (http://flappybird.io/) escrito
;; como exemplo para a disciplina de Paradigma de Programação Lógico e
;; Funcional (http://malbarbo.pro.br/ensino/2014/5200/).
;;
;; Autor: Marco A L Barbosa <marco@malbarbo.pro.br>
;;
;; As imagens foram obtidas de 
;; http://www.spriters-resource.com/mobile_phone/flappybird/sheet/59537/
;;
;; Para executar o jogo, chame a função main.
;;
;; Os elementos básicos do jogo estão todos presentes.
;; O que precisar ser feito:
;;   - Alterar as imagens do bird, para incluir "bater as asas" e cair
;;   - Alterar as imagens dos pontos
;;   - Calibrar os parâmetros pra ficar mais parecido com o original
;;   - Melhorar a colisão. A colisão é feita como se o bird você um retângulo
;;   - Escrever testes para as funções de desenho

(require 2htdp/universe)
(require 2htdp/image)

(require rackunit)
(require rackunit/text-ui)

;;;;;;;;;;;;;;;;;;;;
;; Constantes

;; Imagens

(define BACKGROUND-IMG (bitmap "background.png"))

(define FLOOR-IMG (bitmap "floor.png"))

(define BIRD-IMG (bitmap "bird-middle.png"))

(define PIPE-TOP (bitmap "top-pipe.png"))

(define PIPE-BOTTOM (bitmap "bottom-pipe.png"))

;; World

(define WIDTH (image-width BACKGROUND-IMG))

(define HEIGHT (image-height BACKGROUND-IMG))

(define FLOOR-Y (- HEIGHT (image-height FLOOR-IMG)))

(define SPEED 1.5)

;; Bird

(define BIRD-X (* 0.35 WIDTH))

(define BIRD-WIDTH (image-width BIRD-IMG))

(define BIRD-HEIGHT (image-height BIRD-IMG))

(define BIRD-MIN-Y 0)

(define BIRD-MAX-Y (- FLOOR-Y BIRD-HEIGHT))

(define BIRD-FLY-SPEED -5)

(define BIRD-ACCELERATION 0.8)

;; Pipes

(define PIPE-WIDTH (image-width PIPE-TOP))

(define PIPE-FREQUENCY (/ WIDTH 2))

(define PIPE-SPACE (* 4 BIRD-HEIGHT))

(define PIPE-MIN-SIZE (* 3 BIRD-HEIGHT))

(define PIPE-MAX-SIZE (- FLOOR-Y PIPE-SPACE PIPE-MIN-SIZE))

;; Interface

(define SCALE 3)

(define START-MSG-IMG (text "Pressione enter para começar" 8 "black"))

(define POINTS-Y 10)

(define KEY-FLY " ")

(define KEY-START "\r")

;;;;;;;;;;;;;;;;;;;;
;; Estruturas

(struct world (state bird pipes points ticks) #:transparent)
;; Representa o estado do mundo.
;;  state : String
;;    - "created"  - o jogo foi criado mas ainda não foi iniciado pelo jogador
;;    - "running"  - o jogador iniciou o jogo e está jogando
;;    - "finished" - o jogo acabou
;;  bird  : Bird      - é o pássaro
;;  pipes : List Pipe - lista com pipes que estão no mundo
;;  points: Natural   - número de pontos feito pelo jogador, isto é a
;;                      quantidade de pipes que o jogador passou
;;  ticks : Natural   - número de ticks deste que o jogador iniciou o jogo
;;
;; Template
#;
(define (fun-for-world w)
  (... (world-status w)
       (fun-for-bird (world-bird w))
       (fun-for-list (world-pipes w))
       (world-points w)
       (world-ticks w)))

(struct bird (y speed) #:transparent)
;; Representa o pássaro no mundo
;;  y     : Integer - posição y do pássado
;;                    (a posição x é definida pela constante BIRD-X)
;;  speed : Integer - velocidade instantânea no eixo y
;;
;; Template
#;
(define (fun-for-bird b)
  (... (bird-y b)
       (bird-speed b)))

(struct pipe (x top-height bottom-height counted?) #:transparent)
;; Representa um par de tubo no mundo
;;  x            : Integer - a posição x dos tubos
;;  top-height   : Natural - o tamanho do tubo que está em cima
;;  bottom-height: Natural - o tamanho do tubo que está em baixo
;;  counted      : Boolean - true se os tubos foram contados como ponto,
;;                           false caso contrário
;;
;; Template
#;
(define (fun-for-pipe p)
  (... (pipe-x p)
       (pipe-top-height p)
       (pipe-bottom-height p)
       (pipe-counted? p)))

;; Alguns constantes usadas nos testes
(define BIRD (bird 35 5))

(define BIRD-AFTER-MOVE (bird 40 (+ 5 BIRD-ACCELERATION)))

(define BIRD-AFTER-FLY (bird 35 BIRD-FLY-SPEED))

(define BIRD-ON-FLOOR (bird BIRD-MAX-Y 10))

(define PIPE (pipe (+ BIRD-X BIRD-WIDTH 1) 20 20 #f))

(define PIPE-BIRD-TOP (pipe (+ BIRD-X 3) 45 20 #f))

(define PIPE-BIRD-BOTTOM (pipe (+ BIRD-X 3) 30 (- FLOOR-Y 37) #f))

(define PIPES (list (pipe 100 10 20 #f)
                    (pipe 300 50 70 #f)))

(define PIPES-AFTER-MOVE (list (pipe (- 100 SPEED) 10 20 #f)
                               (pipe (- 300 SPEED) 50 70 #f)))

;; Define o mundo inicial
(define INITIAL-WORLD (world "started" (bird (/ HEIGHT 2) 0) empty 0 0))


;;;;;;;;;;;;;;;;;;;;
;; Funções

;; -> World
;; Inicia o jogo.
(define (main)
  (big-bang INITIAL-WORLD
            (on-tick handle-tick)
            (on-key handle-key)
            (to-draw draw)))

;; World -> World
;; Devolve o próximo world se o jogo está em execução, caso contrário devolve o
;; mesmo world.
(define handle-tick-tests
  (test-suite
   "handle-tick tests"
   (check-equal? (handle-tick INITIAL-WORLD)
                 INITIAL-WORLD)
   (check-equal? (handle-tick (world "running" BIRD empty 0 0))
                 (world "running" BIRD-AFTER-MOVE empty 0 1))))

(define (handle-tick w)
  (if (running? w)
      (world-next w)
      w))

;; World KeyEvent -> World
;; Se o jogo está em execução, KEY-FLY faz o bird voar. KEY-START inicia ou
;; reinicia o jogo.
(define handle-key-tests
  (test-suite
   "handle-key tests"
   (check-equal? (handle-key (world "running" BIRD empty 0 0) KEY-FLY)
                 (world "running" BIRD-AFTER-FLY empty 0 0))
   (check-equal? (handle-key (world "finished" BIRD empty 0 0) KEY-START)
                 (start INITIAL-WORLD))
   (check-equal? (handle-key (world "created" BIRD empty 0 0) KEY-START)
                 (start (world "created" BIRD empty 0 0)))))

(define (handle-key w k)
  (cond
    [(and (key=? k KEY-FLY) (running? w)) (wrold-bird-fly w)]
    [(and (key=? k KEY-START) (finished? w)) (start INITIAL-WORLD)]
    [(key=? k KEY-START) (start w)]
    [else w]))

;; World -> World
;; Avança o mundo para o próximo estado. Isto inclui
;;  - incrementar os ticks e os pontos
;;  - remover, adicionar e mover os pipes
;;  - mover o bird
;;  - verificar colisão
(define (world-next w)
  (check-die
   (check-point
    (world-bird-move
     (move-pipes
      (check-add-pipe
       (check-remove-pipe
        (inc-ticks w))))))))

;; World -> World
;; Devolve um novo world com o status "finished", se o bird colidiu. Caso
;; contrário devolve o mesmo world.
(define check-die-tests
  (test-suite
   "check-die tests"
   ;; collision
   (check-equal? (check-die (world "running" BIRD-ON-FLOOR empty 0 0))
                 (world "finished" BIRD-ON-FLOOR empty 0 0))
   (check-equal? (check-die (world "running" BIRD (list PIPE-BIRD-TOP) 0 0))
                 (world "finished" BIRD (list PIPE-BIRD-TOP) 0 0))
   ;; no collision
   (check-equal? (check-die (world "running" BIRD empty 0 0))
                 (world "running" BIRD empty 0 0))))

(define (check-die w)
  (if (collision? w)
      (finish w)
      w))

;; World -> Boolean
;; Devolve true se tem uma colisão do bird com o chão ou com os tubos, false
;; caso contrário.
(define collision?-tests
  (test-suite
   "collision? tests"
   (check-equal? (collision? (world "running" BIRD empty 0 0)) #f)
   (check-equal? (collision? (world "running" BIRD-ON-FLOOR empty 0 0)) #t)
   (check-equal? (collision? (world "running" BIRD (list PIPE) 0 0)) #f)
   (check-equal? (collision? (world "running" BIRD (list PIPE PIPE-BIRD-TOP) 0 0)) #t)))

(define (collision? w)
  (define b (world-bird w))
  (define pipes (world-pipes w))  
  (or (collision-floor? b)
      (ormap (λ (p) (collision-pipe? b p)) pipes)))

;; Bird Pipe -> Boolean
;; Devolve true se b colidiu com p, false caso contrário.
(define collision-pipe?-tests
  (test-suite
   "check-die tests"
   (check-equal? (collision-pipe? BIRD PIPE) #f)
   (check-equal? (collision-pipe? BIRD PIPE-BIRD-TOP) #t)
   (check-equal? (collision-pipe? BIRD PIPE-BIRD-BOTTOM) #t)))

(define (collision-pipe? b p)
  ;; Integer Integer Integer Integer -> Boolean
  ;; Devolve true se o intervalo a b tem interseção com o intervalo c d, falso
  ;; caso contrário.
  (define (inter? a b c d)
    (or (and (a . <= . c) (c . <= . b))
        (and (a . <= . d) (d . <= . b))))
  (define (horizontal-inter?)
    (inter? BIRD-X (+ BIRD-X BIRD-WIDTH)
            (pipe-x p) (+ (pipe-x p) PIPE-WIDTH)))
  (define (vertical-inter?)
    (or (inter? (bird-y b) (+ (bird-y b) BIRD-HEIGHT)
                0 (pipe-top-height p))
        (inter? (bird-y b) (+ (bird-y b) BIRD-HEIGHT)
                (- FLOOR-Y (pipe-bottom-height p)) FLOOR-Y)))
  (and (horizontal-inter?)
       (vertical-inter?)))

;; Bird -> Boolean
;; Devolve true se b colidiu com o chão, false caso contrário.
(define collision-floor?-tests
  (test-suite
   "collision-floor? tests"
   (check-equal? (collision-floor? BIRD) #f)
   (check-equal? (collision-floor? BIRD-ON-FLOOR) #t)))

(define (collision-floor? b)
  (= BIRD-MAX-Y (bird-y b)))

;; World -> Boolean
;; Devolve um novo world com os pipes que passaram o bird marcados como
;; contados e o número de pontos alterado de acordo.
(define check-point-tests
  (test-suite
   "check-point tests"
   (let* ([p-counted (pipe (sub1 BIRD-X) 10 20 #t)]
          [p-passed (pipe (sub1 BIRD-X) 10 20 #f)]          
          [p-not-passed (pipe (add1 BIRD-X) 10 20 #f)]
          [pipes (list p-counted p-passed p-passed p-not-passed)]
          [pipes-r (list p-counted p-counted p-counted p-not-passed)])
     (check-equal? (check-point (world "running" BIRD pipes 4 0))
                   (world "running" BIRD pipes-r 6 0)))))

(define (check-point w)
  (define (passed-and-not-counted? p)
    (and (< (pipe-x p) BIRD-X)
         (not (pipe-counted? p))))
  (define (mark-counted p)
    (if (passed-and-not-counted? p)
        (struct-copy pipe
                     p
                     [counted? #t])
        p))
  (define pipes (world-pipes w))  
  (define passed (count passed-and-not-counted? pipes))  
  (struct-copy world
               w
               [pipes (map mark-counted pipes)]
               [points (+ (world-points w) passed)]))

;; World -> World
;; Devolve um novo mundo com um bird depois de voar.
(define world-bird-fly-tests
  (test-suite
   "wrold-bird-fly tests"
   (check-equal? (wrold-bird-fly (world "running" BIRD empty 0 0))
                 (world "running" BIRD-AFTER-FLY empty 0 0))))

(define (wrold-bird-fly w)
  (struct-copy world
               w
               [bird (bird-fly (world-bird w))]))

;; Bird -> Bird
;; Devolve um novo bird com speed alterado para BIRD-JUMP-SPEED.
(define bird-fly-tests
  (test-suite
   "bird-fly tests"
   (check-equal? (bird-fly BIRD)
                 BIRD-AFTER-FLY)))

(define (bird-fly b)
  (struct-copy bird
               b
               [speed BIRD-FLY-SPEED]))

;; World -> World
;; Devolve um novo mundo com um bird depois de mover.
(define move-bird-tests
  (test-suite
   "world-bird-move tests"
   (check-equal? (world-bird-move (world "running" BIRD empty 0 0))
                 (world "running" BIRD-AFTER-MOVE empty 0 0))))

(define (world-bird-move w)
  (struct-copy world
               w
               [bird (bird-move (world-bird w))]))

;; Bird -> Bird
;; Devolve um novo bird com y e speed atualizados.
(define bird-move-tests
  (test-suite
   "bird-move tests"
   (check-equal? (bird-move BIRD)
                 BIRD-AFTER-MOVE)
   ;; Não é possível diminuir a posição mínima
   (check-equal? (bird-move (bird BIRD-MIN-Y -5))
                 (bird BIRD-MIN-Y (+ -5 BIRD-ACCELERATION)))
   ;; É possível aumentar a posição mínima
   (check-equal? (bird-move (bird BIRD-MIN-Y 5))
                 (bird (+ BIRD-MIN-Y 5) (+ 5 BIRD-ACCELERATION)))
   ;; Não é possível nem aumentar e nem diminuir a posição máxima
   (check-equal? (bird-move (bird BIRD-MAX-Y 5))
                 (bird BIRD-MAX-Y 5))))

(define (bird-move b)
  (define nspeed (+ (bird-speed b) BIRD-ACCELERATION))
  (define ny (max BIRD-MIN-Y
                  (min BIRD-MAX-Y
                       (+ (bird-y b) (bird-speed b)))))
  (if (= BIRD-MAX-Y (bird-y b))
      b
      (struct-copy bird
                   b
                   [y ny]
                   [speed nspeed])))

;; -> Pipe
;; Devolve um novo pipe como top e bottom aleatório e x igual a WIDTH.
(define make-pipe-tests
  (test-suite
   "make-pipe tests"
   (let ([p (make-pipe)])
     ;; Como o pipe é criado aleatório, não temos como testar o pipe criado
     ;; Neste caso, testamos uma invariante que todo pipe deve ter
     (check-equal? (+ (pipe-top-height p) (pipe-bottom-height p) PIPE-SPACE) FLOOR-Y))))

(define (make-pipe)
  (define (rand-range min max)
    (+ min (random (- max min))))
  (define top (rand-range PIPE-MIN-SIZE PIPE-MAX-SIZE))
  (define bottom (- FLOOR-Y PIPE-SPACE top))
  (pipe WIDTH top bottom false))

;; World -> World
;; Devolve um novo mundo com um novo pipe se for necessário adicionar um novo
;; pipe, caso contrário devolve o mesmo mundo. Um novo pipe é necessário a
;; cada PIPE-FREQUENCY ticks.
(define check-add-pipe-tests
  (test-suite
   "check-add-pipe tests"
   (let* ([w-add (world "running" BIRD (list PIPE) 0 PIPE-FREQUENCY)]
          [w-add-r (check-add-pipe w-add)]          
          [w1 (world "running" BIRD (list PIPE) 0 (sub1 PIPE-FREQUENCY))]
          [w1-r (check-add-pipe w1)])
     ;; adicionou
     (check-equal? (length (world-pipes w-add-r)) 2)
     ;; não adicionou
     (check-equal? (length (world-pipes w1-r)) 1)))) 

(define (check-add-pipe w)
  (define (add-pipe pipes)
    (append pipes (list (make-pipe))))
  (define (add-pipe?)
    (zero? (remainder (world-ticks w) PIPE-FREQUENCY)))
  (if (add-pipe?)
      (struct-copy world
                   w
                   [pipes (add-pipe (world-pipes w))])
      w))

;; World -> World 
;; Devolve um novo mundo sem os tubos que não são mais visíveis.
(define check-remove-pipe-tests
  (test-suite
   "check-remove-pipe tests"
   (let* ([p-out (pipe (- (* 2 PIPE-WIDTH)) 10 20 #f)]
          [p-edge (pipe (- PIPE-WIDTH) 10 20 #f)]
          [p-half-out (pipe (- (/ PIPE-WIDTH 2)) 10 20 #f)]
          [p-in (pipe 30 10 20 #f)]
          [pipes (list p-out p-edge p-half-out p-in)]
          [pipes-r (list p-half-out p-in)])
     (check-equal? (check-remove-pipe (world "running" BIRD pipes 0 0))
                   (world "running" BIRD pipes-r 0 0)))))

(define (check-remove-pipe w)
  (define (out? p)
    (<= (+ (pipe-x p) PIPE-WIDTH) 0))
  (struct-copy world
               w
               [pipes (filter-not out? (world-pipes w))]))

;; World -> World
;; Devolve um novo mundo com todos os pipes com a posição x decrementada por
;; SPEED.
(define move-pipes-tests
  (test-suite
   "move-pipes tests"
   (check-equal? (move-pipes (world "running" BIRD PIPES 0 0))
                 (world "running" BIRD PIPES-AFTER-MOVE 0 0))))

(define (move-pipes w)
  (define (add-speed p)
    (struct-copy pipe
                 p
                 [x (- (pipe-x p) SPEED)]))
  (struct-copy world
               w
               [pipes (map add-speed (world-pipes w))]))

;; World -> World
;; Devolve um novo mundo com o número de ticks incrementado de 1.
(define inc-ticks-tests
  (test-suite
   "inc-ticks tests"
   (check-equal? (inc-ticks (world "running" BIRD empty 0 0))
                 (world "running" BIRD empty 0 1))))

(define (inc-ticks w)
  (struct-copy world
               w
               [ticks (add1 (world-ticks w))]))

;; O teste a seguir exercita as funções start, finish, running? e finished?
(define state-tests
  (test-suite
   "state tests"
   (let* ([created-w INITIAL-WORLD]
          [running-w (start created-w)]
          [finished-w (finish running-w)])
     (check-equal? (running? created-w) #f)
     (check-equal? (finished? created-w) #f)
     (check-equal? (running? running-w) #t)
     (check-equal? (finished? running-w) #f)
     (check-equal? (running? finished-w) #f)
     (check-equal? (finished? finished-w) #t))))

;; World -> Boolean
;; Devolve true se o estado do mundo é "running", false caso contrário.
(define (running? w)
  (equal? (world-state w)
          "running"))

;; World -> Boolean
;; Devolve true se o estado do mundo é "finished", false caso contrário.
(define (finished? w)
  (equal? (world-state w)
          "finished"))

;; World -> World
;; Devolve um novo mundo com o state "running".
(define (start w)
  (struct-copy world
               w
               [state "running"]))

;; World -> World
;; Devolve um novo mundo com o state "finished".
(define (finish w)
  (struct-copy world
               w
               [state "finished"]))


;;;;;;;;;;;;;;;;;;;;
;; Funções de desenho

;; World -> Image
;; Devolve o desenho do mundo.
(define (draw w)
  (define img (draw-pipes (world-pipes w)
                          (draw-bird (world-bird w)
                                     (draw-background w))))
  (define img-with-points (draw-points (world-points w) img))
  (scale SCALE
         (cond
           [(running? w) img-with-points]
           [else (underlay img-with-points START-MSG-IMG)])))

;; World Image -> Image
;; Desevolve uma imagem do fundo com o chão "andando".
(define (draw-background w)
  (define s (remainder (truncate (* SPEED (world-ticks w)))
                       (image-width FLOOR-IMG)))
  (define floor (image-shift s FLOOR-IMG))
  (underlay/align "middle" "bottom" BACKGROUND-IMG floor))

;; Bird -> Image
;; Devolve uma nova imagem com b sobre img.
(define (draw-bird b img)
  (underlay/xy img BIRD-X (bird-y b) BIRD-IMG))

;; Pipe Image -> Image
;; Devolve uma nova imagem com p sobre img.
(define (draw-pipe p img)
  (define x (pipe-x p))  
  (define top-img (crop-top (pipe-top-height p) PIPE-TOP))
  (define bottom-img (crop-bottom (pipe-bottom-height p) PIPE-BOTTOM))
  (place-image/align bottom-img
                     x FLOOR-Y
                     "left" "bottom"
                     (place-image/align top-img
                                        x 0
                                        "left" "top"
                                        img)))

;; List(Pipe) Image -> Image
;; Devolve uma nova imagem com pipes sobre img.
(define (draw-pipes pipes img)
  (foldl draw-pipe img pipes))

;; Integer Image -> Image
;; Devolve uma nova imagem com os pontos p sobre img.
(define (draw-points p img)
  (underlay/align/offset "middle" "top"
                         img
                         0 POINTS-Y
                         (text (number->string p) 20 "black")))

;; Integer Image -> Image
;; Recorta a img para ficar com altura h descartando o topo.
(define crop-top-tests
  (test-suite
   "crop-top tests"
   (check-equal? (crop-top 22 (rectangle 10 30 "solid" "red"))
                 (crop 0 8 10 22 (rectangle 10 30 "solid" "red")))))

(define (crop-top h img)
  (crop 0 (- (image-height img) h) (image-width img) h img))

;; Integer Image -> Image
;; Recorta a img para ficar com altura h descartando a base.
(define crop-bottom-tests
  (test-suite
   "crop-bottom tests"
   (check-equal? (crop-bottom 12 (rectangle 10 30 "solid" "red"))
                 (crop 0 0 10 12 (rectangle 10 30 "solid" "red")))))

(define (crop-bottom h img)
  (crop 0 0 (image-width img) h img))

;; Integer Image -> Image
;; Faz um shift de img em s pixels. Isto é, remove uma faixa de s pixels a
;; partir da esquerda e coloca na direira de img.
(define image-shift-tests
  (test-suite
   "image-shift tests"
   (let* ([i (circle 10 "solid" "red")]
          [p1 (crop 0 0 3 20 i)]
          [p2 (crop 3 0 17 20 i)]
          [r (beside p2 p1)])
     (check-equal? (image-shift 3 i) r))))

(define (image-shift s img)
  (define p1 (crop 0 0 s (image-height img) img))
  (define p2 (crop s 0 (- (image-width img) s) (image-height img) img))
  (beside p2 p1))


;;;;;;;;;;;;;;;;;;;;
;; Funções para auxiliar nos testes

;; Teste ... -> Void
;; Executa um conjunto de testes.
(define (executa-testes . testes)
  (run-tests (test-suite "Todos os testes" testes))
  (void))

;; Chama a função para executar os testes.
(executa-testes handle-tick-tests
                handle-key-tests                
                check-die-tests
                collision?-tests
                collision-pipe?-tests
                collision-floor?-tests
                world-bird-fly-tests
                bird-fly-tests
                move-bird-tests
                bird-move-tests
                check-point-tests
                check-add-pipe-tests
                check-remove-pipe-tests
                make-pipe-tests
                move-pipes-tests
                inc-ticks-tests                
                state-tests
                crop-top-tests
                crop-bottom-tests
                image-shift-tests)
