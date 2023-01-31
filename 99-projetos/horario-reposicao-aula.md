---
title: Horário de reposição de aula
# TODO: adicionar um exemplo de entrada e saída
---

Alberto é professor em uma universidade e não pôde ministrar algumas aulas, agora ele precisa repor essas aulas para cumprir a carga horária das suas disciplinas.
Ele tentou consultar os alunos sobre horários viáveis para reposição mas não obteve sucesso.
O problema é que os horários dos alunos são diferentes e nem todos os alunos comparecem ao mesmo tempo na aula para serem consultados todos de uma vez.

Para tentar contornar o problema, Alberto pediu para a universidade um relatório com os horários dos seus alunos e foi prontamente atendido.
O relatório foi disponibilizado em um arquivo texto junto com informações de como interpretar os dados do arquivo.

As informações diziam o seguinte:

- Cada linha corresponde ao horário de um aluno;
- Cada linha é composta por 5 blocos separados por espaço e cada bloco corresponde ao horário de um dia na semana na ordem: seg, ter, qua, qui, sex;
- O horário de um dia é composto por 16 caracteres (zero ou um), cada caractere correspondendo a um horário de aula. Os horários de 1 à 5 são de manhã, os horários de 6 à 12 são tarde e os horários de 13 à 16 são noite;
- O caractere 0 indica que o aluno não tem aula no horário correspondente e o caractere 1 indica que o aluno tem aula no horário.

Como exemplo, foi dado a seguinte linha

```
1111011000000000 0000000000000000 0000011110000000 0000000000000000 0011011000000000
```

Essa linha descreve o horário de um aluno que não tem aula nem na terça e nem na quinta.
Na segunda ele têm as aulas 1, 2, 3, 4, 6 e 7. Na quarta as aulas 6, 7, 8 e 9 e na sexta as aulas 2, 3, 6 e 7.

Agora o professor Alberto precisa que alguém projete um programa que faça a análise de um arquivo com os horários dos alunos e indique os possíveis horários que todos os alunos têm disponíveis.

Ele gostaria que a saída do programa indicasse os dias e os respectivos horários disponíveis.
Por exemplo, se na segunda os horários disponíveis fossem o 1 e 3 e na quinta os horários disponíveis fossem 7, 8, 9 e 13, a saída poderia ser algo como

```
seg: 1, 3
qui: 7, 8, 12, 13
```

Se não existir nenhum horário disponível para todos os alunos, então ele gostaria de ver os três horários em que o maior número tem alunos tem disponível, algo como

```
ter/10: 20 alunos
seg/1: 19 alunos
sex/2: 12 alunos
```
