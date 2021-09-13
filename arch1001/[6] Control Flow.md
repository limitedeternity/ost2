## Control Flow

* Two forms of control flow:
  * Conditional – switches, loops
  * Unconditional – goto, exceptions, interrupts

### JMP – Jump

* Unconditionally change RIP to a given address

* Ways to specify the address:

  * Short, relative: RIP = RIP of next instruction + 1 byte sign-extended (to 64 bits) displacement
    * Frequently used in small loops
    * Some disassemblers will indicate this with a mnemonic by writing it as “jmp short”
    * “jmp -2” == infinite empty loop :)
  * Near, relative: RIP = RIP of next instruction + 4 byte sign-extended (to 64 bits) displacement
  * Near, absolute indirect: RIP = address in “r/m64” form

  * Far, absolute indirect

### Architecture – RFLAGS

* Got extended from EFLAGS (32-bit), but high-order bits aren’t used for anything
* Holds many single bit flags, for example:
  * 0x40: Zero Flag (ZF) – Set if the result of some instruction is zero; cleared otherwise
  * 0x80: Sign Flag (SF) – Set equal to the most-significant bit of the result, which is the sign bit of a signed integer
  * 0x200000: CPUID instruction availability (ID)

### JCC – Jump If Condition Is Met

* If a condition is true, the jump is taken. Otherwise, it proceeds to the next instruction
* There are more than 4 pages of conditional jump types! Luckily for us, a bunch of them are just synonyms to each other

#### Some notable JCC instructions

* JZ/JE: ZF == 1
* JNZ/JNE: ZF == 0
* JLE/JNG: ZF == 1 OR SF != OF
* JGE/JNL: SF == OF
* JBE/JNA: CF == 1 OR ZF == 1
* JB: CF == 1

#### Mnemonic translations

* A = above, **unsigned** notion
* B = below, **unsigned** notion
* G = greater than, **signed** notion
* L = less than, **signed** notion
* E = equal (same as Z, zero flag set)
* N = not (like “not less than” – JNL)

### Flag Setting

* Before you can do a conditional jump, you need something to set the condition status flags for you
* This is typically done with CMP, TEST or whatever instructions are already there for us and happen to have flag-setting side-effects

## CMP – Compare Two Operands

* “The comparison is performed by subtracting the second operand from the first and then setting the status flags in the same manner as the SUB instruction”
* CMP is similar to SUB, but unlike the latter, CMP simply discards the result while setting the same flags as SUB does
* Modifies CF, OF, SF, ZF, AF and PF

