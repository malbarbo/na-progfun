#!/usr/bin/env -S python3 -B

import os
import sys

DEST = '$(DEST)'
DEST_HANDOUT = '$(DEST)/handout'

zips = []
pdfs = []
handouts = []
texs = []

def gen_pdf(kind):
    print(f'{target}: $(PANDOC) $(TECTONIC) {cap}/{item}')
    print(f'\t@echo {target}')
    print(f'\t@mkdir -p {DEST}/handout')
    print(f'\t@cd {cap} && ../$(PANDOC_{kind}_CMD) -o ../{target} {item}')
    print()

for cap in sorted(os.listdir()):
    if not os.path.isdir(cap) or cap[2:3] != '-':
        continue
    for item in os.listdir(cap):
        if item == 'imagens':
            continue
        if os.path.isdir(f'{cap}/{item}'):
            target = f'{DEST}/{cap}-{item}.zip'
            zips.append(target)
            print(f'{target}: {cap}/{item}/*')
            print(f'\t@echo {target}')
            print(f'\t@mkdir -p {DEST}')
            print(f'\t@zip {target} -x *.swp -r {cap}/{item}')
            print()
        elif item == 'notas-de-aula.md':
            base = os.path.splitext(item)[0]
            # pdf
            target = f'{DEST}/{cap}-{base}.pdf'
            pdfs.append(target)
            gen_pdf('NOTAS')
            # handout
            target = f'{DEST_HANDOUT}/{cap}-{base}.pdf'
            pdfs.append(target)
            gen_pdf('HANDOUT')
            # tex
            target = f'{DEST}/{cap}-{base}.tex'
            texs.append(target)
            gen_pdf('NOTAS')
        elif item.endswith('md'):
            base = os.path.splitext(item)[0]
            # pdf
            target = f'{DEST}/{cap}-{base}.pdf'
            pdfs.append(target)
            gen_pdf('GERAL')
            # tex
            target = f'{DEST}/{cap}-{base}.tex'
            texs.append(target)
            gen_pdf('GERAL')
        else:
            print(f'ignorando: {cap}/{item}', file=sys.stderr)

print('pdf:', ' '.join(pdfs))
print('handout:', ' '.join(handouts))
print('tex:', ' '.join(texs))
print('zip:', ' '.join(zips))
