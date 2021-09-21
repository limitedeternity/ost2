## Real Mode

* “This mode implements the programming environment of the Intel 8086 processor with extensions (such as the ability to switch to protected or system management mode). The processor is placed in real-address mode following power-up or a reset.”
* DOS runs in Real Mode
* No virtual memory, no privilege rings, 16-bit mode

## System Management Mode

* “This mode provides an operating system or executive with a transparent mechanism for implementing platform-specific functions such as power management and system security. The processor enters SMM when the external SMM interrupt pin (SMI#) is activated or an SMI is received from the advanced programmable interrupt controller (APIC).”
* SMM has the capability to protect its memory from all other privileged code, so it is for all intents and purposes the most privileged execution mode on the CPU

## Protected Mode

* “This mode is the native state of the processor. Among the capabilities of protected mode is the ability to directly execute ‘Real-address mode’ 8086 software in a protected, multi-tasking environment. This feature is called **virtual-8086 mode**, although it is not actually a processor mode. Virtual-8086 mode is actually a protected mode attribute that can be enabled for any task.”
* Virtual-8086 is just for backwards compatibility
* Protected mode adds support for virtual memory and privilege rings
* Modern OS operate in protected mode

## Long (IA-32e / Intel 64 / x86-64) Mode

* When AMD created the x86-64 extensions, they called it Long Mode
* Intel calls it IA-32e (extended) or Intel 64 in their manuals