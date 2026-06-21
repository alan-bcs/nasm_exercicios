; Grupo 7 - Trabalho de NASM
; Integrantes: Alan, Roberto Ribeiro, Thiago Fernandes, Eric, Luan Ribeiro
;
; Tarefa 1 (Montador NASM): Exemplifique como debugar um programa em NASM
; usando um software de debug.
; Responsável: Thiago Fernandes

section .data
    msg db "Demonstracao de Debug Finalizada.", 10
    len equ $ - msg

section .text
    global _start

_start:
    ; ==========================================
    ; 1. Movimentacao e Operacoes Aritmeticas
    ; ==========================================
    mov rax, 10         ; Carrega o valor 10 no registrador rax
    mov rbx, 5          ; Carrega o valor 5 no registrador rbx
    add rax, rbx        ; rax = 10 + 5 = 15
    sub rax, 2          ; rax = 15 - 2 = 13

    ; ==========================================
    ; 2. Uso da Pilha (Stack)
    ; ==========================================
    push rax            ; Salva o valor de rax (13) no topo da pilha
    push rbx            ; Salva o valor de rbx (5) no topo da pilha

    mov rax, 0          ; Zera o registrador rax para demonstracao
    mov rbx, 0          ; Zera o registrador rbx para demonstracao

    pop rbx             ; Restaura o valor 5 para rbx (LIFO - Last In, First Out)
    pop rax             ; Restaura o valor 13 para rax

    ; ==========================================
    ; 3. Laco de Repeticao (Loop)
    ; ==========================================
    mov rcx, 5          ; Inicializa o contador do laco com 5
    mov rdx, 0          ; Inicializa rdx com 0 (atuara como acumulador)

laco_soma:
    add rdx, rcx        ; Soma o valor atual do contador (rcx) ao acumulador (rdx)
    dec rcx             ; Decrementa o contador (rcx = rcx - 1)
    cmp rcx, 0          ; Compara o contador com 0
    jg laco_soma        ; Jump if Greater: Se rcx > 0, pula de volta para 'laco_soma'

    ; ==========================================
    ; 4. Chamada de Sistema (Syscall) - Print
    ; ==========================================
    mov rax, 1          ; ID da syscall sys_write
    mov rdi, 1          ; Descritor de arquivo 1 (stdout)
    mov rsi, msg        ; Endereco da string a ser impressa
    mov rdx, len        ; Tamanho da string
    syscall             ; Executa a chamada de sistema

    ; ==========================================
    ; 5. Encerramento do Programa
    ; ==========================================
    mov rax, 60         ; ID da syscall sys_exit
    xor rdi, rdi        ; Retorna codigo 0 (sucesso)
    syscall             ; Executa a chamada de sistema