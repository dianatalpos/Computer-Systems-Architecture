bits 32 

global start        


;Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze 
;in urmatorul format: "<a> * <b> = <result>"
;Exemplu: "2 * 4 = 8"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.

extern exit, printf, scanf
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    format2 db "%d * %d = %d", 0
    msg db "Introduceti un numar:", 0
    format db "%d", 0
    
segment code use32 class=code
    start:
        
        
        push dword msg
        call [printf]
        add esp, 4*1
        
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        push dword msg
        call [printf]
        add esp, 4*1
        
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        
        mov eax, [a]
        mov ebx, [b]
        imul ebx
        
        push eax
        push dword [b]
        push dword [a]
        push format2
        call [printf]
        add esp, 4*3
        
        
        
        push    dword 0      
        call    [exit]       
