build: 
	@nasm -f macho64 cpuid.asm
	@ld -o cpuid -e main -lSystem cpuid.o
