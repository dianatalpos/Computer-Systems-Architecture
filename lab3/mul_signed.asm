bits 32 ; assembling for the 32 bits architecture

;Write a program in assembly language which computes one of the following arithmetic expressions,
;considering the following domains for the variables (in the unsigned and signed representation).
; x-(a+b+c*d)/(9-a); a,c,d-byte; b-doubleword; x-qword

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        x dq 10
        b dd 3
        a db 6 
        c db 5
        d db 3


; our code starts here
segment code use32 class=code
    start:
        ; x-(a+b+c*d)/(9-a); a,c,d-byte; b-doubleword; x-qword
        xor eax, eax
        mov al, [a]   ; al = 6
        cbw
        cwde          ; eax = 6
        add eax, [b]  ; eax = 6+3 = 9
        mov ebx, eax  ; ebx = 9 
        mov al, [c]   ; al=5
        mov ah, [d]   ; ah=3
        imul ah       ; ax=15
        cwde          ; eax = 15
        add eax, ebx  ; eax = 15+9 = 24
        cdq           ; edx:eax = 24
        mov ebx, eax  ; edx:ebx = 24
        mov al, 9
        sub al, [a]   ; al = 9-6 = 3
        cbw
        cwde          ; eax = 3
        mov ecx, eax  ; ecx = 3  
        mov eax, ebx  ; edx:eax= 24
        idiv ecx      ; eax = edx:eax / ecx = 24/3 = 8
        cdq           ; edx:eax = eax = 8
        mov ebx, dword[x]
        mov ecx, dword[x+4] ; ecx:ebx= x = 10
        sub ebx, eax
        sbb ecx, edx ; ecx:ebx = 10-8 = 2 
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
