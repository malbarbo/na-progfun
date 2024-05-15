.PHONY: default all pdf zip handout tex clean clean-all atualiza-template

DEST=target

TECTONIC=$(DEST)/bin/tectonic
TECTONIC_VERSION=0.9.0

PANDOC=$(DEST)/bin/pandoc
PANDOC_VERSION=3.2

PANDOC_NOTAS_CMD=$(PANDOC) \
		-V mathspec \
		--from markdown-auto_identifiers \
		--pdf-engine=$(CURDIR)/$(TECTONIC) \
		--metadata-file ../metadata.yml \
		--template ../templates/default.latex \
		--to beamer \
		--standalone

PANDOC_HANDOUT_CMD=$(PANDOC_NOTAS_CMD) \
		-V classoption:handout \
		--to beamer

PANDOC_GERAL_CMD=$(PANDOC_NOTAS_CMD) \
		--to latex \
		--metadata-file ../metadata-ex.yml \
		-V papersize=a4 \
		-V geometry='margin=1.5cm' \
		-V fontsize=11pt

default:
	@echo Executando make em paralelo [$(shell nproc) tarefas]
	@make -s -j $(shell nproc) all

all: pdf handout zip tex

$(DEST)/Makefile.inc: gen.py
	@echo Gerando $(DEST)/Makefile.inc
	@mkdir -p $(DEST)
	@./gen.py > $(DEST)/Makefile.inc

$(PANDOC):
	mkdir -p $(DEST)
	curl -L https://github.com/jgm/pandoc/releases/download/$(PANDOC_VERSION)/pandoc-$(PANDOC_VERSION)-linux-amd64.tar.gz \
		| tar xz -C $(DEST) --strip-components=1

$(TECTONIC):
	mkdir -p $(DEST)/bin/
	curl -L https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic@$(TECTONIC_VERSION)/tectonic-$(TECTONIC_VERSION)-x86_64-unknown-linux-musl.tar.gz \
		| tar xz -C $(DEST)/bin/

atualiza-template:
	pandoc --print-default-template=beamer > templates/default.latex

clean:
	@echo Removendo $(DEST)/*.pdf
	@rm -rf $(DEST)/*.pdf

clean-all:
	@echo Removendo $(DEST) Makefile.inc
	@rm -rf $(DEST)

include $(DEST)/Makefile.inc
