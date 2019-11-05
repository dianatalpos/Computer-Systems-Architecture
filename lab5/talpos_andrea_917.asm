bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        


;Se da un sir de octeti S. Sa se construiasca un sir D1 care sa contina toate numerele 
;pozitive si un sir D2 care sa contina toate numerele negative din S. 


; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 3, -5, -2, 3, -8, 5, 0
    lens equ $-s
    d1 times lens db 0       ; rezervam numarul de bytes din sirul sursa pentru sirurile rezultat
    lend1 db 0
    d2 times lens db 0
    lend2 db 0

; our code starts here
segment code use32 class=code
    start:
        
        ;initializare:
        mov ecx, lens
        mov esi, 0

        jecxz end_program   ; verificam ca ecx sa nu fie 0
        
        repeta:
            mov dh, [s+esi]  ; mutam in dh elementul curent din sirul s
            mov dl, 0        ; dl = 0
            
            cmp dh, dl       ; comparam elem curent cu 0
            
            jge pozitiv      ; daca elementul este pozitic => pozitiv:
            
            mov edi, 0       ; retinem in edi numarul de elemente din sirul elem negative pana la acest pas 
            mov al, [lend2]
            cbw
            cwde
            mov edi, eax
            
            mov [d2+edi], dh ; mutam in sirul rezultat elementul din s
            inc byte[lend2]  ; crestem dimensiunea sirului d2
            
            pozitiv:         ; daca numarul este pozitiv:  
                
                cmp dh,dl    ; comparam din nou 0 si elementul curent din s 
                             ; pentru a executa pasii doar pentru numerele pozitive 
                
                jl verificat 
                
                mov edi, 0   ; retinem pozitia curenta din sirul rezultat al numerelor pozitive
                mov al, [lend1] ; in care trebuie adaugat elementul
                cbw
                cwde
                mov edi, eax
                
                
                mov  [d1+edi], dh  ; adaugam elementul
                inc byte[lend1]    ; incrementam lungimea sirului
            
            verificat:
            
            inc esi   ; trecem la urmatorul element din sir 
            
        loop repeta
        
        
        
        
        
        end_program:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
