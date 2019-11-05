bits 32 

global start        


extern exit, printf
import exit msvcrt.dll    
import printf msvcrt.dll

segment data use32 class=data
    pos db 1, 2, 3, 4, 5
    s1 db 7, 33, 55, 19, 46
    len1 equ $-s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    len2 equ $-s2
    d times len2+1 db 0
    format db "%d", 0


segment code use32 class=code
    start:
        
        ;parcurgem s2
        
        cld
        mov ecx, len2
        mov esi, s2
        mov edi, d
        
        
        repeta:
            ; salvam sirul
            
            lodsb     ; incarcam din s2 un numar
            mov bl, al  
            
            push ecx
            push esi
            
           
            cld
            mov esi, s1
            mov ecx , len1
            
            mov eax, 0
            stosb
            alt:
                
                
                lodsb
                cmp al, bl  
                jne skip
                mov edx, len1
                sub edx, ecx
                mov al, [pos+edx]
                dec edi
                stosb 
 
                mov ecx, 1
                
                skip:
                
            loop alt
            
 

            
            pop esi
            pop ecx
            cld


        loop repeta
        
        
        mov ecx, len2
        mov esi, d
        cld
        
        prin:
        
            push ecx 
            mov eax, 0
            lodsb
            push eax
            push dword format
            call [printf]
            
            add esp, 4*2
            cld
            pop ecx
        loop prin
        
        
        
              
        push    dword 0      
        call    [exit]       
