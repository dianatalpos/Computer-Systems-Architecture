bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    adresa_Sir db "1A",0
    len_Sir dd 2
    rezultat dd 0
    

; our code starts here
segment code use32 class=code
    start:
        mov esi, adresa_Sir
        cld
        mov ecx, [len_Sir]
        mov eax, 0
        
        
        mov ebx, 16
        mov eax, 1
        rep imul ebx
        push eax 
        
        mov ecx, [len_Sir]
        
        
        
        repeta:
    
            lodsb
            cmp al, '9'
            jl digit
            sub al, '0'
            sub al, 7
            jmp store
            digit:
            sub al, '0'
            store:
            mov edx, 0
            mov dl, al
            pop eax
            mov ebx, eax
            imul edx
            add dword[rezultat], eax
            mov eax, ebx
            mov ebx, 16
            idiv ebx
            push eax
        loop repeta
        jos:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
