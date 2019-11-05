bits 32 

global start        

;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se 
;afiseze acea cifra impreuna cu frecventa acesteia. Numele fisierului text este definit in segmentul de date.


extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll    
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fread msvcrt.dll 
import printf msvcrt.dll 

segment data use32 class=data
    file db "nr.txt", 0 
    mod_acces db "r+", 0
    descriptor dd -1
    len equ 100
    text times len+1 db 0
    nr_caract dd 0
    sir resb 10
    fr_max dd 0
    cif_max dd 0
    format db "Cifra maxima: %d, numar aparitii: %d",0
    
    
segment code use32 class=code
    start:
        
        
        push dword mod_acces
        push dword file
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax 
        
        cmp eax, 0
        je end_program
        
        
        citire:
        
        push dword[descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        cmp eax, 0
        je end_read
        
        add [nr_caract], eax
        
        
        mov esi, text
        cld
        mov ecx, eax
        
        cifre:
        
        lodsb
        
        cmp al, '0'
        jb skip
        cmp al, '9'
        ja skip
        
        mov ebx, 0
        mov bl, al
        sub bl, '0'
        
        add byte[sir+ebx], 1
        
        
        
        skip:
        
        loop cifre 
        jmp citire
        
        
        end_read:
        
        
        mov ecx, 10
        mov esi, sir
        cld
        
        fr:
        
        push ecx
        mov eax, 0
        lodsb
        cmp eax, [fr_max]
        jle skip2
        
        mov [fr_max], eax
        mov ebx, 10
        sub ebx, ecx
        mov [cif_max], ebx
        
        
        skip2:
        pop ecx
        loop fr
        
        
        push dword [fr_max]
        push dword [cif_max]
        push dword format
        call [printf]
        add esp, 4*3
        
        
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        end_program:
        
        push    dword 0      
        call    [exit]       
