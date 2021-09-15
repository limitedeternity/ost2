## INC/DEC – Increment/Decrement

* Single source/destination operand can be in “r/mX” form
* Increases/decreases the value by 1
* When optimized, compilers will tend to favor *not* using inc/dec, as directed by the Intel optimization guide. Their presence may be indicative of a hand-written or non-optimized code
* Modifies OF, SF, ZF, AF, PF and CF flags

## TEST – Logical Compare

* “Computes the bitwise AND of the first operand and the second operand, then sets the SF, ZF and PF depending on the result”
* Like CMP – sets flags, discards the result