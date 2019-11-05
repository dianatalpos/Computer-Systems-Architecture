bits 32 

global start        

;Se da un fisier text. Fisierul contine numere (in baza 10) 
;separate prin spatii. Sa se citeasca continutul acestui 
;fisier, sa se determine minimul numerelor citite si sa se 
;scrie rezultatul la sfarsitul fisierului.


extern exit, printf, scanf, fopen, fclose, fread, fprintf
import exit msvcrt.dll    
import printf msvcrt.dll 
import scanf msvcrt.dll 
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fread msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    
    lentxt db 0
    file db "numere.txt", 0
    mod_acces db "a+", 0
    descriptor dd -1
    len equ 100
    text times len+1 db 0
    n resb 10
    cif dd 0
    rez dd 0
    min dd 100000
    format db '%d',0
    
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
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        mov [lentxt], al
        
        mov ecx, eax
        mov esi, text
        cld
        mov edi, n
        
        numar:
        
        lodsb
        
        cmp ecx, 0
        je finish
        sub ecx, 1
        cmp al, ' '
        je nr
        
        stosb
        add [cif],dword 1
        
        jmp numar
        
        nr:
        push esi
        push ecx 
        
        mov [rez], dword 0
        mov edx, n
        mov ecx, [cif]
        sub ecx, 1
        add edx, ecx
        mov esi, edx
        std
        add ecx, 1
        
        constr:
        mov eax, 0
        lodsb
        sub al, '0'
        mov ebx, eax
        mov eax, [rez]
        mov edx, 10
        mul edx         ; edx:eax = rez*10
        add al, bl
        adc ax, 0
        adc eax, 0
        mov [rez], eax 
       
        loop constr
        
        mov eax, [rez]
        cmp eax, [min]
        ja skip
        mov [min], eax
        
        skip:
        
        
        cld 
        pop ecx
        pop esi
        
        mov edi, n
        mov [cif],dword 0
        
        jmp numar
        
        finish:
        
        mov edi, n
        cld
        
        
        convert:
        mov eax, [min]
        mov edx, 0
        mov ebx, 10
        div ebx
        
        mov [min], eax
        add edx, '0'
        mov eax, edx
        stosb
        
        
        cmp [min], dword 0
        je below
        
        jmp convert 
        
        below:
        
        push dword n
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        
        push dword [descriptor]
        call[fclose]
        add esp, 4*1
        
        end_program:
        
        push    dword 0      
        call    [exit]       
