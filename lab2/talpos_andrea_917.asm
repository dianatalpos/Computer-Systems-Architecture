bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
   x db -2
   y db 5
   a db 3
   b db 1
   c db 5
   d db 7
   aw dw 5
   bw dw 4
   cw dw 7
   d2 dw 5
   a1 db 2
   b1 db 2
   c1 db 3
   d1 dw 10
   aa db 2
   bb db 3
   e dw 4
   f dw 9
; our code starts here
segment code use32 class=code
    start:
    
        ; Exercitii simple - 14
        ; -2*5   x = -2, y = 5 
         
        mov al, [x]   ; al = -2 
        imul byte [y] ; ax = -10
        
        ; Exercitiul 14 - Adunari, scaderi
        ; Byte
        ; Calculati: (a+d-c)-(b+b)  a=3 b=1 c=5 d=7
        xor eax, eax  ; eax=0
        mov al, [a]   ; al=3 
        add al, [d]   ; al=3+7=10
        sub al, [c]   ; al=10-5=5
        mov bl, [b]   ; bl=1
        add bl, [b]   ; bl=1+1=2
        sub al, bl    ; al=5-2=3
        
        ;Word
        ; Calculati: (cw+d2)+(aw-bw)+aw  aw=5  bw=4  cw=7  d2=5 
        xor eax,eax  ; eax=0
        xor ebx, ebx ; ebx=0
        mov ax, [cw] ; ax = cw = 7
        add ax, [d2] ; ax = cw+d2 = 7 + 5 = 12
        mov bx, [aw] ; bx = aw = 5
        sub bx, [bw] ; bx= aw-bw = 5 - 4 = 1
        add ax, bx ;   ax= ax + bx = 12 + 1 = 13 
        add ax, [aw] ; ax= ax + aw = 13+5 = 18
        
        ; Inmultiri, impartiri, 14
        ; a1,b1,c1-byte,d1-word
        ; Calculati : (d1-b1*c1+b1*2)/a1   a1=2  b1=2  c1=3  d1=10
        xor eax, eax   ; eax = 0
        mov al, [b1]   ; al = 2
        imul byte [c1] ; ax = al*c1 = 2*3 = 6  
        mov dx, [d1]   ; dx = 10
        sub dx, ax     ; dx = dx - ax = 10 - 6 = 4
        mov al, [b1]   ; al = 2
        mov ah, 2      ; ah = 2
        mul ah         ; ax = 4 
        add dx, ax     ; dx = dx + ax = 4+4 = 8  
        mov ax, dx     ; ax = 8 
        div byte [a1]  ; al = 8/2 = 4 
        
        ; aa,bb - byte e,f-word
        ; aa*bb*e/(f-5)  aa=2  bb=3 e=4  f=9
        xor eax, eax   ; eax = 0
        mov al, [aa]   ; al = 2 
        mov ah, [bb]   ; ah = 3
        mul ah         ; ax = 2*3 = 6 
        mul word [e]   ; ax = 6*4 = 24 
        mov bx, [f]    ; bx = 9
        sub bx, 5      ; bx = 9-5 = 4
        div bx         ; ax = 24/4 = 6
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
