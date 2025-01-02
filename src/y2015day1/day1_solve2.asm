global _y2015_day1_solve2

section .text

_y2015_day1_solve2:
    mov r10, rdi            ; Load the address of the string
    mov rcx, rsi            ; Load the string length into RCX (loop counter)
    xor r8, r8              ; Initialize floor information to 0
    xor r9, r9              ; Initialize index to 0

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

    jmp loop_start          ; Continue the loop

inc_value:
    inc r8                  ; Increment floor
    jmp check_basement


dec_value:
    dec r8                  ; Decrement floor

check_basement:
    cmp r8, -1              ; Check if basement is reached
    cmove r9, rcx           ; Store the remaining steps if basement is hit
    je loop_end             ; Exit if basement is hit

    jmp loop_start          ; Continue the loop

loop_end:
    xor rax, rax
    mov rax, rsi
    sub rax, r9
    ret
