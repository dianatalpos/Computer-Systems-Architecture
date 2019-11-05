bits 32 ; assembling for the 32 bits architecture

global start        

;A text file is given. Read the content of the file, determine the uppercase letter with the 
;highest frequency and display the letter along with its frequency on the screen. The name of 
;text file is defined in the data segment.


; Nu inteleg de ce nu imi calculeaza maximul. Am luat rezolvarea Flaviei si mi-am modificat 
; aproape ca problema ei si tot nu imi calculeaza maximul. Daca puteti sa va uitati de ce
; nu imi merge. Multumesc!


extern exit, fopen, fclose, printf, fread             
import exit msvcrt.dll    
import fclose msvcrt.dll    
import fopen msvcrt.dll    
import fread msvcrt.dll   
import printf msvcrt.dll 


segment data use32 class=data
    file_name db "input.txt", 0
    access_mode db "r" , 0
    descriptor dd -1
    characters_number dd 0
    len equ 100
    buffer times len db 0
    counter times 26 db 0
    max dd 0
    msg db "The most frequent uppercase letter is %c with the frequency %d.", 0
    max_letter dd 0
; our code starts here
segment code use32 class=code
    start:
        
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        
        ; open the file for reading
        ; fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je end_program
        
        mov [descriptor], eax
        
        ; Read all content from the file:
    
        repeat_read:
            ; Read the first 100 characters
            ; fread(buffer, 1, len, descriptor)
                
            push dword [descriptor]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
                
            ; eax= number of digits
            cmp eax, 0
            je end_file
                
                
            mov [characters_number], eax
                
            
            mov ecx, [characters_number]
            mov esi, 0
            mov edi, 0
            jecxz end_file
            
            letters:
                push ecx
         
                mov al, [buffer + esi]   ; bl = current letter   
 
                cmp al, 0x41             ; Compare the current character with 'A'
                jl next_char
                cmp al, 0x5A             ; Compare the current character with 'Z'
                jg next_char
                    
                mov ebx, 0
                mov bl, [buffer + esi]   ; Calculate the position of the letter in counter
                sub bl, 65
                
                mov dl, [counter+ebx]    ; Increasing the counter 
                add dl, 1
                mov [counter+ebx], dl    
                    
                    
                    
                next_char:
                
            
                pop ecx
                inc esi
                
            loop letters
                
                
                
        jmp repeat_read
        
        end_file:
        ; fclose(descriptor)
        
        push dword [descriptor]
        call [fclose]
        add esp, 4
        
        mov ecx, 26
        mov esi,  0
        
        jecxz end_program
        find_max:
            mov eax, 0
            mov al, [counter+esi]
            cmp eax, [max]
            jbe next_value
            
            mov [max], eax
            mov ebx, esi
            add ebx, 65
            mov [max_letter], ebx
            
            
            next_value:
            inc esi
            
        loop find_max


        push dword [max]
        push dword [max_letter]
        push dword msg
        call [printf]
        add esp, 4*3
        
        end_program:
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
