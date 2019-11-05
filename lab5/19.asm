bits 32 

global start        

;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele pare si negative din cele 2 siruri. 
;Exemplu:
;A: 2, 1, 3, -3, -4, 2, -6
;;B: 4, 5, -5, 7, -6, -2, 1
;R: -4, -6, -6, -2

extern exit
import exit msvcrt.dll    


segment data use32 class=data

    a db 2, 1, 3, -3, -4, 2, -6
    len1 equ $-a
    b db 4, 5, -5, 7, -6, -2, 1
    len2 equ $-b
    r times len1+len2 db 0


segment code use32 class=code
    start:
    
        mov esi, 0
        mov edi, 0
        mov ecx, len1
        
        repeta:
            mov al, [a+esi]
            inc esi
            
            mov bl, 0
            cmp bl, al

            jl skip
            
                test al, 1
                jnz skip
                
                mov [r+edi], al
                inc edi
              
            skip:
            
        loop repeta
        
        mov esi, 0
        mov ecx, len2
        
        repeta2:
        
            mov al, [b+esi]
            inc esi
            
            mov bl, 0
            
            cmp bl, al
            jl skip2
            
                test al, 1
                jnz skip2
                
                mov [r+edi], al
                inc edi
                
                
            skip2:
        
        loop repeta2
        
        push    dword 0      
        call    [exit]       
