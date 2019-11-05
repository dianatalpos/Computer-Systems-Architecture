bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

;Se dau cuvantul A si octetul B. Sa se obtina dublucuvatul C:
;bitii 0-3 ai lui C au valoarea 1
;bitii 4-7 ai lui C coincid cu bitii 0-3 ai lui A
;bitii 8-13 ai lui C au valoarea 0
;bitii 14-23 ai lui C coincid cu bitii 4-13 ai lui A
;bitii 24-29 ai lui C coincid cu bitii 2-7 ai lui B
;bitii 30-31 au valoarea 1

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 1001101110111110b
    b db 01010111b
    c dd 0
    
    
; our code starts here
segment code use32 class=code
    start:
        mov ebx, 0 ; Rezultatul il vom avea in ebx
        
        or ebx, 00000000000000000000000000001111b ; bitii 0-3 ai lui C au valoarea 1
        
        mov eax , 0
        mov ax, [a]
        and ax, 0000000000001111b ;  obtinem bitii 0-3 ai cuvantului a in ax
        mov cl, 4
        shl eax, cl   ; shiftam eax pentru a obtine pe pozitiile 4-7 bitii 0-3 din a 
        or ebx, eax   ; in ebx pe pozitiile 4-7 vom avea bitii 0-3 din ai
        
        and ebx, 11111111111111111100000011111111b ; in ebx facem bitii 8-13 0
        
        mov eax, 0
        mov ax, [a]
        and eax , 00000000000000000011111111110000b ; retinem bitii 4-13 ai lui a         
        mov cl, 10
        shl eax, cl  ; mutam bitii 4-13 din a pe pozitiile 14-23
        or ebx, eax  ; punem bitii in rezultat
        
        mov eax, 0   
        mov al, [b]   ; in eax vom avea bitii lui b
        and eax, 00000000000000000000000011111100b  ; retinem bitii 2-7 ai lui b
        mov cl, 22
        shl eax, cl  ; mutam bitii 2-7 pe pozitiile 24-29
        or ebx, eax  ; punem bitii in rezultat
        
        or ebx, 11000000000000000000000000000000b ; in ebx se afla rezultatul
        
        mov [c], ebx  ; mutam rezultatul in c 
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
