global _y2015_day2_solve1

section .text

_y2015_day2_solve1:
    mov r10, rdi            ; Load the address of the string
    mov rcx, rsi            ; Load the string length into RCX (loop counter)
    xor r8, r8              ; Initialize floor information to 0

loop_start:
    test rcx, rcx           ; Check if the loop counter is zero
    jz loop_end             ; If zero, exit the loop

    mov al, [r10]           ; Load the current character into AL
    inc r10                 ; Move to the next character
    dec rcx                 ; Decrement the loop counter

    cmp al, 0x28            ; Check for '('
    je inc_value

    cmp al, 0x29            ; Check for ')'
    je dec_value

    jmp loop_start          ; Repeat the loop

inc_value:
    inc r8                  ; Increment floor
    jmp loop_start          ; Return to loop logic

dec_value:
    dec r8                  ; Decrement floor
    jmp loop_start          ; Return to loop logic

loop_end:
    mov rax, r8             ; Return the final floor
    ret
