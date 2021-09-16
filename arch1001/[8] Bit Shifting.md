## SHL – Shift Logical Left / SAL – Shift Arithmetic Left

* First operand (source and destination) is in “r/mX” form

* Second operand (number of places to shift) is either cl (lowest byte of rcx), or a 1 byte immediate

* **Multiplies** the register by 2 for each place the value is shifted. More efficient, than a multiply instruction

* Bits shifted off the left hand side are “shifted into” the carry flag
  
  * `sal bl, 2`: 00110011 -> 110011**00**, CF = 0
  * `shl bl, 2`: 00110011 -> 110011**00**, CF = 0
  * `sal bl, 3`: 00110011 -> 10011**000**, CF = 1
  * `shl bl, 3`: 00110011 -> 10011**000**, CF = 1
  
  > SAL behaves exactly the same as SHL!

## SHR – Shift Logical Right / SAR – Shift Arithmetic Right

* First operand (source and destination) is in “r/mX” form
* Second operand (number of places to shift) is either cl (lowest byte of rcx), or a 1 byte immediate
* **Divides** the register by 2 for each place the value is shifted. More efficient, than a divide instruction
* Bits shifted off the right hand side are “shifted into” the carry flag
  * `sar bl, 2`: 10110011 -> **11**101100, CF = 1
  * `shr bl, 2`: 10110011 -> **00**101100, CF = 1
  * `sar bl, 3`: 10110011 -> **111**10110, CF = 0
  * `shr bl, 3`: 10110011 -> **000**10110, CF = 0
