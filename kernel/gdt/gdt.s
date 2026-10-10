.section .rodata

gdt:
	.quad 0x0000000000000000
	.quad 0x00CF9A000000FFFF
	.quad 0x00CF92000000FFFF
	.quad 0x00CFFA000000FFFF
	.quad 0x00CFF2000000FFFF
gdt_end:

gdtr:
    .word gdt_end - gdt - 1
    .long gdt

.section .text

.global loadGdt 
.type loadGdt, @function
loadGdt:
    lgdt gdtr

	pushl $0x08
	pushl $reload_cs
	lret


reload_cs:
    mov $0x10, %eax 
    mov %ax, %ds
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    ret
