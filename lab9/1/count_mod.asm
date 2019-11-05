; prevent multiple inclusion 

%ifndef _COUNT_MOD_ASM_ 
%define _COUNT_MOD_ASM_ 



count_digits:     ; count_digit(base, n)
        xor eax, eax
        xor edx, edx
        xor ebx, ebx
        
        mov eax, [esp+8]
        cdq
        mov ebx, [esp+4]
        
        mov ecx, 100
        
        .count:
            
            div ebx          ; eax = eax:edx / ebx , edx = eax:edx % ebx
            
            
            cmp eax, 0
            je end_loop
            cdq
            
        loop .count
        
        end_loop:
            mov eax, 100
            sub eax, ecx
            add eax, 1
        
        ret 4*2
    
                        

%endif
