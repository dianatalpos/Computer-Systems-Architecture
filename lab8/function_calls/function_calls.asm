bits 32 ; assembling for the 32 bits architecture

global start        

; A natural number a (a: dword, defined in the data segment) is given. Read a natural number b 
; from the keyboard and calculate: a + a/b. Display the result of this operation. 
; The values will be displayed in decimal format (base 10) with sign.


extern exit, printf, scanf              
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data
    a dd -10
    msg db "Give a natural number: ", 0
    format db "%d", 0
    msg2 db "It can't be perform a division by 0! ", 0
    b dd 0
    msg3 db "The result of %d + %d/%d is %d", 0
    
segment code use32 class=code
    start:
        ; display a message
        push msg
        call [printf]
        add esp, 4*1
        
        ; read a number
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov ebx, [b]
        cmp ebx, 0
        jne perform_operation
            push msg2             ; If b = 0 we display a msg saying that the division can't be performed
            call [printf]
            add esp, 4*1
            jmp end_program
            
        perform_operation:
            mov eax, [a]
            cdq                   ; edx:eax = a
            
            ;Divide a by b 
            
            idiv ebx              ; eax = a/b    edx = a%b
            
            ;Add a to the result 
            
            add eax, [a]          ; eax = a/b + a
            
            
            ; Display the result
            push dword eax
            push dword [b]
            push dword [a]
            push dword [a]   
            push dword msg3
            call [printf]
            add esp, 4*5
            
        end_program:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
