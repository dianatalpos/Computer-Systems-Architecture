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

    v dd 12345678h, 98765432h, 11123334h
    v2 dw 1234h, 5678h, 1122h
    format db "%x", 13, 10, 0

segment code use32 class=code
    start:
        
        
        mov ebx, v
        mov ecx, 0
        mov edx, 0
        mov edx, [ebx + ecx*4]
        
        push dword edx
        push dword format
        call [printf]
        
        mov ebx, v2
        mov ecx, 1
        mov edx, 0
        mov dl, [ebx+ ecx*2+1]
        
       
        
        push dword edx
        push dword format
        call [printf]
        add esp, 4*2
        
        
        
        push    dword 0      
        call    [exit]       
