bits 32

global _hex_to_dec

segment data use32 class=data

segment code use32 class=code
_hex_to_dec:
    push ebp
    mov ebp, esp

    ;pushad

    cld
    mov esi, [ebp+8]        ; sirul tmp
    mov ecx, [ebp+12]       ; numarul de cifre hexazecimale (lungimea sirului tmp)
    ; mov ecx, 20
    mov edx, 0
    convert:
        mov eax, 0
        lodsb
        
        ; cmp al, 0
        ; je _exit
        
        cmp al, '9'
        jbe _digit
        
        sub al, 55
        jmp _shift

      _digit:
        sub al, '0'
        
      _shift:
        ; cmp ecx, 1
        ; je _merge

        shl edx, 4

      _merge:
        or edx, eax
    loop convert

  _exit:
  
    ;popad

    mov eax, edx
    
    mov esp, ebp
    pop ebp
    
    ret
