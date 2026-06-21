; Grupo 7 - Trabalho de NASM
; Integrantes: Alan, Roberto Ribeiro, Thiago Fernandes, Eric, Luan Ribeiro

; Tarefa 4 (Pré-processador): Construa um programa NASM que exemplifique o uso 
; de todas as macros multilinhas vistas em sala de aula e as execute.

section .data
    msg1 db "Exemplo de %macro (case-sensitive).", 10
    len1 equ $ - msg1

    msg2 db "Exemplo de %imacro (case-insensitive).", 10
    len2 equ $ - msg2

    msg_if db "Exemplo de %if e macro com labels locais (%%label).", 10
    len_if equ $ - msg_if

    char_rep db "#"

    msg_linux db "Sistema Linux (condicional %ifidn)", 10
    len_linux equ $ - msg_linux

    msg_windows db "Sistema Windows", 10
    len_windows equ $ - msg_windows

    msg_desconhecido db "Sistema Desconhecido", 10
    len_desconhecido equ $ - msg_desconhecido

    newline db 10

section .text
    global _start


; 1. %macro básico
; Imprime uma string genérica na saída padrão (stdout)
; Parâmetros: %1 = endereço da string, %2 = tamanho da string

%macro print 2
    mov rax, 1          ; syscall para sys_write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, %1         ; endereço da string
    mov rdx, %2         ; tamanho da string
    syscall
%endmacro


; 2. %imacro (case-insensitive)
; O nome da macro pode ser escrito com letras maiúsculas ou minúsculas

%imacro PrintInSensitivo 2
    print %1, %2
%endmacro

; 3. %macro com estrutura de repetição (%rep e %endrep)
; Repete a impressão de um caracter
; Parâmetros: %1 = endereço do caracter, %2 = quantidade de repetições

%macro print_char_rep 2
    %rep %2             ; Inicia o loop de repetição no pré-processador
        print %1, 1
    %endrep
    print newline, 1
%endmacro

; 4. %macro com condicionais baseadas em valores literais (%ifidn)
; Verifica se o parâmetro fornecido é igual à string "linux"

%macro check_os 1
    %ifidn %1, linux
        print msg_linux, len_linux
    %elifidn %1, windows
        print msg_windows, len_windows
    %else
        print msg_desconhecido, len_desconhecido
    %endif
%endmacro

; 5. %macro com Labels Locais (%%) e condicional (%if)
; Imprime a mensagem apenas se a flag passada for maior que 0
; Parâmetros: %1 = flag

%macro conditional_print 1
    %if %1 > 0
        print msg_if, len_if
        jmp %%fim_macro
    %%fim_macro:      ; Label local válida apenas dentro da macro
        nop
    %endif
%endmacro


; INICIO DO PROGRAMA

_start:
    ; Teste 1: %macro (case-sensitive)
    print msg1, len1

    ; Teste 2: %imacro (case-insensitive - invocando tudo minúsculo)
    printinsensitivo msg2, len2

    ; Teste 3: %rep (imprimindo 5 vezes o '#')
    print_char_rep char_rep, 5

    ; Teste 4: Condicionais strings (%ifidn, %elifidn, %else)
    check_os linux
    check_os windows
    check_os macos

    ; Teste 5: %if e label local (%%label)
    conditional_print 1
    conditional_print 0     ; Não deve imprimir nada pois 0 > 0 é falso

    ; Encerramento do programa
    mov rax, 60         ; syscall sys_exit
    xor rdi, rdi        ; exit code 0
    syscall
