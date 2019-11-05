bits 32 

global start        


extern exit, fopen, fclose, fprintf, scanf, printf
import exit msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll
import fprintf msvcrt.dll    
import scanf msvcrt.dll    
import printf msvcrt.dll    
    
segment data use32 class=data
    mod_acces db "w", 0
    file db "numbers.txt",0
    format db "%d", 0
    format3 db "%x ", 0
    format2 db "%d " , 0
    format4 db "%d " , 13, 10, 0
    msg db "Give a number: ", 0
    a dd 0
    nr dd 0
    
    
    descriptor dd -1
    

segment code use32 class=code
    start:
        
        
        push mod_acces
        push file
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je end_program
        
        
        mov [descriptor], eax 
       
        
        citire:
        
            mov dword [nr], 0
            
            
            push dword msg
            call [printf]
            add esp,4 
            
            
            
            push dword a
            push dword format
            call [scanf]
            add esp, 4*2
            
            mov eax, [a]
            
            cmp eax, 0
            
            je end_program
            
            push dword [a]
            push dword format2
            push dword [descriptor]
            call [fprintf]
            add esp, 4*3
            
            
            push dword [a]
            push dword format3
            push dword [descriptor]
            call [fprintf]
            add esp, 4*3
            
            ; 10001011010
            
            mov eax, [a]
            mov ecx, 32
            count:
                mov ebx, 1
                and ebx, eax
                add [nr], ebx
                shr eax,1 
            loop count 
            
            push dword [nr]
            push dword format4
            push dword [descriptor]
            call [fprintf]
            add esp, 4*3
            
        jmp citire
            
        
        
        end_program:
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        push    dword 0      
        call    [exit]       
