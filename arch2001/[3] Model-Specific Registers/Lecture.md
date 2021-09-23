## Model-Specific Registers (MSRs)

* When hardware-makers add new features to new processors, they need some way for software to detect whether the feature is present or not
* MSRs provide a way on Intel systems to support an ever-increasing number of feature flags
* The MSR list is so big that Intel has split it out into Volume 4 of the manuals

### Naming Caveat

* “For historical reasons (beginning with the Pentium 4 processor), these “architectural MSRs” were given the prefix ”IA32_“.”
  * It doesn’t mean it’s restricted to 32-bit execution

## RDMSR – Read MSR

* “Read MSR specified by ECX into EDX:EAX”
* The instruction can only be run in kernel mode

## WRMSR – Write MSR

* “Write the value in EDX:EAX to MSR specified by ECX”
* The instruction can only be run in kernel mode