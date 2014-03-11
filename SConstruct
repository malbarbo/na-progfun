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

    # Define os alvos suas dependências
    for to in conf.sources:
        for s in conf.sources[to]:
            _, ext = os.path.splitext(s)
            if is_image(s):
                target = image_target_name(s)
            else:
                target = target_name(s, to)
            # Adiciona este alvo na lista dos alvos padrões
            Default(target)
            if to == 'pdf' and ext == '.md':
                env.Pdf(target, get_md_dependecies(s))
            else: 
                ext = ext[1:]
                if ext not in conf.converters[to]:
                    raise Exception('Don\'t know how to build: "%s" from "%s"' % (target, s))
                env.Command(target, s, conf.converters[to][ext])

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
def target_name(source, target_ext):
    name, ext = os.path.splitext(source)
    name += '.' + target_ext
    return os.path.join(conf.target_dir, name.replace('/', '-', 1))

def image_target_name(source):
   basename = os.path.basename(source)
   f, _ = os.path.splitext(basename)
   return image_path(f)

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
        # Exemplos de images que esta regex deve casar
        #  ![Figura qualquer legal](nomefigura) -> nomefigura
        #  ![Figura 1]([width=5cm]outro-nome) -> outronome
        for m in re.finditer(r'!\[.*\]\((\[.*\])?(?P<name>.+)\)', l.read(), re.MULTILINE):
            r.append(image_path(m.group('name')))
    return r

def is_image(f):
    _, ext = os.path.splitext(f)
    ext = ext[1:] if ext else ext
    return ext in conf.images_ext

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
    c.sources = {}
    for t in conf['sources']:
        c.sources[t] = []
        for s in conf['sources'][t]:
            c.sources[t].extend(glob.glob(s))
    c.target_dir = conf['target_dir'] or 'target'
    c.images_target_dir = os.path.join(c.target_dir, 'images')
    c.images_ext = conf['images_ext'] or []
    c.pygments_style = conf['pygments_style'] or 'default'
    c.pygments_style_file = os.path.join(c.target_dir, 'style', 'pygments.tex')
    c.template_options = conf['template_options']
    c.converters = conf['converters']
    return c

# Chamada principal
conf = load_conf()
run()
