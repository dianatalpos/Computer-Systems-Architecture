
bits 32 

global start        


extern exit, fopen, fclose
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fclose msvcrt.dll


segment data use32 class=data
    nume_fisier db "ana.txt", 0  
    mod_acces db "w", 0                                           
    descriptor_fis dd -1         
    

segment code use32 class=code
    start:
        
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                
        
        mov [descriptor_fis], eax   
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       