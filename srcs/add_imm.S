SECTION .TEXT
      GLOBAL add_imm

add_imm:
    push rbp
    mov rsp, rbp
    mov rax, [rbp+24]
    mov rbx, [rbp+16]
    add rax, rbx
    pop rbp
    ret
