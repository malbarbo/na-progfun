# vim: set ft=python:
# encoding: utf-8

import os
import subprocess
import re
import shutil
import multiprocessing
import textwrap
import yaml
import glob

DEBUG = ARGUMENTS.get('debug') == '1' 

CONF_FILE = 'conf.yaml'

# Procedimento principal que define os alvos a serem construidos
def run():
    # Build em paralelo usando o número de cpus disponíveis
    SetOption('num_jobs', multiprocessing.cpu_count())

    env = Environment()
    env.Append(BUILDERS = {'Pdf' : Builder(action = Action(build_pdf, 'Criando $TARGET'))})

    if env.GetOption('clean'):
        if os.path.exists(conf.target_dir):
            print('Removing ' + conf.target_dir)
            shutil.rmtree(conf.target_dir)
        else:
            print('Nothing to be done.')
        Exit(0)

    # Comando para gerar o arquivo de estilo do pygments
    # target, source, command
    env.Command(conf.pygments_style_file, CONF_FILE, 'bin/pygments-style "%s" > $TARGET' % (conf.pygments_style))

    # Define os alvos pdfs e suas dependências
    for s in conf.sources:
        if s.endswith('.md'):
            t = md_target_name(s)
            env.Pdf(t, get_md_dependecies(s))
            # Adiciona este alvo na lista dos alvos padrões
            Default(t)
        else:
            t = image_target_name(s)            
            _, ext = os.path.splitext(s)
            ext = ext[1:]
            if ext not in conf.converters:
                raise Exception('Don\'t know how to build: "%s" from "%s"' % (t, s))
            env.Command(t, s, conf.converters[ext])

# Converte um arquivo em pdf
def build_pdf(target, source, env):
    s = str(source[0])
    t = str(target[0])
    if s.endswith('.md'):
        convert_md(s, t)
    else:
        raise Exception('Don\'t know how to build: "%s" from "%s"' % (t, s))

# Converte o nome de um arquivo .md para um alvo .pdf
# Exemplo
#   01-introducao/notas-de-aula.md -> target/01-introducao-notas-de-aula.pdf
def md_target_name(source):
    return os.path.join(conf.target_dir, source.replace('.md', '.pdf').replace('/', '-', 1))

# Converte o nome de um imagem para um alvo .pdf
# Exemplo
#   01-introducao/images/1.png -> target/images/1.pdf
def image_target_name(source):
   basename = os.path.basename(source)
   f, ext = os.path.splitext(basename)
   return image_path(f)

# Devolve o caminho da imagem name
def image_path(name):
   return os.path.join(conf.images_target_dir, name + '.pdf')    

# Calcula as dependências para criar um .pdf a partir de um .md
def get_md_dependecies(s):
    template, _ = get_template(s)
    return [s, conf.pygments_style_file, template] + get_md_images(s)

# Devolve a lista de imagens necessárias para gerar o pdf a partir do arquivo f
def get_md_images(f):
    r = []
    with open(f) as l:
        # Exemplos de images que está regex deve casar
        #  ![Figura qualquer legal](nomefigura) -> nomefigura
        #  ![Figura 1]([width=5cm]outro-nome) -> outronome
        for m in re.finditer(r'!\[.*\]\((\[.*\])?(?P<name>.+)\)', l.read(), re.MULTILINE):
            r.append(image_path(m.group('name')))
    return r

def convert_md(s, t):
    import re
    template, opts = get_template(s)
    cmd = 'pandoc --filter bin/filter '
    cmd += '--template "%s" ' % (template)
    cmd += '-H "%s" ' % (conf.pygments_style_file)
    cmd += opts + ' '
    cmd += '"%s" ' % (s)
    if DEBUG:
        # Gerar o arquivo .tex para facilitar a deburação
        call(cmd + '-o "%s"' % (t.replace('.pdf','.tex')))
    cmd += '-o "%s"' % (t)
    call(cmd)

# Devolve o template usado em um arquivo .md e os parâmetros para serem usados
# no pandoc com este template
def get_template(f):
    with open(f) as l:
        m = re.search(r'template: (.+$)', l.read(), re.MULTILINE)
    if not m:
        raise Exception('Template not defined for', f)
    template = m.group(1)
    opts = ''
    if template in conf.template_options:
        opts = conf.template_options[template]
    return os.path.join('templates', template), opts

def call(cmd):
    if DEBUG:
        print(cmd)
    subprocess.call(cmd, shell=True)

# Le as configurações do arquivo conf.yaml
def load_conf():
    conf = yaml.load(open(CONF_FILE))
    class Conf:
        pass
    c = Conf()
    c.sources = []
    for s in conf['sources']:
        r = glob.glob(s)
        if not r:
            print('No match:', s)
            Exit(1)
        c.sources.extend(r)
    c.target_dir = conf['target_dir'] or 'target'
    c.images_target_dir = os.path.join(c.target_dir, 'images')
    c.pygments_style = conf['pygments_style'] or 'default'
    c.pygments_style_file = os.path.join(c.target_dir, 'style', 'pygments.tex')
    c.template_options = conf['template_options']
    c.converters = conf['converters']
    return c

# Chamada principal
conf = load_conf()
run()
