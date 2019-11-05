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
        xor eax, eax; eax = 0
        mov al, [c] ; al = 5
        mov ah, [d] ; ah = 3 
        mul ah      ; ax = al*ah = 15 , eax = 15
        mov ebx, [b]; ebx = 3  
        xor ecx, ecx; ecx = 0
        mov cl, [a] ; ecx= 6
        add ebx, ecx; ebx = 3+6 = 9
        add eax, ebx; eax = 15+9 = 24
        mov edx, 0  ; edx:eax = 24
        mov cl, 9
        sub cl, [a] ; cl = 9- 6 = 3
        mov ebx, 0  ; ebx = 0
        mov bl, cl  ; ebx = 3
        div ebx     ; eax = edx:eax/ebx = 24/3 = 8
        mov edx, 0  ; edx:eax = 8
        mov ebx, dword[x]
        mov ecx, dword[x+4] ; ecx:ebx = 10
        sub ebx, eax; 
        sub ecx, edx; ecx:ebx = 10-8 = 2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
