<!-- vim: set spell spelllang=pt_br: -->
# CLAUDE.md

Este arquivo fornece orientações ao Claude Code (claude.ai/code) para trabalhar com este repositório.

**Toda comunicação e conteúdo deve ser em português brasileiro.**

**Sempre faça uma pergunta por vez.** Ao precisar de decisões do usuário, apresente apenas
uma delas, aguarde a resposta, e só então passe para a próxima. Nunca liste várias
perguntas ou decisões pendentes de uma só vez. Escreva a pergunta como texto normal, não
use menus de seleção de alternativas; o usuário responde por texto.

Isso vale também para os achados de uma revisão: apresente **um único achado**, com a
mudança proposta, e pergunte sobre ele. Só depois da resposta apresente o próximo. Nunca
liste vários achados de uma vez, mesmo que sejam do mesmo nível de prioridade.

## Visão geral

Notas de aula de Paradigma de Programação Funcional, em português brasileiro, usando a
linguagem [Gleam](https://gleam.run/) (via [sgleam](https://malbarbo.pro.br/sgleam/)).
Os slides são escritos em Markdown e convertidos para PDF Beamer via pandoc e tectonic.

## Comandos de build

```bash
make            # Gera tudo em paralelo (pdf + handout + zip + tex)
make pdf        # Gera slides PDF (Beamer) a partir dos arquivos markdown
make handout    # Gera PDFs em formato handout
make zip        # Empacota diretórios de exemplos e soluções
make tex        # Gera arquivos LaTeX
make clean      # Remove PDFs gerados
make clean-all  # Remove todo o diretório target/
```

As ferramentas de build (pandoc, tectonic) são baixadas automaticamente em `target/bin/`
na primeira execução.

## Verificação dos exemplos

```bash
bin/run-tests   # Executa sgleam test em todos os arquivos .gleam
```

Requer o `sgleam` no `PATH`. O `sgleam` também é usado pelo filtro
`filters/sgleam_image.lua` para gerar as imagens dos blocos ` ```sgleam_image `; sem ele,
os SVGs do capítulo A0 saem vazios e o build reclama `Error reading SVG`.

## Arquitetura

Cada capítulo é um diretório numerado (ex: `01-xxx/`, `02-yyy/`) contendo:

- `notas-de-aula.md` — slides (convertidos para PDF Beamer)
- `exercicios.md` — exercícios (convertidos para PDF A4)
- `exemplos/` — arquivos de código referenciados nos slides
- `solucoes/` — arquivos de soluções

`gen.py` varre os diretórios de capítulos e gera `target/Makefile.inc` com as regras de
build. Um diretório é reconhecido como capítulo se o terceiro caractere é `-`.

Arquivos de configuração:

- `metadata.yml` — metadados do pandoc para slides (tema Beamer, fontes, idioma)
- `metadata-ex.yml` — metadados do pandoc para PDFs de exercícios
- `templates/` — templates LaTeX (`default.beamer`, `default.latex`)
- `syntax/gleam.xml` — definição de sintaxe do Gleam para o pandoc
- `syntax/gleam-repl.xml` — sintaxe das sessões do REPL
- `syntax/sgleam.theme` — tema de cores do highlight
- `filters/sgleam_image.lua` — executa blocos ` ```sgleam_image ` e insere a imagem gerada


## Processo de revisão

Os slides servem tanto como suporte para a aula presencial quanto como material de estudo
autônomo. O professor complementa os slides verbalmente durante a aula, mas o aluno que
estuda sozinho depende apenas do que está escrito. Por isso, os slides devem ser
autocontidos o suficiente para que um aluno consiga estudar sem ter assistido à aula.

Ao revisar um capítulo:

1. Ler o `notas-de-aula.md` e `exercicios.md` completos
2. Verificar ortografia, concordância e pontuação
3. Verificar precisão conceitual e consistência dos exemplos
4. Avaliar a pedagogia: progressão das informações, clareza para estudo autônomo, conexões
   entre conceitos
5. Nos capítulos iniciais, avaliar o que pode ser compactado por já ter sido visto em
   na-programacao, e o que merece mais ênfase por ser particular da programação funcional
6. Verificar se slides de Revisão existem no formato perguntas e respostas
7. Verificar se blocos de código usam o highlight correto
8. Verificar se os exercícios estão adequados com as notas de aula e se cobrem o conteúdo
9. Apresentar os achados **um nível de prioridade por vez** (alta, depois média, depois
   baixa), aguardando o usuário avaliar e escolher o que endereçar antes de passar ao
   nível seguinte. Nunca apresentar os três níveis de uma vez, é mais difícil de avaliar
10. Aprofundar iterativamente: não parar na primeira passada superficial; quando o usuário
    pedir mais, ir além de ortografia e cobrir aspectos conceituais, pedagógicos e de
    design dos slides
11. Propor mudanças e aguardar aprovação antes de aplicar
12. Após modificar, gerar os PDFs do capítulo específico e verificar se há erros ou
    warnings:
    ```bash
    rm -f target/XX-nome-capitulo-notas-de-aula.pdf target/XX-nome-capitulo-exercicios.pdf
    make target/XX-nome-capitulo-notas-de-aula.pdf target/XX-nome-capitulo-exercicios.pdf
    ```
13. Perguntas da Revisão (slides) e do Começando (exercícios) podem cobrir os mesmos
    conceitos, mas devem ser formuladas de forma diferente: a Revisão mostra pergunta e
    resposta, os exercícios pedem que o aluno elabore ou dê exemplos
14. Antes de sugerir reorganização de conteúdo, considerar que a ordem pode ser
    intencional. Perguntar ao autor ao invés de assumir que é um problema
15. Após completar cada nível de prioridade, perguntar se o usuário quer commitar. Ao
    completar o nível seguinte, fazer amend no commit anterior. Assim o usuário pode
    revisar as mudanças de cada nível separadamente
16. Nunca commitar sem perguntar antes
