bits 32 

global start        


; Se dau un nume de fisier si un text (definite in segmentul 
; de date). Textul contine litere mici, litere mari, cifre si 
; caractere speciale. Sa se transforme toate literele mari din
; textul dat in litere mici. Sa se creeze un fisier cu numele
; dat si sa se scrie textul obtinut in fisier.

extern exit, printf, scanf, fopen, fclose, fread, fprintf
import exit msvcrt.dll    
import printf msvcrt.dll 
import scanf msvcrt.dll 
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fread msvcrt.dll
import fprintf msvcrt.dll


segment data use32 class=data
    file db "litere.txt", 0 
    text db "Ab cndj ASDDCCC O P  .. , ?? ", 0
    len equ $-text
    mod_acces db "w", 0
    descriptor dd -1
    text2 times len+1 db 0

segment code use32 class=code
    start:
        
        push mod_acces
        push file
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je end_program
        
        mov [descriptor], eax
        
        mov esi, text
        mov edi, text2
        cld
        mov ecx, len
        
        repeta:
        
        lodsb
        cmp al, 'A'
        jb skip
        cmp al, 'Z'
        ja skip
        
        add al, 32
        
        skip:
        stosb
        
        loop repeta
        
        
        
        
        push dword text2
        push dword [descriptor]
        call [fprintf]
        add esp, 4*1
        
        push dword[descriptor]
        call [fclose]
        add esp, 4
        
        end_program:
        push    dword 0      
        call    [exit]       
