bits 32 ; assembling for the 32 bits architecture


global start        

global _zecimal_unsigned


segment data use32 class=data
    rez dd 0
    adresa_Sir dd 0
    len_Sir dd 0
    nr dd 0
    rezultat dd 0
    
segment code use32 class=code
    _zecimal_unsigned:
        push ebp
        mov ebp, esp
        pushad
       
        mov eax, [ebp+8]
        mov [adresa_Sir], eax
        mov eax, [ebp+12]
        mov [len_Sir], eax
        mov eax, [ebp+16]
        mov [nr], eax
        
        mov esi, [adresa_Sir]
        cld
        mov ecx, [len_Sir]
        mov eax, 0
        
        mov ebx, 16
        mov eax, 1
        rep imul ebx
        push eax 
        
        mov ecx, [len_Sir]
        repeta:
            mov eax, 0
            lodsb
            cmp al, '9'
            jl digit
            sub al, '0'
            sub al, 7
            jmp store
            digit:
            sub al, '0'
            store:
            mov edx, 0
            mov dl, al
            pop eax
            mov ebx, eax
            imul edx
            add dword[rezultat], eax
            mov eax, ebx
            mov ebx, 16
            idiv ebx
            push eax
        loop repeta
        jos:
        
        mov eax, [rezultat]
        mov [nr], eax
        
        popad
        add esp, 4
        mov esp, ebp
        pop ebp
        
        ret
        