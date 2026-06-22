%line 7+1 macros.asm
[section .data]
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


 varA db "9. Variavel concatenada A", 10
 len_varA equ $ - varA
 varB db "9. Variavel concatenada B", 10
 len_varB equ $ - varB


 varA1 db "13. Concatenado a digito (%{1}1)", 10
 len_varA1 equ $ - varA1

[section .text]
[global _start]



%line 55+1 macros.asm


%line 60+1 macros.asm


%line 68+1 macros.asm


%line 77+1 macros.asm


%line 87+1 macros.asm



%line 97+1 macros.asm



%line 104+1 macros.asm



%line 113+1 macros.asm

%line 120+1 macros.asm



%line 126+1 macros.asm



%line 137+1 macros.asm



%line 147+1 macros.asm


%line 152+1 macros.asm



%line 158+1 macros.asm


_start:

%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, msg1
 mov rdx, len1
 syscall
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, msg2
 mov rdx, len2
 syscall
%line 164+1 macros.asm


%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, char_rep
 mov rdx, 1
 syscall
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, char_rep
 mov rdx, 1
 syscall
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, char_rep
 mov rdx, 1
 syscall
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, newline
 mov rdx, 1
 syscall
%line 167+1 macros.asm


%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, msg_linux
 mov rdx, len_linux
 syscall
%line 170+1 macros.asm


%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, msg_if
 mov rdx, len_if
 syscall
%line 82+1 macros.asm
 jmp ..@13.fim_macro
 ..@13.fim_macro:
 nop
%line 173+1 macros.asm


%line 91+1 macros.asm
 jmp ..@15.skip_data
 ..@15.str: db "6. Argumento guloso: ", "texto_1", ", texto_2", 10
 ..@15.endstr:
 ..@15.skip_data:
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, ..@15.str
 mov rdx, ..@15.endstr - ..@15.str
 syscall
%line 176+1 macros.asm


%line 101+1 macros.asm
 mov rax, 10
 add rax, 50
%line 179+1 macros.asm


 mov rax, 10
 mov rbx, 20
%line 109+1 macros.asm
 push rax
%line 109+0 macros.asm
 push rbx
%line 117+0 macros.asm
 pop rbx
 pop rax
%line 185+0 macros.asm

%line 186+1 macros.asm

%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, varA
 mov rdx, len_varA
 syscall
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, varB
 mov rdx, len_varB
 syscall
%line 189+1 macros.asm


%line 130+1 macros.asm
 cmp rax, rax
 je ..@24.imprime
 jmp ..@24.fim
..@24.imprime:
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, msg_cc
 mov rdx, len_cc
 syscall
%line 135+1 macros.asm
..@24.fim:
%line 192+1 macros.asm


%line 141+1 macros.asm
 jmp ..@26.skip
 ..@26.str: db "11. Sub-lista passou: ", 'a', 'b', 'c', 10
 ..@26.endstr:
 ..@26.skip:
%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, ..@26.str
 mov rdx, ..@26.endstr - ..@26.str
 syscall
%line 195+1 macros.asm


 mov rax, 1
%line 197+0 macros.asm
 mov rdi, 1
 mov rsi, msg_zero
 mov rdx, len_zero
 syscall
%line 198+1 macros.asm


%line 49+1 macros.asm
 mov rax, 1
 mov rdi, 1
 mov rsi, varA1
 mov rdx, len_varA1
 syscall
%line 201+1 macros.asm


 mov rax, 60
 xor rdi, rdi
 syscall
