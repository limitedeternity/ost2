## System Calls

* The addition of privilege separation requires some way to transfer control between different execution domains

* We've already seen 2 mechanisms which can achieve this: Call Gates and Interrupts

* But those aren't current preferred methods on x86-64

### Instruction Compatibility

![](./Compatibility.png)

* SYSENTER/SYSEXIT is preferred for 32-bit

* SYSCALL/SYSRET is preferred for 64-bit

## SYSCALL – System Call

* RCX = RIP (Will contain address of next instruction)

* RIP = IA32_LSTAR (MSR, 0xC0000082)

* R11 = RFLAGS

* RFLAGS &= ~IA32_FMASK (MSR, 0xC0000084)

* CS.Selector = IA32_STAR[47:32] (MSR, 0xC0000081) & 0xFFFC (RPL forced to 0)

* SS.Selector = IA32_STAR[47:32] (MSR, 0xC0000081) + 8

* RSP won't be saved. Either kernel or userspace handler is responsible for that

## SYSRET – System Call Return

* RIP = RCX

* RFLAGS = R11 & 0x3C7FD7 | 2 (Clear RF, VM, reserved bits; set bit 1)

* CS.Selector = (IA32_STAR[63:48] + 16) | 3 (RPL forced to 3)

* SS.Selector = (IA32_STAR[63:48] + 8) | 3 (RPL forced to 3)

* Whichever side of kernel/userspace saved RSP is responsible for restoring it

## SYSENTER – System Call

* ECX = ESP

* EDX = EIP

* ESP = IA32_SYSENTER_ESP[31:0] (MSR, 0x175)

* EIP = IA32_SYSENTER_EIP[31:0] (MSR, 0x176)

* CS.Selector = IA32_SYSENTER_CS[15:0] (MSR, 0x174) & 0xFFFC (RPL forced to 0)

* SS.Selector = IA32_SYSENTER_CS[15:0] (MSR, 0x174) + 8;

## SYSEXIT – System Call Exit

* ESP = ECX

* EIP = EDX

* CS.Selector = (IA32_SYSENTER_CS[15:0] (MSR, 0x174) + 16) | 3 (RPL forced to 3)

* SS.Selector = (IA32_SYSENTER_CS[15:0] (MSR, 0x174) + 24) | 3 (RPL forced to 3)

## System Call-Adjacent OS Activity

* "When using SYSCALL to implement system calls, there is no kernel stack at the OS entry point. Neither is there a straightforward method to obtain a pointer to kernel structures from which the kernel stack pointer could be read. Thus, the kernel can't save general purpose registers or reference memory" (From the SWAPGS description)

* The SWAPGS instruction is designed to help with the above issue

### SWAPGS – Swap GS Base Register

* Exchanges the GS base linear address (mapped to IA32_GS_BASE) with the one found in the IA32_KERNEL_GS_BASE (MSR, 0xC0000102)

* Useful for interrupt handlers as well as SYSCALL handlers

* {RD,WR}{FS,GS}BASE instructions can be used instead of {RD,WR}MSR to read/write the FS and GS base addresses 
