global main

fetch_cpuid_or_die:
    sub rsp, 8                      ; 0x8 return addr padding

    pushfq                          ; backup rflags
    mov rsi, qword [rsp]            ; copy it to rsi

    pushfq                          ; new backup that we'll modify
    xor qword [rsp], 200000h        ; invert id bit
    popfq                           ; attempt to write back
    pushfq                          ; read again to verify write
    pop rdi                         ; move to rdi
    popfq                           ; restore backup

    xor rsi, rdi                    ; xor original rflags with modified to verify write 
    test rsi, 200000h               ; check mask (bitwise and)
    jz exit                         ; cpuid is not available

    mov eax, 80000001h              ; Extended Processor Info and Feature Bits
    cpuid

    add rsp, 8
    ret

main:
    sub rsp, 28h ; 0x8 return addr padding + rax + rcx + rbx + rdx 
    
    mov qword [rsp+20h], rax
    mov qword [rsp+18h], rcx
    mov qword [rsp+10h], rbx
    mov qword [rsp+8], rdx
    
    call fetch_cpuid_or_die

    mov rdx, qword [rsp+8]
    mov rbx, qword [rsp+10h]
    mov rcx, qword [rsp+18h]
    mov rax, qword [rsp+20h]

    add rsp, 28h
    jmp exit

exit:
    mov eax, 2000001h  ; exit syscall id on MacOS
    mov edi, 0         ; status = success
    syscall

