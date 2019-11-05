bits 32 ; assembling for the 32 bits architecture



;Write a program in assembly language which computes one of the following arithmetic expressions, 
;considering the following domains for the variables (in the unsigned and signed representation)
;    d-b+a-(b+c)
;  a - byte, b - word, c - double word, d - qword




; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b dw 3
    c dd 6
    d dq 20
; our code starts here
segment code use32 class=code
    start:
        ;d-b+a-(b+c)   // a - byte, b - word, c - double word, d - qword
        
        xor eax, eax ; eax = 0
      
        mov eax, dword [d]
        mov edx, dword [d+4] ; edx:eax = 20
        mov ebx, 0
        mov ecx, 0 
        mov bx, [b]  ; ecx:ebx = 3
        sub eax, ebx ; edx:eax = d - b = 20 - 3 = 17 
        mov ecx, 0   ; ecx = 0
        mov ebx, 0   ; ebx = 0
        mov bl, byte[a] ; ecx:ebx=2
        add eax, ebx ; edx:eax = 17 + 2 = d-b+a = 19
        mov ecx, 0 ; ecx = 0
        mov ebx, 0 ; ebx = 0
        mov ebx, [c] ; ebx = 6
        mov cx , [b] ; ecx = 3 
        add ebx, ecx ; ebx = c+b = 6+3=9
        mov ecx, 0   ; ecx:ebx = 9
        sub eax, ebx ; edx:eax = d-b+a-(c+b)=19-9=10  
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
