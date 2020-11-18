section .data
    num1:   equ 100
    num2:   equ 50
    msg:    db "Sum is correct", 10

; DB, DW, DD, DQ, DT, DO, DY and DZ
; They are used for declaring initialized data.
; For example:

;; Initialize 4 bytes 1h, 2h, 3h, 4h
db 0x01,0x02,0x03,0x04

;; Initialize word to 0x12 0x34
dw    0x1234



; RESB, RESW, RESD, RESQ, REST, RESO, RESY and RESZ
; They are used for declaring non initialized variables
; INCBIN - includes External Binary Files
; EQU - defines constant. For example:
;; now one is 1
one equ 1

;TIMES - Repeating Instructions or Data. (description will be in next posts)


;; SIMPLE INTRUCTIONS
; ADD - integer add
; SUB - substract
; MUL - unsigned multiply
; IMUL - signed multiply
; DIV - unsigned divide
; IDIV - signed divide
; INC - increment
; DEC - decrement
; NEG - negate


;; CONTROL FLOW
; JE - if equal
; JZ - if zero
; JNE - if not equal
; JNZ - if not zero
; JG - if first operand is greater than second
; JGE - if first operand is greater or equal to second
; JA - the same that JG, but performs unsigned comparison
; JAE - the same that JGE, but performs unsigned comparison


; if (rax != 50) {
;     exit();
; } else {
;     right();
; }

;; compare rax with 50
cmp rax, 50
;; perform .exit if rax is not equal 50
jne .exit
jmp .right


;; Uncondition jump :
JMP label


; ie:
_start:
    ;; ....
    ;; do something and jump to .exit label
    ;; ....
    jmp .exit

.exit:
    mov    rax, 60
    mov    rdi, 0
    syscall
