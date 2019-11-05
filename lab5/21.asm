bits 32 

global start        

;Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina elementele lui B in ordine inversa urmate de elementele negative ale lui A. 
;Exemplu:
;a: 2, 1, -3, 3, -4, 2, 6
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, -3, -4

extern exit
import exit msvcrt.dll    


segment data use32 class=data
    a db 2, 1, -3, 3, -4, 2, 6
    len1 equ $-a
    b db 4, 5, 7, 6, 2, 1
    len2 equ $-b
    r times len1+len2 db 0
    

segment code use32 class=code
    start:
        
        mov esi, len2-1
        mov edi, 0
        mov ecx, len2
        
        repeta:
            mov al, [b+esi]    ; retinem elementul de pe pozitia curenta
            dec esi            ; scadem indexu
            mov [r+edi], al    ; salvam elemnetul in sirul rezultat
            inc edi            ; crestem indexul sirului rezultat
            
        loop repeta
        
        ; initializam valorile esi, ecx pentru a parcurge primul sir
        
        mov esi, 0
        mov ecx, len1
        
        repeta2:
            
            mov al, [a+esi]    ; salvam elementul curent
            inc esi            ; crestem indexul 
            mov ah, 0
            cmp ah, al         ; verificam daca este mai mic decat 0
            jl skip
            ; daca este negativ il retinem in sirul rezultat, altfel trecem la urmatorul element                
            mov [r+edi], al
            inc edi
            
            skip:
            
        loop repeta2    
        
        
        
        push    dword 0      
        call    [exit]       
