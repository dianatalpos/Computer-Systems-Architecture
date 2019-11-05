bits 32 

global start        


extern exit, printf, scanf, fopen, fclose, fread, fprintf
import exit msvcrt.dll    
import printf msvcrt.dll 
import scanf msvcrt.dll 
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fread msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    s dd 12
    n resb 10
    


segment code use32 class=code
    start:
        
        
        mov edi, n
        cld
        
        convert:
        
        mov eax, [s]
        mov edx, 0
        mov ebx, 10
        div ebx
        
        mov [s], eax
        add edx, '0'
        
        mov al, dl
        stosb
        
        
        cmp dword [s], 0
        je below
        
        jmp convert
        
        below:
        
        push    dword 0      
        call    [exit]       
