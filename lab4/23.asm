bits 32 

global start        

;Given the byte A and the word B, compute the doubleword C as follows:
;the bits 24-31 of C are the same as the bits of A
;the bits 16-23 of C are the invert of the bits of the lowest byte of B
;the bits 10-15 of C have the value 1
;the bits 2-9 of C are the same as the bits of the highest byte of B
;the bits 0-1 both contain the value of the sign bit of A

extern exit
import exit msvcrt.dll    


segment data use32 class=data
    a db 11010010b
    b dw 1000110110100110b
    c dd 0b


segment code use32 class=code
    start:
        ;the bits 24-31 of C are the same as the bits of A
        
        mov eax, 0 
        mov al, [a]   ; eax = a = 11010010b
        shl eax, 24   ; eax = 00000000000000000000000011010010b
        mov [c], eax  ; eax = 11010010000000000000000000000000b
        
        ;the bits 16-23 of C are the invert of the bits of the lowest byte of B
        
        mov eax, 0
        mov al, [b]    ; in eax punem the lowest byte of b 
        shl eax, 16    
        or [c], eax    ; mutam bitii din eax in variabila c 
        
        ;the bits 10-15 of C have the value 1
       
        mov eax, 0
        mov ah, 11111100b     
        or [c], eax
        
        ;the bits 2-9 of C are the same as the bits of the highest byte of B
        
        
        mov eax, 0
        mov al, [b+1]
        shl eax, 2
        or [c], eax
        
        ;the bits 0-1 both contain the value of the sign bit of A
        mov eax, 0
        mov al, [a]
        and al, 10000000b
        shr eax, 7
        shl eax, 1
        or [c], eax
        shr eax, 1
        or [c], eax
        
        
        push    dword 0      
        call    [exit]       
