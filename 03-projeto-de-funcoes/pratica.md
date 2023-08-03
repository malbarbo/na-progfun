---
# vim: set spell spelllang=pt_br sw=4:
title: Projeto de funções - Prática
urlcolor: Blue
---

#. Reveja o material de [projeto de funções](https://malbarbo.pro.br/arquivos/2023/11917/03-projeto-de-funcoes-notas-de-aula.pdf) e responda [esse](https://forms.gle/askYNranaxiDhv4aA) quiz (não vale nota).

#. Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; InteiroPositivo -> Boolean
    ;;
    ;; Produz #t se uma pessoa com idade id é isento da
    ;; tarifa de transporte público, isto é, tem menos
    ;; que 18 anos ou 65 ou mais. Produz #f caso contrário.

    (examples
     (check-equal? (insento-tarifa? 17) #t)
     (check-equal? (insento-tarifa? 18) #t)
     (check-equal? (insento-tarifa? 50) #f)
     (check-equal? (insento-tarifa? 65) #t)
     (check-equal? (insento-tarifa? 70) #t))

    (define (insento-tarifa? id)
      #f)
    ```

#. Implemente a função de acordo com a especificação a seguir. Corrija a especificação se necessário.

    ```scheme
    ;; Inteiro -> Inteiro
    ;;
    ;; Conta a quantidade de dígitos de n.
    ;; Se n é 0, então devolve zero.
    ;; Se n é menor que zero, então devolve a quantidade
    ;; de dígitos do valor absoluto de n.

    (examples
     (check-equal? (quantidade-digitos 121) 3)
     (check-equal? (quantidade-digitos 0) 1)
     (check-equal? (quantidade-digitos -1519) 4))

    (define (quantidade-digitos n)
      0)
    ```

#. Escreva a especificação para a seguinte implementação de função. Observe que a especificação sozinha deve ser suficiente para um programador fazer uma implementação.

    ```scheme
    (define (qualificacao num-questoes num-acertos faltas)
      (define aproveitamento (/ num-acertos num-questoes))
      (cond
        [(or (< aproveitamento 0.3) (> faltas 0.25)) "reprovado"]
        [(< aproveitamento 0.6) "nova-tentativa"]
        [else "aprovado"]))
    ```

#. Um banco emprega diferentes taxas de correção anual para um investimento dependendo do valor aplicado no início de cada    ano. Para valores até R$ 2000 a taxa de correção é de 10%, para valores entre R$ 2000 e R$ 5000 a taxa de correção é de 12%,  para valores maiores que R$ 5000 a taxa de correção é de 13%. Projete uma função que calcule quanto um investimento realizado no início do ano irá render após dois anos aplicados no banco.

#. Rotacionar uma string `n` posições a direita significa mover os últimos `n` caracteres da string para as primeiras `n` posições da string. Por exemplo, rotacionar a string `"marcelio"`{.python} 5 posições a direita produz a string `"celiomar"`{.python}. Projete uma função que receba como entrada uma string e um número `n` e produza uma nova string rotacionando a string de entrada `n` posições a direita.

#. Você está fazendo um programa e precisa verificar se um texto digitado pelo usuário está de acordo com algumas regras. A   regra “sem espaços extras” requer que o texto não comece e não termine com espaços. Projete uma função que verifique se um   texto qualquer está de acordo com a regra “sem espaços extras”.

#. Faça a execução passo a passo das funções definidas nos exercícios anteriores para alguns exemplos. Para isto você deve criar um novo arquivo, mudar a linguagem para "Beginning Student" e copiar o código da função e da chamada de exemplo.
