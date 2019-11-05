
%ifndef _HUNDREDPLACE_ASM_
%define _HUNDREDPLACE_ASM_

hundred_Place:
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    
    mov eax, [esp+4]
    mov ebx, 10
    div bx         ; ax = eax/10
    div bl         ; al = eax/100
    cbw                 ; ax = al
    div bl         ; ah = ax%10  => cifra sutelor
    mov al, ah
    cbw
    cwde
    
    ret 4
    
    
%endif
    