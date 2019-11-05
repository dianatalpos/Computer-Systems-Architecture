bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        


;Sa se citeasca un sir de numere intregi s1 (reprezentate pe dublucuvinte) in baza 10. 
;Sa se determine si sa se afiseze sirul s2 compus din cifrele aflate pe poziţia sutelor 
;în fiecare numar intreg din sirul s1.
;Exemplu:
;Sirul s1: 5892, 456, 33, 7, 245
;Sirul s2: 8, 4, 0, 0, 2

; Se vor citi numere pana la intalnirea lui 0.

extern exit, printf, scanf               
import exit msvcrt.dll    
import printf msvcrt.dll                        
import scanf msvcrt.dll

%include "hundredPlace.asm"

segment data use32 class=data
    msg db "Entry a number: ", 0
    n dd 0
    format2 db "%d ", 0
    format1 db "%d", 0
    s2 times 100 db 0
    len_s2 dd 0 
    msg2 db "The digits from the hundred's place of the numbers that were given are: ", 0

    
    
    ; our code starts here
segment code use32 class=code
    
    start:
        repeta:
        ; display a msg
        push dword msg
        call [printf]
        add esp, 4
        
        ;read a number
        push dword n
        push dword format1
        call [scanf]
        add esp, 4*2

        mov eax, [n]      ; daca am citit valoarea 0 iesim din citire
        cmp eax, 0
        
        je print_numbers
        
        
        ; find the digit on the hundred's position
        push dword [n]
        call hundred_Place
        add esp, 4*1
        
        mov edx, [len_s2]
        mov [s2+edx],al
        add dword[len_s2], 1
        
        jmp repeta
        
        
        print_numbers:
        
        push dword msg2
        call [printf]
        add esp, 4
        
        mov ecx, [len_s2]
        mov esi, 0
        
        
        print:
        push ecx
        mov eax, 0
        mov al, [s2+esi]
        inc esi
        
        
        push eax
        push format2
        call [printf]
        add esp, 4*2
        
        
        pop ecx
        loop print
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
