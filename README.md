# Notas de aula sobre o paradigma de programação funcional

Veja também as [notas de aula](https://github.com/malbarbo/na-proglog) sobre
o paradigma de programação lógico.

# Licença

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
  <img alt="Licença Creative Commons" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a>
<br />
<span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">
Notas de aula de Paradigma de Programação Funcional</span> de
<a xmlns:cc="http://creativecommons.org/ns#" href="http://mabarbo.pro.br" property="cc:attributionName" rel="cc:attributionURL">
Marco A L Barbosa</a>
está licenciado com uma Licença
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
Creative Commons - Atribuição-CompartilhaIgual 4.0 Internacional</a>.

# Requisitos

-   `pandoc` (>= 12), `texlive`, `texlive-fonts-extra`,
    `texlive-lang-portuguese`, `lmodern`, `latex-beamer`, `scons`,
    `python-yaml`, `python3-yaml`, `python3-pygments`,
    `python3-pip`,`inotify-tools`, `imagemagick`, `inkscape`, `pandocfilters`

# Gerar os pdfs

## Sistemas baseados no Debian

-   Habilite o repositório `testing`

    ```bash
    sudo bash -c "echo 'deb http://http.debian.net/debian/ testing main' > /etc/apt/sources.list.d/testing.list"
    ```

-   Instale as dependências

    ```bash
    sudo bin/install-debian-deps
    ```

-   Desabilite o repositório `testing`

    ```bash
    sudo rm /etc/apt/sources.list.d/testing.list
    ```

-   Gere os pdfs

    ```bash
    scons
    ```

## Outros sistemas

-   Instale o [pandoc](http://johnmacfarlane.net/pandoc/installing.html)

-   Instale o [pandocfilters](https://github.com/jgm/pandocfilters) usando o python3

-   Instale as outras dependências

-   Gere os pdfs

    ```bash
    scons
    ```

<!-- % vim: set spell spelllang=pt_br: -->
