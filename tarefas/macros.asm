; Grupo 7 - Trabalho de NASM
; Integrantes: Alan, Roberto Ribeiro, Thiago Fernandes, Eric, Luan Ribeiro
;
; Tarefa 4 (Pré-processador): Construa um programa NASM que exemplifique o uso 
; de todas as macros multilinhas vistas em sala de aula e as execute.

section .data
    msg1 db "1. Exemplo de %macro (case-sensitive).", 10
    len1 equ $ - msg1

    msg2 db "2. Exemplo de %imacro (case-insensitive).", 10
    len2 equ $ - msg2

    msg_if db "5. Exemplo de %if e macro com labels locais (%%label).", 10
    len_if equ $ - msg_if

    char_rep db "#"

    msg_linux db "4. Condicional (%ifidn): Sistema Linux", 10
    len_linux equ $ - msg_linux

    msg_desconhecido db "4. Condicional (%ifidn): Sistema Desconhecido", 10
    len_desconhecido equ $ - msg_desconhecido

    msg_cc db "10. Condition Code (%+1) funcionou!", 10
    len_cc equ $ - msg_cc

    msg_zero db "12. Macro sem parametros (0) e com .nolist", 10
    len_zero equ $ - msg_zero

    newline db 10

    ; Usados para a macro de concatenação de texto
    varA db "9. Variavel concatenada A", 10
    len_varA equ $ - varA
    varB db "9. Variavel concatenada B", 10
    len_varB equ $ - varB

    ; Usado para a concatenação com dígito
    varA1 db "13. Concatenado a digito (%{1}1)", 10
    len_varA1 equ $ - varA1

section .text
    global _start


; 1. %macro básico
%macro print 2
    mov rax, 1          ; syscall sys_write
    mov rdi, 1          ; stdout
    mov rsi, %1         
    mov rdx, %2         
    syscall
%endmacro

; 2. %imacro (case-insensitive)
%imacro PrintInSensitivo 2
    print %1, %2
%endmacro

; 3. Estrutura de repetição (%rep e %endrep)
%macro print_char_rep 2
    %rep %2             
        print %1, 1
    %endrep
    print newline, 1
%endmacro

; 4. Condicionais baseadas em valores literais (%ifidn)
%macro check_os 1
    %ifidn %1, linux
        print msg_linux, len_linux
    %else
        print msg_desconhecido, len_desconhecido
    %endif
%endmacro

; 5. Labels Locais (%%) e condicional (%if)
%macro conditional_print 1
    %if %1 > 0
        print msg_if, len_if
        jmp %%fim_macro
    %%fim_macro:      
        nop
    %endif
%endmacro

; 6. Número variável de parâmetros (Parâmetro "guloso" via +)
; O último parâmetro agrupa todos os demais separados por vírgula.
%macro print_guloso 1+
    jmp %%skip_data
    %%str: db %1
    %%endstr:
    %%skip_data:
    print %%str, %%endstr - %%str
%endmacro

; 7. Valor default para parâmetros (ex: 1 a 2 parâmetros)
; O segundo parâmetro tem o valor default de 50.
%macro soma_com_default 1-2 50
    mov rax, %1
    add rax, %2
%endmacro

; 8. Rotação (%rotate) e Contador de parâmetros (%0)
; Permite iterar dinamicamente sobre uma quantidade infinita de parâmetros
%macro multipush 1-*
    %rep %0
        push %1
        %rotate 1
    %endrep
%endmacro

%macro multipop 1-*
    %rep %0
        %rotate -1
        pop %1
    %endrep
%endmacro

; 9. Concatenação de parâmetro a um texto
; Une o valor de %1 para formar varA e len_varA
%macro print_var 1
    print var%1, len_var%1
%endmacro

; 10. Código de Condição (CC) como parâmetro (%+1)
; %1 é a condição. Ex: 'e' vira 'je'.
%macro jump_cc 1
    cmp rax, rax       
    j%+1 %%imprime     
    jmp %%fim
%%imprime:
    print msg_cc, len_cc
%%fim:
%endmacro

; 11. Sub-lista de parâmetros (via @\{ e @\})
; Passada como um único argumento, porém contendo vírgulas internas.
%macro sublist_macro 1
    jmp %%skip
    %%str: db "11. Sub-lista passou: ", %1, 10
    %%endstr:
    %%skip:
    print %%str, %%endstr - %%str
%endmacro

; 12. Macro sem parâmetros (0) e com .nolist (Desabilita listagem da expansão)
%macro macro_zero_nolist 0.nolist
    print msg_zero, len_zero
%endmacro

; 13. Concatenação a um dígito numérico (usando %{1}1 em vez de %11)
; Se %1 for "A", concatena com "1", gerando varA1.
%macro concat_digito 1
    print var%{1}1, len_var%{1}1
%endmacro

; INÍCIO DO PROGRAMA
_start:
    ; Teste 1 e 2
    print msg1, len1
    printinsensitivo msg2, len2

    ; Teste 3 (%rep)
    print_char_rep char_rep, 3

    ; Teste 4 (%ifidn)
    check_os linux

    ; Teste 5 (%%label)
    conditional_print 1

    ; Teste 6 (Parâmetro guloso +)
    print_guloso "6. Argumento guloso: ", "texto_1", ", texto_2", 10

    ; Teste 7 (Valor default)
    soma_com_default 10 

    ; Teste 8 (%rotate e %0)
    mov rax, 10
    mov rbx, 20
    multipush rax, rbx  
    multipop rax, rbx   

    ; Teste 9 (Concatenação)
    print_var A
    print_var B

    ; Teste 10 (Condição CC)
    jump_cc e  

    ; Teste 11 (Sub-lista com chaves)
    sublist_macro {'a', 'b', 'c'}

    ; Teste 12 (Sem parâmetros e .nolist)
    macro_zero_nolist

    ; Teste 13 (Concatenação ao dígito usando %{1})
    concat_digito A

    ; Encerramento
    mov rax, 60         
    xor rdi, rdi        
    syscall
