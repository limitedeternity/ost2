## SHL – Shift Logical Left

* First operand (source and destination) is in “r/mX” form
* Second operand (number of places to shift) is either cl (lowest byte of rcx), or a 1 byte immediate
* **Multiplies** the register by 2 for each place the value is shifted. More efficient, than a multiply instruction
* Bits shifted off the left hand side are “shifted into” the carry flag
  * `shl bl, 2`: 00110011 -> 11001100, CF = 0
  * `shl bl, 3`: 00110011 -> 10011000, CF = 1

## SHR – Shift Logical Right

* First operand (source and destination) is in “r/mX” form
* Second operand (number of places to shift) is either cl (lowest byte of rcx), or a 1 byte immediate
* **Divides** the register by 2 for each place the value is shifted. More efficient, than a divide instruction
* Bits shifted off the right hand side are “shifted into” the carry flag
  * `shr bl, 2`: 00110011 -> 00001100, CF = 1
  * `shr bl, 3`: 00110011 -> 00000110, CF = 0

