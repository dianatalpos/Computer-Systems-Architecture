bits 32 ; assembling for the 32 bits architecture



;Write a program in assembly language which computes one of the following arithmetic expressions,
;considering the following domains for the variables (in the unsigned and signed representation).
;a - byte, b - word, c - double word, d - qword
;(b-a+c-d)-(d+c-a-b)



; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        a db 2
        b dw 6
        c dd 10
        d dq 3
        
        
; our code starts here
segment code use32 class=code
    start:
        ;a - byte, b - word, c - double word, d - qword
        ;(b-a+c-d)-(d+c-a-b)
        xor eax, eax ; eax = 0
        mov al, [a]
        cbw
        mov bx, [b]
        sub bx, ax  ; bx = b-a = 6-2 = 4
        mov ax, bx  ; ax = bx = 4
        cwde        ; eax = ax = 4
        mov ebx, [c]; ebx = 10
        add eax, ebx; eax = 4+10 = 14
        cdq         ; edx:eax = eax = 14
        mov ebx, dword [d]
        mov ecx, dword [d+4] ; ecx:ebx = 3
        sub eax, ebx 
        sbb edx, ecx ; edx:eax = 14-3 = 11
        mov ebx, eax 
        mov ecx, edx ; ecx:ebx = edx:eax = 11 
        mov al, [a]
        cbw
        cwde         ; eax = a = 2
        mov edx, [c] ; edx = c = 10
        sub edx, eax ; edx = 10-2 = 8
        mov ax, [b]
        cwde         ; eax = 6
        sub edx, eax ; edx = 8-6 = 2
        mov eax, edx ; eax = 2
        cdq          ; edx:eax = 2
        add eax, dword [d]
        adc edx, dword [d+4] ; edx:eax = 2+3=5
        
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx = 11-5 = 6
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
