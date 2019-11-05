bits 32 

global start        

;Se da un sir de dublucuvinte. Sa se obtina sirul format din octetii inferiori ai 
;cuvintelor superioare din elementele sirului de dublucuvinte care sunt palindrom in scrierea in baza 10.
;Exemplu:
;Se da sirul de dublucuvinte:
;s DD 12345678h, 1A2C3C4Dh, 98FCDC76h
;Sa se obtina sirul
;d DB 2Ch, FCh.

extern exit
import exit msvcrt.dll    


segment data use32 class=data
    s DD 12345678h, 1A2C3C4Dh, 98FCDC76h
    lens1 equ $-s
    d times lens1 db 0
    
    
    
    
segment code use32 class=code
    start:
        
        cld
        mov esi, s
        mov ecx, lens1
        mov edi, d
        
        repeta:
            push ecx
            mov eax, 0
            lodsw
            lodsw
        
            
            mov ah,0     ; ax =  octetul inferior al cuvintului superioar
            push eax 
            
            mov dl, 0    ;dl = rezultatul
            mov cl, 10
            palin:
                
                div cl   ;al = ax/ 10, ah = ax%10
                mov bl, al    ;bl = ax/ 10
                mov bh, ah    ;bh = ultima cifra 
                
                mov al, dl    ;al = rez
                
                mul cl   
                add al, bh    ; ax =rez*10+ bh(ultima cifra)
                
                mov dl, al    ; dl(rezultatul) = al 
        
                mov ah, 0
                mov al, bl
                cmp bl, 0
            jnz palin
            
            pop eax
            
            cmp al, dl 
            
            jne skip
            
            cld
            stosb
            
            skip:
            pop ecx
        loop repeta
        
        
        push    dword 0      
        call    [exit]       
