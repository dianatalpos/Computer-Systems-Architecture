bits 32 

global start        



extern exit, fopen, fclose, fread, fprintf
import exit msvcrt.dll    
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fread msvcrt.dll 
import fprintf msvcrt.dll 

segment data use32 class=data
    
    file db "mesaj.txt", 0
    mod_acces db "r+", 0
    descriptor dd -1
    format db "%s", 0
    len equ 100
    text resb len+1
    mesaj2 resb len+1
    caract db 0
    spatiu db ' '
    
    
segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword file
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je end_program
        
        mov [descriptor], eax
        mov eax, 0
        
        
        citire:
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        cmp eax, 0
        je skip
         
        mov ecx, eax
        mov edi, mesaj2 
        mov esi , text
        cld 
        
        repeta:
            
            lodsb 
            mov dl, ' '
            cmp dl, al
            je skip2
            
            cmp al, 'A'
            jb skip2
            
            cmp al, 'z'
            ja skip2
            
            
            cmp al, 'C'
            jae below
                add al, 24
                jmp skip2
                
            below:
            cmp al, 'c'
            jae below2
            cmp al, 'a'
            jb below2
               add al, 24
               jmp skip2
            
            
            below2:
            
            
            sub al, 2
            
            skip2:
            
            stosb
        loop repeta
        
        
        
        
        
        skip:
        
        push dword mesaj2
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
       
        end_program:
        
        push    dword 0      
        call    [exit]       
