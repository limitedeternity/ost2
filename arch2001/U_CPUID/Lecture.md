## CPUID – CPU Feature Identification

* Different processors support different features
* CPUID is how we know if the chip we’re running on supports newer features, such as hardware virtualization, hyper threading, thermal monitors, etc
* CPUID doesn’t have any operands. Rather it takes input as a value preloaded into eax (and possibly ecx)
* After it executes, the outputs are stored into eax, ebx, ecx and edx

### How do we know if we can use CPUID?

* “The ID flag (mask 0x00200000) in the EFLAGS register indicates support for the CPUID instruction. If a software procedure can set and clear this flag, the processor executing the procedure supports the CPUID instruction”
* We can read/write to EFLAGS using PUSHFQ/POPFQ instructions

## POPFQ – Pop Stack Into RFLAGS

* There are some flags which will not be transferred from the stack to RFLAGS unless you’re in ring 0 (kernel mode)