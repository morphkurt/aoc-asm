global _start


section .text

_start:
    lea rsi, [rel msg]       ; Load the address of the string into RSI
    mov rcx, msg.len         ; Load the string length into RCX (loop counter)
    mov r8, 0                ; running total
    mov r9, 0                ; w
    mov r10, 0               ; h
    mov r11, 0               ; l
    mov r12, 0               ; index

parse_loop:
    cmp rcx, 0               ; Check if the loop counter is zero
    je loop_end              ; If zero, exit the loop

    mov al, [rsi]            ; Load the current character into AL
    cmp al, 'x'              ; check whether it is x
    je store_number

    cmp al, 10              ; check whether it is x
    je store_number

    sub al, '0'
    imul rax, rax, 10
    movzx rcx, al 
    add rax, rcx
    inc rsi                  ; Move to the next character
    dec rcx                  ; Decrement the loop counter
    jmp parse_loop

store_number:
    cmp r12, 0
    je store_w

    cmp r12, 1
    je store_h

    cmp r12, 2
    je store_l

store_w:
    mov r9, rax
    mov r12, 1
    inc rsi                  ; Move to the next character
    dec rcx                  ; Decrement the loop counter
    jmp parse_loop
store_h:
    mov r10, rax
    mov r12, 2
    inc rsi                  ; Move to the next character
    dec rcx                  ; Decrement the loop counter
    jmp parse_loop

store_l:
    mov r11, rax
    mov r12, 0
    mul r10
    mov rbx, 2
    mul rbx
    mov r8, rax
    inc rsi                  ; Move to the next character
    dec rcx                  ; Decrement the loop counter
    jmp parse_loop

loop_end:
    ; Answer
    mov rax, 0x2000004       ; syscall: write (macOS)
    mov rdi, 1               ; File descriptor: stdout
    lea rsi, [rel answer]    ; Address of the number string
    mov rdx, answer.len       ; Number of digits
    syscall

    ; Convert r8 to ASCII string and print it
    lea rsi, [rel buffer+9]  ; Point to the end of the buffer
    xor rcx, rcx             ; Clear counter for length
    mov rax, r8              ; move answer to rax

convert_to_ascii:
    xor rdx, rdx             ; Clear remainder
    mov rbx, 10              ; Divisor (base 10)
    div rbx                  ; Divide r8 by 10, quotient in r8, remainder in rdx
    add dl, '0'              ; Convert remainder to ASCII
    dec rsi                  ; Move backward in buffer
    mov [rsi], dl            ; Store the character
    inc rcx                  ; Increment digit counter
    test rax, rax              ; Check if quotient is zero
    jnz convert_to_ascii     ; Repeat if more digits remain

    ; Print the ASCII string
    mov rax, 0x2000004       ; syscall: write (macOS)
    mov rdi, 1               ; File descriptor: stdout
    lea rsi, [rsi]           ; Address of the number string
    mov rdx, rcx             ; Number of digits
    syscall

    ; Print newline
    mov rax, 0x2000004       ; syscall: write (macOS)
    lea rsi, [rel newline]       ; Address of newline character
    mov rdx, 1               ; Length of newline
    syscall

    ; Exit program
    mov rax, 0x2000001       ; syscall: exit
    xor rdi, rdi             ; Status code 0
    syscall


section .data

msg:    db      "20x3x11"
.len:   equ     $ - msg

answer db "answer for solve1: "         ; Newline character
.len:   equ     $ - answer
newline db 0xA, 0         ; Newline character
buffer db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ; Buffer for number (10 digits max)