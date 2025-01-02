global _y2015_day2_solve1

section .text

_y2015_day2_solve1:
    ; Initialize registers
    mov r10, rdi            ; Load the address of the string (rdi = string pointer)
    mov rcx, rsi            ; Load the string length into RCX (rcx = string length, loop counter)
    xor r8, r8              ; Initialize w (r8 = 0)
    xor r9, r9              ; Initialize h (r9 = 0)
    xor r12, r12            ; Initialize l (r12 = 0)
    xor r11, r11            ; Indicate which value we pass (0 = w, 1 = h, 2 = l)
    xor r13, r13            ; Indicate sum accumulator (r13 = 0)
    xor rdx, rdx            ; Zero rdx (rdx = 0, used for current number)

loop_start:
    test rcx, rcx           ; Check if the loop counter (rcx) is zero
    jz loop_end             ; If zero, exit the loop (end of string)

    xor rax, rax            ; Clear rax register
    mov al, [r10]           ; Load the current character from the string into AL
    inc r10                 ; Move to the next character in the string
    dec rcx                 ; Decrement the loop counter

    cmp al, 0x78            ; Check if the current character is 'x' (ASCII 'x' = 0x78)
    je commit_number        ; If 'x', jump to commit_number

    cmp al, 0x0a            ; Check if the current character is newline '\n' (ASCII '\n' = 0x0a)
    je commit_number        ; If newline, jump to commit_number

    imul rdx, rdx, 10       ; Multiply rdx by 10 (build the number)
    sub al, '0'             ; Convert ASCII character to decimal by subtracting '0'
    movzx rax, al           ; Zero-extend AL into RAX
    add rdx, rax            ; Add the converted value to rdx (accumulate number)

    jmp loop_start          ; Repeat the loop

commit_number:
    ; Commit the current number to the appropriate variable (w, h, or l)
    cmp r11, 0              
    cmove r8, rdx           ; If r11 == 0, move rdx (current number) to w (r8)

    cmp r11, 1              
    cmove r9, rdx           ; If r11 == 1, move rdx (current number) to h (r9)

    cmp r11, 2              
    cmove r12, rdx          ; If r11 == 2, move rdx (current number) to l (r12)

    inc r11                 ; Increment floor (r11 = 0 -> 1 -> 2)
    xor rdx, rdx            ; Zero rdx for the next number

    cmp r11, 3              ; Check if we have processed all three values (w, h, l)
    je calculate            ; If so, jump to calculate

    jmp loop_start          ; Return to loop logic for the next number

calculate:
    ; Calculate the result based on w, h, and l (r8, r9, r12)
    mov rax, r8             ; Load w into rax
    imul rax, r9            ; Multiply w * h (r8 * r9)

    mov rbx, r9             ; Load h into rbx
    imul rbx, r12           ; Multiply h * l (r9 * r12)

    mov rdx, r8             ; Load w into rdx
    imul rdx, r12           ; Multiply w * l (r8 * r12)

    add rax, rbx            ; Add (w * h) to the result
    add rax, rdx            ; Add (w * l) to the result
    add rax, rax            ; Double the result (sum all terms)
    add r13, rax            ; Add to the sum accumulator (r13)

    ; Find the smallest and second smallest values
    cmp r9, r12             ; Compare h (r9) with l (r12)
    cmovg r11, r9           ; If h > l, move h to r11 (smallest)
    cmovg r9, r12           ; If h > l, move l to h
    cmovg r12, r11          ; If h > l, move smallest value back to l

    cmp r8, r9              ; Compare w (r8) with h (r9)
    cmovg r11, r8           ; If w > h, move w to r11 (smallest)
    cmovg r8, r9            ; If w > h, move h to w
    cmovg r9, r11           ; If w > h, move smallest value back to h

    cmp r9, r12             ; Compare h (r9) with l (r12)
    cmovg r11, r9           ; If h > l, move h to r11 (smallest)
    cmovg r9, r12           ; If h > l, move l to h
    cmovg r12, r11          ; If h > l, move smallest value back to l

    imul r8, r9             ; Multiply w * h
    add r13, r8             ; Add the result to the sum accumulator (r13)

    ; Reset variables for the next iteration
    xor r11, r11            ; Reset r11 to 0
    xor r8, r8              ; Reset w to 0
    xor r9, r9              ; Reset h to 0
    xor r12, r12            ; Reset l to 0
    xor rdx, rdx            ; Reset rdx to 0

    jmp loop_start          ; Return to loop logic for the next number

loop_end:
    mov rax, r13            ; Move the final result into rax
    ret                      ; Return with the result in rax
