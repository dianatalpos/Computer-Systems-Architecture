bits 32 

global start        

extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    nume_fisier db "ana.txt", 0  
    mod_acces db "a+", 0           
    len equ 100                                              
    text times (len+1) db 0      
    descriptor_fis dd -1     



segment code use32 class=code
    start:
        
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2             

        mov [descriptor_fis], eax  
        
        cmp eax, 0
        je final
        
       
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4                 
        
        
        
        
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]           
    