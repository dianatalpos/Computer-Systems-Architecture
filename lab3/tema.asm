bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5
    b db 4
    c db 1
    d db 2
    a1 dw 10
    b1 dw 2
    c1 dw 5
    d1 dw 1
    x db 6
    y db 4
    z db -1
    u dw 3
    aa db 2
    bb db 5
    g dw 16
; our code starts here
segment code use32 class=code
    start:
        ; exercitii simple- 13. 2+8
        mov al, 2 ; al=2
        add al, 8 ; al=al+8
        
        ; adunari scaderi- 13
        ;byte- 13.a+b-c+d-(a-d)
        
        xor eax, eax ; eax=0
        mov al, [a]  ; al=5        
        add al, [b]  ; al=5+4=9
        sub al, [c]  ; al=9-1=8
        add al, [d]  ; al=8+2=10
        mov ah, [a]  ; ah=5
        sub ah, [d]  ; ah=5-2=3
        sub al, ah   ; al=10-3=7
        
        ; word- 13.(a1+a1-c1)-(b1+b1+d1)
        
        xor eax, eax ; eax=0
        mov ax, [a1] ; ax=10
        add ax, [a1] ; ax=10+10=20
        sub ax, [c1] ; ax=20-5=15
        mov bx, [b1] ; bx=2
        add bx, [b1] ; bx=2+2=4
        add bx, [d1] ; bx=4+1=5
        sub ax, bx   ; ax=15-5=10
        
        ; Inmultiri impartiri
        ; x,y,z- byte u-word
        ; 13.[(x*y)-u]/(y+z)
        
        xor eax, eax
        mov al, [x]    ; al=6
        imul byte [y]  ; ax=6*4=24
        sub ax, [u]    ; ax=24-3=21
        mov bl, [y]    ; bl=4
        add bl, [z]    ; bl=4+(-1)=3
        idiv bl        ; al=21:3=7
        
        ;aa,bb-byte , g-word
        ;13.(g+5)-aa*bb
        
        xor eax, eax   ; eax=0
        mov al, [aa]   ; al=2
        imul byte [bb] ; ax=2*5=10
        mov bx, [g]    ; bx=16
        add bx, 5      ; bx=16+5=21
        sub bx, ax     ; bx=21-10=11
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
