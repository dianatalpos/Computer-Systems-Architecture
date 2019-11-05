bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        



;Se da un sir de dublucuvinte. Sa se obtina, incepand cu partea inferioara a dublucuvantului, dublucuvantul format din octetii 
;superiori pari ai cuvintelor inferioare din elementele sirului de dublucuvinte. Daca nu sunt indeajuns octeti 
;se va completa cu octetul FFh.





; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s DD 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    lens equ ($-s)/4
    d dd 0FFFFFFFFh




; our code starts here
segment code use32 class=code
    start:
        
        ;initializare:
        mov ecx, lens          ; incarcam dimensiunea sirului 
        mov esi, s+lens*4-4    ; pornim de la sfarsit sirului, de la ultimul element
        mov eax, 0
        std                    ; setam directia de parcurgere(de la sfarsit catre inceput)
                             
        repeta:
            lodsd              ; incarcam un dublucuvantul
            
            test ah, 1         ; verificam daca partea superioara a partii inferioara a dublucuvantului din eax (ah) e par 
            
            jnz skip           ; daca e par :
                shl dword [d], 8   ; mutam spre stanga un byte in dublucuvantul rezultat 
                mov byte [d], ah   ; si adaugam byte-ul din dublucuvantul initial in rezultat
           
            skip:
            
        loop repeta
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
