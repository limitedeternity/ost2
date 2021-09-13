## New Instructions: call, ret, mov, add, sub

### CALL – Call Procedure

* CALL’s job is to transfer control to a different function; in a way that control can later be resumed where it left off
* First it *pushes* the address of the next instruction onto the stack (for use by RET when the procedure is done)
* Then it changes RIP to the address given in the operand
* Destination address for the target function can be specified in multiple ways:
  * Absolute address
  * Relative address (relative to the end of the instruction)

### RET – Return from Procedure

* Two forms:
  * `ret`: Pop the top of the stack into RIP
  * `ret 0xN`: Pop the top of the stack into RIP and also add `0xN` bytes to RSP

### How to read two-operand instructions: Intel vs. AT&T Syntax

* Intel: Destination <- Source
  * Windows prefers Intel syntax
  * Like algebra or C: y = 2x + 1
  * `mov rbp, rsp`
* AT&T: Source -> Destination
  * *nix/GNU prefers AT&T syntax
  * Like elementary school: 1 + 2 = 3
  * `mov %rsp, %rbp`

### MOV – Move

* Can move:
  * register to register (`mov rbx, rax`)
  * memory to register (`mov rax, qword ptr [rbx]`), register to memory (`mov qword ptr [rbx], rax`)
  * immediate to register (`mov rbx, imm64`), immediate to memory (`mov dword ptr [rbx], imm32`)
* Never memory to memory!
* Memory addresses are given in “r/mX” form with size descriptions

### ADD and SUB

* Adds or Subtracts, just as expected
* Destination operand can be “r/mX” or register
* Source operand can be “r/mX” or register or immediate
  * `add rsp, 8`
  * `sub rax, [rbx*2]`
* Source **and** destination can’t be “r/mX” simultaneously, because that’d allow for memory to memory transfer, which is not allowed
