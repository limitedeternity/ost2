global main

section .text


fetch_cpuid:
    mov qword [rsp+28h], rax        ; shadow space backup (rax)
    mov qword [rsp+20h], rcx        ; shadow space backup (rcx)

    sub rsp, 8                      ; 0x8 return addr padding

    pushfq                          ; backup rflags
    mov rsi, qword [rsp]            ; copy it to rsi

    pushfq                          ; new backup that we'll modify
    xor qword [rsp], 200000h        ; invert id bit
    popfq                           ; attempt to write back
    pushfq                          ; read again to verify write
    pop rdi                         ; move to rdi
    popfq                           ; restore backup

    xor rsi, rdi                    ; xor original rflags with modified ones to verify write 
    test rsi, 200000h               ; [bitwise AND] check xor mask; fails => cpuid isn't available 
    jz fetch_cpuid_failed

    mov rax, qword [rsp+30h]        ; restore first cpuid argument
    mov rcx, qword [rsp+28h]        ; restore second cpuid argument
    cpuid

    xor r8, r8                      ; return success status in r8 (because rax is _In_out)
    add rsp, 8
    ret

fetch_cpuid_failed:
    mov r8, -1                      ; return failure status in r8 (because rax is _In_out)
    add rsp, 8
    ret


main:
    sub rsp, 48h ; 0x8 return addr padding 
                 ;   + rax backup (_In_out)
                 ;   + rcx backup (_In_out)
                 ;   + rdx backup (_Out)
                 ;   + rbx backup (_Out)
                 ;   + 0x20-sized shadow space (to backup arguments to be able to use reserved registers)
    
    mov qword [rsp+40h], rax
    mov qword [rsp+38h], rcx
    mov qword [rsp+30h], rdx
    mov qword [rsp+28h], rbx
    
    mov rax, 80000001h       ; Extended Processor Info and Feature Bits
    xor rcx, rcx             ; Won't be used in our case, but let's still zero it
    call fetch_cpuid

    test r8, r8              ; cpuid is available => 0, else => -1
    jnz cpuid_unavail_epilogue

    test rdx, 10h            ; [bitwise AND] check msr feature flag
    jnz msr_avail_epilogue 
                             ; [logical OR]

    test rdx, 800h           ; [bitwise AND] mtrr feature flag => msr present
    jnz msr_avail_epilogue

    mov rbx, qword [rsp+28h]
    mov rdx, qword [rsp+30h]
    mov rcx, qword [rsp+38h]
    mov rax, qword [rsp+40h]

    mov rax, 2000004h        ; write syscall id on MacOS x64
    mov rdi, 1               ; destination = stdout
    lea rsi, [rel msr_unavail_msg]
    mov rdx, msr_unavail_msg.len
    syscall

    add rsp, 48h
    xor rax, rax             ; status = success
    ret

cpuid_unavail_epilogue:
    mov rbx, qword [rsp+28h]
    mov rdx, qword [rsp+30h]
    mov rcx, qword [rsp+38h]
    mov rax, qword [rsp+40h]

    mov rax, 2000004h           ; write syscall id on MacOS x64
    mov rdi, 1                  ; destination = stdout
    lea rsi, [rel cpuid_unavail_msg]
    mov rdx, cpuid_unavail_msg.len
    syscall

    add rsp, 48h
    mov rax, 1                  ; status = failure
    ret

msr_avail_epilogue:
    mov rbx, qword [rsp+28h]
    mov rdx, qword [rsp+30h]
    mov rcx, qword [rsp+38h]
    mov rax, qword [rsp+40h]

    mov rax, 2000004h           ; write syscall id on MacOS x64
    mov rdi, 1                  ; destination = stdout
    lea rsi, [rel msr_avail_msg]
    mov rdx, msr_avail_msg.len
    syscall

    add rsp, 48h
    xor rax, rax                ; status = success
    ret


section .data


cpuid_unavail_msg: db "CPUID instruction is not available on this platform", 0ah
.len:              equ $ - cpuid_unavail_msg

msr_unavail_msg: db "Model-specific registers (MSR) are not available", 0ah
.len:            equ $ - msr_unavail_msg

msr_avail_msg: db "Model-specific registers (MSR) are available", 0ah
.len:          equ $ - msr_avail_msg

