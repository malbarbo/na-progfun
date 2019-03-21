.PHONY: default all pdf handout tex clean

PDF_ENGINE=pdflatex
PDF_ENGINE_OPT=
SHELL=/bin/bash
DEST=target
DEST_PDF=$(DEST)/pdfs
DEST_PDF_HANDOUT=$(DEST)/pdfs/handout
DEST_TEX=$(DEST)/tex
IGNORAR=README.md
NA=$(patsubst %/,%,$(dir $(shell ls */notas-de-aula.md)))
NA_PDF=$(addprefix $(DEST_PDF)/, $(addsuffix .pdf, $(NA)))
NA_PDF_HANDOUT=$(addprefix $(DEST_PDF_HANDOUT)/, $(addsuffix .pdf, $(NA)))
EX=$(patsubst %/,%,$(dir $(shell ls */exercicios.md)))
EX_PDF=$(addprefix $(DEST_PDF)/, $(addsuffix -exercicios.pdf, $(EX)))
PANDOC=$(DEST)/bin/pandoc
PANDOC_VERSION=2.7.1
PANDOC_CMD=$(PANDOC) \
		--pdf-engine="${PDF_ENGINE}" \
		--pdf-engine-opt="${PDF_ENGINE_OPT}" \
		--metadata-file ../metadata.yml \
		--template ../templates/default.latex \
		--standalone \
		-t beamer

default:
	@echo Executando make em paralelo [$(shell nproc) tarefas]
	@make -s -j $(shell nproc) all

all: pdf handout ex

pdf: $(NA_PDF)

handout: $(NA_PDF_HANDOUT)

ex: $(EX_PDF)

$(DEST_PDF)/%.pdf: %/notas-de-aula.md templates/default.latex metadata.yml $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF)
	@echo $@
	@cd $$(dirname $<) && \
		../$(PANDOC_CMD) \
		-o ../$@ notas-de-aula.md

$(DEST_PDF_HANDOUT)/%.pdf: %/notas-de-aula.md templates/default.latex metadata.yml $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF_HANDOUT)
	@echo $@
	@cd $$(dirname $<) && \
		../$(PANDOC_CMD) \
		-V classoption:handout \
		-o ../$@ notas-de-aula.md

$(DEST_PDF)/%-exercicios.pdf: %/exercicios.md templates/default.latex metadata.yml $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF)
	@echo $@
	@cd $$(dirname $<) && \
		../$(PANDOC_CMD) \
			-t latex \
			-V papersize=a4 \
			-V geometry='margin=1.5cm' \
			-V fontsize=11pt \
			-o ../$@ exercicios.md

$(PANDOC):
	mkdir -p $(DEST)
	curl -L https://github.com/jgm/pandoc/releases/download/$(PANDOC_VERSION)/pandoc-$(PANDOC_VERSION)-linux.tar.gz | tar xz -C $(DEST) --strip-components=1

clean:
	@echo Removendo $(DEST_PDF)
	@rm -rf $(DEST_PDF)
