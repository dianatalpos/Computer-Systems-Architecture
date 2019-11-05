bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        


extern exit, scanf, printf
import exit msvcrt.dll   
import printf msvcrt.dll    
import scanf msvcrt.dll    

%include "count_mod.asm"
                         

segment data use32 class=data
   msg db "Enter a number: ", 0
   n dd 0
   format_1 db "%d", 0
   format_2 db "The number of digits is: %d", 0
   base dd 10
   max db 100
   
   
; our code starts here
segment code use32 class=code
    ; count_digits:     ; count_digit(base, n)
        ; xor eax, eax
        ; xor edx, edx
        ; xor ebx, ebx
        
        ; mov eax, [esp+8]
        ; cdq
        ; mov ebx, [esp+4]
        
        ; mov ecx, [max]
        
        ; .count:
            
            ; div ebx          ; eax = eax:edx / ebx , edx = eax:edx % ebx
            
            
            ; cmp eax, 0
            ; je end_loop
            ; cdq
            
        ; loop .count
        
        ; end_loop:
            ; mov eax, [max]
            ; sub eax, ecx
            ; add eax, 1
        
        ; ret 4*2
    
    
    start:
        ; display a msg
        push dword msg
        call [printf]
        add esp, 4*1
        
        ; read the number
        push dword n
        push dword format_1
        call[scanf]
        add esp, 4*2
        
        
        ; count the digits
        push dword [n]
        push dword [base]
        call count_digits
        
        
        ; display the result
        push dword eax
        push dword format_2
        call [printf]
        add esp, 4*2
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
