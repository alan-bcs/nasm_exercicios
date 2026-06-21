# Exercícios NASM - Grupo 7

Este repositório contém as implementações referentes ao trabalho prático da disciplina envolvendo o montador NASM. 

## Tarefas Escolhidas

De acordo com a especificação do trabalho, o grupo escolheu executar as seguintes tarefas:

1. **Pré-processador (Tarefa 4):** Construa um programa NASM que exemplifique o uso de todas as macros multilinhas vistas em sala de aula e as execute. Mostre como são expandidas.
2. **Montador NASM (Tarefa 1):** Exemplifique como debugar um programa em NASM usando um software de debug.

## Integrantes e Atividades Desenvolvidas

Conforme a divisão de tarefas escolhidas pelo grupo (Pré-processador e Montador NASM), abaixo está a tabela com as atividades desenvolvidas por cada membro:

| Integrante | Fase | Atividade Desenvolvida |
| :--- | :---: | :--- |
| **Alan** | 1 | Implementação do programa NASM com **Macros Multilinhas** (Criação de `%macro`, `%imacro`, `%rep`, `%if`, etc). |
| **Thiago Fernandes** | 1 | Implementação do programa NASM para **Demonstração de Debug**. |
| **Roberto Ribeiro** | 2 | Geração e documentação da **Expansão das Macros** (utilizando o pré-processador do NASM via `nasm -E`). |
| **Eric** | 2 | Tutorial e execução passo a passo do **Debug** do programa (utilizando o GDB para analisar registradores e memória). |
| **Luan Ribeiro** | 3 | **Revisão e Documento Final**. Compilação de todos os códigos e explicações, além da preparação dos slides/roteiro para as apresentações. |

## Como Compilar e Executar as Macros

Exemplo de compilação do código de macros multilinhas (pasta `tarefas`):
```bash
nasm -f elf64 macros.asm -o macros.o
ld macros.o -o macros
./macros
```
