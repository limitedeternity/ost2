## REP STOS – Repeat Store String

* STOS is one of instructions that can have the “rep” prefix added to it, which repeats a single instruction multiple times
* There are 3 pieces which must happen before the actual “rep stos” occurs:
  * Set \*ax/al to the value to store
  * Set \*cx to the number of times to repeat store (decrements by 1 each step until zero)
  * Set \*di to the start of the destination (increments by 1 (`byte ptr` case) / 2 (`word ptr` case) / 4 (`dword ptr` case) / 8 (`qword ptr` case) each step)
* All “rep” operations use \*cx register as a “counter” to determine how many times to loop through the instruction

## REP MOVS – Repeat Move Data String To String

* MOVS is one of instructions that can have the “rep” prefix added to it, which repeats a single instruction multiple times
* There are 3 pieces which must happen before the actual “rep movs” occurs:
  * Set \*si to the start of the source (increments by 1 (`byte ptr` case) / 2 (`word ptr` case) / 4 (`dword ptr` case) / 8 (`qword ptr` case) each step)
  * Set \*di to the start of the destination (increments by 1 (`byte ptr` case) / 2 (`word ptr` case) / 4 (`dword ptr` case) / 8 (`qword ptr` case) each step)
  * Set *cx to the number of times to repeat move (decrements by 1 each step until zero)
* Unlike MOV, MOVS can move memory to memory, but only between [\*si] and [\*di]