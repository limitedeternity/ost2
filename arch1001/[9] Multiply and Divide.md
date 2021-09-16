## DIV – Unsigned Division / IDIV – Signed Division

* Three forms:
  * Unsigned division of ax by r/m8, al = quotient, ah = remainder
  * Unsigned division of edx:eax by r/m32, eax = quotient, edx = remainder
  * Unsigned division of rdx:rax by r/m64, rax = quotient, rdx = remainder
* If dividend fits in eax/rax, edx/rdx will just be set to 0 by the compiler before the instruction
* If the divisor is 0, exception interrupt is thrown

**Examples**:

1. ```
   mov rdx, 0h;
   mov rax, 8h;
   mov rcx, 5h;
   div rax, rcx;
   ```

   Result:

   * rdx = 0x3
   * rax = 0x1

2. ```
   mov ax, feh;
   mov cx, 2h;
   idiv ax, cx;
   ```

   Result:

   * ah = 0x0
   * al = 0xff

